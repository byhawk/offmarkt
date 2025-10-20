require('dotenv').config();
const mongoose = require('mongoose');
const Product = require('../models/Product');
const { Shop, ShopType, ShopInstance } = require('../models/Shop');
const Admin = require('../models/Admin');
const { logger } = require('../utils/logger');

// MongoDB bağlantısı
mongoose.connect(process.env.MONGODB_URI)
  .then(() => logger.info('MongoDB connected for seeding'))
  .catch(err => logger.error('MongoDB connection error:', err));

// Ürünler
const products = [
  // Electronics
  { name: 'Laptop', emoji: '💻', category: 'electronics', basePrice: 15000, currentPrice: 15000, demand: 60, volatility: 0.15, isLegal: true, minLevel: 1 },
  { name: 'Telefon', emoji: '📱', category: 'electronics', basePrice: 8000, currentPrice: 8000, demand: 70, volatility: 0.12, isLegal: true, minLevel: 1 },
  { name: 'Tablet', emoji: '📱', category: 'electronics', basePrice: 5000, currentPrice: 5000, demand: 55, volatility: 0.10, isLegal: true, minLevel: 1 },
  { name: 'Kulaklık', emoji: '🎧', category: 'electronics', basePrice: 1500, currentPrice: 1500, demand: 65, volatility: 0.08, isLegal: true, minLevel: 1 },
  
  // Clothing
  { name: 'Ayakkabı', emoji: '👟', category: 'clothing', basePrice: 2000, currentPrice: 2000, demand: 60, volatility: 0.10, isLegal: true, minLevel: 1 },
  { name: 'Ceket', emoji: '🧥', category: 'clothing', basePrice: 3000, currentPrice: 3000, demand: 50, volatility: 0.12, isLegal: true, minLevel: 1 },
  { name: 'Çanta', emoji: '👜', category: 'clothing', basePrice: 2500, currentPrice: 2500, demand: 55, volatility: 0.11, isLegal: true, minLevel: 1 },
  
  // Food
  { name: 'Kahve', emoji: '☕', category: 'food', basePrice: 500, currentPrice: 500, demand: 80, volatility: 0.05, isLegal: true, minLevel: 1 },
  { name: 'Çikolata', emoji: '🍫', category: 'food', basePrice: 300, currentPrice: 300, demand: 75, volatility: 0.06, isLegal: true, minLevel: 1 },
  { name: 'İçecek', emoji: '🥤', category: 'food', basePrice: 200, currentPrice: 200, demand: 85, volatility: 0.04, isLegal: true, minLevel: 1 },
  
  // Jewelry
  { name: 'Altın', emoji: '💍', category: 'jewelry', basePrice: 50000, currentPrice: 50000, demand: 40, volatility: 0.20, isLegal: true, minLevel: 5 },
  { name: 'Elmas', emoji: '💎', category: 'jewelry', basePrice: 100000, currentPrice: 100000, demand: 30, volatility: 0.25, isLegal: true, minLevel: 10 },
  { name: 'Saat', emoji: '⌚', category: 'jewelry', basePrice: 20000, currentPrice: 20000, demand: 45, volatility: 0.18, isLegal: true, minLevel: 3 },
  
  // Vehicles
  { name: 'Araba', emoji: '🚗', category: 'vehicles', basePrice: 200000, currentPrice: 200000, demand: 35, volatility: 0.15, isLegal: true, minLevel: 15 },
  { name: 'Motosiklet', emoji: '🏍️', category: 'vehicles', basePrice: 80000, currentPrice: 80000, demand: 40, volatility: 0.12, isLegal: true, minLevel: 10 }
];

// Dükkanlar
const shops = [
  // Street
  { name: 'Sokak Tezgahı', location: 'Merkez Sokak', locationType: 'street', monthlyRent: 5000, deposit: 2500, squareMeters: 10, floor: 0, hasWindow: false, parkingSpaces: 0 },
  { name: 'Köşe Dükkanı', location: 'Ana Cadde', locationType: 'street', monthlyRent: 8000, deposit: 4000, squareMeters: 20, floor: 0, hasWindow: true, parkingSpaces: 0 },
  
  // Mall
  { name: 'AVM Mağazası', location: 'City Mall', locationType: 'mall', monthlyRent: 15000, deposit: 7500, squareMeters: 50, floor: 1, hasWindow: true, parkingSpaces: 2 },
  { name: 'Premium Mağaza', location: 'Luxury Mall', locationType: 'mall', monthlyRent: 25000, deposit: 12500, squareMeters: 80, floor: 2, hasWindow: true, parkingSpaces: 3 },
  
  // Market
  { name: 'Mini Market', location: 'Mahalle Pazarı', locationType: 'market', monthlyRent: 10000, deposit: 5000, squareMeters: 30, floor: 0, hasWindow: true, parkingSpaces: 1 },
  { name: 'Süpermarket', location: 'Büyük Pazar', locationType: 'market', monthlyRent: 20000, deposit: 10000, squareMeters: 100, floor: 0, hasWindow: true, parkingSpaces: 5 },
  
  // Office
  { name: 'Ofis', location: 'İş Merkezi', locationType: 'office', monthlyRent: 12000, deposit: 6000, squareMeters: 40, floor: 3, hasWindow: true, parkingSpaces: 1 },
  { name: 'Lüks Ofis', location: 'Plaza', locationType: 'office', monthlyRent: 30000, deposit: 15000, squareMeters: 120, floor: 10, hasWindow: true, parkingSpaces: 4 },
  
  // Warehouse
  { name: 'Depo', location: 'Sanayi Bölgesi', locationType: 'warehouse', monthlyRent: 18000, deposit: 9000, squareMeters: 200, floor: 0, hasWindow: false, parkingSpaces: 10 },
  { name: 'Büyük Depo', location: 'Lojistik Merkezi', locationType: 'warehouse', monthlyRent: 35000, deposit: 17500, squareMeters: 500, floor: 0, hasWindow: false, parkingSpaces: 20 }
];

