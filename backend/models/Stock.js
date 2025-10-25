const mongoose = require('mongoose');

const stockSchema = new mongoose.Schema({
  companyId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true
  },
  companyName: String,
  symbol: {
    type: String,
    unique: true,
    required: true
  },
  
  // Pricing
  basePrice: {
    type: Number,
    required: true
  },
  currentPrice: {
    type: Number,
    required: true
  },
  priceHistory: [{
    price: Number,
    timestamp: {
      type: Date,
      default: Date.now
    }
  }],
  
  // Shares
  totalShares: {
    type: Number,
    default: 1000
  },
  availableShares: {
    type: Number,
    default: 1000
  },
  soldShares: {
    type: Number,
    default: 0
  },
  
  // Dividend
  dividendPercentage: {
    type: Number,
    default: 0.1 // 10% of monthly profit
  },
  lastDividendDate: Date,
  nextDividendDate: Date,
  totalDividendsPaid: {
    type: Number,
    default: 0
  },
  
  // Company Performance
  companyValue: {
    type: Number,
    default: 0
  },
  monthlyProfit: {
    type: Number,
    default: 0
  },
  
  // Status
  isActive: {
    type: Boolean,
    default: true
  },
  isPublic: {
    type: Boolean,
    default: true
  },
  
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
stockSchema.index({ companyId: 1 });
stockSchema.index({ symbol: 1 });
stockSchema.index({ currentPrice: -1 });

// Methods
stockSchema.methods.updatePrice = function(newPrice) {
  this.currentPrice = newPrice;
  
  this.priceHistory.push({
    price: newPrice,
    timestamp: new Date()
  });
  
  if (this.priceHistory.length > 100) {
    this.priceHistory.shift();
  }
  
  return this.save();
};

stockSchema.methods.buyShares = function(quantity) {
  if (this.availableShares < quantity) {
    throw new Error('Insufficient shares available');
  }
  
  this.availableShares -= quantity;
  this.soldShares += quantity;
  
  return this.save();
};

stockSchema.methods.calculateDividend = function() {
  return this.monthlyProfit * this.dividendPercentage;
};

stockSchema.methods.payDividend = function(amount) {
  this.totalDividendsPaid += amount;
  this.lastDividendDate = new Date();
  this.nextDividendDate = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000);
  
  return this.save();
};

module.exports = mongoose.model('Stock', stockSchema);
