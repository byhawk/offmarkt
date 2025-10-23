const mongoose = require('mongoose');

/**
 * MarketSettings Model
 * Global pazar ayarları - Singleton pattern (tek kayıt)
 */
const marketSettingsSchema = new mongoose.Schema({
  // Fiyat güncelleme sıklığı (tick sayısı)
  updateFrequency: {
    type: Number,
    default: 6, // 6 tick = 30 saniye (her tick 5s)
    min: 1,
    max: 120
  },

  // Arz-talep dengesinin fiyat üzerindeki etkisi (%)
  demandEffect: {
    type: Number,
    default: 15,
    min: 0,
    max: 50
  },

  // Rastgele volatilite (%)
  randomVolatility: {
    type: Number,
    default: 10,
    min: 0,
    max: 30
  },

  // Maksimum fiyat çarpanı (basePrice * maxPriceMultiplier)
  maxPriceMultiplier: {
    type: Number,
    default: 2.0,
    min: 1.0,
    max: 5.0
  },

  // Minimum fiyat çarpanı (basePrice * minPriceMultiplier)
  minPriceMultiplier: {
    type: Number,
    default: 0.5,
    min: 0.1,
    max: 1.0
  },

  // Otomatik güncelleme aktif mi?
  autoUpdate: {
    type: Boolean,
    default: true
  },

  // Son güncelleme
  updatedAt: {
    type: Date,
    default: Date.now
  },

  // Güncelleyen admin
  updatedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Admin'
  }
}, {
  timestamps: true
});

// Singleton pattern - sadece bir kayıt olacak
marketSettingsSchema.statics.getSingleton = async function() {
  let settings = await this.findOne();

  if (!settings) {
    // Yoksa default değerlerle oluştur
    settings = await this.create({});
  }

  return settings;
};

// Ayarları güncelle
marketSettingsSchema.statics.updateSettings = async function(data, adminId) {
  let settings = await this.getSingleton();

  Object.assign(settings, data);
  settings.updatedBy = adminId;
  settings.updatedAt = new Date();

  await settings.save();
  return settings;
};

const MarketSettings = mongoose.model('MarketSettings', marketSettingsSchema);

module.exports = MarketSettings;
