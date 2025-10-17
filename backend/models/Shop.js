const mongoose = require('mongoose');

const shopSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  location: {
    type: String,
    required: true
  },
  locationType: {
    type: String,
    required: true,
    enum: ['street', 'mall', 'market', 'office', 'warehouse']
  },
  monthlyRent: {
    type: Number,
    required: true,
    min: 0
  },
  deposit: {
    type: Number,
    required: true,
    min: 0
  },
  squareMeters: {
    type: Number,
    required: true,
    min: 10
  },
  floor: {
    type: Number,
    default: 0
  },
  hasWindow: {
    type: Boolean,
    default: false
  },
  parkingSpaces: {
    type: Number,
    default: 0
  },
  
  // Kiralama bilgileri
  isAvailable: {
    type: Boolean,
    default: true
  },
  rentedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    default: null
  },
  rentedAt: {
    type: Date,
    default: null
  },
  businessCategory: {
    type: String,
    enum: ['electronics', 'clothing', 'food', 'jewelry', 'general', null],
    default: null
  },
  
  // İşletme istatistikleri
  monthlyRevenue: {
    type: Number,
    default: 0
  },
  monthlyCustomers: {
    type: Number,
    default: 0
  },
  isActive: {
    type: Boolean,
    default: true
  },
  
  // Performans geçmişi
  revenueHistory: [{
    month: Number,
    revenue: Number,
    customers: Number,
    timestamp: {
      type: Date,
      default: Date.now
    }
  }]
}, {
  timestamps: true
});

// Dükkanı kirala
shopSchema.methods.rent = function(playerId, category) {
  this.isAvailable = false;
  this.rentedBy = playerId;
  this.rentedAt = new Date();
  this.businessCategory = category;
  return this.save();
};

// Dükkanı bırak
shopSchema.methods.leave = function() {
  this.isAvailable = true;
  this.rentedBy = null;
  this.rentedAt = null;
  this.businessCategory = null;
  this.monthlyRevenue = 0;
  this.monthlyCustomers = 0;
  return this.save();
};

// Gelir güncelle
shopSchema.methods.updateRevenue = function(revenue, customers) {
  this.monthlyRevenue += revenue;
  this.monthlyCustomers += customers;
  
  // Geçmişe ekle (son 12 ay)
  const currentMonth = new Date().getMonth();
  this.revenueHistory.push({
    month: currentMonth,
    revenue,
    customers,
    timestamp: new Date()
  });
  
  if (this.revenueHistory.length > 12) {
    this.revenueHistory.shift();
  }
  
  return this.save();
};

// Müsait dükkanları getir (static)
shopSchema.statics.getAvailable = function() {
  return this.find({ isAvailable: true, isActive: true });
};

// Oyuncunun dükkanlarını getir (static)
shopSchema.statics.getPlayerShops = function(playerId) {
  return this.find({ rentedBy: playerId, isActive: true });
};

// Lokasyon tipine göre getir (static)
shopSchema.statics.getByLocationType = function(locationType) {
  return this.find({ locationType, isAvailable: true, isActive: true });
};

// Indexes
shopSchema.index({ isAvailable: 1, isActive: 1 });
shopSchema.index({ rentedBy: 1 });
shopSchema.index({ locationType: 1, isAvailable: 1 });
shopSchema.index({ monthlyRent: 1 });

module.exports = mongoose.model('Shop', shopSchema);
