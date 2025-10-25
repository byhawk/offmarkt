const mongoose = require('mongoose');

const globalEventSchema = new mongoose.Schema({
  // Event Info
  type: {
    type: String,
    enum: [
      'economic_crisis',
      'boom_period',
      'natural_disaster',
      'technology_breakthrough',
      'weather_change',
      'epidemic',
      'policy_change',
      'trade_change'
    ],
    required: true
  },
  name: {
    type: String,
    required: true
  },
  description: String,
  
  // Severity
  severity: {
    type: String,
    enum: ['low', 'medium', 'high'],
    default: 'medium'
  },
  
  // Impact
  impact: {
    priceChange: {
      type: Number,
      default: 0 // -0.2 to 0.2 (percentage)
    },
    demandChange: {
      type: Number,
      default: 0
    },
    affectedProductTypes: [String],
    affectedLocations: [String],
    customEffects: mongoose.Schema.Types.Mixed
  },
  
  // Duration
  startDate: {
    type: Date,
    default: Date.now
  },
  endDate: Date,
  durationHours: {
    type: Number,
    default: 24
  },
  
  // Status
  isActive: {
    type: Boolean,
    default: true
  },
  isTriggered: {
    type: Boolean,
    default: false
  },
  triggeredAt: Date,
  
  // Affected Players
  affectedPlayers: [{
    playerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Player'
    },
    impact: mongoose.Schema.Types.Mixed,
    notified: {
      type: Boolean,
      default: false
    }
  }],
  
  // Statistics
  totalAffectedPlayers: {
    type: Number,
    default: 0
  },
  totalImpact: {
    type: Number,
    default: 0
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
globalEventSchema.index({ isActive: 1, endDate: 1 });
globalEventSchema.index({ type: 1 });
globalEventSchema.index({ startDate: -1 });

// Methods
globalEventSchema.methods.trigger = async function() {
  this.isTriggered = true;
  this.triggeredAt = new Date();
  
  if (!this.endDate) {
    this.endDate = new Date(Date.now() + this.durationHours * 60 * 60 * 1000);
  }
  
  return this.save();
};

globalEventSchema.methods.deactivate = function() {
  this.isActive = false;
  return this.save();
};

globalEventSchema.methods.getEventEmoji = function() {
  const emojis = {
    economic_crisis: '📉',
    boom_period: '📈',
    natural_disaster: '🌪️',
    technology_breakthrough: '🚀',
    weather_change: '🌤️',
    epidemic: '🦠',
    policy_change: '📋',
    trade_change: '🚢'
  };
  return emojis[this.type] || '⚡';
};

globalEventSchema.methods.getDescription = function() {
  const descriptions = {
    economic_crisis: 'Ekonomik kriz! Tüm ürün fiyatları %20 düşüyor.',
    boom_period: 'Boom dönemi! Tüm ürün fiyatları %20 yükseliyor.',
    natural_disaster: 'Doğal afet! Rastgele şehirde dükkanlar zarar görüyor.',
    technology_breakthrough: 'Teknoloji atılımı! R&D başarı oranı %30 artıyor.',
    weather_change: 'Hava durumu değişimi! Mevsimsel ürünler etkileniyor.',
    epidemic: 'Salgın! Sağlık ürünleri talep artıyor.',
    policy_change: 'Politika değişimi! Vergi oranları değişiyor.',
    trade_change: 'Dış ticaret değişimi! İthalatçı ürünler pahalılaşıyor.'
  };
  return descriptions[this.type] || this.description;
};

module.exports = mongoose.model('GlobalEvent', globalEventSchema);
