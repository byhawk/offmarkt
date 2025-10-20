const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { generateAdminToken, protectAdmin, checkPermission, requireSuperAdmin } = require('../middleware/adminAuth');
const Admin = require('../models/Admin');
const Player = require('../models/Player');
const Product = require('../models/Product');
const { ShopType, ShopInstance } = require('../models/Shop');
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

// === EKONOMİK SİSTEM YÖNETİMİ ===

// Yardımcı fonksiyonlar - doğrudan burada tanımlanıyor
async function calculateSupplyDemandForProduct(productId, allShops) {
  let totalListed = 0;
  let totalStock = 0;
  const shopListings = [];

  for (const shop of allShops) {
    const listing = shop.listedProducts.find(
      p => p.productId.toString() === productId.toString() && p.isActive
    );

    if (listing) {
      totalListed += listing.currentStock;
      totalStock += listing.maxStock;
      shopListings.push({
        shopId: shop._id,
        shopName: shop.name,
        currentStock: listing.currentStock,
        maxStock: listing.maxStock,
        listPrice: listing.listPrice
      });
    }
  }

  const totalAvailable = totalListed + 50; // Basitleştirilmiş hesaplama
  const supplyRatio = totalAvailable > 0 ? totalListed / totalAvailable : 0;
  const demandLevel = calculateDemandLevel(supplyRatio);

  return {
    productId,
    totalListed,
    totalAvailable,
    totalCapacity: totalStock,
    supplyRatio,
    demandLevel,
    shopListings,
    recommendation: getPriceRecommendation(demandLevel)
  };
}

function calculateDemandLevel(supplyRatio) {
  if (supplyRatio < 0.3) return 'very_high';
  if (supplyRatio < 0.7) return 'high';
  if (supplyRatio <= 1.3) return 'balanced';
  if (supplyRatio <= 2.0) return 'low';
  return 'very_low';
}

function getPriceRecommendation(demandLevel) {
  switch (demandLevel) {
    case 'very_high': return 'Fiyatı %10-15 artır';
    case 'high': return 'Fiyatı %5-10 artır';
    case 'balanced': return 'Fiyatı koru';
    case 'low': return 'Fiyatı %5-10 düşür';
    case 'very_low': return 'Fiyatı %10-15 düşür';
    default: return 'Fiyatı koru';
  }
}

function calculateMarketSummary(analyses) {
  if (!analyses || analyses.length === 0) {
    return {
      totalProducts: 0,
      highDemandProducts: 0,
      balancedProducts: 0,
      lowDemandProducts: 0,
      avgSupplyRatio: 1.0,
      marketHealth: 'healthy'
    };
  }

  const totalProducts = analyses.length;
  const highDemandProducts = analyses.filter(a => ['very_high', 'high'].includes(a.demandLevel)).length;
  const lowDemandProducts = analyses.filter(a => ['low', 'very_low'].includes(a.demandLevel)).length;
  const balancedProducts = analyses.filter(a => a.demandLevel === 'balanced').length;

  const avgSupplyRatio = analyses.reduce((sum, a) => sum + a.supplyRatio, 0) / totalProducts;

  return {
    totalProducts,
    highDemandProducts,
    balancedProducts,
    lowDemandProducts,
    avgSupplyRatio: isNaN(avgSupplyRatio) ? 1.0 : avgSupplyRatio,
    marketHealth: avgSupplyRatio >= 0.7 && avgSupplyRatio <= 1.3 ? 'healthy' : 'unbalanced'
  };
}

async function calculateSupplyDemandForShop(shopId) {
  const shop = await Shop.findById(shopId).populate('listedProducts.productId');

  if (!shop) return { productAnalyses: [] };

  const productAnalyses = await Promise.all(
    shop.listedProducts
      .filter(p => p.isActive)
      .map(async (listing) => {
        const analysis = await calculateSupplyDemandForProduct(
          listing.productId._id,
          await Shop.find({ isActive: true })
        );
        return {
          productId: listing.productId._id,
          productName: listing.productId.name,
          supplyRatio: analysis.supplyRatio,
          demandLevel: analysis.demandLevel
        };
      })
  );

  return {
    shopId,
    productAnalyses
  };
}

