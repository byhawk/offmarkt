const express = require('express');
const router = express.Router();
const { protect } = require('../middleware/auth');
const { protectAdmin } = require('../middleware/adminAuth');
const PremiumCurrency = require('../models/PremiumCurrency');
const Player = require('../models/Player');

// Gem bakiyesi
router.get('/balance', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    
    let premium = await PremiumCurrency.findOne({ playerId });
    
    if (!premium) {
      premium = new PremiumCurrency({ playerId });
      await premium.save();
    }
    
    res.json({
      success: true,
      data: {
        gems: premium.gems,
        totalSpent: premium.totalSpent,
        totalEarned: premium.totalEarned,
        activeBoosts: premium.getActiveBoosts()
      }
    });
  } catch (error) {
    console.error('Get balance error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Gem satın al (Admin tarafından)
router.post('/purchase', protectAdmin, async (req, res) => {
  try {
    const { playerId, amount, price } = req.body;
    
    if (!playerId || !amount || !price) {
      return res.status(400).json({ success: false, message: 'Missing required fields' });
    }
    
    let premium = await PremiumCurrency.findOne({ playerId });
    if (!premium) {
      premium = new PremiumCurrency({ playerId });
    }
    
    const balanceBefore = premium.gems;
    premium.gems += amount;
    premium.totalPurchased += amount;
    
    premium.transactions.push({
      type: 'purchase',
      amount,
      price,
      balanceBefore,
      balanceAfter: premium.gems
    });
    
    await premium.save();
    
    res.json({
      success: true,
      message: 'Gems purchased successfully',
      data: { premium }
    });
  } catch (error) {
    console.error('Purchase error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Gem harca
router.post('/spend', protect, async (req, res) => {
  try {
    const { amount, reason } = req.body;
    const playerId = req.user.id;
    
    if (!amount || amount <= 0) {
      return res.status(400).json({ success: false, message: 'Invalid amount' });
    }
    
    let premium = await PremiumCurrency.findOne({ playerId });
    if (!premium) {
      return res.status(400).json({ success: false, message: 'No premium account' });
    }
    
    if (premium.gems < amount) {
      return res.status(400).json({ success: false, message: 'Insufficient gems' });
    }
    
    await premium.spendGems(amount, reason);
    
    res.json({
      success: true,
      message: 'Gems spent successfully',
      data: { premium }
    });
  } catch (error) {
    console.error('Spend error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Gem kazan
router.post('/earn', protect, async (req, res) => {
  try {
    const { amount, reason } = req.body;
    const playerId = req.user.id;
    
    if (!amount || amount <= 0) {
      return res.status(400).json({ success: false, message: 'Invalid amount' });
    }
    
    let premium = await PremiumCurrency.findOne({ playerId });
    if (!premium) {
      premium = new PremiumCurrency({ playerId });
    }
    
    await premium.earnGems(amount, reason);
    
    res.json({
      success: true,
      message: 'Gems earned successfully',
      data: { premium }
    });
  } catch (error) {
    console.error('Earn error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// İşlem geçmişi
router.get('/transactions', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    const { limit = 50 } = req.query;
    
    let premium = await PremiumCurrency.findOne({ playerId });
    if (!premium) {
      premium = new PremiumCurrency({ playerId });
      await premium.save();
    }
    
    const transactions = premium.getTransactionHistory(parseInt(limit));
    
    res.json({
      success: true,
      data: { transactions, count: transactions.length }
    });
  } catch (error) {
    console.error('Get transactions error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Boost aktifleştir
router.post('/boost/activate', protect, async (req, res) => {
  try {
    const { boostType, multiplier, durationHours, cost } = req.body;
    const playerId = req.user.id;
    
    if (!boostType || !multiplier || !durationHours || !cost) {
      return res.status(400).json({ success: false, message: 'Missing required fields' });
    }
    
    let premium = await PremiumCurrency.findOne({ playerId });
    if (!premium) {
      return res.status(400).json({ success: false, message: 'No premium account' });
    }
    
    if (premium.gems < cost) {
      return res.status(400).json({ success: false, message: 'Insufficient gems' });
    }
    
    await premium.spendGems(cost, `Boost: ${boostType}`);
    await premium.activateBoost(boostType, multiplier, durationHours);
    
    res.json({
      success: true,
      message: 'Boost activated successfully',
      data: { premium }
    });
  } catch (error) {
    console.error('Activate boost error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Aktif boostlar
router.get('/boost/active', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    
    let premium = await PremiumCurrency.findOne({ playerId });
    if (!premium) {
      premium = new PremiumCurrency({ playerId });
      await premium.save();
    }
    
    const activeBoosts = premium.getActiveBoosts();
    
    res.json({
      success: true,
      data: { boosts: activeBoosts, count: activeBoosts.length }
    });
  } catch (error) {
    console.error('Get active boosts error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Boost deaktifleştir
router.post('/boost/deactivate', protect, async (req, res) => {
  try {
    const { boostId } = req.body;
    const playerId = req.user.id;
    
    if (!boostId) {
      return res.status(400).json({ success: false, message: 'Missing boost ID' });
    }
    
    let premium = await PremiumCurrency.findOne({ playerId });
    if (!premium) {
      return res.status(400).json({ success: false, message: 'No premium account' });
    }
    
    await premium.deactivateBoost(boostId);
    
    res.json({
      success: true,
      message: 'Boost deactivated successfully',
      data: { premium }
    });
  } catch (error) {
    console.error('Deactivate boost error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Tüm oyuncuların premium bilgisi (Admin)
router.get('/admin/all', protectAdmin, async (req, res) => {
  try {
    const premiums = await PremiumCurrency.find({})
      .sort({ gems: -1 })
      .limit(100);
    
    res.json({
      success: true,
      data: { premiums, count: premiums.length }
    });
  } catch (error) {
    console.error('Get all premiums error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
