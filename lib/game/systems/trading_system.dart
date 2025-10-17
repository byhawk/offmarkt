import '../../data/models/player.dart';
import '../../data/models/product.dart';

/// Ticaret sistemi - Alım satım işlemlerinin pure logic'i
class TradingSystem {
  /// Ürün satın alma
  /// Returns: (success, errorMessage)
  static (bool, String?) purchaseProduct({
    required Player player,
    required Product product,
    required int quantity,
  }) {
    final totalCost = product.currentPrice * quantity;

    // Yeterli nakit kontrolü
    if (player.cash < totalCost) {
      return (false, 'Yetersiz nakit! Gereken: ₺${totalCost.toStringAsFixed(2)}');
    }

    // Maksimum ürün limiti (opsiyonel)
    if (quantity > 999) {
      return (false, 'Tek seferde en fazla 999 ürün alınabilir!');
    }

    return (true, null);
  }

  /// Ürün satma
  /// Returns: (success, errorMessage)
  static (bool, String?) sellProduct({
    required int currentInventoryQuantity,
    required int quantityToSell,
  }) {
    // Yeterli stok kontrolü
    if (currentInventoryQuantity < quantityToSell) {
      return (false, 'Yetersiz stok! Stoğunuz: $currentInventoryQuantity adet');
    }

    if (quantityToSell <= 0) {
      return (false, 'Geçersiz miktar!');
    }

    return (true, null);
  }

  /// Kar/zarar hesaplama
  static double calculateProfitLoss({
    required double purchasePrice,
    required double currentPrice,
    required int quantity,
  }) {
    return (currentPrice - purchasePrice) * quantity;
  }

  /// Kar yüzdesi hesaplama
  static double calculateProfitPercentage({
    required double purchasePrice,
    required double currentPrice,
  }) {
    if (purchasePrice == 0) return 0;
    return ((currentPrice - purchasePrice) / purchasePrice) * 100;
  }

  /// İşlem başına kazanılan deneyim puanı
  static int calculateExperienceGain({
    required double transactionValue,
    required bool isPurchase,
    required String productCategory,
  }) {
    // Temel exp: işlem değerinin 1%'i
    int baseExp = (transactionValue * 0.01).round();

    // Satış, alıştan daha fazla exp verir
    if (!isPurchase) {
      baseExp = (baseExp * 1.5).round();
    }

    // Risk kategorileri daha fazla exp verir
    if (productCategory == 'illegal') {
      baseExp = (baseExp * 2).round();
    }

    // Minimum 10, maksimum 500 exp
    return baseExp.clamp(10, 500);
  }

  /// Ticaret performans skoru (0-100)
  static double calculateTradingScore({
    required int totalTransactions,
    required double totalProfit,
    required int playerLevel,
  }) {
    if (totalTransactions == 0) return 0;

    // İşlem başına ortalama kar
    final avgProfit = totalProfit / totalTransactions;

    // Skor hesaplama
    double score = 0;

    // İşlem sayısı bonusu (max 30 puan)
    score += (totalTransactions / 10).clamp(0, 30);

    // Karlılık bonusu (max 40 puan)
    if (avgProfit > 0) {
      score += (avgProfit / 100).clamp(0, 40);
    }

    // Seviye bonusu (max 30 puan)
    score += (playerLevel * 3).clamp(0, 30).toDouble();

    return score.clamp(0, 100);
  }

  /// Toplu alım indirimi hesaplama
  static double calculateBulkDiscount(int quantity) {
    if (quantity >= 100) {
      return 0.15; // %15 indirim
    } else if (quantity >= 50) {
      return 0.10; // %10 indirim
    } else if (quantity >= 20) {
      return 0.05; // %5 indirim
    }
    return 0.0; // İndirim yok
  }

  /// Hızlı satış bonusu (kısa sürede satış yapıldıysa)
  static double calculateQuickSaleBonus({
    required DateTime purchaseDate,
    required DateTime saleDate,
  }) {
    final hoursDiff = saleDate.difference(purchaseDate).inHours;

    if (hoursDiff <= 1) {
      return 1.20; // %20 bonus
    } else if (hoursDiff <= 6) {
      return 1.10; // %10 bonus
    } else if (hoursDiff <= 24) {
      return 1.05; // %5 bonus
    }

    return 1.0; // Bonus yok
  }

  /// Trend ürün bonusu
  static double calculateTrendBonus({
    required bool isTrending,
    required int demand,
  }) {
    double bonus = 1.0;

    if (isTrending) {
      bonus += 0.15; // Trend ürün %15 bonus
    }

    if (demand > 80) {
      bonus += 0.10; // Yüksek talep %10 bonus
    } else if (demand > 60) {
      bonus += 0.05; // Orta talep %5 bonus
    }

    return bonus;
  }

  /// Günlük işlem limiti kontrolü
  static (bool, String?) checkDailyTransactionLimit({
    required int todayTransactionCount,
    required int playerLevel,
  }) {
    // Seviyeye göre günlük limit
    final limit = 50 + (playerLevel * 10);

    if (todayTransactionCount >= limit) {
      return (false, 'Günlük işlem limitine ulaştınız! Limit: $limit');
    }

    return (true, null);
  }

  /// İşlem vergisi hesaplama
  static double calculateTransactionTax({
    required double transactionValue,
    required int legalReputation,
  }) {
    // Temel vergi: %5
    double taxRate = 0.05;

    // Yüksek yasal itibar vergi indirimini sağlar
    if (legalReputation > 80) {
      taxRate = 0.03; // %3
    } else if (legalReputation > 60) {
      taxRate = 0.04; // %4
    }

    return transactionValue * taxRate;
  }
}
