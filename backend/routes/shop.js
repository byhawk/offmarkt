const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const Shop = require('../models/Shop');
const Transaction = require('../models/Transaction');

// @route   GET /api/shop/available
// @desc    Müsait dükkanları getir
// @access  Private
router.get('/available', protect, asyncHandler(async (req, res) => {
  const { locationType } = req.query;
  
  let shops;
  if (locationType) {
    shops = await Shop.getByLocationType(locationType);
  } else {
    shops = await Shop.getAvailable();
  }
  
  res.json({
    success: true,
    data: { shops }
  });
}));

// @route   POST /api/shop/rent
// @desc    Dükkan kirala
// @access  Private
router.post('/rent', protect, asyncHandler(async (req, res) => {
  const { shopId, businessCategory } = req.body;

  const shop = await Shop.findById(shopId);
  
  if (!shop || !shop.isAvailable) {
    return res.status(400).json({
      success: false,
      message: 'Dükkan müsait değil'
    });
  }

  const totalCost = shop.monthlyRent + shop.deposit;
  
  if (req.user.cash < totalCost) {
    return res.status(400).json({
      success: false,
      message: 'Yetersiz nakit'
    });
  }

  // Dükkanı kirala
  await shop.rent(req.user._id, businessCategory);
  
  // Oyuncuya ekle
  req.user.ownedShops.push(shop._id);
  req.user.cash -= totalCost;
  await req.user.save();

  // İşlem kaydı
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'rent_shop',
    amount: totalCost,
    shopId: shop._id,
    description: `${shop.name} kiralandı`
  });

  res.json({
    success: true,
    message: 'Dükkan kiralandı',
    data: {
      shop,
      cash: req.user.cash
    }
  });
}));

// @route   DELETE /api/shop/:id/leave
// @desc    Dükkan bırak
// @access  Private
router.delete('/:id/leave', protect, asyncHandler(async (req, res) => {
  const shop = await Shop.findById(req.params.id);
  
  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(400).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  // Dükkanı bırak
  await shop.leave();
  
  // Oyuncudan çıkar
  req.user.ownedShops = req.user.ownedShops.filter(
    id => id.toString() !== shop._id.toString()
  );
  await req.user.save();

  // İşlem kaydı
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'leave_shop',
    amount: 0,
    shopId: shop._id,
    description: `${shop.name} bırakıldı`
  });

  res.json({
    success: true,
    message: 'Dükkan bırakıldı'
  });
}));

// @route   GET /api/shop/owned
// @desc    Sahip olunan dükkanlar
// @access  Private
router.get('/owned', protect, asyncHandler(async (req, res) => {
  const shops = await Shop.getPlayerShops(req.user._id);
  
  res.json({
    success: true,
    data: { shops }
  });
}));

module.exports = router;
