const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  emoji: {
    type: String,
    required: true
  },
  category: {
    type: String,
    required: true,
    enum: ['electronics', 'clothing', 'food', 'jewelry', 'vehicles']
  },
  basePrice: {
    type: Number,
    required: true,
    min: 0
  },
  currentPrice: {
    type: Number,
    required: true,
    min: 0
  },
  demand: {
    type: Number,
    default: 50,
    min: 0,
    max: 100
  },
  volatility: {
    type: Number,
    default: 0.1,
    min: 0,
    max: 1
  },

  // Tick-based sales economy
  baseDemand: {
    type: Number,
    default: 10, // Units per tick (5s) at market price
    min: 1,
    max: 100
  },
  peakHours: {
    type: [Number],
    default: [18, 19, 20], // Hours when demand is highest (6PM-8PM)
    validate: {
      validator: function(arr) {
        return arr.every(h => h >= 0 && h <= 23);
      },
      message: 'Peak hours must be between 0-23'
    }
  },
  seasonality: {
    type: String,
    enum: ['stable', 'high', 'low'],
    default: 'stable'
  },

  trending: {
    type: Boolean,
    default: false
  },
  isLegal: {
    type: Boolean,
    default: true
  },
  minLevel: {
    type: Number,
    default: 1,
    min: 1
  },
  description: {
    type: String,
    default: ''
  },
  isActive: {
    type: Boolean,
    default: true
  },
  priceHistory: [{
    price: Number,
    timestamp: {
      type: Date,
      default: Date.now
    }
  }]
}, {
  timestamps: true
});

// Fiyat güncelleme metodu
productSchema.methods.updatePrice = function() {
  const change = (Math.random() - 0.5) * 2 * this.volatility;
  const newPrice = this.currentPrice * (1 + change);
  
  // Fiyatı basePrice'ın 0.5x ve 2x arasında tut
  this.currentPrice = Math.max(
    this.basePrice * 0.5,
    Math.min(this.basePrice * 2, newPrice)
  );
  
  // Fiyat geçmişine ekle (son 100 kayıt)
  this.priceHistory.push({
    price: this.currentPrice,
    timestamp: new Date()
  });
  
  if (this.priceHistory.length > 100) {
    this.priceHistory.shift();
  }
  
  return this.save();
};

// Tüm aktif ürünlerin fiyatlarını güncelle (static method)
productSchema.statics.updateAllPrices = async function() {
  const products = await this.find({ isActive: true });
  
  for (const product of products) {
    await product.updatePrice();
  }
  
  return products;
};

// Kategoriye göre ürünleri getir
productSchema.statics.getByCategory = function(category) {
  return this.find({ category, isActive: true });
};

// Trend ürünleri getir
productSchema.statics.getTrending = function() {
  return this.find({ trending: true, isActive: true });
};

// Indexes
productSchema.index({ category: 1, isActive: 1 });
productSchema.index({ trending: 1, isActive: 1 });
productSchema.index({ minLevel: 1 });

module.exports = mongoose.model('Product', productSchema);
