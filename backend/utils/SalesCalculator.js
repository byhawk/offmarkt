/**
 * SalesCalculator - Gerçekçi Ekonomi Satış Hesaplayıcı
 *
 * Fiyat elastikiyeti, talep, zaman ve lokasyon faktörlerini
 * kullanarak tick başına satış miktarını hesaplar
 */

class SalesCalculator {
  /**
   * Fiyat elastikiyeti hesapla
   * Fiyat market fiyatından ne kadar uzaksa satış o kadar zorlaşır
   *
   * @param {number} sellPrice - Dükkan satış fiyatı
   * @param {number} marketPrice - Market (Product.currentPrice) fiyatı
   * @param {number} volatility - Ürün volatilitesi (0-1)
   * @returns {number} Elastikiyet çarpanı (0.2 - 2.0)
   */
  static calculatePriceElasticity(sellPrice, marketPrice, volatility = 0.1) {
    const priceRatio = sellPrice / marketPrice;

    // Fiyat çok düşük (< %90 market fiyatı) - Çok hızlı satar
    if (priceRatio < 0.9) {
      return 2.0;
    }

    // Fiyat market fiyatında veya hafif altında - Normal hız
    if (priceRatio <= 1.0) {
      return 1.0 + (1.0 - priceRatio) * 2; // 1.0 - 1.2 arası
    }

    // Fiyat market fiyatının üstünde (%0-20 arası) - Yavaş satar
    if (priceRatio <= 1.2) {
      const excess = priceRatio - 1.0;
      return Math.max(0.5, 1.0 - (excess * 2.5)); // 1.0 → 0.5
    }

    // Fiyat çok yüksek (> %20 market fiyatı) - Çok yavaş satar
    if (priceRatio <= 1.5) {
      return 0.3;
    }

    // Aşırı yüksek fiyat - Neredeyse hiç satmaz
    return 0.1;
  }

  /**
   * Zaman çarpanı hesapla (Peak hours)
   *
   * @param {Array<number>} peakHours - Yoğun saatler ([18, 19, 20])
   * @param {Date} currentTime - Şu anki zaman
   * @returns {number} Zaman çarpanı (0.7 - 1.5)
   */
  static calculateTimeMultiplier(peakHours = [18, 19, 20], currentTime = new Date()) {
    const currentHour = currentTime.getHours();

    // Peak saatlerde daha fazla satış
    if (peakHours.includes(currentHour)) {
      return 1.5;
    }

    // Gece saatleri (00-06) - Az satış
    if (currentHour >= 0 && currentHour <= 6) {
      return 0.7;
    }

    // Sabah saatleri (07-11) - Orta
    if (currentHour >= 7 && currentHour <= 11) {
      return 0.9;
    }

    // Öğlen-öğleden sonra (12-17) - Normal
    if (currentHour >= 12 && currentHour <= 17) {
      return 1.0;
    }

    // Akşam (21-23) - Normal
    return 1.0;
  }

  /**
   * Lokasyon çarpanı hesapla
   *
   * @param {string} locationType - Lokasyon tipi
   * @returns {number} Lokasyon çarpanı (0.8 - 1.5)
   */
  static calculateLocationMultiplier(locationType) {
    const locationFactors = {
      mall: 1.5,      // AVM - En yüksek müşteri trafiği
      market: 1.3,    // Pazar yeri - Yüksek trafik
      street: 1.0,    // Sokak - Normal
      office: 0.9,    // Ofis bölgesi - Orta
      warehouse: 0.8  // Depo - En düşük
    };

    return locationFactors[locationType] || 1.0;
  }

  /**
   * Mevsimsellik çarpanı
   *
   * @param {string} seasonality - 'high', 'stable', 'low'
   * @returns {number} Mevsim çarpanı (0.8 - 1.2)
   */
  static calculateSeasonalityMultiplier(seasonality = 'stable') {
    const factors = {
      high: 1.2,    // Mevsimi (örn: kışın mont satışı)
      stable: 1.0,  // Normal
      low: 0.8      // Sezon dışı
    };

    return factors[seasonality] || 1.0;
  }

  /**
   * Rastgele varyasyon ekle (%20 varyasyon)
   * Gerçek hayattaki öngörülemezliği simüle eder
   *
   * @returns {number} Random çarpan (0.8 - 1.2)
   */
  static getRandomVariation() {
    return 0.8 + (Math.random() * 0.4); // 0.8 - 1.2 arası
  }

