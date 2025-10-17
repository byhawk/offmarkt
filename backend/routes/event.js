const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const Event = require('../models/Event');

// @route   GET /api/event/active
// @desc    Aktif olayları getir
// @access  Private
router.get('/active', protect, asyncHandler(async (req, res) => {
  const events = await Event.getActiveEvents(req.user._id);
  
  res.json({
    success: true,
    data: { events }
  });
}));

// @route   POST /api/event/:id/respond
// @desc    Olaya yanıt ver
// @access  Private
router.post('/:id/respond', protect, asyncHandler(async (req, res) => {
  const { choiceId } = req.body;
  const event = await Event.findById(req.params.id);
  
  if (!event || event.playerId.toString() !== req.user._id.toString()) {
    return res.status(404).json({
      success: false,
      message: 'Olay bulunamadı'
    });
  }

  if (event.status !== 'active') {
    return res.status(400).json({
      success: false,
      message: 'Bu olay artık aktif değil'
    });
  }

  // Seçilen choice'ın etkilerini uygula
  const choice = event.choices.find(c => c.id === choiceId);
  if (choice) {
    for (const effect of choice.effects) {
      switch (effect.type) {
        case 'cashGain':
          req.user.cash += effect.value;
          break;
        case 'cashLoss':
          req.user.cash = Math.max(0, req.user.cash - effect.value);
          break;
        case 'reputationChange':
          if (effect.target === 'legal') {
            req.user.legalReputation = Math.max(0, Math.min(100, req.user.legalReputation + effect.value));
          } else if (effect.target === 'street') {
            req.user.streetReputation = Math.max(0, Math.min(100, req.user.streetReputation + effect.value));
          }
          break;
        case 'riskIncrease':
          req.user.riskLevel = Math.min(100, req.user.riskLevel + effect.value);
          break;
        case 'riskDecrease':
          req.user.riskLevel = Math.max(0, req.user.riskLevel - effect.value);
          break;
      }
    }
    await req.user.save();
  }

  // Olayı tamamla
  await event.complete(choiceId);

  res.json({
    success: true,
    message: 'Yanıt kaydedildi',
    data: {
      event,
      player: {
        cash: req.user.cash,
        legalReputation: req.user.legalReputation,
        streetReputation: req.user.streetReputation,
        riskLevel: req.user.riskLevel
      }
    }
  });
}));

// @route   GET /api/event/history
// @desc    Olay geçmişi
// @access  Private
router.get('/history', protect, asyncHandler(async (req, res) => {
  const { limit = 50 } = req.query;
  const history = await Event.getHistory(req.user._id, parseInt(limit));
  
  res.json({
    success: true,
    data: { history }
  });
}));

module.exports = router;
