const express = require('express');
const router = express.Router();
const { asyncHandler } = require('../middleware/errorHandler');
const { protect } = require('../middleware/auth');
const { Shop, ShopType, ShopInstance } = require('../models/Shop');
const Transaction = require('../models/Transaction');
const Product = require('../models/Product');
const PendingAction = require('../models/PendingAction');

// @route   GET /api/shop/types
// @desc    Satın alınabilir dükkan tiplerini getir (YENİ SİSTEM)
// @access  Private
router.get('/types', protect, asyncHandler(async (req, res) => {
  const shopTypes = await ShopType.find({ isActive: true });

  res.json({
    success: true,
    data: { shopTypes }
  });
}));

// @route   GET /api/shop/available
// @desc    Müsait dükkanları getir (ESKİ SİSTEM - backward compatibility)
// @access  Private
router.get('/available', protect, asyncHandler(async (req, res) => {
  // Yeni sistem: ShopType'ları döndür
  const shopTypes = await ShopType.find({ isActive: true });

  res.json({
    success: true,
    data: {
      shops: shopTypes // Backward compatibility için 'shops' key'i kullan
    }
  });
}));

// @route   POST /api/shop/rent
// @desc    Dükkan kirala
// @access  Private
router.post('/rent', protect, asyncHandler(async (req, res) => {
  const { shopId } = req.body;

  const shop = await Shop.findById(shopId);

  if (!shop || !shop.isAvailable) {
    return res.status(400).json({
      success: false,
      message: 'Dükkan müsait değil'
    });
  }

  const totalCost = shop.monthlyRent + shop.deposit;

  if (req.user.cash < totalCost) {
    return res.status(400).json({
      success: false,
      message: 'Yetersiz nakit'
    });
  }

  // Dükkanı kirala
  await shop.rent(req.user._id);
  
  // Oyuncuya ekle
  req.user.ownedShops.push(shop._id);
  req.user.cash -= totalCost;
  await req.user.save();

  // İşlem kaydı
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'rent_shop',
    amount: totalCost,
    shopId: shop._id,
    description: `${shop.name} kiralandı`
  });

  res.json({
    success: true,
    message: 'Dükkan kiralandı',
    data: {
      shop,
      cash: req.user.cash
    }
  });
}));

// @route   POST /api/shop/purchase
// @desc    Dükkan satın al (YENİ SİSTEM)
// @access  Private
router.post('/purchase', protect, asyncHandler(async (req, res) => {
  const { shopTypeId, city, country, customName } = req.body;

  // ShopType'ı bul
  const shopType = await ShopType.findById(shopTypeId);

  if (!shopType || !shopType.isActive) {
    return res.status(400).json({
      success: false,
      message: 'Bu dükkan tipi mevcut değil'
    });
  }

  const purchasePrice = shopType.purchasePrice;

  // Oyuncunun parası yeterli mi?
  if (req.user.cash < purchasePrice) {
    return res.status(400).json({
      success: false,
      message: 'Yetersiz nakit',
      data: {
        required: purchasePrice,
        available: req.user.cash,
        missing: purchasePrice - req.user.cash
      }
    });
  }

  // ShopInstance oluştur
  const shopInstance = await ShopInstance.create({
    shopType: shopType.shopType,
    ownerId: req.user._id,
    country: country || 'Türkiye',
    city: city || 'İstanbul',
    customName: customName || `${city || 'İstanbul'} ${shopType.displayName}`,
    isActive: true,
    settings: {
      autoSellEnabled: true,
      minProfitMargin: 10,
      maxStockPerProduct: 100,
      enablePriceOptimization: true
    }
  });

  // Oyuncudan parayı düş
  req.user.cash -= purchasePrice;
  req.user.ownedShops.push(shopInstance._id);
  await req.user.save();

  // İşlem kaydı oluştur
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'purchase_shop',
    amount: purchasePrice,
    shopId: shopInstance._id,
    description: `${shopInstance.customName} satın alındı`
  });

  // AUTO_SELL PendingAction oluştur (tick-based satış için)
  await PendingAction.createAutoSellAction(
    req.user._id,
    shopInstance._id
  );

  res.json({
    success: true,
    message: 'Dükkan başarıyla satın alındı',
    data: {
      shop: shopInstance,
      cash: req.user.cash,
      shopType: shopType
    }
  });
}));

// @route   DELETE /api/shop/:id/leave
// @desc    Dükkan bırak
// @access  Private
router.delete('/:id/leave', protect, asyncHandler(async (req, res) => {
  const shop = await Shop.findById(req.params.id);
  
  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(400).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  // Dükkanı bırak
  await shop.leave();
  
  // Oyuncudan çıkar
  req.user.ownedShops = req.user.ownedShops.filter(
    id => id.toString() !== shop._id.toString()
  );
  await req.user.save();

  // İşlem kaydı
  await Transaction.createTransaction({
    playerId: req.user._id,
    type: 'leave_shop',
    amount: 0,
    shopId: shop._id,
    description: `${shop.name} bırakıldı`
  });

  res.json({
    success: true,
    message: 'Dükkan bırakıldı'
  });
}));

