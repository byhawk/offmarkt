const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const Product = require('../models/Product');
const Shop = require('../models/Shop');

// @route   GET /api/market/products
// @desc    Tüm ürünleri getir
// @access  Private
router.get('/products', protect, asyncHandler(async (req, res) => {
  const { category, trending } = req.query;
  
  let query = { isActive: true };
  
  if (category) query.category = category;
  if (trending === 'true') query.trending = true;
  
  // Seviye kontrolü
  query.minLevel = { $lte: req.user.level };
  
  const products = await Product.find(query);
  
  res.json({
    success: true,
    data: { products }
  });
}));

// @route   GET /api/market/products/:id
// @desc    Ürün detayı
// @access  Private
router.get('/products/:id', protect, asyncHandler(async (req, res) => {
  const product = await Product.findById(req.params.id);
  
  if (!product) {
    return res.status(404).json({
      success: false,
      message: 'Ürün bulunamadı'
    });
  }
  
  res.json({
    success: true,
    data: { product }
  });
}));

// @route   GET /api/market/categories
// @desc    Kategorileri getir
// @access  Private
router.get('/categories', protect, asyncHandler(async (req, res) => {
  const categories = ['electronics', 'clothing', 'food', 'jewelry', 'vehicles'];
  
  const categoryCounts = await Promise.all(
    categories.map(async (category) => {
      const count = await Product.countDocuments({ category, isActive: true });
      return { category, count };
    })
  );
  
  res.json({
    success: true,
    data: { categories: categoryCounts }
  });
}));

// === ARZ/TALEP ANALİZİ VE OTOMATİK FİYATLANDIRMA ===

// @route   GET /api/market/supply-demand-analysis
// @desc    Genel arz/talep analizini hesapla
// @access  Private
router.get('/supply-demand-analysis', protect, asyncHandler(async (req, res) => {
  const { productId } = req.query;

  // Tüm aktif dükkanları getir
  const allShops = await Shop.find({ isActive: true }).populate('listedProducts.productId');

  let analysis = {};

  if (productId) {
    // Belirli bir ürün için analiz
    analysis = await calculateSupplyDemandForProduct(productId, allShops);
  } else {
    // Tüm ürünlerin analizi
    const allProductIds = await Product.find({ isActive: true }).select('_id');
    const analysisResults = await Promise.all(
      allProductIds.map(async (product) => {
        const result = await calculateSupplyDemandForProduct(product._id, allShops);
        return { productId: product._id, ...result };
      })
    );

    analysis = {
      productAnalyses: analysisResults,
      summary: calculateMarketSummary(analysisResults)
    };
  }

  res.json({
    success: true,
    data: analysis
  });
}));

// @route   POST /api/market/auto-price-adjustment
// @desc    Tüm dükkanlar için otomatik fiyat ayarlama çalıştır
// @access  Private (Admin olabilir - şimdilik player erişimine açık)
router.post('/auto-price-adjustment', protect, asyncHandler(async (req, res) => {
  const { maxAdjustments = 10 } = req.body;

  // Tüm aktif dükkanları getir
  const allShops = await Shop.find({ isActive: true }).populate('listedProducts.productId');
  const adjustments = [];

  let adjustmentCount = 0;

  for (const shop of allShops) {
    if (!shop.autoPurchaseSettings.smartPricing || adjustmentCount >= maxAdjustments) {
      continue;
    }

    // Bu dükkanın analizini al
    const shopAnalysis = await calculateSupplyDemandForShop(shop._id);

    for (const analysis of shopAnalysis.productAnalyses) {
      if (analysis.supplyRatio < 0.5 || analysis.supplyRatio > 2.0) {
        // Fiyat ayarlama uygula
        await shop.adjustPriceForSupplyDemand(
          analysis.productId,
          analysis.supplyRatio
        );

        adjustments.push({
          shopId: shop._id,
          productId: analysis.productId,
          oldSupplyRatio: analysis.supplyRatio,
          priceAdjusted: true
        });

        adjustmentCount++;
        if (adjustmentCount >= maxAdjustments) break;
      }
    }

    if (adjustmentCount >= maxAdjustments) break;
  }

  res.json({
    success: true,
    message: `${adjustments.length} fiyat ayarlama işlemi yapıldı`,
    data: { adjustments }
  });
}));

