const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { generateToken, generateRefreshToken, protect, verifyRefreshToken } = require('../middleware/auth');
const { validateText } = require('../middleware/validateText');
const Player = require('../models/Player');
const { body, validationResult } = require('express-validator');

// @route   POST /api/auth/register
// @desc    Kayıt ol
// @access  Public
router.post('/register', [
  body('username').trim().isLength({ min: 3, max: 20 }).withMessage('Kullanıcı adı 3-20 karakter olmalı'),
  body('email').isEmail().normalizeEmail().withMessage('Geçerli bir email adresi girin'),
  body('password').isLength({ min: 6 }).withMessage('Şifre en az 6 karakter olmalı')
], validateText(['username', 'name']), asyncHandler(async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      success: false,
      message: 'Doğrulama hatası',
      errors: errors.array()
    });
  }

  const { username, email, password } = req.body;

  // Kullanıcı adı veya email kontrolü
  const existingPlayer = await Player.findOne({
    $or: [{ username }, { email }]
  });

  if (existingPlayer) {
    return res.status(400).json({
      success: false,
      message: existingPlayer.username === username 
        ? 'Bu kullanıcı adı zaten kullanılıyor' 
        : 'Bu email adresi zaten kullanılıyor'
    });
  }

  // Oyuncu oluştur
  const player = await Player.create({
    username,
    email,
    password,
    name: username,
    cash: parseInt(process.env.INITIAL_CASH) || 5000
  });

  // Token oluştur
  const accessToken = generateToken(player._id);
  const refreshToken = generateRefreshToken(player._id);

  res.status(201).json({
    success: true,
    message: 'Kayıt başarılı',
    data: {
      player: {
        id: player._id,
        username: player.username,
        email: player.email,
        level: player.level,
        cash: player.cash
      },
      accessToken,
      refreshToken
    }
  });
}));

// @route   POST /api/auth/login
// @desc    Giriş yap
// @access  Public
router.post('/login', [
  body('password').notEmpty().withMessage('Şifre gerekli')
], asyncHandler(async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      success: false,
      message: 'Doğrulama hatası',
      errors: errors.array()
    });
  }

  const { username, email, password } = req.body;
  
  // Email veya username ile giriş
  const loginField = email || username;
  
  if (!loginField) {
    return res.status(400).json({
      success: false,
      message: 'Email veya kullanıcı adı gerekli'
    });
  }

  // Oyuncuyu email veya username ile bul
  const player = await Player.findOne({
    $or: [{ email: loginField }, { username: loginField }]
  });

  if (!player) {
    return res.status(401).json({
      success: false,
      message: 'Email/kullanıcı adı veya şifre hatalı'
    });
  }

  // Şifre kontrolü
  const isMatch = await player.comparePassword(password);

  if (!isMatch) {
    return res.status(401).json({
      success: false,
      message: 'Kullanıcı adı veya şifre hatalı'
    });
  }

  // Ban kontrolü
  if (player.isBanned) {
    return res.status(403).json({
      success: false,
      message: `Hesabınız yasaklandı. Sebep: ${player.banReason || 'Belirtilmemiş'}`
    });
  }

  // Aktif kontrolü
  if (!player.isActive) {
    return res.status(403).json({
      success: false,
      message: 'Hesabınız aktif değil'
    });
  }

  // Token oluştur
  const accessToken = generateToken(player._id);
  const refreshToken = generateRefreshToken(player._id);

  // Son aktiviteyi güncelle
  await player.updateActivity();

  res.json({
    success: true,
    message: 'Giriş başarılı',
    data: {
      player: {
        id: player._id,
        username: player.username,
        email: player.email,
        level: player.level,
        cash: player.cash,
        experience: player.experience,
        legalReputation: player.legalReputation,
        streetReputation: player.streetReputation
      },
      accessToken,
      refreshToken
    }
  });
}));

// @route   POST /api/auth/refresh
// @desc    Token yenile
// @access  Public
router.post('/refresh', verifyRefreshToken, asyncHandler(async (req, res) => {
  const player = await Player.findById(req.userId);

  if (!player || !player.isActive || player.isBanned) {
    return res.status(401).json({
      success: false,
      message: 'Geçersiz refresh token'
    });
  }

  const accessToken = generateToken(player._id);
  const refreshToken = generateRefreshToken(player._id);

  res.json({
    success: true,
    data: {
      accessToken,
      refreshToken
    }
  });
}));

// @route   POST /api/auth/logout
// @desc    Çıkış yap
// @access  Private
router.post('/logout', protect, asyncHandler(async (req, res) => {
  req.user.isOnline = false;
  await req.user.save();

  res.json({
    success: true,
    message: 'Çıkış başarılı'
  });
}));

// @route   GET /api/auth/me
// @desc    Mevcut kullanıcı bilgisi
// @access  Private
router.get('/me', protect, asyncHandler(async (req, res) => {
  res.json({
    success: true,
    data: {
      player: {
        id: req.user._id,
        username: req.user.username,
        email: req.user.email,
        name: req.user.name,
        level: req.user.level,
        experience: req.user.experience,
        cash: req.user.cash,
        bankAccount: req.user.bankAccount,
        debt: req.user.debt,
        legalReputation: req.user.legalReputation,
        streetReputation: req.user.streetReputation,
        riskLevel: req.user.riskLevel,
        suspicionLevel: req.user.suspicionLevel,
        currentDay: req.user.currentDay,
        totalTransactions: req.user.totalTransactions,
        totalProfit: req.user.totalProfit,
        isPremium: req.user.isPremium,
        premiumExpires: req.user.premiumExpires,
        inventory: req.user.inventory || [],
        ownedShops: req.user.ownedShops || []
      }
    }
  });
}));

module.exports = router;
