const PendingAction = require('../models/PendingAction');
const { ShopInstance } = require('../models/Shop');
const Product = require('../models/Product');
const Player = require('../models/Player');
const { logger } = require('../utils/logger');
const SalesCalculator = require('../utils/SalesCalculator');

/**
 * TickEngine - 5 Saniye Döngü Motoru
 *
 * Her 5 saniyede bir çalışır ve:
 * 1. Zamanı gelen pending action'ları işler
 * 2. AUTO_SELL action'ları için satış simülasyonu yapar
 * 3. Sonuçları database'e yazar
 * 4. WebSocket ile oyunculara bildirir
 */

class TickEngine {
  constructor(io) {
    this.io = io; // Socket.IO instance
    this.isRunning = false;
    this.tickInterval = 5000; // 5 seconds
    this.tickCounter = 0;
    this.timer = null;
  }

  /**
   * Engine'i başlat
   */
  start() {
    if (this.isRunning) {
      logger.warn('TickEngine already running');
      return;
    }

    this.isRunning = true;
    logger.info(`🚀 TickEngine started with ${this.tickInterval}ms interval`);

    // İlk tick'i hemen çalıştır
    this.tick();

    // Sonraki tick'leri schedule et
    this.timer = setInterval(() => {
      this.tick();
    }, this.tickInterval);
  }

  /**
   * Engine'i durdur
   */
  stop() {
    if (this.timer) {
      clearInterval(this.timer);
      this.timer = null;
    }
    this.isRunning = false;
    logger.info('⏸️  TickEngine stopped');
  }

  /**
   * Tek bir tick döngüsü
   */
  async tick() {
    const startTime = Date.now();
    this.tickCounter++;

    try {
      logger.info(`⏰ Tick #${this.tickCounter} started`);

      // 1. Zamanı gelen action'ları çek
      const readyActions = await PendingAction.getReadyActions(100);

      if (readyActions.length === 0) {
        logger.info(`Tick #${this.tickCounter}: No pending actions`);
        return;
      }

      logger.info(`Tick #${this.tickCounter}: Processing ${readyActions.length} actions`);

      // 2. Her action'ı işle
      const results = await Promise.allSettled(
        readyActions.map(action => this.processAction(action))
      );

      // 3. Sonuçları logla
      const successful = results.filter(r => r.status === 'fulfilled').length;
      const failed = results.filter(r => r.status === 'rejected').length;

      const elapsed = Date.now() - startTime;
      logger.info(
        `✅ Tick #${this.tickCounter} completed in ${elapsed}ms | ` +
        `Success: ${successful}, Failed: ${failed}`
      );

    } catch (error) {
      logger.error('TickEngine error:', error);
    }
  }

  /**
   * Tek bir action'ı işle
   */
  async processAction(action) {
    try {
      // Action'ı processing olarak işaretle
      await action.markProcessing();

      // Action tipine göre handler çağır
      let result;
      switch (action.actionType) {
        case 'AUTO_SELL':
          result = await this.handleAutoSell(action);
          break;

        case 'LIST_PRODUCT':
          result = await this.handleListProduct(action);
          break;

        case 'RESTOCK_ORDER':
          result = await this.handleRestockOrder(action);
          break;

        default:
          throw new Error(`Unknown action type: ${action.actionType}`);
      }

      // Action'ı complete et
      await action.complete(result);

      // WebSocket bildirimi gönder
      this.notifyPlayer(action.playerId, action.actionType, result);

      return result;

    } catch (error) {
      logger.error(`Action ${action._id} failed:`, error);
      await action.fail(error.message, 'PROCESSING_ERROR');
      throw error;
    }
  }