// @route   GET /api/shop/owned
// @desc    Sahip olunan dükkanlar
// @access  Private
router.get('/owned', protect, asyncHandler(async (req, res) => {
  // YENİ SİSTEM: ShopInstance collection'ından al
  const shops = await ShopInstance.find({ ownerId: req.user._id, isActive: true })
    .sort({ purchasedAt: -1 });

  res.json({
    success: true,
    data: { shops }
  });
}));

// === ÜRÜN LİSTELEME SİSTEMİ ===

// @route   POST /api/shop/:shopId/products
// @desc    Dükkanda ürün listele
// @access  Private
router.post('/:shopId/products', protect, asyncHandler(async (req, res) => {
  const { productId, listPrice, minStock, maxStock } = req.body;
  const shop = await Shop.findById(req.params.shopId);

  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  await shop.addListedProduct(productId, listPrice, minStock, maxStock);

  res.json({
    success: true,
    message: 'Ürün listelendi',
    data: { shop }
  });
}));

// @route   GET /api/shop/:shopId/products
// @desc    Dükkanın listelenen ürünlerini getir
// @access  Private
router.get('/:shopId/products', protect, asyncHandler(async (req, res) => {
  const shop = await Shop.findById(req.params.shopId).populate({
    path: 'listedProducts.productId',
    select: 'name category description imageUrl'
  });

  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  const activeProducts = shop.getActiveListedProducts();

  res.json({
    success: true,
    data: {
      products: activeProducts,
      stockStats: shop.getStockStatistics()
    }
  });
}));

// @route   PUT /api/shop/:shopId/products/:productId
// @desc    Listelenen ürünü güncelle
// @access  Private
router.put('/:shopId/products/:productId', protect, asyncHandler(async (req, res) => {
  const { listPrice, minStock, maxStock, autoPurchase } = req.body;
  const shop = await Shop.findById(req.params.shopId);

  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  const updates = {};
  if (listPrice !== undefined) updates.listPrice = listPrice;
  if (minStock !== undefined) updates.minStock = minStock;
  if (maxStock !== undefined) updates.maxStock = maxStock;
  if (autoPurchase !== undefined) updates.autoPurchase = autoPurchase;

  await shop.updateListedProduct(req.params.productId, updates);

  res.json({
    success: true,
    message: 'Ürün güncellendi',
    data: { shop }
  });
}));

// @route   DELETE /api/shop/:shopId/products/:productId
// @desc    Ürünü satıştan kaldır
// @access  Private
router.delete('/:shopId/products/:productId', protect, asyncHandler(async (req, res) => {
  const shop = await Shop.findById(req.params.shopId);

  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  await shop.removeListedProduct(req.params.productId);

  res.json({
    success: true,
    message: 'Ürün satıştan kaldırıldı'
  });
}));

// @route   GET /api/shop/:shopId/stock-stats
// @desc    Dükkan stok istatistikleri
// @access  Private
router.get('/:shopId/stock-stats', protect, asyncHandler(async (req, res) => {
  const shop = await Shop.findById(req.params.shopId);

  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  res.json({
    success: true,
    data: shop.getStockStatistics()
  });
}));

// @route   POST /api/shop/:shopId/auto-purchase
// @desc    Otomatik stok alımı gerçekleştir
// @access  Private
router.post('/:shopId/auto-purchase', protect, asyncHandler(async (req, res) => {
  const shop = await Shop.findById(req.params.shopId);

  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  const productsToPurchase = shop.checkAndAutoPurchase();

  if (productsToPurchase.length === 0) {
    return res.json({
      success: true,
      message: 'Otomatik alım gerekli değil',
      data: { productsPurchased: [] }
    });
  }

  // Burada gerçek satın alma işlemi yapılacak
  // Şimdilik sadece simülasyon
  const purchasedProducts = [];
  let totalCost = 0;

  for (const item of productsToPurchase) {
    // Stok güncelle
    await shop.updateProductStock(item.productId, item.quantity);
    purchasedProducts.push(item);
    totalCost += item.quantity * item.currentPrice;

    // Oyuncu envanterini güncelle (burada Player model ile entegrasyon gerekiyor)
    // TODO: Player inventory'den ürünleri çıkar
  }

  res.json({
    success: true,
    message: `${productsToPurchase.length} ürün otomatik alındı`,
    data: {
      productsPurchased: purchasedProducts,
      totalCost
    }
  });
}));

