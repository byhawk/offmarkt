const express = require('express');
const router = express.Router();
const { protect } = require('../middleware/auth');
const Holding = require('../models/Holding');
const Player = require('../models/Player');

// Holding oluştur veya getir
router.get('/', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    
    let holding = await Holding.findOne({ playerId });
    
    if (!holding) {
      holding = new Holding({ playerId });
      await holding.save();
    }
    
    res.json({ success: true, data: { holding } });
  } catch (error) {
    console.error('Get holding error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Hisse satın al
router.post('/buy-shares', protect, async (req, res) => {
  try {
    const { companyId, companyName, quantity, pricePerShare } = req.body;
    const playerId = req.user.id;

    if (!companyId || !quantity || !pricePerShare) {
      return res.status(400).json({ success: false, message: 'Missing required fields' });
    }

    const player = await Player.findById(playerId);
    if (!player) {
      return res.status(404).json({ success: false, message: 'Player not found' });
    }

    const totalCost = quantity * pricePerShare;
    if (player.cash < totalCost) {
      return res.status(400).json({ success: false, message: 'Insufficient cash' });
    }

    let holding = await Holding.findOne({ playerId });
    if (!holding) {
      holding = new Holding({ playerId });
    }

    holding.buyShares(companyId, companyName, quantity, pricePerShare);
    player.cash -= totalCost;
    await player.save();

    res.json({
      success: true,
      message: 'Shares purchased successfully',
      data: { holding }
    });
  } catch (error) {
    console.error('Buy shares error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Hisse sat
router.post('/sell-shares', protect, async (req, res) => {
  try {
    const { companyId, quantity, currentPrice } = req.body;
    const playerId = req.user.id;

    if (!companyId || !quantity || !currentPrice) {
      return res.status(400).json({ success: false, message: 'Missing required fields' });
    }

    const player = await Player.findById(playerId);
    if (!player) {
      return res.status(404).json({ success: false, message: 'Player not found' });
    }

    let holding = await Holding.findOne({ playerId });
    if (!holding) {
      return res.status(400).json({ success: false, message: 'No holding found' });
    }

    const result = holding.sellShares(companyId, quantity, currentPrice);
    player.cash += result.saleValue;
    await player.save();

    res.json({
      success: true,
      message: 'Shares sold successfully',
      data: { saleValue: result.saleValue, profit: result.profit, holding }
    });
  } catch (error) {
    console.error('Sell shares error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Temettü bilgisi
router.get('/dividends', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    
    let holding = await Holding.findOne({ playerId });
    if (!holding) {
      holding = new Holding({ playerId });
      await holding.save();
    }

    res.json({
      success: true,
      data: {
        monthlyDividend: holding.monthlyDividend,
        totalDividendReceived: holding.totalDividendReceived,
        lastDividendDate: holding.lastDividendDate,
        nextDividendDate: holding.nextDividendDate
      }
    });
  } catch (error) {
    console.error('Get dividends error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Temettü öde (Tick Engine tarafından çağrılır)
router.post('/pay-dividends', async (req, res) => {
  try {
    const holdings = await Holding.find({});
    let totalPaid = 0;
    const results = [];

    for (const holding of holdings) {
      if (holding.shares.length === 0) continue;

      const player = await Player.findById(holding.playerId);
      if (!player) continue;

      const dividend = holding.monthlyDividend;
      if (dividend > 0) {
        player.cash += dividend;
        holding.receiveDividend(dividend);
        
        await player.save();
        await holding.save();
        
        totalPaid += dividend;
        results.push({ holdingId: holding._id, dividend });
      }
    }

    res.json({
      success: true,
      message: 'Dividends paid',
      data: { totalPaid, results }
    });
  } catch (error) {
    console.error('Pay dividends error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
