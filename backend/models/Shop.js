// Import mongoose at the top
const mongoose = require('mongoose');

// === EXISTING SHOP MODEL ===
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
  squareMeters: {
    type: Number,
    required: true
  },
  floor: {
    type: Number,
    required: true
  },
  monthlyRent: {
    type: Number,
    required: true
  },
  deposit: {
    type: Number,
    required: true
  },
  hasWindow: {
    type: Boolean,
    default: false
  },
  parkingSpaces: {
    type: Number,
    default: 0
  },
  isAvailable: {
    type: Boolean,
    default: true
  },
  rentedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player'
  },
  isActive: {
    type: Boolean,
    default: true
  },
  monthlyRevenue: {
    type: Number,
    default: 0
  },
  monthlyCustomers: {
    type: Number,
    default: 0
  },
  listedProducts: [{
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Product'
    },
    minStock: Number,
    maxStock: Number,
    currentStock: { type: Number, default: 0 },
    listPrice: Number,
    autoPurchase: { type: Boolean, default: true },
    isActive: { type: Boolean, default: true }
  }],
  autoPurchaseSettings: {
    enableBalanceControl: { type: Boolean, default: true },
    balanceInterval: { type: Number, default: 3600000 },
    priceAdjustmentRate: { type: Number, default: 0.02 },
    smartPricing: { type: Boolean, default: true }
  }
}, { timestamps: true });

// ShopType Schema - Admin tarafından oluşturulan template'lar
const shopTypeSchema = new mongoose.Schema({
  shopType: {
    type: String,
    required: true,
    unique: true,
    enum: ['supermarket', 'flower_shop', 'clothing_store', 'jewelry_store', 'food_shop', 'electronics', 'general'],
  },
  displayName: {
    type: String,
    required: true,
    trim: true
  },
  nameTemplate: {
    type: String,
    default: '{ŞEHİR} {TÜR}',
    trim: true
  },
  // Satın alma fiyatı (kira yok, satın alma var)
  purchasePrice: {
    type: Number,
    required: true,
    min: 1000
  },
  // Kapasiteler
  rackCapacity: {
    type: Number,
    required: true,
    min: 100
  },
  storageCapacity: {
    type: Number,
    required: true,
    min: 100
  },
  // İstatistikler
  minCustomers: {
    type: Number,
    default: 10,
    min: 0
  },
  locationType: {
    type: String,
    required: true,
    enum: ['street', 'mall', 'market', 'office', 'warehouse']
  },
  // İzin verilen ürün kategorileri
  allowedCategories: {
    type: [String],
    required: true,
    default: []
  },
  isActive: {
    type: Boolean,
    default: true
  }
}, {
  timestamps: true
});