// Shop Types - Yeni sistem
const shopTypes = [
  {
    shopType: 'supermarket',
    displayName: 'Süpermarket',
    nameTemplate: '{ŞEHİR} Süpermarket',
    purchasePrice: 20000,
    rackCapacity: 2000,
    storageCapacity: 5000,
    minCustomers: 100,
    locationType: 'market'
  },
  {
    shopType: 'flower_shop',
    displayName: 'Çiçekçi Mağazası',
    nameTemplate: '{ŞEHİR} Çiçekçisi',
    purchasePrice: 15000,
    rackCapacity: 500,
    storageCapacity: 1000,
    minCustomers: 50,
    locationType: 'street'
  },
  {
    shopType: 'clothing_store',
    displayName: 'Giyim Mağazası',
    nameTemplate: '{ŞEHİR} Giyim',
    purchasePrice: 25000,
    rackCapacity: 1000,
    storageCapacity: 2000,
    minCustomers: 80,
    locationType: 'mall'
  },
  {
    shopType: 'electronics',
    displayName: 'Elektronik Dükkanı',
    nameTemplate: '{ŞEHİR} Elektronik',
    purchasePrice: 35000,
    rackCapacity: 800,
    storageCapacity: 1500,
    minCustomers: 60,
    locationType: 'mall'
  },
  {
    shopType: 'food_shop',
    displayName: 'Yiyecek Dükkanı',
    nameTemplate: '{ŞEHİR} Lezzet Evi',
    purchasePrice: 18000,
    rackCapacity: 1500,
    storageCapacity: 3000,
    minCustomers: 120,
    locationType: 'market'
  },
  {
    shopType: 'general',
    displayName: 'Genel Mağaza',
    nameTemplate: '{ŞEHİR} Market',
    purchasePrice: 22000,
    rackCapacity: 1800,
    storageCapacity: 4000,
    minCustomers: 90,
    locationType: 'street'
  }
];

// Seed fonksiyonu
async function seed() {
  try {
    // Mevcut verileri temizle
    logger.info('Clearing existing data...');
    await Product.deleteMany({});
    await Shop.deleteMany({});
    await ShopType.deleteMany({});

    // Ürünleri ekle
    logger.info('Seeding products...');
    await Product.insertMany(products);
    logger.info(`${products.length} products seeded`);

    // Dükkanları ekle
    logger.info('Seeding shops...');
    await Shop.insertMany(shops);
    logger.info(`${shops.length} shops seeded`);

    // Shop Types ekle (yeni sistem)
    logger.info('Seeding shop types...');
    await ShopType.insertMany(shopTypes);
    logger.info(`${shopTypes.length} shop types seeded`);
    
    // Admin kullanıcı oluştur (eğer yoksa)
    const adminExists = await Admin.findOne({ email: process.env.ADMIN_EMAIL });
    if (!adminExists) {
      logger.info('Creating admin user...');
      await Admin.create({
        username: 'admin',
        email: process.env.ADMIN_EMAIL || 'admin@offmarket.com',
        password: process.env.ADMIN_PASSWORD || 'Admin123!',
        role: 'super_admin',
        permissions: [
          'manage_players',
          'manage_products',
          'manage_shops',
          'manage_events',
          'manage_settings',
          'view_analytics',
          'ban_players',
          'manage_admins'
        ]
      });
      logger.info('Admin user created');
    } else {
      logger.info('Admin user already exists');
    }
    
    logger.info('Seeding completed successfully!');
    process.exit(0);
  } catch (error) {
    logger.error('Seeding error:', error);
    process.exit(1);
  }
}

// Seed'i çalıştır
seed();
