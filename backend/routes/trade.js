const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const Product = require('../models/Product');
const Transaction = require('../models/Transaction');

// @route   POST /api/trade/buy
// @desc    Ürün satın al
// @access  Private
router.post('/buy', protect, asyncHandler(async (req, res) => {
  const { productId, quantity } = req.body;

  if (!quantity || quantity <= 0) {
    return res.status(400).json({
      success: false,
      message: 'Geçerli bir miktar girin'
    });
  }

  const product = await Product.findById(productId);
  if (!product) {
    return res.status(404).json({
      success: false,
      message: 'Ürün bulunamadı'
    });
  }

  const totalCost = product.currentPrice * quantity;

  if (req.user.cash < totalCost) {
    return res.status(400).json({
      success: false,
      message: 'Yetersiz nakit'
    });
  }

  // Envantere ekle
  const existingItem = req.user.inventory.find(
    item => item.productId.toString() === productId
  );

  if (existingItem) {
    existingItem.quantity += quantity;
  } else {
    req.user.inventory.push({
      productId,
      quantity,
      purchasePrice: product.currentPrice,
      purchaseDate: new Date(),
      source: 'market'
    });
  }

  req.user.cash -= totalCost;
  req.user.totalTransactions += 1;
  await req.user.save();

  // İşlem kaydı
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'buy',
    amount: totalCost,
    productId,
    quantity,
    price: product.currentPrice,
    description: `${product.name} satın alındı`
  });

  res.json({
    success: true,
    message: 'Ürün satın alındı',
    data: {
      cash: req.user.cash,
      inventory: req.user.inventory
    }
  });
}));

// @route   POST /api/trade/sell
// @desc    Ürün sat
// @access  Private
router.post('/sell', protect, asyncHandler(async (req, res) => {
  const { productId, quantity } = req.body;

  if (!quantity || quantity <= 0) {
    return res.status(400).json({
      success: false,
      message: 'Geçerli bir miktar girin'
    });
  }

  const inventoryItem = req.user.inventory.find(
    item => item.productId.toString() === productId
  );

  if (!inventoryItem || inventoryItem.quantity < quantity) {
    return res.status(400).json({
      success: false,
      message: 'Yetersiz stok'
    });
  }

  const product = await Product.findById(productId);
  const totalRevenue = product.currentPrice * quantity;
  const profit = (product.currentPrice - inventoryItem.purchasePrice) * quantity;

  // Envanterden çıkar
  inventoryItem.quantity -= quantity;
  if (inventoryItem.quantity === 0) {
    req.user.inventory = req.user.inventory.filter(
      item => item.productId.toString() !== productId
    );
  }

  req.user.cash += totalRevenue;
  req.user.totalProfit += profit;
  req.user.totalTransactions += 1;
  await req.user.save();

  // İşlem kaydı
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'sell',
    amount: totalRevenue,
    productId,
    quantity,
    price: product.currentPrice,
    profit,
    description: `${product.name} satıldı`
  });

  // Deneyim kazan
  await req.user.addExperience(Math.floor(profit / 100));

  res.json({
    success: true,
    message: 'Ürün satıldı',
    data: {
      cash: req.user.cash,
      profit,
      inventory: req.user.inventory
    }
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
