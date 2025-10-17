const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const Product = require('../models/Product');

// @route   GET /api/market/products
// @desc    Tüm ürünleri getir
// @access  Private
router.get('/products', protect, asyncHandler(async (req, res) => {
  const { category, trending } = req.query;
  
  let query = { isActive: true };
  
  if (category) query.category = category;
  if (trending === 'true') query.trending = true;
  
  // Seviye kontrolü
  query.minLevel = { $lte: req.user.level };
  
  const products = await Product.find(query);
  
  res.json({
    success: true,
    data: { products }
  });
}));

// @route   GET /api/market/products/:id
// @desc    Ürün detayı
// @access  Private
router.get('/products/:id', protect, asyncHandler(async (req, res) => {
  const product = await Product.findById(req.params.id);
  
  if (!product) {
    return res.status(404).json({
      success: false,
      message: 'Ürün bulunamadı'
    });
  }
  
  res.json({
    success: true,
    data: { product }
  });
}));

// @route   GET /api/market/categories
// @desc    Kategorileri getir
// @access  Private
router.get('/categories', protect, asyncHandler(async (req, res) => {
  const categories = ['electronics', 'clothing', 'food', 'jewelry', 'vehicles'];
  
  const categoryCounts = await Promise.all(
    categories.map(async (category) => {
      const count = await Product.countDocuments({ category, isActive: true });
      return { category, count };
    })
  );
  
  res.json({
    success: true,
    data: { categories: categoryCounts }
  });
}));

module.exports = router;