// @route   GET /api/admin/economic-dashboard
// @desc    Ekonomik sistem dashboard'ı
// @access  Private (Admin)
router.get('/economic-dashboard', protectAdmin, checkPermission('view_analytics'), asyncHandler(async (req, res) => {
  try {
    // Genel market istatistikleri
    const allShops = await Shop.find({ isActive: true }).populate('listedProducts.productId');
    const totalListedProducts = allShops.reduce((sum, shop) => sum + shop.listedProducts.length, 0);

    // Aktif ekonomik sistemler
    const shopsWithAutoPurchase = allShops.filter(shop => shop.autoPurchaseSettings && shop.autoPurchaseSettings.enableBalanceControl).length;

    // Arz/talep analizi (basitleştirilmiş)
    const productIds = await Product.find({ isActive: true }).select('_id name');
    const marketAnalysis = [];

    for (const product of productIds) {
      try {
        const analysis = await calculateSupplyDemandForProduct(product._id, allShops);
        marketAnalysis.push({
          productId: product._id,
          productName: product.name,
          supplyRatio: analysis.supplyRatio || 1.0,
          demandLevel: analysis.demandLevel || 'balanced',
          totalListed: analysis.totalListed || 0,
          totalAvailable: analysis.totalAvailable || 1
        });
      } catch (error) {
        console.warn(`Product analysis failed for ${product._id}:`, error.message);
      }
    }

    // Piyasa sağlığı
    const summary = calculateMarketSummary(marketAnalysis);

    const dashboard = {
      marketOverview: {
        totalShops: allShops.length,
        shopsWithAutoPurchase,
        totalListedProducts,
        marketHealth: summary.marketHealth
      },
      supplyDemandAnalysis: {
        analyses: marketAnalysis,
        summary
      },
      recentPriceAdjustments: [],
      shopPerformance: allShops.map(shop => {
        const listedProductsCount = shop.listedProducts ? shop.listedProducts.filter(p => p && p.isActive).length : 0;
        const totalStockValue = shop.listedProducts
          ? shop.listedProducts.filter(p => p && p.isActive).reduce((sum, p) => sum + ((p.currentStock || 0) * (p.listPrice || 0)), 0)
          : 0;
        const autoPurchaseEnabled = shop.autoPurchaseSettings && shop.autoPurchaseSettings.enableBalanceControl;

        return {
          shopId: shop._id,
          shopName: shop.name,
          owner: shop.rentedBy,
          listedProductsCount: listedProductsCount,
          totalStockValue: totalStockValue,
          autoPurchaseEnabled: autoPurchaseEnabled
        };
      }).filter(shop => shop !== null)
    };

    res.json({
      success: true,
      data: dashboard
    });
  } catch (error) {
    console.error('Economic dashboard error:', error);
    res.status(500).json({
      success: false,
      message: 'Ekonomik dashboard verileri alınırken hata oluştu',
      error: error.message
    });
  }
}));

// @route   GET /api/admin/shops/detailed
// @desc    Dükkanların ekonomik detayları
// @access  Private (Admin)
router.get('/shops/detailed', protectAdmin, checkPermission('manage_shops'), asyncHandler(async (req, res) => {
  const shops = await Shop.find()
    .populate('rentedBy', 'username email')
    .populate('listedProducts.productId', 'name category')
    .sort({ monthlyRent: -1 });

  const detailedShops = shops.map(shop => ({
    ...shop.toObject(),
    economicMetrics: {
      listedProductsCount: shop.listedProducts.length,
      totalListedValue: shop.listedProducts.reduce((sum, p) => sum + (p.currentStock * p.listPrice), 0),
      lowStockProducts: shop.listedProducts.filter(p => p.currentStock < p.minStock).length,
      autoPurchaseEnabled: shop.autoPurchaseSettings.enableBalanceControl,
      lastPurchaseDate: shop.listedProducts.length > 0 ?
        Math.max(...shop.listedProducts.map(p => p.lastPurchaseDate?.getTime() || 0)) : null
    }
  }));

  res.json({
    success: true,
    data: { shops: detailedShops }
  });
}));

// @route   GET /api/admin/shops/:shopId/listed-products
// @desc    Dükkanın listelenen ürünleri detayı
// @access  Private (Admin)
router.get('/shops/:shopId/listed-products', protectAdmin, checkPermission('manage_shops'), asyncHandler(async (req, res) => {
  const shop = await Shop.findById(req.params.shopId)
    .populate('rentedBy', 'username email')
    .populate('listedProducts.productId', 'name category emoji');

  if (!shop) {
    return res.status(404).json({
      success: false,
      message: 'Dükkan bulunamadı'
    });
  }

  res.json({
    success: true,
    data: {
      shopInfo: {
        id: shop._id,
        name: shop.name,
        location: shop.location,
        owner: shop.rentedBy,
        autoPurchaseSettings: shop.autoPurchaseSettings
      },
      listedProducts: shop.listedProducts,
      summary: shop.getStockStatistics()
    }
  });
}));

