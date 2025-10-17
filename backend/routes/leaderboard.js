const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const Player = require('../models/Player');

// @route   GET /api/leaderboard/level
// @desc    Seviye sıralaması
// @access  Private
router.get('/level', protect, asyncHandler(async (req, res) => {
  const { limit = 100 } = req.query;
  
  const players = await Player.find({ isActive: true })
    .select('username name level experience')
    .sort({ level: -1, experience: -1 })
    .limit(parseInt(limit));
  
  res.json({
    success: true,
    data: { players }
  });
}));

// @route   GET /api/leaderboard/wealth
// @desc    Zenginlik sıralaması
// @access  Private
router.get('/wealth', protect, asyncHandler(async (req, res) => {
  const { limit = 100 } = req.query;
  
  const players = await Player.find({ isActive: true })
    .select('username name cash bankAccount portfolioValue debt')
    .limit(parseInt(limit));
  
  // Net worth hesapla ve sırala
  const playersWithNetWorth = players.map(player => ({
    username: player.username,
    name: player.name,
    netWorth: player.getNetWorth(),
    cash: player.cash,
    bankAccount: player.bankAccount
  })).sort((a, b) => b.netWorth - a.netWorth);
  
  res.json({
    success: true,
    data: { players: playersWithNetWorth }
  });
}));

// @route   GET /api/leaderboard/profit
// @desc    Kar sıralaması
// @access  Private
router.get('/profit', protect, asyncHandler(async (req, res) => {
  const { limit = 100 } = req.query;
  
  const players = await Player.find({ isActive: true })
    .select('username name totalProfit totalTransactions')
    .sort({ totalProfit: -1 })
    .limit(parseInt(limit));
  
  res.json({
    success: true,
    data: { players }
  });
}));

module.exports = router;
