const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const playerSchema = new mongoose.Schema({
  // Auth
  username: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    minlength: 3,
    maxlength: 20
  },
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
    trim: true
  },
  password: {
    type: String,
    required: true,
    minlength: 6
  },
  
  // Game Stats
  name: {
    type: String,
    default: 'Oyuncu'
  },
  level: {
    type: Number,
    default: 1,
    min: 1,
    max: 100
  },
  experience: {
    type: Number,
    default: 0,
    min: 0
  },
  
  // Financial
  cash: {
    type: Number,
    default: 5000,
    min: 0
  },
  bankAccount: {
    type: Number,
    default: 0,
    min: 0
  },
  debt: {
    type: Number,
    default: 0,
    min: 0
  },
  portfolioValue: {
    type: Number,
    default: 0
  },

  // Reputation
  legalReputation: {
    type: Number,
    default: 0,
    min: -100,
    max: 100
  },
  streetReputation: {
    type: Number,
    default: 0,
    min: -100,
    max: 100
  },

  // Progress
  currentDay: {
    type: Number,
    default: 1
  },
  totalTransactions: {
    type: Number,
    default: 0
  },
  totalProfit: {
    type: Number,
    default: 0
  },
  
  // Inventory
  inventory: [{
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Product'
    },
    quantity: Number,
    purchasePrice: Number,
    purchaseDate: Date,
    source: String
  }],
  
  // Shops
  ownedShops: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Shop'
  }],

  // Holding
  holdingId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Holding'
  },
  
  // Online Status
  isOnline: {
    type: Boolean,
    default: false
  },
  lastActivity: {
    type: Date,
    default: Date.now
  },
  
  // Account Status
  isActive: {
    type: Boolean,
    default: true
  },
  isBanned: {
    type: Boolean,
    default: false
  },
  banReason: String,
  banExpires: Date,
  
  // Premium
  isPremium: {
    type: Boolean,
    default: false
  },
  premiumExpires: Date,
  
  // Settings
  settings: {
    notifications: {
      type: Boolean,
      default: true
    },
    sound: {
      type: Boolean,
      default: true
    },
    language: {
      type: String,
      default: 'tr'
    }
  }
}, {
  timestamps: true
});

// Hash password before saving
playerSchema.pre('save', async function(next) {
  if (!this.isModified('password')) return next();
  
  try {
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
    next();
  } catch (error) {
    next(error);
  }
});

// Compare password method
playerSchema.methods.comparePassword = async function(candidatePassword) {
  return await bcrypt.compare(candidatePassword, this.password);
};

// Update last activity
playerSchema.methods.updateActivity = function() {
  this.lastActivity = new Date();
  this.isOnline = true;
  return this.save();
};

// Add experience and check level up
playerSchema.methods.addExperience = function(exp) {
  this.experience += exp;
  
  const expPerLevel = 1000;
  while (this.experience >= expPerLevel && this.level < 100) {
    this.experience -= expPerLevel;
    this.level += 1;
    
    // Level rewards
    this.cash += this.level * 1000;
    this.legalReputation = Math.min(100, this.legalReputation + 5);
  }
  
  return this.save();
};

// Get net worth
playerSchema.methods.getNetWorth = function() {
  return this.cash + this.bankAccount + this.portfolioValue - this.debt;
};

// Indexes
playerSchema.index({ username: 1 });
playerSchema.index({ email: 1 });
playerSchema.index({ level: -1 });
playerSchema.index({ totalProfit: -1 });
playerSchema.index({ isOnline: 1, lastActivity: -1 });

module.exports = mongoose.model('Player', playerSchema);
