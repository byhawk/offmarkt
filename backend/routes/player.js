const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const Player = require('../models/Player');
const Transaction = require('../models/Transaction');
const Event = require('../models/Event');
const { ShopType, ShopInstance } = require('../models/Shop');

// @route   GET /api/player/profile
// @desc    Profil bilgisi
// @access  Private
router.get('/profile', protect, asyncHandler(async (req, res) => {
  res.json({
    success: true,
    data: { player: req.user }
  });
}));

// @route   PUT /api/player/profile
// @desc    Profil güncelle
// @access  Private
router.put('/profile', protect, asyncHandler(async (req, res) => {
  const { name } = req.body;

  if (name) {
    req.user.name = name;
    await req.user.save();
  }

  res.json({
    success: true,
    message: 'Profil güncellendi',
    data: { player: req.user }
  });
}));

// @route   GET /api/player/stats
// @desc    İstatistikler
// @access  Private
router.get('/stats', protect, asyncHandler(async (req, res) => {
  const profitStats = await Transaction.calculateTotalProfit(req.user._id);
  const typeStats = await Transaction.getStatsByType(req.user._id);
  const dailyStats = await Transaction.getDailyStats(req.user._id, 7);

  res.json({
    success: true,
    data: {
      player: {
        level: req.user.level,
        experience: req.user.experience,
        netWorth: req.user.getNetWorth(),
        currentDay: req.user.currentDay
      },
      transactions: profitStats,
      byType: typeStats,
      daily: dailyStats
    }
  });
}));

// @route   GET /api/player/inventory
// @desc    Envanter
// @access  Private
router.get('/inventory', protect, asyncHandler(async (req, res) => {
  const player = await Player.findById(req.user._id).populate('inventory.productId');

  res.json({
    success: true,
    data: {
      inventory: player.inventory,
      totalValue: player.portfolioValue
    }
  });
}));

// @route   POST /api/player/advance-day
// @desc    Gün ilerlet
// @access  Private
router.post('/advance-day', protect, asyncHandler(async (req, res) => {
  req.user.currentDay += 1;

  // Risk azalt
  req.user.riskLevel = Math.max(0, req.user.riskLevel - 5);
  req.user.suspicionLevel = Math.max(0, req.user.suspicionLevel - 3);

  // Rastgele olay tetikle (%30 şans)
  let event = null;
  if (Math.random() < 0.3) {
    event = await Event.createRandomEvent(req.user);
  }

  await req.user.save();

  res.json({
    success: true,
    message: `Gün ${req.user.currentDay}`,
    data: {
      currentDay: req.user.currentDay,
      riskLevel: req.user.riskLevel,
      event: event || null
    }
  });
}));

// @route   POST /api/player/bank/deposit
// @desc    Bankaya para yatır
// @access  Private
router.post('/bank/deposit', protect, asyncHandler(async (req, res) => {
  const { amount } = req.body;

  if (!amount || amount <= 0) {
    return res.status(400).json({
      success: false,
      message: 'Geçerli bir miktar girin'
    });
  }

  if (req.user.cash < amount) {
    return res.status(400).json({
      success: false,
      message: 'Yetersiz nakit'
    });
  }

  req.user.cash -= amount;
  req.user.bankAccount += amount;
  await req.user.save();

  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'deposit',
    amount,
    description: 'Bankaya para yatırma'
  });

  res.json({
    success: true,
    message: 'Para yatırıldı',
    data: {
      cash: req.user.cash,
      bankAccount: req.user.bankAccount
    }
  });
}));

// @route   POST /api/player/bank/withdraw
// @desc    Bankadan para çek
// @access  Private
router.post('/bank/withdraw', protect, asyncHandler(async (req, res) => {
  const { amount } = req.body;

  if (!amount || amount <= 0) {
    return res.status(400).json({
      success: false,
      message: 'Geçerli bir miktar girin'
    });
  }

  if (req.user.bankAccount < amount) {
    return res.status(400).json({
      success: false,
      message: 'Yetersiz bakiye'
    });
  }

  req.user.bankAccount -= amount;
  req.user.cash += amount;
  await req.user.save();

  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'withdraw',
    amount,
    description: 'Bankadan para çekme'
  });

  res.json({
    success: true,
    message: 'Para çekildi',
    data: {
      cash: req.user.cash,
      bankAccount: req.user.bankAccount
    }
  });
}));

/**
 * YENİ ÇOKLU MAĞAZA SİSTEMİ ENDPOINT'LARI
 */

