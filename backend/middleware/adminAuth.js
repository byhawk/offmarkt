const jwt = require('jsonwebtoken');
const { asyncHandler } = require('./errorHandler');
const Admin = require('../models/Admin');

// Admin token oluştur
const generateAdminToken = (id) => {
  return jwt.sign({ id, type: 'admin' }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRE || '7d'
  });
};

// Admin token doğrulama
const protectAdmin = asyncHandler(async (req, res, next) => {
  let token;

  if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
    token = req.headers.authorization.split(' ')[1];
  }

  if (!token) {
    const error = new Error('Admin yetkilendirme token bulunamadı');
    error.statusCode = 401;
    throw error;
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    if (decoded.type !== 'admin') {
      const error = new Error('Geçersiz admin token');
      error.statusCode = 401;
      throw error;
    }

    req.admin = await Admin.findById(decoded.id).select('-password');

    if (!req.admin) {
      const error = new Error('Admin bulunamadı');
      error.statusCode = 401;
      throw error;
    }

    if (!req.admin.isActive) {
      const error = new Error('Admin hesabı aktif değil');
      error.statusCode = 403;
      throw error;
    }

    next();
  } catch (error) {
    if (error.name === 'JsonWebTokenError') {
      error.message = 'Geçersiz admin token';
      error.statusCode = 401;
    } else if (error.name === 'TokenExpiredError') {
      error.message = 'Admin token süresi doldu';
      error.statusCode = 401;
    }
    throw error;
  }
});

// Permission kontrolü
const checkPermission = (permission) => {
  return asyncHandler(async (req, res, next) => {
    if (!req.admin.hasPermission(permission)) {
      const error = new Error('Bu işlem için yetkiniz yok');
      error.statusCode = 403;
      throw error;
    }
    next();
  });
};

// Super admin kontrolü
const requireSuperAdmin = asyncHandler(async (req, res, next) => {
  if (req.admin.role !== 'super_admin') {
    const error = new Error('Bu işlem sadece super admin tarafından yapılabilir');
    error.statusCode = 403;
    throw error;
  }
  next();
});

module.exports = {
  generateAdminToken,
  protectAdmin,
  checkPermission,
  requireSuperAdmin
};
