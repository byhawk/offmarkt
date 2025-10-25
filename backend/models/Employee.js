const mongoose = require('mongoose');

const employeeSchema = new mongoose.Schema({
  // Basic Info
  playerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true
  },
  name: {
    type: String,
    required: true,
    trim: true
  },
  position: {
    type: String,
    required: true,
    enum: ['Manager', 'Specialist', 'Technician', 'Analyst', 'Director', 'Consultant']
  },
  
  // Financial
  salary: {
    type: Number,
    required: true,
    min: 1000,
    default: 5000
  },
  totalEarnings: {
    type: Number,
    default: 0,
    min: 0
  },
  
  // Performance
  performance: {
    type: Number,
    default: 50,
    min: 0,
    max: 100
  },
  loyalty: {
    type: Number,
    default: 50,
    min: 0,
    max: 100
  },
  productivity: {
    type: Number,
    default: 1.0,
    min: 0.5,
    max: 2.0
  },
  
  // Skills
  skills: [{
    name: {
      type: String,
      enum: ['Management', 'Technical', 'Sales', 'Research', 'Operations', 'Finance']
    },
    level: {
      type: Number,
      min: 1,
      max: 10,
      default: 1
    }
  }],
  
  // Status
  status: {
    type: String,
    enum: ['active', 'fired', 'on_leave'],
    default: 'active'
  },
  hireDate: {
    type: Date,
    default: Date.now
  },
  fireDate: Date,
  
  // Contribution
  totalContribution: {
    type: Number,
    default: 0
  },
  monthlyContribution: {
    type: Number,
    default: 0
  },
  
  // Satisfaction
  satisfaction: {
    type: Number,
    default: 70,
    min: 0,
    max: 100
  },
  
  // Last Payment
  lastPaymentDate: Date,
  
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
employeeSchema.index({ playerId: 1, status: 1 });
employeeSchema.index({ playerId: 1, hireDate: -1 });

// Methods
employeeSchema.methods.calculateMonthlyContribution = function() {
  const baseContribution = this.salary * 0.5;
  const performanceBonus = (this.performance / 100) * this.salary * 0.3;
  const loyaltyBonus = (this.loyalty / 100) * this.salary * 0.2;
  
  this.monthlyContribution = (baseContribution + performanceBonus + loyaltyBonus) * this.productivity;
  return this.monthlyContribution;
};

employeeSchema.methods.updatePerformance = function() {
  const satisfactionFactor = this.satisfaction / 100;
  const loyaltyFactor = this.loyalty / 100;
  
  this.performance = Math.min(100, this.performance + (satisfactionFactor * 5) + (loyaltyFactor * 3));
  this.performance = Math.max(0, this.performance - 2); // Decay
  
  return this.save();
};

employeeSchema.methods.updateSatisfaction = function(change) {
  this.satisfaction = Math.min(100, Math.max(0, this.satisfaction + change));
  return this.save();
};

module.exports = mongoose.model('Employee', employeeSchema);
