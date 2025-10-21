const mongoose = require('mongoose');

const transactionSchema = new mongoose.Schema({
  playerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Player',
    required: true
  },
  type: {
    type: String,
    required: true,
    enum: [
      'buy',
      'sell',
      'rent_shop',
      'purchase_shop',
      'leave_shop',
      'deposit',
      'withdraw',
      'loan_taken',
      'loan_payment',
      'event_reward',
      'event_penalty',
      'level_reward',
      'other'
    ]
  },
  amount: {
    type: Number,
    required: true
  },
  productId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Product',
    default: null
  },
  shopId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Shop',
    default: null
  },
  quantity: {
    type: Number,
    default: 0
  },
  price: {
    type: Number,
    default: 0
  },
  profit: {
    type: Number,
    default: 0
  },
  description: {
    type: String,
    default: ''
  },
  metadata: {
    type: mongoose.Schema.Types.Mixed,
    default: {}
  }
}, {
  timestamps: true
});

// İşlem oluştur (static)
transactionSchema.statics.createTransaction = function(data) {
  return this.create(data);
};

// Oyuncunun işlem geçmişini getir (static)
transactionSchema.statics.getPlayerHistory = function(playerId, options = {}) {
  const {
    type,
    limit = 50,
    skip = 0,
    startDate,
    endDate
  } = options;
  
  const query = { playerId };
  
  if (type) query.type = type;
  if (startDate || endDate) {
    query.createdAt = {};
    if (startDate) query.createdAt.$gte = startDate;
    if (endDate) query.createdAt.$lte = endDate;
  }
  
  return this.find(query)
    .sort({ createdAt: -1 })
    .limit(limit)
    .skip(skip)
    .populate('productId', 'name emoji category')
    .populate('shopId', 'name location');
};

// Toplam kar/zarar hesapla (static)
transactionSchema.statics.calculateTotalProfit = async function(playerId) {
  const result = await this.aggregate([
    { $match: { playerId: mongoose.Types.ObjectId(playerId) } },
    {
      $group: {
        _id: null,
        totalProfit: { $sum: '$profit' },
        totalTransactions: { $sum: 1 }
      }
    }
  ]);
  
  return result[0] || { totalProfit: 0, totalTransactions: 0 };
};

// Kategoriye göre istatistikler (static)
transactionSchema.statics.getStatsByType = async function(playerId) {
  return this.aggregate([
    { $match: { playerId: mongoose.Types.ObjectId(playerId) } },
    {
      $group: {
        _id: '$type',
        count: { $sum: 1 },
        totalAmount: { $sum: '$amount' },
        totalProfit: { $sum: '$profit' }
      }
    },
    { $sort: { count: -1 } }
  ]);
};

// Günlük istatistikler (static)
transactionSchema.statics.getDailyStats = async function(playerId, days = 7) {
  const startDate = new Date();
  startDate.setDate(startDate.getDate() - days);
  
  return this.aggregate([
    {
      $match: {
        playerId: mongoose.Types.ObjectId(playerId),
        createdAt: { $gte: startDate }
      }
    },
    {
      $group: {
        _id: {
          $dateToString: { format: '%Y-%m-%d', date: '$createdAt' }
        },
        count: { $sum: 1 },
        totalAmount: { $sum: '$amount' },
        totalProfit: { $sum: '$profit' }
      }
    },
    { $sort: { _id: 1 } }
  ]);
};

// Indexes
transactionSchema.index({ playerId: 1, createdAt: -1 });
transactionSchema.index({ type: 1 });
transactionSchema.index({ productId: 1 });
transactionSchema.index({ shopId: 1 });
transactionSchema.index({ createdAt: -1 });

module.exports = mongoose.model('Transaction', transactionSchema);
