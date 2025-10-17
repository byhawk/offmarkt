const mongoose = require('mongoose');

const eventSchema = new mongoose.Schema({
  playerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true
  },
  type: {
    type: String,
    required: true,
    enum: [
      'marketCrash',
      'marketBoom',
      'luckyFind',
      'robbery',
      'taxInspection',
      'policeRaid',
      'gangOffer',
      'debtCollector',
      'businessOpportunity'
    ]
  },
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  effects: [{
    type: {
      type: String,
      enum: [
        'cashGain',
        'cashLoss',
        'priceChange',
        'reputationChange',
        'riskIncrease',
        'riskDecrease',
        'inventoryLoss',
        'inventoryGain',
        'expGain',
        'futureIncome'
      ]
    },
    value: Number,
    target: String,
    duration: Number
  }],
  choices: [{
    id: String,
    text: String,
    effects: [{
      type: String,
      value: Number,
      target: String
    }]
  }],
  duration: {
    type: Number,
    default: 0
  },
  status: {
    type: String,
    enum: ['active', 'completed', 'expired'],
    default: 'active'
  },
  selectedChoice: {
    type: String,
    default: null
  },
  expiresAt: {
    type: Date,
    default: null
  }
}, {
  timestamps: true
});

// Olay tamamla
eventSchema.methods.complete = function(choiceId = null) {
  this.status = 'completed';
  this.selectedChoice = choiceId;
  return this.save();
};

// Olay süresi doldu
eventSchema.methods.expire = function() {
  this.status = 'expired';
  return this.save();
};

// Rastgele olay oluştur (static)
eventSchema.statics.createRandomEvent = async function(player) {
  const eventTypes = ['marketCrash', 'marketBoom', 'luckyFind', 'robbery'];
  
  // Oyuncu durumuna göre ek olaylar
  if (player.cash > 50000) eventTypes.push('taxInspection');
  if (player.legalReputation < 40) eventTypes.push('policeRaid');
  if (player.streetReputation > 60) eventTypes.push('gangOffer');
  if (player.debt > 20000) eventTypes.push('debtCollector');
  if (player.level >= 10) eventTypes.push('businessOpportunity');
  
  // Rastgele olay seç
  const randomType = eventTypes[Math.floor(Math.random() * eventTypes.length)];
  
  // Olay detaylarını oluştur
  const eventData = generateEventData(randomType, player);
  
  const event = new this({
    playerId: player._id,
    ...eventData
  });
  
  return event.save();
};

// Aktif olayları getir (static)
eventSchema.statics.getActiveEvents = function(playerId) {
  return this.find({
    playerId,
    status: 'active',
    $or: [
      { expiresAt: null },
      { expiresAt: { $gt: new Date() } }
    ]
  });
};

// Olay geçmişini getir (static)
eventSchema.statics.getHistory = function(playerId, limit = 50) {
  return this.find({
    playerId,
    status: { $in: ['completed', 'expired'] }
  })
  .sort({ createdAt: -1 })
  .limit(limit);
};

// Süresi dolan olayları kontrol et (static)
eventSchema.statics.checkExpiredEvents = async function() {
  const expiredEvents = await this.find({
    status: 'active',
    expiresAt: { $lte: new Date() }
  });
  
  for (const event of expiredEvents) {
    await event.expire();
  }
  
  return expiredEvents;
};

// Olay detayları oluştur
function generateEventData(type, player) {
  switch (type) {
    case 'marketCrash':
      return {
        type,
        title: '📉 Piyasa Çöküşü',
        description: 'Ani bir kriz nedeniyle tüm ürünlerin fiyatları %20 düştü!',
        effects: [{
          type: 'priceChange',
          value: -0.20,
          target: 'all_products'
        }],
        duration: 2
      };
      
    case 'marketBoom':
      const categories = ['electronics', 'jewelry', 'vehicles'];
      const category = categories[Math.floor(Math.random() * categories.length)];
      return {
        type,
        title: '📈 Piyasa Canlanması',
        description: `${category} kategorisinde talep patlaması! Fiyatlar %30 arttı.`,
        effects: [{
          type: 'priceChange',
          value: 0.30,
          target: category
        }],
        duration: 3
      };
      
    case 'luckyFind':
      const amount = 5000 + Math.floor(Math.random() * 15000);
      return {
        type,
        title: '🍀 Şanslı Gün',
        description: `Sokakta ₺${amount} buldunuz!`,
        effects: [{
          type: 'cashGain',
          value: amount
        }]
      };
      
    case 'robbery':
      const stolenAmount = Math.min(player.cash * 0.1, 20000);
      return {
        type,
        title: '🚨 Soygun',
        description: `Hırsızlar sizi soydu! ₺${stolenAmount.toFixed(0)} kaybettiniz.`,
        effects: [
          { type: 'cashLoss', value: stolenAmount },
          { type: 'reputationChange', value: -5, target: 'street' }
        ]
      };
      
    case 'taxInspection':
      const tax = player.cash * 0.15;
      return {
        type,
        title: '🏛️ Vergi Denetimi',
        description: 'Vergi müfettişleri geldi! %15 vergi ödemek zorundasınız.',
        effects: [
          { type: 'cashLoss', value: tax },
          { type: 'reputationChange', value: 10, target: 'legal' }
        ],
        choices: [
          {
            id: 'pay',
            text: 'Vergini öde',
            effects: []
          },
          {
            id: 'bribe',
            text: `Rüşvet ver (₺${(tax * 0.5).toFixed(0)})`,
            effects: [
              { type: 'cashLoss', value: tax * 0.5 },
              { type: 'riskIncrease', value: 20 }
            ]
          }
        ]
      };
      
    case 'gangOffer':
      return {
        type,
        title: '🌃 Çete Teklifi',
        description: 'Yerel çete size özel bir iş teklif etti. Riskli ama karlı!',
        effects: [],
        choices: [
          {
            id: 'accept',
            text: 'Kabul et (₺50,000 kar, yüksek risk)',
            effects: [
              { type: 'cashGain', value: 50000 },
              { type: 'riskIncrease', value: 40 },
              { type: 'reputationChange', value: 15, target: 'street' }
            ]
          },
          {
            id: 'decline',
            text: 'Reddet (Güvenli)',
            effects: [
              { type: 'reputationChange', value: -5, target: 'street' }
            ]
          }
        ]
      };
      
    default:
      return {
        type,
        title: 'Olay',
        description: 'Bir şeyler oldu...',
        effects: []
      };
  }
}

// Indexes
eventSchema.index({ playerId: 1, status: 1 });
eventSchema.index({ type: 1 });
eventSchema.index({ createdAt: -1 });
eventSchema.index({ expiresAt: 1, status: 1 });

module.exports = mongoose.model('Event', eventSchema);
