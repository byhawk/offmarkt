const express = require('express');
const router = express.Router();
const { protect } = require('../middleware/auth');
const { protectAdmin } = require('../middleware/adminAuth');
const GlobalEvent = require('../models/GlobalEvent');
const Product = require('../models/Product');
const Player = require('../models/Player');

// Global olayları listele
router.get('/', async (req, res) => {
  try {
    const { status = 'active' } = req.query;
    
    const query = {};
    if (status === 'active') {
      query.isActive = true;
    } else if (status === 'triggered') {
      query.isTriggered = true;
    }
    
    const events = await GlobalEvent.find(query)
      .sort({ startDate: -1 })
      .limit(50);
    
    res.json({
      success: true,
      data: { events, count: events.length }
    });
  } catch (error) {
    console.error('Get events error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Olay detayı
router.get('/:id', async (req, res) => {
  try {
    const event = await GlobalEvent.findById(req.params.id);
    
    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found' });
    }
    
    res.json({ success: true, data: { event } });
  } catch (error) {
    console.error('Get event error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Olay oluştur (Admin)
router.post('/create', protectAdmin, async (req, res) => {
  try {
    const { type, name, severity, impact, durationHours } = req.body;
    
    if (!type || !name) {
      return res.status(400).json({ success: false, message: 'Missing required fields' });
    }
    
    const event = new GlobalEvent({
      type,
      name,
      severity: severity || 'medium',
      impact: impact || {},
      durationHours: durationHours || 24
    });
    
    await event.save();
    
    res.json({
      success: true,
      message: 'Event created successfully',
      data: { event }
    });
  } catch (error) {
    console.error('Create event error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Olay tetikle (Admin)
router.post('/:id/trigger', protectAdmin, async (req, res) => {
  try {
    const event = await GlobalEvent.findById(req.params.id);
    
    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found' });
    }
    
    await event.trigger();
    
    // Olay etkilerini uygula
    await applyEventEffects(event);
    
    res.json({
      success: true,
      message: 'Event triggered successfully',
      data: { event }
    });
  } catch (error) {
    console.error('Trigger event error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Olay güncelle (Admin)
router.put('/:id', protectAdmin, async (req, res) => {
  try {
    const { name, severity, impact, durationHours } = req.body;
    
    const event = await GlobalEvent.findById(req.params.id);
    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found' });
    }
    
    if (name) event.name = name;
    if (severity) event.severity = severity;
    if (impact) event.impact = impact;
    if (durationHours) event.durationHours = durationHours;
    
    await event.save();
    
    res.json({
      success: true,
      message: 'Event updated successfully',
      data: { event }
    });
  } catch (error) {
    console.error('Update event error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Olay sil (Admin)
router.delete('/:id', protectAdmin, async (req, res) => {
  try {
    const event = await GlobalEvent.findByIdAndDelete(req.params.id);
    
    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found' });
    }
    
    res.json({
      success: true,
      message: 'Event deleted successfully'
    });
  } catch (error) {
    console.error('Delete event error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Olay etkilerini uygula (Tick Engine tarafından çağrılır)
router.post('/apply-effects', async (req, res) => {
  try {
    const activeEvents = await GlobalEvent.find({ isActive: true, isTriggered: true });
    const results = [];
    
    for (const event of activeEvents) {
      const result = await applyEventEffects(event);
      results.push(result);
      
      // Olay süresi biterse deaktifleştir
      if (new Date() >= event.endDate) {
        event.isActive = false;
        await event.save();
      }
    }
    
    res.json({
      success: true,
      message: 'Event effects applied',
      data: { results }
    });
  } catch (error) {
    console.error('Apply effects error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Olay etkilerini uygula (Helper function)
async function applyEventEffects(event) {
  try {
    const impact = event.impact;
    
    switch (event.type) {
      case 'economic_crisis':
        // Tüm ürün fiyatlarını %20 düşür
        await Product.updateMany(
          { isActive: true },
          { $mul: { currentPrice: 0.8 } }
        );
        break;
        
      case 'boom_period':
        // Tüm ürün fiyatlarını %20 yükselt
        await Product.updateMany(
          { isActive: true },
          { $mul: { currentPrice: 1.2 } }
        );
        break;
        
      case 'technology_breakthrough':
        // R&D başarı oranını %30 artır (bu Tick Engine'de yapılır)
        break;
        
      case 'epidemic':
        // Sağlık ürünleri talebini artır
        await Product.updateMany(
          { category: 'health' },
          { $mul: { baseDemand: 1.5 } }
        );
        break;
    }
    
    return {
      eventId: event._id,
      type: event.type,
      applied: true
    };
  } catch (error) {
    console.error('Apply effects error:', error);
    return {
      eventId: event._id,
      type: event.type,
      applied: false,
      error: error.message
    };
  }
}

module.exports = router;