// @route   GET /api/player/shop-types
// @desc    Aktif dükkan çeşitlerini listele
// @access  Private
router.get('/shop-types', protect, asyncHandler(async (req, res) => {
  const shopTypes = await ShopType.find({ isActive: true });

  res.json({
    success: true,
    data: { shopTypes }
  });
}));

// @route   POST /api/player/shops/purchase
// @desc    Yeni mağaza satın al
// @access  Private
router.post('/shops/purchase', protect, asyncHandler(async (req, res) => {
  const { shopType, country, city, customName } = req.body;

  // Validation
  if (!shopType || !country || !city) {
    return res.status(400).json({
      success: false,
      message: 'Gerekli alanlar eksik'
    });
  }

  // Shop type kontrol et
  const typeInfo = await ShopType.findOne({ shopType, isActive: true });
  if (!typeInfo) {
    return res.status(404).json({
      success: false,
      message: 'Bu dükkan türü bulunamadı veya aktif değil'
    });
  }

  // Aynı şehir/türde mağaza var mı kontrol et (opcional olabilir)
  const existingShop = await ShopInstance.findOne({
    ownerId: req.user._id,
    shopType,
    country,
    city,
    isActive: true
  });

  if (existingShop) {
    return res.status(400).json({
      success: false,
      message: 'Bu şehirde aynı türden mağazanız zaten var'
    });
  }

  // Para yeter mi kontrol et
  if (req.user.cash < typeInfo.purchasePrice) {
    return res.status(400).json({
      success: false,
      message: 'Yetersiz bakiye'
    });
  }

  // Ad template kullanarak mağaza adı oluştur
  const finalName = customName || typeInfo.nameTemplate
    .replace('{ŞEHİR}', city)
    .replace('{TÜR}', typeInfo.displayName);

  // Mağaza oluştur
  const newInstance = await ShopInstance.create({
    shopType: typeInfo.shopType,
    ownerId: req.user._id,
    country,
    city,
    customName: finalName,
    purchasedAt: new Date()
  });

  // Oyuncu parasını düşür
  req.user.cash -= typeInfo.purchasePrice;
  await req.user.save();

  // Transaction kaydı
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'shop_purchase',
    amount: typeInfo.purchasePrice,
    description: `${city} ${typeInfo.displayName} mağaza satın alma`
  });

  res.status(201).json({
    success: true,
    message: 'Mağaza başarıyla açıldı!',
    data: {
      shop: newInstance,
      player: {
        cash: req.user.cash,
        bankAccount: req.user.bankAccount
      }
    }
  });
}));

// @route   GET /api/player/shops
// @desc    Oyuncunun mağazalarını listele
// @access  Private
router.get('/shops', protect, asyncHandler(async (req, res) => {
  const instances = await ShopInstance.find({
    ownerId: req.user._id,
    isActive: true
  }).populate('shopType').sort({ purchasedAt: -1 });

  res.json({
    success: true,
    data: { shops: instances }
  });
}));

// @route   GET /api/player/shops/:shopId
// @desc    Mağaza detayı
// @access  Private
router.get('/shops/:shopId', protect, asyncHandler(async (req, res) => {
  const instance = await ShopInstance.findOne({
    _id: req.params.shopId,
    ownerId: req.user._id,
    isActive: true
  }).populate('shopType');

  if (!instance) {
    return res.status(404).json({
      success: false,
      message: 'Mağaza bulunamadı'
    });
  }

  res.json({
    success: true,
    data: { shop: instance }
  });
}));

// @route   DELETE /api/player/shops/:shopId
// @desc    Mağaza geri sat (opsiyonel feature)
// @access  Private
router.delete('/shops/:shopId', protect, asyncHandler(async (req, res) => {
  const instance = await ShopInstance.findOne({
    _id: req.params.shopId,
    ownerId: req.user._id,
    isActive: true
  });

  if (!instance) {
    return res.status(404).json({
      success: false,
      message: 'Mağaza bulunamadı'
    });
  }

  // Mağaza yerine satma mantığı: %50 geri ödeme
  const refundAmount = Math.floor(instance.shopType.purchasePrice * 0.5);

  // Mağaza pasifleştir
  instance.isActive = false;
  await instance.save();

  // Para geri ver
  req.user.cash += refundAmount;
  await req.user.save();

  // Transaction
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'shop_sell',
    amount: refundAmount,
    description: `${instance.customName} mağaza satışı (iade)`
  });

  res.json({
    success: true,
    message: `Mağaza geri satıldı. ₺${refundAmount} iade edildi`,
    data: {
      refundAmount,
      player: {
        cash: req.user.cash,
        bankAccount: req.user.bankAccount
      }
    }
  });
}));

module.exports = router;
