const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const Product = require('../models/Product');
const Transaction = require('../models/Transaction');

// @route   POST /api/trade/buy
// @desc    Ürün satın al (Doğrudan dükkan envanterine gider)
// @access  Private
router.post('/buy', protect, asyncHandler(async (req, res) => {
  const { productId, quantity, shopId } = req.body;

  if (!quantity || quantity <= 0) {
    return res.status(400).json({
      success: false,
      message: 'Geçerli bir miktar girin'
    });
  }

  if (!shopId) {
    return res.status(400).json({
      success: false,
      message: 'Dükkan seçilmelidir'
    });
  }

  const product = await Product.findById(productId);
  if (!product) {
    return res.status(404).json({
      success: false,
      message: 'Ürün bulunamadı'
    });
  }

  // Dükkanı kontrol et
  const { ShopInstance } = require('../models/Shop');
  const shop = await ShopInstance.findById(shopId);

  if (!shop || shop.ownerId.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  const totalCost = product.currentPrice * quantity;

  if (req.user.cash < totalCost) {
    return res.status(400).json({
      success: false,
      message: 'Yetersiz nakit'
    });
  }

  // Dükkan envanterine ekle
  const existingItem = shop.inventory.find(
    item => item.productId.toString() === productId
  );

  if (existingItem) {
    existingItem.quantity += quantity;
  } else {
    shop.inventory.push({
      productId,
      quantity,
      purchasePrice: product.currentPrice,
      sellPrice: product.currentPrice * 1.2,
      totalSold: 0,
      lastSoldAt: null
    });
  }

  req.user.cash -= totalCost;
  req.user.totalTransactions += 1;
  await req.user.save();
  await shop.save();

  // İşlem kaydı
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'buy',
    amount: totalCost,
    productId,
    quantity,
    price: product.currentPrice,
    description: `${product.name} satın alındı (${shop.customName})`
  });

  res.json({
    success: true,
    message: 'Ürün dükkan envanterine eklendi',
    data: {
      cash: req.user.cash,
      shop: shop
    }
  });
}));

// @route   POST /api/trade/sell
// @desc    Ürün sat (Pazarda satış yapılamaz - sadece dükkan üzerinden)
// @access  Private
router.post('/sell', protect, asyncHandler(async (req, res) => {
  return res.status(403).json({
    success: false,
    message: 'Pazarda satış yapılamaz. Ürünlerinizi dükkanınızda satabilirsiniz.'
  });
}));

// @route   GET /api/trade/history
// @desc    İşlem geçmişi
// @access  Private
router.get('/history', protect, asyncHandler(async (req, res) => {
  const { limit = 50, skip = 0, type } = req.query;

  const history = await Transaction.getPlayerHistory(req.user._id, {
    limit: parseInt(limit),
    skip: parseInt(skip),
    type
  });

  res.json({
    success: true,
    data: { history }
  });
}));

module.exports = router;
