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

      // 1. Her 6 tick'te bir (30 saniye) fiyatları güncelle
      if (this.tickCounter % 6 === 0) {
        await this.updateMarketPrices();
      }

      // 2. Zamanı gelen action'ları çek
      const readyActions = await PendingAction.getReadyActions(100);

      if (readyActions.length === 0) {
        logger.info(`Tick #${this.tickCounter}: No pending actions`);
      } else {
        logger.info(`Tick #${this.tickCounter}: Processing ${readyActions.length} actions`);

        // 3. Her action'ı işle
        const results = await Promise.allSettled(
          readyActions.map(action => this.processAction(action))
        );

        // 4. Sonuçları logla
        const successful = results.filter(r => r.status === 'fulfilled').length;
        const failed = results.filter(r => r.status === 'rejected').length;

        logger.info(
          `  Actions: Success: ${successful}, Failed: ${failed}`
        );
      }

      // 5. HR Sistem - Maaş Ödeme (Her 12 tick'te = 60 saniye)
      if (this.tickCounter % 12 === 0) {
        await this.processHRSystem();
      }

      // 6. R&D Sistem - Proje İlerlemesi (Her tick'te)
      await this.processRDSystem();

      // 7. Holding Sistem - Temettü Ödeme (Her 24 tick'te = 120 saniye)
      if (this.tickCounter % 24 === 0) {
        await this.processHoldingSystem();
      }

      // 8. Auction Sistem - İhale Tamamlama (Her 6 tick'te = 30 saniye)
      if (this.tickCounter % 6 === 0) {
        await this.processAuctionSystem();
      }

      // 9. Global Events - Olay Tetikleme (Her 24 tick'te = 120 saniye)
      if (this.tickCounter % 24 === 0) {
        await this.processGlobalEvents();
      }

      // 10. Bank Sistem - Faiz Hesaplama (Her 12 tick'te = 60 saniye)
      if (this.tickCounter % 12 === 0) {
        await this.processBankInterest();
      }

      // 11. Premium Sistem - Boost Yönetimi (Her tick'te)
      await this.processPremiumBoosts();

      const elapsed = Date.now() - startTime;
      logger.info(`✅ Tick #${this.tickCounter} completed in ${elapsed}ms`);

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
   * Market Fiyatlarını Güncelle (Arz-Talep Dengesi)
   * Her 30 saniyede bir çalışır
   */
  async updateMarketPrices() {
    try {
      logger.info('💰 Updating market prices based on supply-demand...');

      // Market settings'i al
      const MarketSettings = require('../models/MarketSettings');
      const settings = await MarketSettings.getSingleton();

      // Tüm aktif ürünleri al
      const products = await Product.find({ isActive: true });

      // Her ürün için oyuncu envanterini kontrol et
      for (const product of products) {
        // Tüm oyuncuların bu üründen toplam stoğunu hesapla
        const players = await Player.find({
          'inventory.productId': product._id
        });

        let totalPlayerStock = 0;
        for (const player of players) {
          const playerItem = player.inventory.find(
            item => item.productId.toString() === product._id.toString()
          );
          if (playerItem) {
            totalPlayerStock += playerItem.quantity;
          }
        }

        // Tüm dükkanların bu üründen toplam stoğunu hesapla
        const { ShopInstance } = require('../models/Shop');
        const shops = await ShopInstance.find({
          'inventory.productId': product._id
        });

        let totalShopStock = 0;
        for (const shop of shops) {
          const shopItem = shop.inventory.find(
            item => item.productId.toString() === product._id.toString()
          );
          if (shopItem) {
            totalShopStock += shopItem.quantity;
          }
        }

        const totalSupply = totalPlayerStock + totalShopStock;

        // Arz-Talep dengesine göre fiyat değişikliği hesapla
        const demandFactor = this.calculateDemandFactor(totalSupply, product.baseDemand);

        // Rastgele volatilite (market settings'den)
        const randomVolatility = settings.randomVolatility / 100; // 10 -> 0.10
        const baseChange = (Math.random() - 0.5) * 2 * randomVolatility;

        // Arz-talep etkisi (market settings'den)
        const demandEffect = settings.demandEffect / 100; // 15 -> 0.15
        const supplyDemandChange = demandFactor * demandEffect;

        const totalChange = baseChange + supplyDemandChange;
        let newPrice = product.currentPrice * (1 + totalChange);

        // Trending durumunda fiyat düşürme mekanizması
        const recentPrices = product.priceHistory.slice(-10);
        if (recentPrices.length >= 5) {
          const isUptrend = recentPrices.every((item, i) =>
            i === 0 || item.price > recentPrices[i - 1].price
          );

          // Eğer trending ve fiyat taban fiyatın %150'sini geçtiyse, düşüş uygula
          if (isUptrend && product.currentPrice > product.basePrice * 1.5) {
            const correctionFactor = -0.02; // %2 düzeltme
            newPrice = product.currentPrice * (1 + correctionFactor);
            logger.info(`  🔽 ${product.name}: Correction applied (overpriced)`);
          }

          product.trending = isUptrend;
        }

        // Fiyatı market settings limitlerinde tut
        product.currentPrice = Math.max(
          product.basePrice * settings.minPriceMultiplier,
          Math.min(product.basePrice * settings.maxPriceMultiplier, newPrice)
        );

        // Fiyat geçmişine ekle
        product.priceHistory.push({
          price: product.currentPrice,
          timestamp: new Date()
        });

        // Son 100 kaydı tut
        if (product.priceHistory.length > 100) {
          product.priceHistory.shift();
        }

        await product.save();

        logger.info(
          `  ${product.emoji} ${product.name}: ` +
          `₺${product.currentPrice.toFixed(2)} | ` +
          `Supply: ${totalSupply} | ` +
          `Demand Factor: ${demandFactor.toFixed(2)} | ` +
          `Change: ${(totalChange * 100).toFixed(1)}%`
        );
      }

      logger.info(`✅ Updated ${products.length} product prices`);

      // WebSocket ile tüm oyunculara bildir
      if (this.io) {
        this.io.emit('market:priceUpdate', {
          timestamp: new Date(),
          message: 'Market prices updated'
        });
      }

    } catch (error) {
      logger.error('Market price update error:', error);
    }
  }

  /**
   * Arz-Talep Faktörü Hesapla
   * @param {number} supply - Toplam arz (oyuncu + dükkan stoğu)
   * @param {number} baseDemand - Ürünün taban talebi
   * @returns {number} -1 ile +1 arası faktör
   *
   * Yüksek arz (supply >> baseDemand) → Fiyat düşer (negatif faktör)
   * Düşük arz (supply << baseDemand) → Fiyat yükselir (pozitif faktör)
   * Sıfır stok → Rastgele dalgalanma (arz-talep etkisi yok)
   */
  calculateDemandFactor(supply, baseDemand) {
    const optimalSupply = baseDemand * 50; // 50 tick'lik stok optimal kabul edilir

    // Hiç stok yoksa arz-talep etkisi yok, sadece rastgele dalgalanma
    if (supply === 0) {
      return (Math.random() - 0.5) * 0.3; // -0.15 ile +0.15 arası küçük dalgalanma
    }

    if (supply < optimalSupply * 0.3) {
      // Çok düşük stok (<%30) → Fiyat yükselir (ama daha az agresif)
      return 0.3 + (1 - supply / (optimalSupply * 0.3)) * 0.4;
    } else if (supply > optimalSupply * 2) {
      // Çok yüksek stok (>%200) → Fiyat düşer
      const excessRatio = (supply - optimalSupply * 2) / optimalSupply;
      return -0.3 - Math.min(excessRatio * 0.3, 0.7); // Maks -1.0
    } else {
      // Normal aralık → Daha dengeli dalgalanmalar
      const deviation = (supply - optimalSupply) / optimalSupply;
      return -deviation * 0.5; // ±%50'lik sapma için ±0.25 faktör
    }
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
   * HR Sistem - Maaş Ödeme
   */
  async processHRSystem() {
    try {
      logger.info('💼 HR System: Processing salaries...');
      
      const Employee = require('../models/Employee');
      const employees = await Employee.find({ status: 'active' });

      let totalPaid = 0;
      let successCount = 0;

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
          successCount++;
        }
      }

      logger.info(`  ✅ Paid ${successCount} employees, Total: ₺${totalPaid.toFixed(2)}`);
    } catch (error) {
      logger.error('HR System error:', error);
    }
  }

  /**
   * R&D Sistem - Proje İlerlemesi
   */
  async processRDSystem() {
    try {
      const RdLab = require('../models/RdLab');
      const labs = await RdLab.find({});

      let completedCount = 0;
      let failedCount = 0;

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
              completedCount++;
            } else {
              project.status = 'failed';
              lab.totalProjectsFailed += 1;
              lab.failedProjects.push(project.projectId);
              failedCount++;
            }

            lab.activeProjects = lab.activeProjects.filter(p => p.projectId !== project.projectId);
            lab.updateSuccessRate();
          }
        }

        await lab.save();
      }

      if (completedCount > 0 || failedCount > 0) {
        logger.info(`🔬 R&D System: Completed: ${completedCount}, Failed: ${failedCount}`);
      }
    } catch (error) {
      logger.error('R&D System error:', error);
    }
  }

  /**
   * Holding Sistem - Temettü Ödeme
   */
  async processHoldingSystem() {
    try {
      logger.info('📈 Holding System: Processing dividends...');
      
      const Holding = require('../models/Holding');
      const holdings = await Holding.find({});

      let totalPaid = 0;
      let holdingCount = 0;

      for (const holding of holdings) {
        if (holding.shares.length === 0) continue;

        const player = await Player.findById(holding.playerId);
        if (!player) continue;

        const dividend = holding.monthlyDividend;
        if (dividend > 0) {
          player.cash += dividend;
          holding.receiveDividend(dividend);
          
          await player.save();
          await holding.save();
          
          totalPaid += dividend;
          holdingCount++;
        }
      }

      if (holdingCount > 0) {
        logger.info(`  ✅ Paid dividends to ${holdingCount} holdings, Total: ₺${totalPaid.toFixed(2)}`);
      }
    } catch (error) {
      logger.error('Holding System error:', error);
    }
  }

  /**
   * Auction Sistem - İhale Tamamlama
   */
  async processAuctionSystem() {
    try {
      const Auction = require('../models/Auction');
      const auctions = await Auction.find({ status: 'active' });

      let completedCount = 0;
      let failedCount = 0;

      for (const auction of auctions) {
        if (new Date() >= auction.endDate) {
          auction.completeAuction();
          await auction.save();

          if (auction.status === 'completed' && auction.winner) {
            const winner = await Player.findById(auction.winner);
            if (winner) {
              winner.cash -= auction.finalPrice;
              await winner.save();
            }
            completedCount++;
          } else if (auction.status === 'failed') {
            failedCount++;
          }
        }
      }

      if (completedCount > 0 || failedCount > 0) {
        logger.info(`🔨 Auction System: Completed: ${completedCount}, Failed: ${failedCount}`);
      }
    } catch (error) {
      logger.error('Auction System error:', error);
    }
  }

  /**
   * Global Events - Olay Tetikleme
   */
  async processGlobalEvents() {
    try {
      logger.info('🌍 Global Events: Processing events...');
      
      const GlobalEvent = require('../models/GlobalEvent');
      const activeEvents = await GlobalEvent.find({ isActive: true, isTriggered: true });

      let processedCount = 0;

      for (const event of activeEvents) {
        // Olay süresi biterse deaktifleştir
        if (new Date() >= event.endDate) {
          event.isActive = false;
          await event.save();
          processedCount++;
        }
      }

      if (processedCount > 0) {
        logger.info(`  ✅ Processed ${processedCount} events`);
      }
    } catch (error) {
      logger.error('Global Events error:', error);
    }
  }

  /**
   * Bank Sistem - Faiz Hesaplama
   */
  async processBankInterest() {
    try {
      logger.info('🏦 Bank System: Calculating interest...');
      
      const BankAccount = require('../models/BankAccount');
      const accounts = await BankAccount.find({ isActive: true });

      let totalInterest = 0;
      let successCount = 0;

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
          successCount++;
        }
      }

      if (successCount > 0) {
        logger.info(`  ✅ Calculated interest for ${successCount} accounts, Total: ₺${totalInterest.toFixed(2)}`);
      }
    } catch (error) {
      logger.error('Bank System error:', error);
    }
  }

  /**
   * Premium Sistem - Boost Yönetimi
   */
  async processPremiumBoosts() {
    try {
      const PremiumCurrency = require('../models/PremiumCurrency');
      const premiums = await PremiumCurrency.find({ 'activeBoosts.isActive': true });

      let deactivatedCount = 0;

      for (const premium of premiums) {
        const now = new Date();
        
        for (const boost of premium.activeBoosts) {
          if (boost.isActive && boost.endDate <= now) {
            boost.isActive = false;
            deactivatedCount++;
          }
        }
        
        if (deactivatedCount > 0) {
          await premium.save();
        }
      }

      if (deactivatedCount > 0) {
        logger.info(`💎 Premium System: Deactivated ${deactivatedCount} boosts`);
      }
    } catch (error) {
      logger.error('Premium System error:', error);
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
