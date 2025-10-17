import '../../data/models/player.dart';
import '../../data/models/shop.dart';

/// Dükkan yönetim sistemi - Kiralama ve gelir hesaplama logic'i
class ShopSystem {
  /// Dükkan kiralama kontrolü
  /// Returns: (success, errorMessage)
  static (bool, String?) canRentShop({
    required Player player,
    required Shop shop,
  }) {
    final totalCost = shop.deposit + shop.monthlyRent;

    // Yeterli nakit kontrolü
    if (player.cash < totalCost) {
      return (
        false,
        'Yetersiz nakit! Gereken: ₺${totalCost.toStringAsFixed(2)} (Depozito + İlk ay kira)'
      );
    }

    // Dükkan müsait mi?
    if (!shop.isAvailable) {
      return (false, 'Bu dükkan şu anda kiralanmış durumda!');
    }

    // Minimum seviye kontrolü (opsiyonel)
    if (shop.monthlyRent > 20000 && player.level < 3) {
      return (false, 'Bu dükkanı kiralamak için en az 3. seviye olmalısınız!');
    }

    // Yasal itibar kontrolü
    if (shop.locationType == 'mall' && player.legalReputation < 50) {
      return (false, 'AVM dükkanı kiralamak için yasal itibarınız en az 50 olmalı!');
    }

    return (true, null);
  }

  /// Aylık gelir hesaplama
  static double calculateMonthlyRevenue({
    required Shop shop,
    required String businessCategory,
    required int playerLevel,
    required int legalReputation,
  }) {
    // Temel gelir: Alan ve konum tipine göre
    double baseRevenue = _calculateBaseRevenue(shop);

    // İş kategorisi çarpanı
    final categoryMultiplier = _getCategoryMultiplier(businessCategory);
    double revenue = baseRevenue * categoryMultiplier;

    // Konum bonusu
    final locationBonus = _getLocationBonus(shop.locationType);
    revenue *= locationBonus;

    // Özellik bonusları
    if (shop.hasWindow) {
      revenue *= 1.15; // Vitrin %15 bonus
    }

    if (shop.parkingSpaces > 0) {
      revenue *= (1.0 + (shop.parkingSpaces * 0.05)); // Park yeri başına %5
    }

    // Kat cezası/bonusu
    if (shop.floor == 1) {
      revenue *= 1.20; // Zemin kat %20 bonus
    } else if (shop.floor > 3) {
      revenue *= 0.90; // Üst katlar %10 ceza
    }

    // Seviye bonusu
    revenue *= (1.0 + (playerLevel * 0.05));

    // İtibar bonusu
    if (legalReputation > 80) {
      revenue *= 1.25;
    } else if (legalReputation > 60) {
      revenue *= 1.15;
    }

    return revenue.roundToDouble();
  }

  /// Temel gelir hesaplama
  static double _calculateBaseRevenue(Shop shop) {
    // m² başına gelir
    const revenuePerSqm = 200.0;
    return shop.squareMeters * revenuePerSqm;
  }

  /// İş kategorisi çarpanı
  static double _getCategoryMultiplier(String category) {
    switch (category) {
      case 'electronics':
        return 1.5;
      case 'jewelry':
        return 2.0;
      case 'clothing':
        return 1.2;
      case 'food':
        return 1.3;
      case 'general':
        return 1.0;
      default:
        return 1.0;
    }
  }

  /// Konum tipi bonusu
  static double _getLocationBonus(String locationType) {
    switch (locationType) {
      case 'mall':
        return 1.8; // AVM en karlı
      case 'street':
        return 1.3;
      case 'market':
        return 1.4;
      case 'office':
        return 1.6;
      case 'warehouse':
        return 1.1; // Depo en az karlı
      default:
        return 1.0;
    }
  }

  /// Müşteri sayısı hesaplama
  static int calculateMonthlyCustomers({
    required Shop shop,
    required int playerLevel,
    required int streetReputation,
  }) {
    // Temel müşteri: Alan başına
    int baseCustomers = shop.squareMeters * 10;

    // Konum çarpanı
    final locationMultiplier = _getCustomerLocationMultiplier(shop.locationType);
    int customers = (baseCustomers * locationMultiplier).round();

    // Vitrin bonusu
    if (shop.hasWindow) {
      customers = (customers * 1.30).round(); // %30 daha fazla müşteri
    }

    // Zemin kat bonusu
    if (shop.floor == 1) {
      customers = (customers * 1.25).round();
    }

    // Sokak itibarı etkisi
    customers = (customers * (1.0 + (streetReputation / 200))).round();

    // Seviye bonusu
    customers += playerLevel * 50;

    return customers;
  }

  /// Müşteri konum çarpanı
  static double _getCustomerLocationMultiplier(String locationType) {
    switch (locationType) {
      case 'mall':
        return 2.5;
      case 'market':
        return 2.0;
      case 'street':
        return 1.5;
      case 'office':
        return 1.2;
      case 'warehouse':
        return 0.5;
      default:
        return 1.0;
    }
  }

