const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { generateAdminToken, protectAdmin, checkPermission, requireSuperAdmin } = require('../middleware/adminAuth');
const Admin = require('../models/Admin');
const Player = require('../models/Player');
const Product = require('../models/Product');
const Shop = require('../models/Shop');
const Event = require('../models/Event');
const Transaction = require('../models/Transaction');
const BannedWord = require('../models/BannedWord');
const { body, validationResult } = require('express-validator');

// @route   POST /api/admin/login
// @desc    Admin giriş
// @access  Public
router.post('/login', [
  body('email').isEmail().withMessage('Geçerli bir email girin'),
  body('password').notEmpty().withMessage('Şifre gerekli')
], asyncHandler(async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      success: false,
      errors: errors.array()
    });
  }

  const { email, password } = req.body;
  const admin = await Admin.findOne({ email });

  if (!admin || !await admin.comparePassword(password)) {
    return res.status(401).json({
      success: false,
      message: 'Email veya şifre hatalı'
    });
  }

  if (!admin.isActive) {
    return res.status(403).json({
      success: false,
      message: 'Admin hesabı aktif değil'
    });
  }

  const token = generateAdminToken(admin._id);
  await admin.updateLogin(req.ip, req.get('user-agent'));

  res.json({
    success: true,
    data: {
      admin: {
        id: admin._id,
        username: admin.username,
        email: admin.email,
        role: admin.role,
        permissions: admin.permissions
      },
      token
    }
  });
}));

// @route   GET /api/admin/dashboard
// @desc    Dashboard istatistikleri
// @access  Private (Admin)
router.get('/dashboard', protectAdmin, checkPermission('view_analytics'), asyncHandler(async (req, res) => {
  const totalPlayers = await Player.countDocuments();
  const activePlayers = await Player.countDocuments({ isOnline: true });
  const bannedPlayers = await Player.countDocuments({ isBanned: true });
  
  const totalProducts = await Product.countDocuments({ isActive: true });
  const totalShops = await Shop.countDocuments({ isActive: true });
  const rentedShops = await Shop.countDocuments({ isAvailable: false });
  
  const totalTransactions = await Transaction.countDocuments();
  const todayTransactions = await Transaction.countDocuments({
    createdAt: { $gte: new Date(new Date().setHours(0, 0, 0, 0)) }
  });

  const topPlayers = await Player.find({ isActive: true })
    .select('username level totalProfit')
    .sort({ totalProfit: -1 })
    .limit(10);

  res.json({
    success: true,
    data: {
      players: {
        total: totalPlayers,
        active: activePlayers,
        banned: bannedPlayers
      },
      products: {
        total: totalProducts
      },
      shops: {
        total: totalShops,
        rented: rentedShops,
        available: totalShops - rentedShops
      },
      transactions: {
        total: totalTransactions,
        today: todayTransactions
      },
      topPlayers
    }
  });
}));

// @route   GET /api/admin/players
// @desc    Tüm oyuncular
// @access  Private (Admin)
router.get('/players', protectAdmin, checkPermission('manage_players'), asyncHandler(async (req, res) => {
  const { page = 1, limit = 50, search, status } = req.query;
  
  let query = {};
  if (search) {
    query.$or = [
      { username: new RegExp(search, 'i') },
      { email: new RegExp(search, 'i') }
    ];
  }
  if (status === 'banned') query.isBanned = true;
  if (status === 'active') query.isActive = true;
  if (status === 'online') query.isOnline = true;

  const players = await Player.find(query)
    .select('-password')
    .sort({ createdAt: -1 })
    .limit(parseInt(limit))
    .skip((parseInt(page) - 1) * parseInt(limit));

  const total = await Player.countDocuments(query);

  res.json({
    success: true,
    data: {
      players,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / parseInt(limit))
      }
    }
  });
}));

// @route   GET /api/admin/players/:id
// @desc    Oyuncu detayı
// @access  Private (Admin)
router.get('/players/:id', protectAdmin, checkPermission('manage_players'), asyncHandler(async (req, res) => {
  const player = await Player.findById(req.params.id)
    .select('-password')
    .populate('inventory.productId')
    .populate('ownedShops');

  if (!player) {
    return res.status(404).json({
      success: false,
      message: 'Oyuncu bulunamadı'
    });
  }

  const transactions = await Transaction.find({ playerId: player._id })
    .sort({ createdAt: -1 })
    .limit(20);

  res.json({
    success: true,
    data: {
      player,
      recentTransactions: transactions
    }
  });
}));