  /**
   * MAIN FUNCTION: Tick başına satış miktarı hesapla
   *
   * @param {Object} params - Hesaplama parametreleri
   * @param {number} params.baseDemand - Ürünün taban talebi (Product.baseDemand)
   * @param {number} params.sellPrice - Dükkan satış fiyatı
   * @param {number} params.marketPrice - Market fiyatı (Product.currentPrice)
   * @param {number} params.volatility - Ürün volatilitesi
   * @param {Array<number>} params.peakHours - Yoğun saatler
   * @param {string} params.locationType - Lokasyon tipi
   * @param {string} params.seasonality - Mevsimsellik
   * @param {number} params.availableStock - Mevcut stok
   * @returns {Object} { soldQuantity, sellChance, factors }
   */
  static calculateSalesPerTick({
    baseDemand = 10,
    sellPrice,
    marketPrice,
    volatility = 0.1,
    peakHours = [18, 19, 20],
    locationType = 'street',
    seasonality = 'stable',
    availableStock = 0
  }) {
    // Stok yoksa satış yok
    if (availableStock <= 0) {
      return {
        soldQuantity: 0,
        sellChance: 0,
        factors: {}
      };
    }

    // Tüm çarpanları hesapla
    const priceElasticity = this.calculatePriceElasticity(sellPrice, marketPrice, volatility);
    const timeMultiplier = this.calculateTimeMultiplier(peakHours);
    const locationMultiplier = this.calculateLocationMultiplier(locationType);
    const seasonalityMultiplier = this.calculateSeasonalityMultiplier(seasonality);
    const randomVariation = this.getRandomVariation();

    // Satış potansiyeli (velocity)
    const salesVelocity = baseDemand
      * priceElasticity
      * timeMultiplier
      * locationMultiplier
      * seasonalityMultiplier
      * randomVariation;

    // Satış şansı (0-1)
    const sellChance = Math.min(0.95, salesVelocity / baseDemand); // Max %95

    // Satılan miktar hesapla
    let soldQuantity = Math.floor(salesVelocity);

    // Stoğun üstüne çıkma
    soldQuantity = Math.min(soldQuantity, availableStock);

    // Minimum 0
    soldQuantity = Math.max(0, soldQuantity);

    return {
      soldQuantity,
      sellChance,
      salesVelocity,
      factors: {
        baseDemand,
        priceElasticity: priceElasticity.toFixed(2),
        timeMultiplier: timeMultiplier.toFixed(2),
        locationMultiplier: locationMultiplier.toFixed(2),
        seasonalityMultiplier: seasonalityMultiplier.toFixed(2),
        randomVariation: randomVariation.toFixed(2)
      }
    };
  }

  /**
   * Kar hesapla
   *
   * @param {number} soldQuantity - Satılan miktar
   * @param {number} sellPrice - Satış fiyatı
   * @param {number} purchasePrice - Alış fiyatı
   * @returns {Object} { revenue, cost, profit, margin }
   */
  static calculateProfit(soldQuantity, sellPrice, purchasePrice) {
    const revenue = soldQuantity * sellPrice;
    const cost = soldQuantity * purchasePrice;
    const profit = revenue - cost;
    const margin = cost > 0 ? ((profit / cost) * 100) : 0;

    return {
      revenue,
      cost,
      profit,
      marginPercent: margin.toFixed(2)
    };
  }

  /**
   * Optimal fiyat önerisi
   * Maksimum kar için ideal satış fiyatını hesaplar
   *
   * @param {number} marketPrice - Market fiyatı
   * @param {number} purchasePrice - Alış fiyatı
   * @param {number} targetMargin - Hedef kar marjı (%)
   * @returns {Object} { recommendedPrice, expectedMargin }
   */
  static suggestOptimalPrice(marketPrice, purchasePrice, targetMargin = 20) {
    // Hedef kar marjına göre fiyat
    const targetPrice = purchasePrice * (1 + (targetMargin / 100));

    // Market fiyatından fazla olmamalı (çok yüksek fiyat satmaz)
    const maxPrice = marketPrice * 1.15; // Market fiyatının %115'i

    // Önerilen fiyat
    const recommendedPrice = Math.min(targetPrice, maxPrice);

    // Gerçekleşen marj
    const actualMargin = ((recommendedPrice - purchasePrice) / purchasePrice) * 100;

    return {
      recommendedPrice: Math.round(recommendedPrice * 100) / 100,
      expectedMargin: actualMargin.toFixed(2),
      isOptimal: recommendedPrice === targetPrice
    };
  }
}

module.exports = SalesCalculator;
