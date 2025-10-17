const jwt = require('jsonwebtoken');
const { asyncHandler } = require('./errorHandler');
const Player = require('../models/Player');

// JWT token oluştur
const generateToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRE || '7d'
  });
};

// Refresh token oluştur
const generateRefreshToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_REFRESH_SECRET, {
    expiresIn: process.env.JWT_REFRESH_EXPIRE || '30d'
  });
};

// Token doğrulama middleware
const protect = asyncHandler(async (req, res, next) => {
  let token;

  // Header'dan token al
  if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
    token = req.headers.authorization.split(' ')[1];
  }

  // Token yoksa hata
  if (!token) {
    const error = new Error('Yetkilendirme token bulunamadı');
    error.statusCode = 401;
    throw error;
  }

  try {
    // Token'ı doğrula
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // Oyuncuyu bul
    req.user = await Player.findById(decoded.id).select('-password');

    if (!req.user) {
      const error = new Error('Kullanıcı bulunamadı');
      error.statusCode = 401;
      throw error;
    }

    // Oyuncu banlı mı kontrol et
    if (req.user.isBanned) {
      const error = new Error('Hesabınız yasaklandı');
      error.statusCode = 403;
      throw error;
    }

    // Oyuncu aktif mi kontrol et
    if (!req.user.isActive) {
      const error = new Error('Hesabınız aktif değil');
      error.statusCode = 403;
      throw error;
    }

    // Son aktiviteyi güncelle
    await req.user.updateActivity();

    next();
  } catch (error) {
    if (error.name === 'JsonWebTokenError') {
      error.message = 'Geçersiz token';
      error.statusCode = 401;
    } else if (error.name === 'TokenExpiredError') {
      error.message = 'Token süresi doldu';
      error.statusCode = 401;
    }
    throw error;
  }
});

// Refresh token doğrulama
const verifyRefreshToken = asyncHandler(async (req, res, next) => {
  const { refreshToken } = req.body;

  if (!refreshToken) {
    const error = new Error('Refresh token bulunamadı');
    error.statusCode = 401;
    throw error;
  }

  try {
    const decoded = jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET);
    req.userId = decoded.id;
    next();
  } catch (error) {
    error.message = 'Geçersiz refresh token';
    error.statusCode = 401;
    throw error;
  }
});

// Premium kontrolü
const checkPremium = asyncHandler(async (req, res, next) => {
  if (!req.user.isPremium || (req.user.premiumExpires && req.user.premiumExpires < new Date())) {
    const error = new Error('Bu özellik premium üyeler içindir');
    error.statusCode = 403;
    throw error;
  }
  next();
});

// Seviye kontrolü
const checkLevel = (minLevel) => {
  return asyncHandler(async (req, res, next) => {
    if (req.user.level < minLevel) {
      const error = new Error(`Bu özellik için minimum ${minLevel}. seviye gereklidir`);
      error.statusCode = 403;
      throw error;
    }
    next();
  });
};

module.exports = {
  generateToken,
  generateRefreshToken,
  protect,
  verifyRefreshToken,
  checkPremium,
  checkLevel
};
