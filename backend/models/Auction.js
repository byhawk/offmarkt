const mongoose = require('mongoose');

const auctionSchema = new mongoose.Schema({
  // Item Info
  itemType: {
    type: String,
    enum: ['shop', 'product', 'company', 'asset'],
    required: true
  },
  itemId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true
  },
  itemName: {
    type: String,
    required: true
  },
  itemDescription: String,
  
  // Pricing
  startPrice: {
    type: Number,
    required: true,
    min: 0
  },
  currentPrice: {
    type: Number,
    required: true
  },
  reservePrice: {
    type: Number,
    default: 0
  },
  
  // Bidding
  bids: [{
    bidderId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Player'
    },
    bidderName: String,
    amount: {
      type: Number,
      required: true
    },
    timestamp: {
      type: Date,
      default: Date.now
    }
  }],
  
  highestBidder: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player'
  },
  highestBidderName: String,
  numberOfBids: {
    type: Number,
    default: 0
  },
  
  // Timing
  startDate: {
    type: Date,
    default: Date.now
  },
  endDate: {
    type: Date,
    required: true
  },
  
  // Status
  status: {
    type: String,
    enum: ['active', 'completed', 'cancelled', 'failed'],
    default: 'active'
  },
  
  // Results
  winner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player'
  },
  winnerName: String,
  finalPrice: Number,
  completedDate: Date,
  
  // Creator
  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player'
  },
  
  // Metadata
  category: String,
  tags: [String],
  
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
auctionSchema.index({ status: 1, endDate: 1 });
auctionSchema.index({ itemType: 1, itemId: 1 });
auctionSchema.index({ highestBidder: 1 });
auctionSchema.index({ createdBy: 1 });
auctionSchema.index({ endDate: 1 });

// Methods
auctionSchema.methods.placeBid = function(bidderId, bidderName, amount) {
  if (this.status !== 'active') {
    throw new Error('Auction is not active');
  }
  
  if (new Date() > this.endDate) {
    throw new Error('Auction has ended');
  }
  
  if (amount <= this.currentPrice) {
    throw new Error('Bid must be higher than current price');
  }
  
  this.bids.push({
    bidderId,
    bidderName,
    amount,
    timestamp: new Date()
  });
  
  this.currentPrice = amount;
  this.highestBidder = bidderId;
  this.highestBidderName = bidderName;
  this.numberOfBids += 1;
  
  return this.save();
};

auctionSchema.methods.completeAuction = function() {
  if (this.status !== 'active') {
    throw new Error('Auction is not active');
  }
  
  if (new Date() <= this.endDate) {
    throw new Error('Auction has not ended yet');
  }
  
  if (this.currentPrice < this.reservePrice) {
    this.status = 'failed';
    this.completedDate = new Date();
    return this.save();
  }
  
  if (!this.highestBidder) {
    this.status = 'failed';
    this.completedDate = new Date();
    return this.save();
  }
  
  this.status = 'completed';
  this.winner = this.highestBidder;
  this.winnerName = this.highestBidderName;
  this.finalPrice = this.currentPrice;
  this.completedDate = new Date();
  
  return this.save();
};

auctionSchema.methods.cancelAuction = function(reason) {
  if (this.status === 'completed') {
    throw new Error('Cannot cancel completed auction');
  }
  
  this.status = 'cancelled';
  this.completedDate = new Date();
  
  return this.save();
};

auctionSchema.methods.isActive = function() {
  return this.status === 'active' && new Date() <= this.endDate;
};

auctionSchema.methods.getTimeRemaining = function() {
  const now = new Date();
  const remaining = this.endDate - now;
  
  if (remaining <= 0) {
    return 0;
  }
  
  return remaining;
};

auctionSchema.methods.getFormattedTimeRemaining = function() {
  const ms = this.getTimeRemaining();
  
  if (ms <= 0) return 'Ended';
  
  const seconds = Math.floor((ms / 1000) % 60);
  const minutes = Math.floor((ms / (1000 * 60)) % 60);
  const hours = Math.floor((ms / (1000 * 60 * 60)) % 24);
  const days = Math.floor(ms / (1000 * 60 * 60 * 24));
  
  if (days > 0) return `${days}d ${hours}h`;
  if (hours > 0) return `${hours}h ${minutes}m`;
  if (minutes > 0) return `${minutes}m ${seconds}s`;
  return `${seconds}s`;
};

module.exports = mongoose.model('Auction', auctionSchema);
