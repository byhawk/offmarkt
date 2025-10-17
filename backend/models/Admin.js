const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const adminSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    minlength: 3
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
  role: {
    type: String,
    enum: ['super_admin', 'admin', 'moderator'],
    default: 'moderator'
  },
  permissions: [{
    type: String,
    enum: [
      'manage_players',
      'manage_products',
      'manage_shops',
      'manage_events',
      'manage_settings',
      'view_analytics',
      'ban_players',
      'manage_admins'
    ]
  }],
  isActive: {
    type: Boolean,
    default: true
  },
  lastLogin: {
    type: Date,
    default: null
  },
  loginHistory: [{
    ip: String,
    userAgent: String,
    timestamp: {
      type: Date,
      default: Date.now
    }
  }]
}, {
  timestamps: true
});

// Hash password before saving
adminSchema.pre('save', async function(next) {
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
adminSchema.methods.comparePassword = async function(candidatePassword) {
  return await bcrypt.compare(candidatePassword, this.password);
};

// Update last login
adminSchema.methods.updateLogin = function(ip, userAgent) {
  this.lastLogin = new Date();
  this.loginHistory.push({ ip, userAgent });
  
  // Son 50 login kaydını tut
  if (this.loginHistory.length > 50) {
    this.loginHistory.shift();
  }
  
  return this.save();
};

// Check permission
adminSchema.methods.hasPermission = function(permission) {
  if (this.role === 'super_admin') return true;
  return this.permissions.includes(permission);
};

// Get active admins (static)
adminSchema.statics.getActiveAdmins = function() {
  return this.find({ isActive: true }).select('-password');
};

// Indexes
adminSchema.index({ username: 1 });
adminSchema.index({ email: 1 });
adminSchema.index({ role: 1 });

module.exports = mongoose.model('Admin', adminSchema);
