const mongoose = require('mongoose');

const holdingSchema = new mongoose.Schema({
  playerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true,
    unique: true
  },
  
  // Holding Info
  name: {
    type: String,
    default: 'My Holding'
  },
  
  // Shares
  shares: [{
    companyId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Player'
    },
    companyName: String,
    percentage: {
      type: Number,
      min: 0,
      max: 100
    },
    value: {
      type: Number,
      default: 0
    },
    purchasePrice: Number,
    purchaseDate: Date,
    quantity: Number
  }],
  
  // Financial
  totalValue: {
    type: Number,
    default: 0
  },
  totalInvested: {
    type: Number,
    default: 0
  },
  monthlyDividend: {
    type: Number,
    default: 0
  },
  totalDividendReceived: {
    type: Number,
    default: 0
  },
  
  // Performance
  profitLoss: {
    type: Number,
    default: 0
  },
  profitLossPercentage: {
    type: Number,
    default: 0
  },
  
  // Diversification
  numberOfCompanies: {
    type: Number,
    default: 0
  },
  diversificationScore: {
    type: Number,
    default: 0,
    min: 0,
    max: 100
  },
  
  // Last Dividend
  lastDividendDate: Date,
  nextDividendDate: Date,
  
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
holdingSchema.index({ playerId: 1 });
holdingSchema.index({ 'shares.companyId': 1 });

// Methods
holdingSchema.methods.buyShares = function(companyId, companyName, quantity, pricePerShare) {
  const totalCost = quantity * pricePerShare;
  
  const existingShare = this.shares.find(s => s.companyId.toString() === companyId.toString());
  
  if (existingShare) {
    existingShare.quantity += quantity;
    existingShare.value += totalCost;
  } else {
    this.shares.push({
      companyId,
      companyName,
      percentage: 0,
      value: totalCost,
      purchasePrice: pricePerShare,
      purchaseDate: new Date(),
      quantity
    });
    this.numberOfCompanies += 1;
  }
  
  this.totalInvested += totalCost;
  this.updateTotalValue();
  
  return this.save();
};

holdingSchema.methods.sellShares = function(companyId, quantity, currentPrice) {
  const share = this.shares.find(s => s.companyId.toString() === companyId.toString());
  
  if (!share || share.quantity < quantity) {
    throw new Error('Insufficient shares');
  }
  
  const saleValue = quantity * currentPrice;
  const costBasis = (share.purchasePrice * quantity);
  const profit = saleValue - costBasis;
  
  share.quantity -= quantity;
  share.value = share.quantity * currentPrice;
  
  if (share.quantity === 0) {
    this.shares = this.shares.filter(s => s.companyId.toString() !== companyId.toString());
    this.numberOfCompanies -= 1;
  }
  
  this.profitLoss += profit;
  this.updateTotalValue();
  
  return { saleValue, profit, this: this.save() };
};

holdingSchema.methods.updateTotalValue = function() {
  this.totalValue = this.shares.reduce((sum, share) => sum + share.value, 0);
  
  if (this.totalInvested > 0) {
    this.profitLossPercentage = ((this.totalValue - this.totalInvested) / this.totalInvested) * 100;
  }
  
  this.updateDiversification();
  return this.save();
};

holdingSchema.methods.updateDiversification = function() {
  if (this.shares.length === 0) {
    this.diversificationScore = 0;
    return;
  }
  
  let herfindahlIndex = 0;
  this.shares.forEach(share => {
    const percentage = (share.value / this.totalValue) * 100;
    herfindahlIndex += (percentage * percentage);
  });
  
  // Normalize to 0-100 scale
  this.diversificationScore = Math.max(0, 100 - (herfindahlIndex / 100));
};

holdingSchema.methods.calculateMonthlyDividend = function(dividendRates) {
  this.monthlyDividend = 0;
  
  this.shares.forEach(share => {
    const rate = dividendRates[share.companyId] || 0.02;
    this.monthlyDividend += share.value * rate;
  });
  
  return this.monthlyDividend;
};

holdingSchema.methods.receiveDividend = function(amount) {
  this.totalDividendReceived += amount;
  this.lastDividendDate = new Date();
  this.nextDividendDate = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000); // 30 days
  
  return this.save();
};

module.exports = mongoose.model('Holding', holdingSchema);
