const express = require('express');
const router = express.Router();
const { protect } = require('../middleware/auth');
const Employee = require('../models/Employee');
const Player = require('../models/Player');

// Çalışan işe al
router.post('/hire', protect, async (req, res) => {
  try {
    const { name, position, salary } = req.body;
    const playerId = req.user.id;

    if (!name || !position || !salary) {
      return res.status(400).json({ success: false, message: 'Missing required fields' });
    }

    const player = await Player.findById(playerId);
    if (!player) {
      return res.status(404).json({ success: false, message: 'Player not found' });
    }

    if (player.cash < salary) {
      return res.status(400).json({ success: false, message: 'Insufficient cash' });
    }

    const employee = new Employee({
      playerId,
      name,
      position,
      salary
    });

    await employee.save();
    player.cash -= salary;
    await player.save();

    res.json({
      success: true,
      message: 'Employee hired successfully',
      data: { employee }
    });
  } catch (error) {
    console.error('Hire employee error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Çalışanları listele
router.get('/employees', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    const { status = 'active' } = req.query;

    const query = { playerId };
    if (status) query.status = status;

    const employees = await Employee.find(query).sort({ hireDate: -1 });

    const totalSalaries = employees
      .filter(e => e.status === 'active')
      .reduce((sum, e) => sum + e.salary, 0);

    res.json({
      success: true,
      data: {
        employees,
        totalSalaries,
        count: employees.length
      }
    });
  } catch (error) {
    console.error('Get employees error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Çalışan detayı
router.get('/employees/:id', protect, async (req, res) => {
  try {
    const employee = await Employee.findById(req.params.id);

    if (!employee) {
      return res.status(404).json({ success: false, message: 'Employee not found' });
    }

    if (employee.playerId.toString() !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    res.json({ success: true, data: { employee } });
  } catch (error) {
    console.error('Get employee error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Çalışan güncelle
router.put('/employees/:id', protect, async (req, res) => {
  try {
    const { salary, position, skills } = req.body;
    const employee = await Employee.findById(req.params.id);

    if (!employee) {
      return res.status(404).json({ success: false, message: 'Employee not found' });
    }

    if (employee.playerId.toString() !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    if (salary) employee.salary = salary;
    if (position) employee.position = position;
    if (skills) employee.skills = skills;

    await employee.save();

    res.json({
      success: true,
      message: 'Employee updated successfully',
      data: { employee }
    });
  } catch (error) {
    console.error('Update employee error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Çalışan çıkar
router.delete('/employees/:id', protect, async (req, res) => {
  try {
    const employee = await Employee.findById(req.params.id);

    if (!employee) {
      return res.status(404).json({ success: false, message: 'Employee not found' });
    }

    if (employee.playerId.toString() !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    employee.status = 'fired';
    employee.fireDate = new Date();
    await employee.save();

    res.json({
      success: true,
      message: 'Employee fired successfully',
      data: { employee }
    });
  } catch (error) {
    console.error('Fire employee error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Çalışan istatistikleri
router.get('/employees/:id/stats', protect, async (req, res) => {
  try {
    const employee = await Employee.findById(req.params.id);

    if (!employee) {
      return res.status(404).json({ success: false, message: 'Employee not found' });
    }

    if (employee.playerId.toString() !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    const monthlyContribution = employee.calculateMonthlyContribution();

    res.json({
      success: true,
      data: {
        performance: employee.performance,
        loyalty: employee.loyalty,
        productivity: employee.productivity,
        satisfaction: employee.satisfaction,
        monthlyContribution,
        totalEarnings: employee.totalEarnings,
        totalContribution: employee.totalContribution
      }
    });
  } catch (error) {
    console.error('Get employee stats error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Maaş öde (Tick Engine tarafından çağrılır)
router.post('/pay-salaries', async (req, res) => {
  try {
    const employees = await Employee.find({ status: 'active' });

    let totalPaid = 0;
    const results = [];

    for (const employee of employees) {
      const player = await Player.findById(employee.playerId);
      if (!player) continue;

      const salary = employee.salary;
      
      if (player.cash >= salary) {
        player.cash -= salary;
        employee.totalEarnings += salary;
        employee.lastPaymentDate = new Date();
        
        await player.save();
        await employee.save();
        
        totalPaid += salary;
        results.push({ employeeId: employee._id, paid: true });
      } else {
        results.push({ employeeId: employee._id, paid: false, reason: 'Insufficient cash' });
      }
    }

    res.json({
      success: true,
      message: 'Salaries processed',
      data: { totalPaid, results }
    });
  } catch (error) {
    console.error('Pay salaries error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