// Yardımcı fonksiyonlar
async function calculateSupplyDemandForProduct(productId, allShops) {
  let totalListed = 0;
  let totalStock = 0;
  const shopListings = [];

  for (const shop of allShops) {
    const listing = shop.listedProducts.find(
      p => p.productId.toString() === productId.toString() && p.isActive
    );

    if (listing) {
      totalListed += listing.currentStock;
      totalStock += listing.maxStock; // Maksimum kapasite
      shopListings.push({
        shopId: shop._id,
        shopName: shop.name,
        currentStock: listing.currentStock,
        maxStock: listing.maxStock,
        listPrice: listing.listPrice
      });
    }
  }

  // Oyuncu envanterlerindeki toplam ürünü hesapla (potansiyel arz)
  const playersWithProduct = await require('../models/Player').find({
    'inventory.productId': productId,
    'inventory.quantity': { $gt: 0 }
  });

  const totalInventory = playersWithProduct.reduce((sum, player) => {
    const inventoryItem = player.inventory.find(
      item => item.productId.toString() === productId.toString()
    );
    return sum + (inventoryItem ? inventoryItem.quantity : 0);
  }, 0);

  const totalAvailable = totalInventory;
  const supplyRatio = totalAvailable > 0 ? totalListed / totalAvailable : 0;

  // Talep belirleme: Son satışlar, trendler vb.
  const demandLevel = calculateDemandLevel(supplyRatio);

  return {
    productId,
    totalListed,
    totalAvailable,
    totalCapacity: totalStock,
    supplyRatio,
    demandLevel,
    shopListings,
    recommendation: getPriceRecommendation(demandLevel)
  };
}

async function calculateSupplyDemandForShop(shopId) {
  const shop = await Shop.findById(shopId).populate('listedProducts.productId');

  if (!shop) return { productAnalyses: [] };

  const productAnalyses = await Promise.all(
    shop.listedProducts
      .filter(p => p.isActive)
      .map(async (listing) => {
        const analysis = await calculateSupplyDemandForProduct(
          listing.productId._id,
          await Shop.find({ isActive: true })
        );
        return {
          productId: listing.productId._id,
          productName: listing.productId.name,
          supplyRatio: analysis.supplyRatio,
          demandLevel: analysis.demandLevel
        };
      })
  );

  return {
    shopId,
    productAnalyses
  };
}

function calculateDemandLevel(supplyRatio) {
  if (supplyRatio < 0.3) return 'very_high';     // Çok az arz - yüksek talep
  if (supplyRatio < 0.7) return 'high';          // Az arz - yüksek talep
  if (supplyRatio <= 1.3) return 'balanced';     // Dengeli
  if (supplyRatio <= 2.0) return 'low';          // Çok arz - düşük talep
  return 'very_low';                             // Aşırı arz - çok düşük talep
}

function getPriceRecommendation(demandLevel) {
  switch (demandLevel) {
    case 'very_high': return 'Fiyatı %10-15 artır';
    case 'high': return 'Fiyatı %5-10 artır';
    case 'balanced': return 'Fiyatı koru';
    case 'low': return 'Fiyatı %5-10 düşür';
    case 'very_low': return 'Fiyatı %10-15 düşür';
    default: return 'Fiyatı koru';
  }
}

function calculateMarketSummary(analyses) {
  const totalProducts = analyses.length;
  const highDemandProducts = analyses.filter(a => ['very_high', 'high'].includes(a.demandLevel)).length;
  const lowDemandProducts = analyses.filter(a => ['low', 'very_low'].includes(a.demandLevel)).length;
  const balancedProducts = analyses.filter(a => a.demandLevel === 'balanced').length;

  const avgSupplyRatio = analyses.reduce((sum, a) => sum + a.supplyRatio, 0) / totalProducts;

  return {
    totalProducts,
    highDemandProducts,
    balancedProducts,
    lowDemandProducts,
    avgSupplyRatio,
    marketHealth: avgSupplyRatio >= 0.7 && avgSupplyRatio <= 1.3 ? 'healthy' : 'unbalanced'
  };
}

module.exports = router;