// @route   POST /api/admin/shops/:shopId/reset-inventory
// @desc    Dükkan envanterini sıfırla
// @access  Private (Admin)
router.post('/shops/:shopId/reset-inventory', protectAdmin, checkPermission('manage_shops'), asyncHandler(async (req, res) => {
  const shop = await Shop.findById(req.params.shopId);

  if (!shop) {
    return res.status(404).json({
      success: false,
      message: 'Dükkan bulunamadı'
    });
  }

  // Tüm ürünleri sıfırla
  shop.listedProducts.forEach(product => {
    product.currentStock = 0;
    product.totalSold = 0;
    product.lastPurchaseDate = null;
  });

  await shop.save();

  res.json({
    success: true,
    message: 'Dükkan envanteri sıfırlandı'
  });
}));

// @route   POST /api/admin/market/global-price-adjustment
// @desc    Tüm pazar için genel fiyat ayarlama çalıştır
// @access  Private (Admin)
router.post('/market/global-price-adjustment', protectAdmin, checkPermission('manage_products'), asyncHandler(async (req, res) => {
  const { forceAdjustment = false, maxAdjustments = 20 } = req.body;

  // Tüm aktif dükkanları getir
  const allShops = await Shop.find({ isActive: true });

  let totalAdjustments = 0;
  const adjustmentResults = [];

  for (const shop of allShops) {
    if (!forceAdjustment && !shop.autoPurchaseSettings.smartPricing) continue;

    // Bu dükkanın arz/talep analizini al
    const shopAnalysis = await calculateSupplyDemandForShop(shop._id);

    for (const analysis of shopAnalysis.productAnalyses) {
      // Çok arz veya az arz durumları
      const needsAdjustment = analysis.supplyRatio < 0.5 || analysis.supplyRatio > 2.0;

      if (forceAdjustment || needsAdjustment) {
        try {
          await shop.adjustPriceForSupplyDemand(
            analysis.productId,
            analysis.supplyRatio
          );

          adjustmentResults.push({
            shopId: shop._id,
            productId: analysis.productId,
            productName: analysis.productName,
            oldSupplyRatio: analysis.supplyRatio,
            priceAdjusted: true
          });

          totalAdjustments++;

          if (totalAdjustments >= maxAdjustments) break;
        } catch (error) {
          adjustmentResults.push({
            shopId: shop._id,
            productId: analysis.productId,
            error: error.message
          });
        }
      }
    }

    if (totalAdjustments >= maxAdjustments) break;
  }

  res.json({
    success: true,
    message: `${totalAdjustments} fiyat ayarlama işlemi gerçekleştirildi`,
    data: {
      totalAdjustments,
      adjustments: adjustmentResults
    }
  });
}));

// @route   GET /api/admin/market/supply-demand-analysis
// @desc    Admin paneli için genel arz/talep analizi
// @access  Private (Admin)
router.get('/market/supply-demand-analysis', protectAdmin, checkPermission('view_analytics'), asyncHandler(async (req, res) => {
  const { productId, days = 7 } = req.query;

  // İstenen zaman aralığında aktif dükkanları getir
  const startDate = new Date();
  startDate.setDate(startDate.getDate() - parseInt(days));

  const allShops = await Shop.find({ isActive: true }).populate('listedProducts.productId');

  if (productId) {
    // Belirli ürün analizi
    const analysis = await calculateSupplyDemandForProduct(productId, allShops);

    // Son fiyat değişiklikleri
    const priceChanges = await Transaction.find({
      type: { $in: ['shop_listing', 'shop_purchase'] },
      'metadata.productId': productId,
      createdAt: { $gte: startDate }
    }).limit(20).sort({ createdAt: -1 });

    analysis.priceChanges = priceChanges;

    res.json({
      success: true,
      data: { analysis }
    });
  } else {
    // Genel pazar analizi
    const allProductIds = await Product.find({ isActive: true }).select('_id');
    const analyses = await Promise.all(
      allProductIds.map(async (product) => {
        const analysis = await calculateSupplyDemandForProduct(product._id, allShops);
        return {
          productId: product._id,
          productName: (await Product.findById(product._id)).name,
          supplyRatio: analysis.supplyRatio,
          demandLevel: analysis.demandLevel,
          totalListed: analysis.totalListed,
          totalAvailable: analysis.totalAvailable,
          shopListings: analysis.shopListings
        };
      })
    );

    const summary = calculateMarketSummary(analyses);

    res.json({
      success: true,
      data: {
        analyses,
        summary,
        timeRange: {
          days: parseInt(days),
          startDate,
          endDate: new Date()
        }
      }
    });
  }
}));

