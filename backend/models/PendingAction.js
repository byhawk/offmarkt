const mongoose = require('mongoose');

const pendingActionSchema = new mongoose.Schema({
  playerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true,
    index: true
  },

  actionType: {
    type: String,
    enum: ['AUTO_SELL', 'LIST_PRODUCT', 'RESTOCK_ORDER'],
    required: true,
    index: true
  },

  status: {
    type: String,
    enum: ['pending', 'processing', 'completed', 'failed', 'cancelled'],
    default: 'pending',
    index: true
  },

  scheduledFor: {
    type: Date,
    required: true,
    index: true,
    default: Date.now
  },

  processedAt: {
    type: Date
  },

  completedAt: {
    type: Date
  },

  // Action-specific data
  data: {
    shopId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Shop'
    },
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Product'
    },
    quantity: Number,
    price: Number,
    purchasePrice: Number,

    // AUTO_SELL specific
    targetSellPrice: Number,
    minProfitMargin: Number,

    // LIST_PRODUCT specific
    fromInventory: Boolean,

    // RESTOCK_ORDER specific
    autoRestockEnabled: Boolean,
    restockThreshold: Number,
    restockQuantity: Number
  },

  // Result of the action
  result: {
    success: {
      type: Boolean,
      default: false
    },
    soldQuantity: {
      type: Number,
      default: 0
    },
    earnedMoney: {
      type: Number,
      default: 0
    },
    profit: {
      type: Number,
      default: 0
    },
    message: String,
    errorCode: String
  },

  // Retry mechanism
  retryCount: {
    type: Number,
    default: 0
  },
  maxRetries: {
    type: Number,
    default: 3
  },

  // Recurring actions (AUTO_SELL)
  isRecurring: {
    type: Boolean,
    default: false
  },
  nextScheduledAt: {
    type: Date
  },

  // Metadata
  metadata: {
    sourceIp: String,
    userAgent: String,
    clientVersion: String
  }
}, {
  timestamps: true
});

// Indexes for efficient queries
pendingActionSchema.index({ scheduledFor: 1, status: 1 });
pendingActionSchema.index({ playerId: 1, actionType: 1, status: 1 });
pendingActionSchema.index({ 'data.shopId': 1, status: 1 });
pendingActionSchema.index({ createdAt: 1 }, { expireAfterSeconds: 7 * 24 * 60 * 60 }); // TTL 7 days for completed

// Static Methods

/**
 * Get all pending actions ready to be processed
 */
pendingActionSchema.statics.getReadyActions = async function(limit = 100) {
  return this.find({
    status: 'pending',
    scheduledFor: { $lte: new Date() }
  })
  .limit(limit)
  .sort({ scheduledFor: 1 })
  .populate('playerId', 'username cash bankAccount')
  .populate('data.shopId')
  .populate('data.productId');
};

/**
 * Create AUTO_SELL action for a shop
 */
pendingActionSchema.statics.createAutoSellAction = async function(shopId, playerId) {
  return this.create({
    playerId,
    actionType: 'AUTO_SELL',
    status: 'pending',
    scheduledFor: new Date(),
    isRecurring: true,
    data: {
      shopId
    }
  });
};

/**
 * Create LIST_PRODUCT action
 */
pendingActionSchema.statics.createListProductAction = async function({
  playerId,
  shopId,
  productId,
  quantity,
  sellPrice,
  purchasePrice
}) {
  return this.create({
    playerId,
    actionType: 'LIST_PRODUCT',
    status: 'pending',
    scheduledFor: new Date(),
    data: {
      shopId,
      productId,
      quantity,
      price: sellPrice,
      purchasePrice,
      fromInventory: true
    }
  });
};

// Instance Methods

/**
 * Mark action as processing
 */
pendingActionSchema.methods.markProcessing = async function() {
  this.status = 'processing';
  this.processedAt = new Date();
  return this.save();
};

/**
 * Complete action with result
 */
pendingActionSchema.methods.complete = async function(result) {
  this.status = 'completed';
  this.completedAt = new Date();
  this.result = {
    ...this.result,
    ...result,
    success: true
  };

  // If recurring, schedule next
  if (this.isRecurring && this.actionType === 'AUTO_SELL') {
    this.nextScheduledAt = new Date(Date.now() + 5000); // Next tick in 5 seconds
  }

  return this.save();
};

/**
 * Fail action with error
 */
pendingActionSchema.methods.fail = async function(errorMessage, errorCode) {
  this.retryCount += 1;

  if (this.retryCount >= this.maxRetries) {
    this.status = 'failed';
    this.completedAt = new Date();
  } else {
    this.status = 'pending';
    this.scheduledFor = new Date(Date.now() + 5000 * this.retryCount); // Exponential backoff
  }

  this.result = {
    ...this.result,
    success: false,
    message: errorMessage,
    errorCode
  };

  return this.save();
};

/**
 * Cancel action
 */
pendingActionSchema.methods.cancel = async function(reason) {
  this.status = 'cancelled';
  this.completedAt = new Date();
  this.result = {
    ...this.result,
    success: false,
    message: reason
  };
  return this.save();
};

module.exports = mongoose.model('PendingAction', pendingActionSchema);