  /// Kar marjı hesaplama
  static double calculateProfitMargin({
    required double monthlyRevenue,
    required double monthlyRent,
  }) {
    if (monthlyRent == 0) return 0;
    return ((monthlyRevenue - monthlyRent) / monthlyRent) * 100;
  }

  /// Net kar hesaplama
  static double calculateNetProfit({
    required double monthlyRevenue,
    required double monthlyRent,
    required double additionalCosts,
  }) {
    return monthlyRevenue - monthlyRent - additionalCosts;
  }

  /// Aylık ek maliyetler (elektrik, su, personel vb.)
  static double calculateAdditionalCosts({
    required Shop shop,
    required int employeeCount,
  }) {
    // Alan başına sabit gider
    final utilityCost = shop.squareMeters * 50;

    // Personel maaşı
    final employeeCost = employeeCount * 15000.0;

    return utilityCost + employeeCost;
  }

  /// Dükkan değer artışı (satış fiyatı)
  static double calculateShopValue({
    required Shop shop,
    required double avgMonthlyProfit,
    required int ownedMonths,
  }) {
    // Temel değer: Depozito + (12 aylık kira)
    double baseValue = shop.deposit + (shop.monthlyRent * 12);

    // Karlılık bonusu
    if (avgMonthlyProfit > 0) {
      baseValue += (avgMonthlyProfit * 6); // 6 aylık kar
    }

    // Sahiplik süresi bonusu
    if (ownedMonths > 12) {
      baseValue *= 1.15; // 1 yıldan fazla %15 artış
    }

    return baseValue;
  }

  /// İyi yatırım mı? (Tavsiye sistemi)
  static String getInvestmentAdvice({
    required Shop shop,
    required double estimatedRevenue,
    required Player player,
  }) {
    final profitMargin = calculateProfitMargin(
      monthlyRevenue: estimatedRevenue,
      monthlyRent: shop.monthlyRent,
    );

    final totalCost = shop.deposit + shop.monthlyRent;
    final cashAfterRent = player.cash - totalCost;

    if (cashAfterRent < 0) {
      return '❌ Çok Riskli - Nakdiniz kalmayacak!';
    } else if (cashAfterRent < 5000) {
      return '⚠️ Riskli - Acil durum için az para kalacak';
    } else if (profitMargin < 20) {
      return '⚠️ Düşük Karlılık - Kar marjı çok düşük (${profitMargin.toStringAsFixed(1)}%)';
    } else if (profitMargin < 50) {
      return '✅ Makul Yatırım - Orta düzey karlılık (${profitMargin.toStringAsFixed(1)}%)';
    } else if (profitMargin < 100) {
      return '⭐ İyi Yatırım - Yüksek karlılık (${profitMargin.toStringAsFixed(1)}%)';
    } else {
      return '🌟 Mükemmel Yatırım - Çok yüksek karlılık (${profitMargin.toStringAsFixed(1)}%)';
    }
  }

  /// Başabaş noktası (kaç ayda amortisman)
  static int calculateBreakEvenMonths({
    required Shop shop,
    required double estimatedMonthlyProfit,
  }) {
    if (estimatedMonthlyProfit <= 0) return -1; // Asla başabaş olmaz

    final totalInvestment = shop.deposit + shop.monthlyRent;
    return (totalInvestment / estimatedMonthlyProfit).ceil();
  }

  /// Dükkan performans skoru (0-100)
  static double calculatePerformanceScore({
    required Shop shop,
    required double actualRevenue,
    required double expectedRevenue,
    required int actualCustomers,
    required int expectedCustomers,
  }) {
    double score = 0;

    // Gelir performansı (max 50 puan)
    final revenuePerformance = (actualRevenue / expectedRevenue).clamp(0, 2);
    score += revenuePerformance * 25;

    // Müşteri performansı (max 30 puan)
    final customerPerformance = (actualCustomers / expectedCustomers).clamp(0, 2);
    score += customerPerformance * 15;

    // Karlılık (max 20 puan)
    final profit = actualRevenue - shop.monthlyRent;
    if (profit > 0) {
      score += 20;
    } else if (profit > -shop.monthlyRent * 0.5) {
      score += 10; // Yarı zarar
    }

    return score.clamp(0, 100);
  }

  /// Konum çarpanını public olarak döndür
  static double getLocationMultiplier(String locationType) {
    return _getLocationBonus(locationType);
  }

  /// İş kategorisi çarpanını public olarak döndür
  static double getCategoryMultiplier(String category) {
    return _getCategoryMultiplier(category);
  }

  /// Kira maliyeti hesaplama
  static double calculateRentCost(Shop shop, int months) {
    return shop.monthlyRent * months;
  }

  /// Performans değerlendirmesi
  static String getPerformanceRating(double score) {
    if (score >= 80) return 'Mükemmel';
    if (score >= 60) return 'İyi';
    if (score >= 40) return 'Orta';
    if (score >= 20) return 'Zayıf';
    return 'Kötü';
  }
}
