const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const Player = require('../models/Player');
const Transaction = require('../models/Transaction');
const Event = require('../models/Event');

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

module.exports = router;
