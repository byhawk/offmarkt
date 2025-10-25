const express = require('express');
const router = express.Router();
const { protect } = require('../middleware/auth');
const BankAccount = require('../models/BankAccount');
const Player = require('../models/Player');

// Hesap bilgisi
router.get('/account', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    
    let account = await BankAccount.findOne({ playerId });
    
    if (!account) {
      account = new BankAccount({ playerId });
      await account.save();
    }
    
    res.json({ success: true, data: { account } });
  } catch (error) {
    console.error('Get account error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Para yatır
router.post('/deposit', protect, async (req, res) => {
  try {
    const { amount } = req.body;
    const playerId = req.user.id;
    
    if (!amount || amount <= 0) {
      return res.status(400).json({ success: false, message: 'Invalid amount' });
    }
    
    const player = await Player.findById(playerId);
    if (!player) {
      return res.status(404).json({ success: false, message: 'Player not found' });
    }
    
    if (player.cash < amount) {
      return res.status(400).json({ success: false, message: 'Insufficient cash' });
    }
    
    let account = await BankAccount.findOne({ playerId });
    if (!account) {
      account = new BankAccount({ playerId });
    }
    
    await account.deposit(amount);
    player.cash -= amount;
    await player.save();
    
    res.json({
      success: true,
      message: 'Deposit successful',
      data: { account }
    });
  } catch (error) {
    console.error('Deposit error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Para çek
router.post('/withdraw', protect, async (req, res) => {
  try {
    const { amount } = req.body;
    const playerId = req.user.id;
    
    if (!amount || amount <= 0) {
      return res.status(400).json({ success: false, message: 'Invalid amount' });
    }
    
    const player = await Player.findById(playerId);
    if (!player) {
      return res.status(404).json({ success: false, message: 'Player not found' });
    }
    
    let account = await BankAccount.findOne({ playerId });
    if (!account) {
      return res.status(400).json({ success: false, message: 'No account found' });
    }
    
    if (account.balance < amount) {
      return res.status(400).json({ success: false, message: 'Insufficient balance' });
    }
    
    await account.withdraw(amount);
    player.cash += amount;
    await player.save();
    
    res.json({
      success: true,
      message: 'Withdrawal successful',
      data: { account }
    });
  } catch (error) {
    console.error('Withdraw error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// İşlem geçmişi
router.get('/transactions', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    const { limit = 50 } = req.query;
    
    let account = await BankAccount.findOne({ playerId });
    if (!account) {
      account = new BankAccount({ playerId });
      await account.save();
    }
    
    const transactions = account.getTransactionHistory(parseInt(limit));
    
    res.json({
      success: true,
      data: { transactions, count: transactions.length }
    });
  } catch (error) {
    console.error('Get transactions error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Faiz hesapla (Tick Engine tarafından çağrılır)
router.post('/calculate-interest', async (req, res) => {
  try {
    const accounts = await BankAccount.find({ isActive: true });
    let totalInterest = 0;
    const results = [];
    
    for (const account of accounts) {
      if (account.balance > 0) {
        const dailyInterest = account.balance * account.interestRate;
        
        await account.calculateInterest();
        
        // Oyuncuya faizi ekle
        const player = await Player.findById(account.playerId);
        if (player) {
          player.cash += dailyInterest;
          await player.save();
        }
        
        totalInterest += dailyInterest;
        results.push({
          accountId: account._id,
          interest: dailyInterest,
          newBalance: account.balance
        });
      }
    }
    
    res.json({
      success: true,
      message: 'Interest calculated',
      data: { totalInterest, results }
    });
  } catch (error) {
    console.error('Calculate interest error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
