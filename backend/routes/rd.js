const express = require('express');
const router = express.Router();
const { protect } = require('../middleware/auth');
const RdLab = require('../models/RdLab');
const Player = require('../models/Player');

// R&D Lab oluştur veya getir
router.get('/lab', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    
    let lab = await RdLab.findOne({ playerId });
    
    if (!lab) {
      lab = new RdLab({ playerId });
      await lab.save();
    }
    
    res.json({ success: true, data: { lab } });
  } catch (error) {
    console.error('Get lab error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Proje başlat
router.post('/start-project', protect, async (req, res) => {
  try {
    const { projectName, duration, budget, successProbability } = req.body;
    const playerId = req.user.id;

    if (!projectName || !duration || !budget) {
      return res.status(400).json({ success: false, message: 'Missing required fields' });
    }

    let lab = await RdLab.findOne({ playerId });
    if (!lab) {
      lab = new RdLab({ playerId });
      await lab.save();
    }

    if (!lab.canStartProject()) {
      return res.status(400).json({ success: false, message: 'Max projects reached' });
    }

    if (lab.currentBudget < budget) {
      return res.status(400).json({ success: false, message: 'Insufficient budget' });
    }

    const player = await Player.findById(playerId);
    if (!player) {
      return res.status(404).json({ success: false, message: 'Player not found' });
    }

    const startDate = new Date();
    const endDate = new Date(startDate.getTime() + duration * 24 * 60 * 60 * 1000);

    const project = {
      projectId: require('mongoose').Types.ObjectId(),
      progress: 0,
      startDate,
      endDate,
      status: 'in_progress'
    };

    lab.activeProjects.push(project);
    await lab.spendBudget(budget);

    res.json({
      success: true,
      message: 'Project started successfully',
      data: { project, lab }
    });
  } catch (error) {
    console.error('Start project error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Projeleri listele
router.get('/projects', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    const { status } = req.query;

    let lab = await RdLab.findOne({ playerId });
    if (!lab) {
      lab = new RdLab({ playerId });
      await lab.save();
    }

    let projects = lab.activeProjects;
    if (status) {
      projects = projects.filter(p => p.status === status);
    }

    res.json({
      success: true,
      data: {
        projects,
        completedProjects: lab.completedProjects.length,
        failedProjects: lab.failedProjects.length,
        successRate: lab.successRate
      }
    });
  } catch (error) {
    console.error('Get projects error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Proje ilerlemesi güncelle (Tick Engine tarafından çağrılır)
router.post('/update-progress', async (req, res) => {
  try {
    const labs = await RdLab.find({});
    const results = [];

    for (const lab of labs) {
      for (const project of lab.activeProjects) {
        if (project.status !== 'in_progress') continue;

        const now = new Date();
        const totalDuration = project.endDate - project.startDate;
        const elapsed = now - project.startDate;
        const progress = Math.min(100, (elapsed / totalDuration) * 100);

        project.progress = progress;

        if (now >= project.endDate) {
          const random = Math.random();
          const successProbability = 0.7 * lab.safetyFactor;

          if (random < successProbability) {
            project.status = 'completed';
            lab.totalProjectsCompleted += 1;
            lab.completedProjects.push(project.projectId);
          } else {
            project.status = 'failed';
            lab.totalProjectsFailed += 1;
            lab.failedProjects.push(project.projectId);
          }

          lab.activeProjects = lab.activeProjects.filter(p => p.projectId !== project.projectId);
          lab.updateSuccessRate();
        }
      }

      await lab.save();
      results.push({ labId: lab._id, projectsUpdated: lab.activeProjects.length });
    }

    res.json({
      success: true,
      message: 'Projects updated',
      data: { results }
    });
  } catch (error) {
    console.error('Update progress error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Lab seviyesini yükselt
router.post('/upgrade-lab', protect, async (req, res) => {
  try {
    const playerId = req.user.id;
    const upgradeCost = 50000;

    const player = await Player.findById(playerId);
    if (!player) {
      return res.status(404).json({ success: false, message: 'Player not found' });
    }

    if (player.cash < upgradeCost) {
      return res.status(400).json({ success: false, message: 'Insufficient cash' });
    }

    let lab = await RdLab.findOne({ playerId });
    if (!lab) {
      lab = new RdLab({ playerId });
      await lab.save();
    }

    lab.upgradeLevel();
    player.cash -= upgradeCost;
    await player.save();

    res.json({
      success: true,
      message: 'Lab upgraded successfully',
      data: { lab }
    });
  } catch (error) {
    console.error('Upgrade lab error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

// Bütçe ekle
router.post('/add-budget', protect, async (req, res) => {
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

    let lab = await RdLab.findOne({ playerId });
    if (!lab) {
      lab = new RdLab({ playerId });
      await lab.save();
    }

    lab.addBudget(amount);
    player.cash -= amount;
    await player.save();

    res.json({
      success: true,
      message: 'Budget added successfully',
      data: { lab }
    });
  } catch (error) {
    console.error('Add budget error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