// @route   PUT /api/shop/:shopId/auto-settings
// @desc    Otomatik alım ayarlarını güncelle
// @access  Private
router.put('/:shopId/auto-settings', protect, asyncHandler(async (req, res) => {
  const {
    enableBalanceControl,
    balanceInterval,
    priceAdjustmentRate,
    smartPricing
  } = req.body;

  const shop = await Shop.findById(req.params.shopId);

  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  const settings = shop.autoPurchaseSettings;

  if (enableBalanceControl !== undefined) settings.enableBalanceControl = enableBalanceControl;
  if (balanceInterval !== undefined) settings.balanceInterval = Math.max(300000, balanceInterval);
  if (priceAdjustmentRate !== undefined) settings.priceAdjustmentRate = Math.max(0, Math.min(0.1, priceAdjustmentRate));
  if (smartPricing !== undefined) settings.smartPricing = smartPricing;

  await shop.save();

  res.json({
    success: true,
    message: 'Ayarlar güncellendi',
    data: { autoPurchaseSettings: settings }
  });
}));

// @route   GET /api/shop/:shopId/auto-settings
// @desc    Otomatik alım ayarlarını getir
// @access  Private
router.get('/:shopId/auto-settings', protect, asyncHandler(async (req, res) => {
  const shop = await Shop.findById(req.params.shopId);

  if (!shop || shop.rentedBy.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  res.json({
    success: true,
    data: { autoPurchaseSettings: shop.autoPurchaseSettings }
  });
}));

// ============================================
// TİCK-BASED SHOP SİSTEMİ
// ============================================

// @route   POST /api/shop/:shopId/inventory/add
// @desc    Oyuncu envanterinden dükkana ürün ekle (tick-based)
// @access  Private
router.post('/:shopId/inventory/add', protect, asyncHandler(async (req, res) => {
  const { productId, quantity, sellPrice } = req.body;
  const shop = await ShopInstance.findById(req.params.shopId);
  const product = await Product.findById(productId);

  // Validasyon
  if (!shop || shop.ownerId.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  if (!product) {
    return res.status(404).json({
      success: false,
      message: 'Ürün bulunamadı'
    });
  }

  // Dükkan tipini kontrol et ve izin verilen kategorileri al
  const { ShopType } = require('../models/Shop');
  const shopType = await ShopType.findOne({ shopType: shop.shopType });

  if (shopType && shopType.allowedCategories && shopType.allowedCategories.length > 0) {
    // Ürün kategorisi izin verilen kategorilerde mi?
    if (!shopType.allowedCategories.includes(product.category)) {
      return res.status(400).json({
        success: false,
        message: `Bu dükkan tipi "${product.category}" kategorisindeki ürünleri satamaz. İzin verilen kategoriler: ${shopType.allowedCategories.join(', ')}`
      });
    }
  }

  if (!quantity || quantity <= 0) {
    return res.status(400).json({
      success: false,
      message: 'Geçersiz miktar'
    });
  }

  if (!sellPrice || sellPrice <= 0) {
    return res.status(400).json({
      success: false,
      message: 'Geçersiz fiyat'
    });
  }

  // Oyuncu envanterinden ürünü kontrol et
  const playerInventory = req.user.inventory.find(
    item => item.productId.toString() === productId.toString()
  );

  if (!playerInventory || playerInventory.quantity < quantity) {
    return res.status(400).json({
      success: false,
      message: 'Envanterinizde yeterli ürün yok'
    });
  }

  // PendingAction oluştur (TickEngine tarafından işlenecek)
  const action = await PendingAction.createListProductAction({
    playerId: req.user._id,
    shopId: shop._id,
    productId: product._id,
    quantity,
    sellPrice,
    purchasePrice: playerInventory.purchasePrice || product.currentPrice
  });

  // Oyuncu envanterinden çıkar
  playerInventory.quantity -= quantity;
  if (playerInventory.quantity <= 0) {
    req.user.inventory = req.user.inventory.filter(
      item => item.productId.toString() !== productId.toString()
    );
  }
  await req.user.save();

  res.json({
    success: true,
    message: `${quantity}x ${product.name} dükkana ekleniyor...`,
    data: {
      action,
      remainingInventory: req.user.inventory
    }
  });
}));

// @route   PUT /api/shop/:shopId/inventory/:productId/price
// @desc    Dükkan envanterindeki ürün fiyatını güncelle
// @access  Private
router.put('/:shopId/inventory/:productId/price', protect, asyncHandler(async (req, res) => {
  const { sellPrice } = req.body;
  const shop = await ShopInstance.findById(req.params.shopId);

  if (!shop || shop.ownerId.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  if (!sellPrice || sellPrice <= 0) {
    return res.status(400).json({
      success: false,
      message: 'Geçersiz fiyat'
    });
  }

  const inventoryItem = shop.inventory.find(
    item => item.productId.toString() === req.params.productId.toString()
  );

  if (!inventoryItem) {
    return res.status(404).json({
      success: false,
      message: 'Ürün dükkan envanterinde bulunamadı'
    });
  }

  const oldPrice = inventoryItem.sellPrice;
  inventoryItem.sellPrice = sellPrice;
  await shop.save();

  res.json({
    success: true,
    message: 'Fiyat güncellendi',
    data: {
      productId: req.params.productId,
      oldPrice,
      newPrice: sellPrice,
      inventory: shop.inventory
    }
  });
}));

// @route   GET /api/shop/:shopId/inventory
// @desc    Dükkan envanterini getir
// @access  Private
router.get('/:shopId/inventory', protect, asyncHandler(async (req, res) => {
  const shop = await ShopInstance.findById(req.params.shopId)
    .populate('inventory.productId', 'name emoji category currentPrice baseDemand');

  if (!shop || shop.ownerId.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  res.json({
    success: true,
    data: {
      inventory: shop.inventory,
      salesStats: shop.salesStats
    }
  });
}));

// @route   DELETE /api/shop/:shopId/inventory/:productId
// @desc    Dükkan envanterinden ürünü geri oyuncuya transfer et
// @access  Private
router.delete('/:shopId/inventory/:productId', protect, asyncHandler(async (req, res) => {
  const shop = await ShopInstance.findById(req.params.shopId);
  const product = await Product.findById(req.params.productId);

  if (!shop || shop.ownerId.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  const inventoryItem = shop.inventory.find(
    item => item.productId.toString() === req.params.productId.toString()
  );

  if (!inventoryItem || inventoryItem.quantity <= 0) {
    return res.status(404).json({
      success: false,
      message: 'Ürün dükkan envanterinde bulunamadı'
    });
  }

  // Oyuncu envanterine geri ekle
  const playerInventory = req.user.inventory.find(
    item => item.productId.toString() === req.params.productId.toString()
  );

  if (playerInventory) {
    playerInventory.quantity += inventoryItem.quantity;
  } else {
    req.user.inventory.push({
      productId: req.params.productId,
      quantity: inventoryItem.quantity,
      purchasePrice: inventoryItem.purchasePrice
    });
  }

  const removedQuantity = inventoryItem.quantity;

  // Dükkan envanterinden çıkar
  shop.inventory = shop.inventory.filter(
    item => item.productId.toString() !== req.params.productId.toString()
  );

  await shop.save();
  await req.user.save();

  res.json({
    success: true,
    message: `${removedQuantity}x ${product.name} envanterinize geri eklendi`,
    data: {
      removedQuantity,
      playerInventory: req.user.inventory
    }
  });
}));

// @route   PUT /api/shop/:shopId/settings
// @desc    Dükkan ayarlarını güncelle (auto-sell)
// @access  Private
router.put('/:shopId/settings', protect, asyncHandler(async (req, res) => {
  const { autoSellEnabled, minProfitMargin, maxStockPerProduct } = req.body;
  const shop = await ShopInstance.findById(req.params.shopId);

  if (!shop || shop.ownerId.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  if (autoSellEnabled !== undefined) {
    shop.settings.autoSellEnabled = autoSellEnabled;

    // Auto-sell açıldıysa PendingAction oluştur
    if (autoSellEnabled) {
      await PendingAction.createAutoSellAction(shop._id, req.user._id);
    }
  }

  if (minProfitMargin !== undefined) {
    shop.settings.minProfitMargin = Math.max(0, minProfitMargin);
  }

  if (maxStockPerProduct !== undefined) {
    shop.settings.maxStockPerProduct = Math.max(10, maxStockPerProduct);
  }

  await shop.save();

  res.json({
    success: true,
    message: 'Ayarlar güncellendi',
    data: {
      settings: shop.settings
    }
  });
}));

// @route   GET /api/shop/:shopId/sales-stats
// @desc    Dükkan satış istatistiklerini getir
// @access  Private
router.get('/:shopId/sales-stats', protect, asyncHandler(async (req, res) => {
  const shop = await ShopInstance.findById(req.params.shopId);

  if (!shop || shop.ownerId.toString() !== req.user._id.toString()) {
    return res.status(403).json({
      success: false,
      message: 'Bu dükkan size ait değil'
    });
  }

  res.json({
    success: true,
    data: {
      salesStats: shop.salesStats,
      inventory: shop.inventory.map(item => ({
        productId: item.productId,
        quantity: item.quantity,
        totalSold: item.totalSold,
        lastSoldAt: item.lastSoldAt
      }))
    }
  });
}));

module.exports = router;