// ShopInstance Schema - Oyuncuların satın aldığı mağazalar
const shopInstanceSchema = new mongoose.Schema({
  // Bağlı olduğu type
  shopType: {
    type: String,
    required: true,
    enum: ['supermarket', 'flower_shop', 'clothing_store', 'jewelry_store', 'food_shop', 'electronics', 'general'],
  },
  // Oyuncu bilgileri
  ownerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true
  },
  // Konum
  country: {
    type: String,
    required: true,
    trim: true
  },
  city: {
    type: String,
    required: true,
    trim: true
  },
  // Özel isim
  customName: {
    type: String,
    required: true,
    trim: true
  },
  // Satın alma tarihi
  purchasedAt: {
    type: Date,
    default: Date.now
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
  
  // TICK-BASED INVENTORY SYSTEM
  inventory: [{
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Product',
      required: true
    },
    quantity: {
      type: Number,
      required: true,
      min: 0
    },
    purchasePrice: {
      type: Number, // Alış fiyatı (kar hesabı için)
      required: true
    },
    sellPrice: {
      type: Number, // Satış fiyatı
      required: true
    },
    listedAt: {
      type: Date,
      default: Date.now
    },
    totalSold: {
      type: Number, // Bu batch'ten satılan
      default: 0
    },
    lastSoldAt: {
      type: Date
    }
  }],

  // SALES STATISTICS
  salesStats: {
    todaySales: {
      type: Number,
      default: 0
    },
    totalRevenue: {
      type: Number,
      default: 0
    },
    totalProfit: {
      type: Number,
      default: 0
    },
    avgSalePrice: {
      type: Number,
      default: 0
    },
    totalItemsSold: {
      type: Number,
      default: 0
    },
    lastResetAt: {
      type: Date,
      default: Date.now
    }
  },

  // AUTO-SELL SETTINGS
  settings: {
    autoSellEnabled: {
      type: Boolean,
      default: true
    },
    minProfitMargin: {
      type: Number, // Minimum kar marjı %
      default: 10,
      min: 0,
      max: 100
    },
    maxStockPerProduct: {
      type: Number,
      default: 100,
      min: 1
    },
    enablePriceOptimization: {
      type: Boolean,
      default: true
    }
  },

  // Ürün listeleme sistemi (ESKI SISTEM - Backward compatibility)
  listedProducts: [{
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Product',
      required: true
    },
    minStock: {
      type: Number,
      default: 5,
      min: 1
    },
    maxStock: {
      type: Number,
      default: 20,
      min: 1
    },
    currentStock: {
      type: Number,
      default: 0,
      min: 0
    },
    listPrice: {
      type: Number,
      required: true,
      min: 0.01
    },
    autoPurchase: {
      type: Boolean,
      default: true
    },
    isActive: {
      type: Boolean,
      default: true
    },
    totalSold: {
      type: Number,
      default: 0
    },
    lastPurchaseDate: {
      type: Date,
      default: null
    },
    priceHistory: [{
      price: Number,
      changedAt: {
        type: Date,
        default: Date.now
      },
      reason: {
        type: String,
        enum: ['manual', 'supply_demand', 'inflation']
      }
    }]
  }],

  // Otomatik alım ayarları
  autoPurchaseSettings: {
    enableBalanceControl: {
      type: Boolean,
      default: true
    },
    balanceInterval: {
      type: Number,
      default: 3600000, // 1 saat
      min: 300000 // 5 dakika minimum
    },
    priceAdjustmentRate: {
      type: Number,
      default: 0.02, // %2
      min: 0,
      max: 0.1 // %10 maximum
    },
    smartPricing: {
      type: Boolean,
      default: true
    }
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
shopSchema.methods.rent = function(playerId) {
  this.isAvailable = false;
  this.rentedBy = playerId;
  this.rentedAt = new Date();
  return this.save();
};

// Dükkanı bırak
shopSchema.methods.leave = function() {
  this.isAvailable = true;
  this.rentedBy = null;
  this.rentedAt = null;
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

// Ürün listeleme metodları
shopSchema.methods.addListedProduct = function(productId, listPrice, minStock = 5, maxStock = 20) {
  // Aynı ürün zaten listelenmiş mi kontrol et
  const existingProduct = this.listedProducts.find(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (existingProduct) {
    throw new Error('Bu ürün zaten dükkanınızda listelenmiş durumda');
  }

  this.listedProducts.push({
    productId,
    listPrice,
    minStock,
    maxStock,
    currentStock: 0,
    isActive: true,
    priceHistory: [{
      price: listPrice,
      changedAt: new Date(),
      reason: 'manual'
    }]
  });

  return this.save();
};

// Ürün güncelleme
shopSchema.methods.updateListedProduct = function(productId, updates) {
  const product = this.listedProducts.find(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (!product) {
    throw new Error('Ürün bulunamadı');
  }

  // Fiyat değişikliği varsa geçmişe kaydet
  if (updates.listPrice && updates.listPrice !== product.listPrice) {
    product.priceHistory.push({
      price: updates.listPrice,
      changedAt: new Date(),
      reason: updates.priceChangeReason || 'manual'
    });
  }

  // Güncellemeleri uygula
  Object.assign(product, updates);
  return this.save();
};

// Ürün satıştan kaldırma
shopSchema.methods.removeListedProduct = function(productId) {
  const productIndex = this.listedProducts.findIndex(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (productIndex === -1) {
    throw new Error('Ürün bulunamadı');
  }

  this.listedProducts[productIndex].isActive = false;
  return this.save();
};

// Stok güncelleme (satış sonrası veya alım sonrası)
shopSchema.methods.updateProductStock = function(productId, quantityChange, isSale = false) {
  const product = this.listedProducts.find(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (!product) {
    throw new Error('Ürün bulunamadı');
  }

  product.currentStock += quantityChange;

  if (isSale) {
    product.totalSold += Math.abs(quantityChange);
    product.lastPurchaseDate = new Date();
  }

  // Stok sınırlarını kontrol et
  if (product.currentStock < 0) {
    product.currentStock = 0;
  }

  return this.save();
};

// Otomatik alım kontrolü - stok yeniden doldurma
shopSchema.methods.checkAndAutoPurchase = function() {
  const productsToPurchase = [];

  for (const product of this.listedProducts) {
    if (!product.isActive || !product.autoPurchase) continue;

    if (product.currentStock < product.minStock) {
      const quantityToPurchase = product.maxStock - product.currentStock;
      productsToPurchase.push({
        productId: product.productId,
        quantity: quantityToPurchase,
        currentPrice: product.listPrice
      });
    }
  }

  return productsToPurchase;
};

// Arz/talep bazlı fiyat güncelleme
shopSchema.methods.adjustPriceForSupplyDemand = function(productId, globalSupplyRatio) {
  const product = this.listedProducts.find(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (!product || !this.autoPurchaseSettings.smartPricing) {
    return null;
  }

  const adjustmentRate = this.autoPurchaseSettings.priceAdjustmentRate;
  let newPrice = product.listPrice;

  // Arz fazlaysa fiyat düşür (daha fazla arz)
  if (globalSupplyRatio > 1.5) {
    newPrice *= (1 - adjustmentRate);
  }
  // Arz azsa fiyat artır (daha az arz)
  else if (globalSupplyRatio < 0.5) {
    newPrice *= (1 + adjustmentRate);
  }

  // Çok aşırı değişiklikleri önle
  const maxChange = product.listPrice * 0.5; // %50'ye kadar değişiklik
  newPrice = Math.max(product.listPrice - maxChange, Math.min(product.listPrice + maxChange, newPrice));

  if (newPrice !== product.listPrice) {
    product.priceHistory.push({
      price: newPrice,
      changedAt: new Date(),
      reason: 'supply_demand'
    });
    product.listPrice = newPrice;
    return this.save();
  }

  return null;
};

// Aktif ürünleri getir
shopSchema.methods.getActiveListedProducts = function() {
  return this.listedProducts.filter(p => p.isActive);
};

// Stok istatistikleri
shopSchema.methods.getStockStatistics = function() {
  const activeProducts = this.getActiveListedProducts();
  const totalValue = activeProducts.reduce((sum, p) => sum + (p.currentStock * p.listPrice), 0);

  return {
    totalProducts: activeProducts.length,
    totalStockValue: totalValue,
    lowStockProducts: activeProducts.filter(p => p.currentStock < p.minStock).length,
    highStockProducts: activeProducts.filter(p => p.currentStock > p.maxStock).length
  };
};

// ShopType model methods
shopTypeSchema.methods.getPurchasePrice = function() {
  return this.purchasePrice;
};

// ShopInstance model methods - eski methods'ları taşıyoruz
shopInstanceSchema.methods.updateRevenue = function(revenue, customers) {
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

// ShopInstance statics
shopInstanceSchema.statics.getPlayerInstances = function(playerId) {
  return this.find({ ownerId: playerId, isActive: true });
};

shopInstanceSchema.statics.getByCity = function(country, city) {
  return this.find({ country, city, isActive: true });
};

// Ürün listeleme metodları - mevcut code
shopInstanceSchema.methods.addListedProduct = function(productId, listPrice, minStock = 5, maxStock = 20) {
  const existingProduct = this.listedProducts.find(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (existingProduct) {
    throw new Error('Bu ürün zaten dükkanınızda listelenmiş durumda');
  }

  this.listedProducts.push({
    productId,
    listPrice,
    minStock,
    maxStock,
    currentStock: 0,
    isActive: true,
    priceHistory: [{
      price: listPrice,
      changedAt: new Date(),
      reason: 'manual'
    }]
  });

  return this.save();
};

shopInstanceSchema.methods.updateListedProduct = function(productId, updates) {
  const product = this.listedProducts.find(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (!product) {
    throw new Error('Ürün bulunamadı');
  }

  if (updates.listPrice && updates.listPrice !== product.listPrice) {
    product.priceHistory.push({
      price: updates.listPrice,
      changedAt: new Date(),
      reason: updates.priceChangeReason || 'manual'
    });
  }

  Object.assign(product, updates);
  return this.save();
};

shopInstanceSchema.methods.removeListedProduct = function(productId) {
  const productIndex = this.listedProducts.findIndex(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (productIndex === -1) {
    throw new Error('Ürün bulunamadı');
  }

  this.listedProducts[productIndex].isActive = false;
  return this.save();
};

shopInstanceSchema.methods.updateProductStock = function(productId, quantityChange, isSale = false) {
  const product = this.listedProducts.find(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (!product) {
    throw new Error('Ürün bulunamadı');
  }

  product.currentStock += quantityChange;

  if (isSale) {
    product.totalSold += Math.abs(quantityChange);
    product.lastPurchaseDate = new Date();
  }

  if (product.currentStock < 0) {
    product.currentStock = 0;
  }

  return this.save();
};

shopInstanceSchema.methods.adjustPriceForSupplyDemand = function(productId, globalSupplyRatio) {
  const product = this.listedProducts.find(
    p => p.productId.toString() === productId.toString() && p.isActive
  );

  if (!product || !this.autoPurchaseSettings.smartPricing) {
    return null;
  }

  const adjustmentRate = this.autoPurchaseSettings.priceAdjustmentRate;
  let newPrice = product.listPrice;

  if (globalSupplyRatio > 1.5) {
    newPrice *= (1 - adjustmentRate);
  }
  else if (globalSupplyRatio < 0.5) {
    newPrice *= (1 + adjustmentRate);
  }

  const maxChange = product.listPrice * 0.5;
  newPrice = Math.max(product.listPrice - maxChange, Math.min(product.listPrice + maxChange, newPrice));

  if (newPrice !== product.listPrice) {
    product.priceHistory.push({
      price: newPrice,
      changedAt: new Date(),
      reason: 'supply_demand'
    });
    product.listPrice = newPrice;
    return this.save();
  }

  return null;
};

shopInstanceSchema.methods.getActiveListedProducts = function() {
  return this.listedProducts.filter(p => p.isActive);
};

shopInstanceSchema.methods.getStockStatistics = function() {
  const activeProducts = this.getActiveListedProducts();
  const totalValue = activeProducts.reduce((sum, p) => sum + (p.currentStock * p.listPrice), 0);

  return {
    totalProducts: activeProducts.length,
    totalStockValue: totalValue,
    lowStockProducts: activeProducts.filter(p => p.currentStock < p.minStock).length,
    highStockProducts: activeProducts.filter(p => p.currentStock > p.maxStock).length
  };
};

// Indexes
shopTypeSchema.index({ shopType: 1, isActive: 1 });
shopInstanceSchema.index({ ownerId: 1, isActive: 1 });
shopInstanceSchema.index({ shopType: 1 });
shopInstanceSchema.index({ country: 1, city: 1 });
shopInstanceSchema.index({ 'listedProducts.productId': 1 });
shopInstanceSchema.index({ 'listedProducts.isActive': 1 });

const Shop = mongoose.model('Shop', shopSchema);

// Export all models
const ShopType = mongoose.model('ShopType', shopTypeSchema);
const ShopInstance = mongoose.model('ShopInstance', shopInstanceSchema);

module.exports = {
  Shop,
  ShopType,
  ShopInstance
};
