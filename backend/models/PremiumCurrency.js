const mongoose = require('mongoose');

const premiumCurrencySchema = new mongoose.Schema({
  playerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true,
    unique: true
  },
  
  // Gems Balance
  gems: {
    type: Number,
    default: 0,
    min: 0
  },
  
  // Statistics
  totalPurchased: {
    type: Number,
    default: 0
  },
  totalSpent: {
    type: Number,
    default: 0
  },
  totalEarned: {
    type: Number,
    default: 0
  },
  
  // Transactions
  transactions: [{
    type: {
      type: String,
      enum: ['purchase', 'spend', 'earn', 'refund']
    },
    amount: Number,
    reason: String,
    price: Number, // USD price for purchases
    balanceBefore: Number,
    balanceAfter: Number,
    timestamp: {
      type: Date,
      default: Date.now
    }
  }],
  
  // Active Boosts
  activeBoosts: [{
    boostId: mongoose.Schema.Types.ObjectId,
    type: {
      type: String,
      enum: ['sales_boost', 'price_reduction', 'interest_boost', 'speed_up']
    },
    multiplier: Number,
    startDate: Date,
    endDate: Date,
    isActive: Boolean
  }],
  
  // Timestamps
  createdAt: {
    type: Date,
    default: Date.now
  },
  updatedAt: {
    type: Date,
    default: Date.now
  }
}, {
  timestamps: true
});

// Indexes
premiumCurrencySchema.index({ playerId: 1 });
premiumCurrencySchema.index({ gems: -1 });

// Methods
premiumCurrencySchema.methods.addGems = function(amount, reason = 'purchase') {
  if (amount <= 0) {
    throw new Error('Amount must be positive');
  }
  
  const balanceBefore = this.gems;
  this.gems += amount;
  this.totalPurchased += amount;
  
  this.transactions.push({
    type: 'purchase',
    amount,
    reason,
    balanceBefore,
    balanceAfter: this.gems
  });
  
  return this.save();
};

premiumCurrencySchema.methods.spendGems = function(amount, reason) {
  if (amount <= 0) {
    throw new Error('Amount must be positive');
  }
  
  if (this.gems < amount) {
    throw new Error('Insufficient gems');
  }
  
  const balanceBefore = this.gems;
  this.gems -= amount;
  this.totalSpent += amount;
  
  this.transactions.push({
    type: 'spend',
    amount,
    reason,
    balanceBefore,
    balanceAfter: this.gems
  });
  
  return this.save();
};

premiumCurrencySchema.methods.earnGems = function(amount, reason) {
  if (amount <= 0) {
    throw new Error('Amount must be positive');
  }
  
  const balanceBefore = this.gems;
  this.gems += amount;
  this.totalEarned += amount;
  
  this.transactions.push({
    type: 'earn',
    amount,
    reason,
    balanceBefore,
    balanceAfter: this.gems
  });
  
  return this.save();
};

premiumCurrencySchema.methods.activateBoost = function(boostType, multiplier, durationHours) {
  const startDate = new Date();
  const endDate = new Date(startDate.getTime() + durationHours * 60 * 60 * 1000);
  
  this.activeBoosts.push({
    boostId: new mongoose.Types.ObjectId(),
    type: boostType,
    multiplier,
    startDate,
    endDate,
    isActive: true
  });
  
  return this.save();
};

premiumCurrencySchema.methods.deactivateBoost = function(boostId) {
  const boost = this.activeBoosts.find(b => b.boostId.toString() === boostId.toString());
  if (boost) {
    boost.isActive = false;
  }
  return this.save();
};

premiumCurrencySchema.methods.getActiveBoosts = function() {
  const now = new Date();
  return this.activeBoosts.filter(b => b.isActive && b.endDate > now);
};

premiumCurrencySchema.methods.getBoostMultiplier = function(boostType) {
  const activeBoosts = this.getActiveBoosts();
  const boost = activeBoosts.find(b => b.type === boostType);
  return boost ? boost.multiplier : 1;
};

premiumCurrencySchema.methods.getTransactionHistory = function(limit = 50) {
  return this.transactions.slice(-limit).reverse();
};

module.exports = mongoose.model('PremiumCurrency', premiumCurrencySchema);