// @route   PUT /api/admin/players/:id/ban
// @desc    Oyuncu banla
// @access  Private (Admin)
router.put('/players/:id/ban', protectAdmin, checkPermission('ban_players'), asyncHandler(async (req, res) => {
  const { reason, duration } = req.body;
  const player = await Player.findById(req.params.id);

  if (!player) {
    return res.status(404).json({
      success: false,
      message: 'Oyuncu bulunamadı'
    });
  }

  player.isBanned = true;
  player.banReason = reason || 'Belirtilmemiş';
  if (duration) {
    player.banExpires = new Date(Date.now() + duration * 24 * 60 * 60 * 1000);
  }
  await player.save();

  res.json({
    success: true,
    message: 'Oyuncu banlandı',
    data: { player }
  });
}));

// @route   PUT /api/admin/players/:id/unban
// @desc    Oyuncu banını kaldır
// @access  Private (Admin)
router.put('/players/:id/unban', protectAdmin, checkPermission('ban_players'), asyncHandler(async (req, res) => {
  const player = await Player.findById(req.params.id);

  if (!player) {
    return res.status(404).json({
      success: false,
      message: 'Oyuncu bulunamadı'
    });
  }

  player.isBanned = false;
  player.banReason = null;
  player.banExpires = null;
  await player.save();

  res.json({
    success: true,
    message: 'Ban kaldırıldı',
    data: { player }
  });
}));

// @route   PUT /api/admin/players/:id/reset-password
// @desc    Oyuncu şifresini sıfırla
// @access  Private (Admin)
router.put('/players/:id/reset-password', protectAdmin, checkPermission('manage_players'), asyncHandler(async (req, res) => {
  const { newPassword } = req.body;
  
  if (!newPassword || newPassword.length < 6) {
    return res.status(400).json({
      success: false,
      message: 'Şifre en az 6 karakter olmalı'
    });
  }

  const player = await Player.findById(req.params.id);

  if (!player) {
    return res.status(404).json({
      success: false,
      message: 'Oyuncu bulunamadı'
    });
  }

  player.password = newPassword;
  await player.save();

  res.json({
    success: true,
    message: 'Şifre başarıyla sıfırlandı'
  });
}));

// @route   GET /api/admin/products
// @desc    Tüm ürünler
// @access  Private (Admin)
router.get('/products', protectAdmin, checkPermission('manage_products'), asyncHandler(async (req, res) => {
  const products = await Product.find().sort({ category: 1, name: 1 });
  
  res.json({
    success: true,
    data: { products }
  });
}));

// @route   POST /api/admin/products
// @desc    Yeni ürün ekle
// @access  Private (Admin)
router.post('/products', protectAdmin, checkPermission('manage_products'), asyncHandler(async (req, res) => {
  // Emoji ve currentPrice otomatik ekle
  const productData = {
    ...req.body,
    emoji: req.body.emoji || '📦',
    currentPrice: req.body.currentPrice || req.body.basePrice
  };
  
  const product = await Product.create(productData);
  
  res.status(201).json({
    success: true,
    message: 'Ürün eklendi',
    data: { product }
  });
}));

// @route   PUT /api/admin/products/:id
// @desc    Ürün güncelle
// @access  Private (Admin)
router.put('/products/:id', protectAdmin, checkPermission('manage_products'), asyncHandler(async (req, res) => {
  const product = await Product.findByIdAndUpdate(
    req.params.id,
    req.body,
    { new: true, runValidators: true }
  );

  if (!product) {
    return res.status(404).json({
      success: false,
      message: 'Ürün bulunamadı'
    });
  }

  res.json({
    success: true,
    message: 'Ürün güncellendi',
    data: { product }
  });
}));

// @route   DELETE /api/admin/products/:id
// @desc    Ürün sil
// @access  Private (Admin)
router.delete('/products/:id', protectAdmin, checkPermission('manage_products'), asyncHandler(async (req, res) => {
  const product = await Product.findByIdAndUpdate(
    req.params.id,
    { isActive: false },
    { new: true }
  );

  if (!product) {
    return res.status(404).json({
      success: false,
      message: 'Ürün bulunamadı'
    });
  }

  res.json({
    success: true,
    message: 'Ürün silindi'
  });
}));