  /**
   * AUTO_SELL Handler
   * Dükkan envanterindeki ürünleri satmaya çalışır
   */
  async handleAutoSell(action) {
    const shop = await ShopInstance.findById(action.data.shopId)
      .populate('ownerId');

    if (!shop) {
      throw new Error('Shop not found');
    }

    if (!shop.settings?.autoSellEnabled) {
      return {
        soldQuantity: 0,
        earnedMoney: 0,
        message: 'Auto-sell disabled'
      };
    }

    // Envanterdeki her ürün için satış simülasyonu
    const salesResults = [];
    let totalRevenue = 0;
    let totalProfit = 0;
    let totalSold = 0;

    for (const item of shop.inventory) {
      if (item.quantity <= 0) continue;

      // Ürün bilgilerini al
      const product = await Product.findById(item.productId);
      if (!product) continue;

      // Satış hesapla
      const saleResult = SalesCalculator.calculateSalesPerTick({
        baseDemand: product.baseDemand,
        sellPrice: item.sellPrice,
        marketPrice: product.currentPrice,
        volatility: product.volatility,
        peakHours: product.peakHours,
        locationType: shop.country === 'Turkey' ? 'street' : 'mall', // Basit lokasyon
        seasonality: product.seasonality,
        availableStock: item.quantity
      });

      if (saleResult.soldQuantity > 0) {
        // Kar hesapla
        const profitResult = SalesCalculator.calculateProfit(
          saleResult.soldQuantity,
          item.sellPrice,
          item.purchasePrice
        );

        // Inventory'i güncelle
        item.quantity -= saleResult.soldQuantity;
        item.totalSold += saleResult.soldQuantity;
        item.lastSoldAt = new Date();

        // İstatistikleri güncelle
        totalRevenue += profitResult.revenue;
        totalProfit += profitResult.profit;
        totalSold += saleResult.soldQuantity;

        salesResults.push({
          productId: product._id,
          productName: product.name,
          sold: saleResult.soldQuantity,
          revenue: profitResult.revenue,
          profit: profitResult.profit
        });
      }
    }

    // Shop salesStats'ı güncelle
    shop.salesStats.todaySales += totalRevenue;
    shop.salesStats.totalRevenue += totalRevenue;
    shop.salesStats.totalProfit += totalProfit;
    shop.salesStats.totalItemsSold += totalSold;

    // Ortalama satış fiyatı
    if (shop.salesStats.totalItemsSold > 0) {
      shop.salesStats.avgSalePrice =
        shop.salesStats.totalRevenue / shop.salesStats.totalItemsSold;
    }

    await shop.save();

    // Oyuncuya parayı ekle
    if (totalRevenue > 0) {
      const player = await Player.findById(shop.ownerId);
      if (player) {
        player.cash += totalRevenue;
        await player.save();
      }
    }

    // Eğer recurring action ise, bir sonraki tick için schedule et
    if (action.isRecurring) {
      action.nextScheduledAt = new Date(Date.now() + this.tickInterval);

      // Yeni bir action oluştur (bu tamamlanmış olarak kalacak)
      await PendingAction.create({
        playerId: action.playerId,
        actionType: 'AUTO_SELL',
        status: 'pending',
        scheduledFor: action.nextScheduledAt,
        isRecurring: true,
        data: {
          shopId: shop._id
        }
      });
    }

    return {
      soldQuantity: totalSold,
      earnedMoney: totalRevenue,
      profit: totalProfit,
      message: `Sold ${totalSold} items for ₺${totalRevenue.toFixed(2)}`,
      details: salesResults
    };
  }

  /**
   * LIST_PRODUCT Handler
   * Oyuncu envanterinden dükkana ürün transfer eder
   */
  async handleListProduct(action) {
    const shop = await ShopInstance.findById(action.data.shopId);
    const player = await Player.findById(action.playerId);
    const product = await Product.findById(action.data.productId);

    if (!shop || !player || !product) {
      throw new Error('Shop, Player or Product not found');
    }

    const { productId, quantity, price, purchasePrice } = action.data;

    // Oyuncu envanterinden ürünü kontrol et (basitleştirilmiş)
    // NOT: Player model'de inventory array'i yoksa eklemen gerekebilir

    // Dükkana ekle
    const existingItem = shop.inventory.find(
      item => item.productId.toString() === productId.toString()
    );

    if (existingItem) {
      // Varolan ürüne ekle
      existingItem.quantity += quantity;
    } else {
      // Yeni ürün olarak ekle
      shop.inventory.push({
        productId,
        quantity,
        purchasePrice,
        sellPrice: price,
        listedAt: new Date()
      });
    }

    await shop.save();

    return {
      success: true,
      message: `Listed ${quantity}x ${product.name} at ₺${price}`,
      productId,
      quantity
    };
  }

  /**
   * RESTOCK_ORDER Handler
   * Otomatik stok yenileme (gelecekte implement edilecek)
   */
  async handleRestockOrder(action) {
    // TODO: Implement auto-restock
    return {
      message: 'Restock not implemented yet'
    };
  }

  /**
   * WebSocket ile oyuncuya bildirim gönder
   */
  notifyPlayer(playerId, actionType, result) {
    if (!this.io) return;

    try {
      // Socket.IO ile oyuncuya özel room'a gönder
      const room = `player:${playerId}`;

      this.io.to(room).emit('action:completed', {
        actionType,
        result,
        timestamp: new Date()
      });

      // Satış bildirimi özel event
      if (actionType === 'AUTO_SELL' && result.soldQuantity > 0) {
        this.io.to(room).emit('sale:completed', {
          soldQuantity: result.soldQuantity,
          earnedMoney: result.earnedMoney,
          profit: result.profit,
          details: result.details,
          timestamp: new Date()
        });
      }

    } catch (error) {
      logger.error('WebSocket notification error:', error);
    }
  }

  /**
   * Engine istatistikleri
   */
  getStats() {
    return {
      isRunning: this.isRunning,
      tickCounter: this.tickCounter,
      tickInterval: this.tickInterval,
      uptime: this.tickCounter * this.tickInterval / 1000 // seconds
    };
  }
}

module.exports = TickEngine;
