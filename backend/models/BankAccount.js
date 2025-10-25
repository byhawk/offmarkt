const mongoose = require('mongoose');

const bankAccountSchema = new mongoose.Schema({
  playerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true,
    unique: true
  },
  
  // Balance
  balance: {
    type: Number,
    default: 0,
    min: 0
  },
  
  // Interest
  interestRate: {
    type: Number,
    default: 0.005 // 0.5% daily = ~15% monthly
  },
  lastInterestDate: Date,
  totalInterestEarned: {
    type: Number,
    default: 0
  },
  
  // Transactions
  transactions: [{
    type: {
      type: String,
      enum: ['deposit', 'withdraw', 'interest']
    },
    amount: Number,
    balanceBefore: Number,
    balanceAfter: Number,
    timestamp: {
      type: Date,
      default: Date.now
    }
  }],
  
  // Statistics
  totalDeposited: {
    type: Number,
    default: 0
  },
  totalWithdrawn: {
    type: Number,
    default: 0
  },
  
  // Account Status
  isActive: {
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
bankAccountSchema.index({ playerId: 1 });
bankAccountSchema.index({ balance: -1 });

// Methods
bankAccountSchema.methods.deposit = function(amount) {
  if (amount <= 0) {
    throw new Error('Deposit amount must be positive');
  }
  
  const balanceBefore = this.balance;
  this.balance += amount;
  this.totalDeposited += amount;
  
  this.transactions.push({
    type: 'deposit',
    amount,
    balanceBefore,
    balanceAfter: this.balance
  });
  
  return this.save();
};

bankAccountSchema.methods.withdraw = function(amount) {
  if (amount <= 0) {
    throw new Error('Withdrawal amount must be positive');
  }
  
  if (this.balance < amount) {
    throw new Error('Insufficient balance');
  }
  
  const balanceBefore = this.balance;
  this.balance -= amount;
  this.totalWithdrawn += amount;
  
  this.transactions.push({
    type: 'withdraw',
    amount,
    balanceBefore,
    balanceAfter: this.balance
  });
  
  return this.save();
};

bankAccountSchema.methods.calculateInterest = function() {
  const dailyInterest = this.balance * this.interestRate;
  
  const balanceBefore = this.balance;
  this.balance += dailyInterest;
  this.totalInterestEarned += dailyInterest;
  this.lastInterestDate = new Date();
  
  this.transactions.push({
    type: 'interest',
    amount: dailyInterest,
    balanceBefore,
    balanceAfter: this.balance
  });
  
  return this.save();
};

bankAccountSchema.methods.getTransactionHistory = function(limit = 50) {
  return this.transactions.slice(-limit).reverse();
};

module.exports = mongoose.model('BankAccount', bankAccountSchema);
