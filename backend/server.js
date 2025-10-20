require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const http = require('http');
const socketIO = require('socket.io');
const redis = require('redis');

// Import routes
const authRoutes = require('./routes/auth');
const playerRoutes = require('./routes/player');
const marketRoutes = require('./routes/market');
const shopRoutes = require('./routes/shop');
const tradeRoutes = require('./routes/trade');
const eventRoutes = require('./routes/event');
const leaderboardRoutes = require('./routes/leaderboard');
const adminRoutes = require('./routes/admin');

// Import middleware
const { errorHandler } = require('./middleware/errorHandler');
const { logger } = require('./utils/logger');

// Initialize Express
const app = express();
const server = http.createServer(app);

// Initialize Socket.IO
const io = socketIO(server, {
  cors: {
    origin: process.env.CORS_ORIGIN || '*',
    methods: ['GET', 'POST']
  }
});

// Redis client
const redisClient = redis.createClient({
  host: process.env.REDIS_HOST || 'localhost',
  port: process.env.REDIS_PORT || 6379,
  password: process.env.REDIS_PASSWORD || undefined
});

redisClient.on('error', (err) => logger.error('Redis Error:', err));
redisClient.on('connect', () => logger.info('Redis connected'));

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/offmarket', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => {
  logger.info('MongoDB connected');
}).catch((err) => {
  logger.error('MongoDB connection error:', err);
  process.exit(1); // Exit if can't connect to DB
});

// Middleware
app.use(helmet());
app.use(compression());
app.use(cors({
  origin: process.env.CORS_ORIGIN || '*',
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(morgan('combined', { stream: { write: message => logger.info(message.trim()) } }));

// Rate limiting
const limiter = rateLimit({
  windowMs: (process.env.RATE_LIMIT_WINDOW || 15) * 60 * 1000,
  max: process.env.RATE_LIMIT_MAX_REQUESTS || 100,
  message: 'Çok fazla istek gönderdiniz, lütfen daha sonra tekrar deneyin.'
});
app.use('/api/', limiter);

// Health check
app.get('/health', (req, res) => {
  res.json({
    status: 'OK',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    mongodb: mongoose.connection.readyState === 1 ? 'connected' : 'disconnected',
    redis: redisClient.isOpen ? 'connected' : 'disconnected'
  });
});

// Test endpoint - temporary for debugging shop-types
app.get('/test/shop-types', async (req, res) => {
  try {
    const { ShopType } = require('./models/Shop');
    const types = await ShopType.find().limit(5);
    res.json({
      success: true,
      count: types.length,
      data: types,
      message: 'Shop-types test endpoint working'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error accessing shop types',
      error: error.message
    });
  }
});

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/player', playerRoutes);
app.use('/api/market', marketRoutes);
app.use('/api/shop', shopRoutes);
app.use('/api/trade', tradeRoutes);
app.use('/api/event', eventRoutes);
app.use('/api/leaderboard', leaderboardRoutes);
app.use('/api/admin', adminRoutes);

// Socket.IO connection handling
io.on('connection', (socket) => {
  logger.info(`Client connected: ${socket.id}`);

  // Player joins game
  socket.on('player:join', async (data) => {
    const { playerId, token } = data;
    // Verify token and join player to their room
    socket.join(`player:${playerId}`);
    logger.info(`Player ${playerId} joined`);
  });

  // Market updates subscription
  socket.on('market:subscribe', () => {
    socket.join('market:updates');
  });

  // Player disconnect
  socket.on('disconnect', () => {
    logger.info(`Client disconnected: ${socket.id}`);
  });
});

// Market price update interval
setInterval(async () => {
  try {
    const Product = require('./models/Product');
    await Product.updateAllPrices();
    
    // Broadcast to all subscribed clients
    const products = await Product.find({ isActive: true });
    io.to('market:updates').emit('market:priceUpdate', products);
  } catch (error) {
    logger.error('Market update error:', error);
  }
}, process.env.MARKET_UPDATE_INTERVAL || 300000);

// Event check interval
setInterval(async () => {
  try {
    const Event = require('./models/Event');
    const Player = require('./models/Player');
    
    // Trigger random events for active players
    const activePlayers = await Player.find({ 
      isOnline: true,
      lastActivity: { $gte: new Date(Date.now() - 3600000) } // Last hour
    });

    for (const player of activePlayers) {
      const event = await Event.triggerRandomEvent(player);
      if (event) {
        io.to(`player:${player._id}`).emit('event:triggered', event);
      }
    }
  } catch (error) {
    logger.error('Event check error:', error);
  }
}, process.env.EVENT_CHECK_INTERVAL || 60000);

// Error handling middleware
app.use(errorHandler);

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Endpoint bulunamadı'
  });
});

// Start server
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  logger.info(`Server running on port ${PORT}`);
  logger.info(`Environment: ${process.env.NODE_ENV}`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  logger.info('SIGTERM signal received: closing HTTP server');
  server.close(() => {
    logger.info('HTTP server closed');
    mongoose.connection.close(false, () => {
      logger.info('MongoDB connection closed');
      redisClient.quit(() => {
        logger.info('Redis connection closed');
        process.exit(0);
      });
    });
  });
});

module.exports = { app, io, redisClient };