// @route   PUT /api/admin/products/:id/toggle-active
// @desc    Ürünü pazara ekle/çıkar
// @access  Private (Admin)
router.put('/products/:id/toggle-active', protectAdmin, checkPermission('manage_products'), asyncHandler(async (req, res) => {
  const product = await Product.findById(req.params.id);

  if (!product) {
    return res.status(404).json({
      success: false,
      message: 'Ürün bulunamadı'
    });
  }

  product.isActive = !product.isActive;
  await product.save();

  res.json({
    success: true,
    message: product.isActive ? 'Ürün pazara eklendi' : 'Ürün pazardan çıkarıldı',
    data: { product }
  });
}));

// @route   GET /api/admin/shops
// @desc    Tüm dükkanlar
// @access  Private (Admin)
router.get('/shops', protectAdmin, checkPermission('manage_shops'), asyncHandler(async (req, res) => {
  const shops = await Shop.find()
    .populate('rentedBy', 'username email')
    .sort({ locationType: 1, monthlyRent: 1 });
  
  res.json({
    success: true,
    data: { shops }
  });
}));

// @route   POST /api/admin/shops
// @desc    Yeni dükkan ekle
// @access  Private (Admin)
router.post('/shops', protectAdmin, checkPermission('manage_shops'), asyncHandler(async (req, res) => {
  const shop = await Shop.create(req.body);
  
  res.status(201).json({
    success: true,
    message: 'Dükkan eklendi',
    data: { shop }
  });
}));

// @route   PUT /api/admin/shops/:id
// @desc    Dükkan güncelle
// @access  Private (Admin)
router.put('/shops/:id', protectAdmin, checkPermission('manage_shops'), asyncHandler(async (req, res) => {
  const shop = await Shop.findByIdAndUpdate(
    req.params.id,
    req.body,
    { new: true, runValidators: true }
  );

  if (!shop) {
    return res.status(404).json({
      success: false,
      message: 'Dükkan bulunamadı'
    });
  }

  res.json({
    success: true,
    message: 'Dükkan güncellendi',
    data: { shop }
  });
}));

// @route   POST /api/admin/events/trigger
// @desc    Manuel olay tetikle
// @access  Private (Admin)
router.post('/events/trigger', protectAdmin, checkPermission('manage_events'), asyncHandler(async (req, res) => {
  const { playerId } = req.body;
  
  const player = await Player.findById(playerId);
  if (!player) {
    return res.status(404).json({
      success: false,
      message: 'Oyuncu bulunamadı'
    });
  }

  const event = await Event.createRandomEvent(player);
  
  res.json({
    success: true,
    message: 'Olay tetiklendi',
    data: { event }
  });
}));

// @route   GET /api/admin/transactions
// @desc    Tüm işlemler
// @access  Private (Admin)
router.get('/transactions', protectAdmin, checkPermission('view_analytics'), asyncHandler(async (req, res) => {
  const { page = 1, limit = 50, type, playerId } = req.query;
  
  let query = {};
  if (type) query.type = type;
  if (playerId) query.playerId = playerId;

  const transactions = await Transaction.find(query)
    .populate('playerId', 'username email')
    .sort({ createdAt: -1 })
    .limit(parseInt(limit))
    .skip((parseInt(page) - 1) * parseInt(limit));

  const total = await Transaction.countDocuments(query);

  res.json({
    success: true,
    data: {
      transactions,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / parseInt(limit))
      }
    }
  });
}));

// @route   GET /api/admin/events
// @desc    Tüm olaylar
// @access  Private (Admin)
router.get('/events', protectAdmin, checkPermission('manage_events'), asyncHandler(async (req, res) => {
  const { page = 1, limit = 50, status, playerId } = req.query;
  
  let query = {};
  if (status) query.status = status;
  if (playerId) query.playerId = playerId;

  const events = await Event.find(query)
    .populate('playerId', 'username email')
    .sort({ createdAt: -1 })
    .limit(parseInt(limit))
    .skip((parseInt(page) - 1) * parseInt(limit));

  const total = await Event.countDocuments(query);

  res.json({
    success: true,
    data: {
      events,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / parseInt(limit))
      }
    }
  });
}));