// @route   PUT /api/admin/shops/:shopId/auto-settings
// @desc    Dükkan otomatik alım ayarlarını admin olarak değiştir
// @access  Private (Admin)
router.put('/shops/:shopId/auto-settings', protectAdmin, checkPermission('manage_shops'), asyncHandler(async (req, res) => {
  const { enableBalanceControl, balanceInterval, priceAdjustmentRate, smartPricing } = req.body;

  const shop = await Shop.findById(req.params.shopId);

  if (!shop) {
    return res.status(404).json({
      success: false,
      message: 'Dükkan bulunamadı'
    });
  }

  const settings = shop.autoPurchaseSettings;

  if (enableBalanceControl !== undefined) settings.enableBalanceControl = enableBalanceControl;
  if (balanceInterval !== undefined) settings.balanceInterval = Math.max(300000, balanceInterval);
  if (priceAdjustmentRate !== undefined) settings.priceAdjustmentRate = Math.max(0, Math.min(0.1, priceAdjustmentRate));
  if (smartPricing !== undefined) settings.smartPricing = smartPricing;

  await shop.save();

  res.json({
    success: true,
    message: 'Otomatik alım ayarları güncellendi',
    data: { autoPurchaseSettings: settings }
  });
}));

// @route   POST /api/admin/market/force-product-price
// @desc    Belirli ürünün fiyatını tüm dükkanlarda zorla ayarla
// @access  Private (Admin)
router.post('/market/force-product-price', protectAdmin, checkPermission('manage_products'), asyncHandler(async (req, res) => {
  const { productId, newPrice, reason = 'admin_override' } = req.body;

  if (!productId || newPrice === undefined) {
    return res.status(400).json({
      success: false,
      message: 'Ürün ID ve yeni fiyat gerekli'
    });
  }

  const shopsUpdated = [];
  const shops = await Shop.find({
    isActive: true,
    'listedProducts.productId': productId,
    'listedProducts.isActive': true
  });

  for (const shop of shops) {
    const productIndex = shop.listedProducts.findIndex(
      p => p.productId.toString() === productId && p.isActive
    );

    if (productIndex !== -1) {
      shop.listedProducts[productIndex].priceHistory.push({
        price: newPrice,
        changedAt: new Date(),
        reason: reason
      });

      shop.listedProducts[productIndex].listPrice = newPrice;

      shopsUpdated.push({
        shopId: shop._id,
        shopName: shop.name,
        ownerId: shop.rentedBy,
        oldPrice: shop.listedProducts[productIndex].listPrice,
        newPrice: newPrice
      });
    }
  }

  // Tüm değişiklikleri kaydet
  await Promise.all(shops.map(shop => shop.save()));

  res.json({
    success: true,
    message: `${shopsUpdated.length} dükkanda fiyat güncellendi`,
    data: {
      productId,
      newPrice,
      updatedShops: shopsUpdated
    }
  });
}));

/**
 * SHOPTYPES ENDPOINT'LARI - Yeni çoklu mağaza sistemi için
 */

// @route   GET /api/admin/shop-types
// @desc    Tüm dükkan çeşitlerini listele
// @access  Private (Admin) - Temporarily removed for debugging
router.get('/shop-types', asyncHandler(async (req, res) => {
  const shopTypes = await ShopType.find().sort({ displayName: 1 });

  // Her type için aktife açılmış mağaza sayısını hesapla
  const typesWithCounts = await Promise.all(
    shopTypes.map(async (type) => {
      const instanceCount = await ShopInstance.countDocuments({ shopType: type.shopType, isActive: true });
      return {
        ...type.toObject(),
        instanceCount
      };
    })
  );

  // Genel istatistikler
  const summary = {
    totalTypes: shopTypes.length,
    activeTypes: shopTypes.filter(t => t.isActive).length,
    totalInstances: await ShopInstance.countDocuments({ isActive: true }),
    mostPopularType: null
  };

  // En popüler türü bul
  if (typesWithCounts.length > 0) {
    const popularType = typesWithCounts.reduce((prev, current) =>
      (prev.instanceCount > current.instanceCount) ? prev : current
    );
    summary.mostPopularType = popularType.displayName;
  }

  // Toplam satış gelirini hesapla
  summary.totalRevenue = await ShopInstance.aggregate([
    {
      $match: { isActive: true }
    },
    {
      $group: {
        _id: null,
        totalRevenue: { $sum: '$monthlyRevenue' }
      }
    }
  ]).then(result => result[0]?.totalRevenue || 0);

  res.json({
    success: true,
    data: {
      shopTypes: typesWithCounts,
      summary
    }
  });
}));

