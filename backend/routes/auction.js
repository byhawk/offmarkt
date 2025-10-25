const express = require('express');
const router = express.Router();
const { protect } = require('../middleware/auth');
const Auction = require('../models/Auction');
const Player = require('../models/Player');

// İhale oluştur
router.post('/create', protect, async (req, res) => {
  try {
    const { itemType, itemId, itemName, startPrice, duration } = req.body;
    const playerId = req.user.id;

    if (!itemType || !itemId || !itemName || !startPrice || !duration) {
      return res.status(400).json({ success: false, message: 'Missing required fields' });
    }

    const endDate = new Date(Date.now() + duration * 60 * 60 * 1000);

    const auction = new Auction({
      itemType,
      itemId,
      itemName,
      startPrice,
      currentPrice: startPrice,
      endDate,
      createdBy: playerId
    });

    await auction.save();

    res.json({
      success: true,
      message: 'Auction created successfully',
      data: { auction }
    });
  } catch (error) {
    console.error('Create auction error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// İhaleleri listele
router.get('/', async (req, res) => {
  try {
    const { status = 'active' } = req.query;

    const query = {};
    if (status) query.status = status;

    const auctions = await Auction.find(query)
      .sort({ endDate: 1 })
      .limit(50);

    res.json({
      success: true,
      data: { auctions, count: auctions.length }
    });
  } catch (error) {
    console.error('Get auctions error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// İhale detayı
router.get('/:id', async (req, res) => {
  try {
    const auction = await Auction.findById(req.params.id);

    if (!auction) {
      return res.status(404).json({ success: false, message: 'Auction not found' });
    }

    res.json({
      success: true,
      data: {
        auction,
        timeRemaining: auction.getFormattedTimeRemaining(),
        isActive: auction.isActive()
      }
    });
  } catch (error) {
    console.error('Get auction error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Teklif ver
router.post('/:id/bid', protect, async (req, res) => {
  try {
    const { amount } = req.body;
    const playerId = req.user.id;

    if (!amount || amount <= 0) {
      return res.status(400).json({ success: false, message: 'Invalid bid amount' });
    }

    const auction = await Auction.findById(req.params.id);
    if (!auction) {
      return res.status(404).json({ success: false, message: 'Auction not found' });
    }

    if (!auction.isActive()) {
      return res.status(400).json({ success: false, message: 'Auction is not active' });
    }

    const player = await Player.findById(playerId);
    if (!player) {
      return res.status(404).json({ success: false, message: 'Player not found' });
    }

    if (player.cash < amount) {
      return res.status(400).json({ success: false, message: 'Insufficient cash' });
    }

    auction.placeBid(playerId, player.username, amount);
    await auction.save();

    res.json({
      success: true,
      message: 'Bid placed successfully',
      data: { auction }
    });
  } catch (error) {
    console.error('Place bid error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// İhale tamamla (Tick Engine tarafından çağrılır)
router.post('/complete-auctions', async (req, res) => {
  try {
    const auctions = await Auction.find({ status: 'active' });
    const results = [];

    for (const auction of auctions) {
      if (new Date() >= auction.endDate) {
        auction.completeAuction();
        await auction.save();

        if (auction.status === 'completed' && auction.winner) {
          const winner = await Player.findById(auction.winner);
          if (winner) {
            winner.cash -= auction.finalPrice;
            await winner.save();
          }
        }

        results.push({
          auctionId: auction._id,
          status: auction.status,
          winner: auction.winner,
          finalPrice: auction.finalPrice
        });
      }
    }

    res.json({
      success: true,
      message: 'Auctions completed',
      data: { results }
    });
  } catch (error) {
    console.error('Complete auctions error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// İhale iptal et
router.post('/:id/cancel', protect, async (req, res) => {
  try {
    const auction = await Auction.findById(req.params.id);

    if (!auction) {
      return res.status(404).json({ success: false, message: 'Auction not found' });
    }

    if (auction.createdBy.toString() !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    auction.cancelAuction();
    await auction.save();

    res.json({
      success: true,
      message: 'Auction cancelled successfully',
      data: { auction }
    });
  } catch (error) {
    console.error('Cancel auction error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