// @route   GET /api/admin/stats
// @desc    Detaylı istatistikler
// @access  Private (Admin)
router.get('/stats', protectAdmin, checkPermission('view_analytics'), asyncHandler(async (req, res) => {
  const { days = 7 } = req.query;
  const startDate = new Date();
  startDate.setDate(startDate.getDate() - parseInt(days));

  const dailyStats = await Transaction.aggregate([
    {
      $match: {
        createdAt: { $gte: startDate }
      }
    },
    {
      $group: {
        _id: {
          $dateToString: { format: '%Y-%m-%d', date: '$createdAt' }
        },
        count: { $sum: 1 },
        totalAmount: { $sum: '$amount' }
      }
    },
    { $sort: { _id: 1 } }
  ]);

  res.json({
    success: true,
    data: { dailyStats }
  });
}));

// @route   GET /api/admin/banned-words
// @desc    Yasaklı kelime listesi
// @access  Private (Admin)
router.get('/banned-words', protectAdmin, checkPermission('manage_settings'), asyncHandler(async (req, res) => {
  const { category, isActive } = req.query;
  
  let query = {};
  if (category) query.category = category;
  if (isActive !== undefined) query.isActive = isActive === 'true';
  
  const words = await BannedWord.find(query)
    .populate('addedBy', 'username email')
    .sort({ createdAt: -1 });
  
  res.json({
    success: true,
    data: { words }
  });
}));

// @route   POST /api/admin/banned-words
// @desc    Yasaklı kelime ekle
// @access  Private (Admin)
router.post('/banned-words', protectAdmin, checkPermission('manage_settings'), asyncHandler(async (req, res) => {
  const { word, category, severity } = req.body;
  
  if (!word) {
    return res.status(400).json({
      success: false,
      message: 'Kelime gerekli'
    });
  }
  
  const bannedWord = await BannedWord.create({
    word: word.toLowerCase(),
    category: category || 'other',
    severity: severity || 'medium',
    addedBy: req.admin._id
  });
  
  res.status(201).json({
    success: true,
    message: 'Yasaklı kelime eklendi',
    data: { word: bannedWord }
  });
}));

// @route   POST /api/admin/banned-words/bulk
// @desc    Toplu yasaklı kelime ekle
// @access  Private (Admin)
router.post('/banned-words/bulk', protectAdmin, checkPermission('manage_settings'), asyncHandler(async (req, res) => {
  const { words } = req.body;
  
  if (!words || !Array.isArray(words) || words.length === 0) {
    return res.status(400).json({
      success: false,
      message: 'Kelime listesi gerekli'
    });
  }
  
  const results = await BannedWord.addMultiple(words, req.admin._id);
  
  res.json({
    success: true,
    message: `${results.added.length} kelime eklendi, ${results.skipped.length} kelime zaten mevcut`,
    data: results
  });
}));

// @route   PUT /api/admin/banned-words/:id
// @desc    Yasaklı kelime güncelle
// @access  Private (Admin)
router.put('/banned-words/:id', protectAdmin, checkPermission('manage_settings'), asyncHandler(async (req, res) => {
  const { category, severity, isActive } = req.body;
  
  const bannedWord = await BannedWord.findByIdAndUpdate(
    req.params.id,
    { category, severity, isActive },
    { new: true, runValidators: true }
  );
  
  if (!bannedWord) {
    return res.status(404).json({
      success: false,
      message: 'Kelime bulunamadı'
    });
  }
  
  res.json({
    success: true,
    message: 'Kelime güncellendi',
    data: { word: bannedWord }
  });
}));

// @route   DELETE /api/admin/banned-words/:id
// @desc    Yasaklı kelime sil
// @access  Private (Admin)
router.delete('/banned-words/:id', protectAdmin, checkPermission('manage_settings'), asyncHandler(async (req, res) => {
  const bannedWord = await BannedWord.findByIdAndDelete(req.params.id);
  
  if (!bannedWord) {
    return res.status(404).json({
      success: false,
      message: 'Kelime bulunamadı'
    });
  }
  
  res.json({
    success: true,
    message: 'Kelime silindi'
  });
}));

// @route   POST /api/admin/banned-words/check
// @desc    Metin kontrolü
// @access  Private (Admin)
router.post('/banned-words/check', protectAdmin, checkPermission('manage_settings'), asyncHandler(async (req, res) => {
  const { text } = req.body;
  
  if (!text) {
    return res.status(400).json({
      success: false,
      message: 'Metin gerekli'
    });
  }
  
  const result = await BannedWord.checkText(text);
  const cleanedText = await BannedWord.cleanText(text);
  
  res.json({
    success: true,
    data: {
      isClean: result.isClean,
      foundWords: result.foundWords,
      originalText: text,
      cleanedText
    }
  });
}));

module.exports = router;
