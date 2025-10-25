const mongoose = require('mongoose');

const rdLabSchema = new mongoose.Schema({
  playerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true,
    unique: true
  },
  
  // Lab Info
  level: {
    type: Number,
    default: 1,
    min: 1,
    max: 10
  },
  
  // Capacity
  maxProjects: {
    type: Number,
    default: 5
  },
  
  // Resources
  researchPointsPerDay: {
    type: Number,
    default: 50
  },
  currentBudget: {
    type: Number,
    default: 10000,
    min: 0
  },
  totalInvestment: {
    type: Number,
    default: 0
  },
  
  // Bonuses
  efficiencyBonus: {
    type: Number,
    default: 1.0,
    min: 0.5,
    max: 3.0
  },
  safetyFactor: {
    type: Number,
    default: 0.5,
    min: 0,
    max: 1
  },
  innovationRate: {
    type: Number,
    default: 0.1,
    min: 0,
    max: 1
  },
  
  // Projects
  activeProjects: [{
    projectId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'RdProject'
    },
    progress: {
      type: Number,
      default: 0,
      min: 0,
      max: 100
    },
    startDate: Date,
    endDate: Date,
    status: {
      type: String,
      enum: ['in_progress', 'completed', 'failed', 'cancelled'],
      default: 'in_progress'
    }
  }],
  
  completedProjects: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'RdProject'
  }],
  
  failedProjects: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'RdProject'
  }],
  
  // Statistics
  totalProjectsCompleted: {
    type: Number,
    default: 0
  },
  totalProjectsFailed: {
    type: Number,
    default: 0
  },
  successRate: {
    type: Number,
    default: 0,
    min: 0,
    max: 100
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
rdLabSchema.index({ playerId: 1 });

// Methods
rdLabSchema.methods.canStartProject = function() {
  const activeCount = this.activeProjects.filter(p => p.status === 'in_progress').length;
  return activeCount < this.maxProjects;
};

rdLabSchema.methods.addBudget = function(amount) {
  this.currentBudget += amount;
  this.totalInvestment += amount;
  return this.save();
};

rdLabSchema.methods.spendBudget = function(amount) {
  if (this.currentBudget < amount) {
    throw new Error('Insufficient budget');
  }
  this.currentBudget -= amount;
  return this.save();
};

rdLabSchema.methods.updateSuccessRate = function() {
  const total = this.totalProjectsCompleted + this.totalProjectsFailed;
  if (total === 0) {
    this.successRate = 0;
  } else {
    this.successRate = (this.totalProjectsCompleted / total) * 100;
  }
  return this.save();
};

rdLabSchema.methods.upgradeLevel = function() {
  if (this.level < 10) {
    this.level += 1;
    this.maxProjects += 2;
    this.researchPointsPerDay += 25;
    this.efficiencyBonus += 0.1;
    return this.save();
  }
  throw new Error('Lab already at max level');
};

module.exports = mongoose.model('RdLab', rdLabSchema);