// @route   POST /api/admin/shop-types
// @desc    Yeni dükkan çeşidi oluştur
// @access  Private (Admin) - Temporarily removed for debugging
router.post('/shop-types', asyncHandler(async (req, res) => {
  const { shopType, displayName, purchasePrice, rackCapacity, storageCapacity, nameTemplate, minCustomers, locationType } = req.body;

  // Validation
  if (!shopType || !displayName || !purchasePrice || !rackCapacity || !storageCapacity) {
    return res.status(400).json({
      success: false,
      message: 'Gerekli alanlar eksik'
    });
  }

  // Aynı shopType olup olmadığını kontrol et
  const existingType = await ShopType.findOne({ shopType });
  if (existingType) {
    return res.status(400).json({
      success: false,
      message: 'Bu dükkan türü zaten mevcut'
    });
  }

  const newShopType = await ShopType.create({
    shopType,
    displayName,
    nameTemplate: nameTemplate || `{ŞEHİR} ${displayName}`,
    purchasePrice,
    rackCapacity,
    storageCapacity,
    minCustomers: minCustomers || 10,
    locationType: locationType || 'street'
  });

  res.status(201).json({
    success: true,
    message: 'Dükkan çeşidi oluşturuldu',
    data: { shopType: newShopType }
  });
}));

// @route   PUT /api/admin/shop-types/:id
// @desc    Dükkan çeşidi güncelle
// @access  Private (Admin) - Temporarily removed for debugging
router.put('/shop-types/:id', asyncHandler(async (req, res) => {
  const { displayName, purchasePrice, rackCapacity, storageCapacity, nameTemplate, minCustomers, locationType, isActive } = req.body;

  const shopType = await ShopType.findByIdAndUpdate(
    req.params.id,
    {
      displayName,
      purchasePrice,
      rackCapacity,
      storageCapacity,
      nameTemplate,
      minCustomers,
      locationType,
      isActive
    },
    { new: true, runValidators: true }
  );

  if (!shopType) {
    return res.status(404).json({
      success: false,
      message: 'Dükkan çeşidi bulunamadı'
    });
  }

  res.json({
    success: true,
    message: 'Dükkan çeşidi güncellendi',
    data: { shopType }
  });
}));

// @route   PATCH /api/admin/shop-types/:id/activate
// @desc    Dükkan çeşidi aktifleştir
// @access  Private (Admin) - Temporarily removed for debugging
router.patch('/shop-types/:id/activate', asyncHandler(async (req, res) => {
  const shopType = await ShopType.findByIdAndUpdate(
    req.params.id,
    { isActive: true },
    { new: true }
  );

  if (!shopType) {
    return res.status(404).json({
      success: false,
      message: 'Dükkan çeşidi bulunamadı'
    });
  }

  res.json({
    success: true,
    message: 'Dükkan çeşidi aktifleştirildi',
    data: { shopType }
  });
}));

// @route   PATCH /api/admin/shop-types/:id/deactivate
// @desc    Dükkan çeşidi devre dışı bırak
// @access  Private (Admin) - Temporarily removed for debugging
router.patch('/shop-types/:id/deactivate', asyncHandler(async (req, res) => {
  const shopType = await ShopType.findByIdAndUpdate(
    req.params.id,
    { isActive: false },
    { new: true }
  );

  if (!shopType) {
    return res.status(404).json({
      success: false,
      message: 'Dükkan çeşidi bulunamadı'
    });
  }

  res.json({
    success: true,
    message: 'Dükkan çeşidi devre dışı bırakıldı',
    data: { shopType }
  });
}));

// === PLAYERS ENDPOINTS FOR NEW SYSTEM ===

// @route   GET /api/admin/shops/player-instances
// @desc    Tüm oyuncu mağazalarını listele (eski sistem için)
// @access  Private (Admin)
router.get('/shops/player-instances', protectAdmin, checkPermission('manage_shops'), asyncHandler(async (req, res) => {
  const { page = 1, limit = 50, playerId } = req.query;

  let query = {};
  if (playerId) query.ownerId = playerId;

  const instances = await ShopInstance.find(query)
    .populate('ownerId', 'username email')
    .sort({ createdAt: -1 })
    .limit(parseInt(limit))
    .skip((parseInt(page) - 1) * parseInt(limit));

  const total = await ShopInstance.countDocuments(query);

  res.json({
    success: true,
    data: {
      instances,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / parseInt(limit))
      }
    }
  });
}));

module.exports = router;
