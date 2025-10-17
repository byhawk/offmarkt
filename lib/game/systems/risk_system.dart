import 'dart:math';
import '../../data/models/player.dart';

/// Risk yönetim sistemi - Risk hesaplama ve ceza mekanizmaları
class RiskSystem {
  static final _random = Random();

  /// Genel risk seviyesi hesaplama (0-100)
  static int calculateOverallRisk({
    required Player player,
    required int illegalProductCount,
    required double totalIllegalValue,
  }) {
    int risk = player.riskLevel;

    // Yasadışı ürün sayısı etkisi
    risk += (illegalProductCount * 2).clamp(0, 30);

    // Yasadışı ürün değeri etkisi
    risk += (totalIllegalValue / 10000).round().clamp(0, 30);

    // Düşük yasal itibar riski artırır
    if (player.legalReputation < 30) {
      risk += 20;
    } else if (player.legalReputation < 50) {
      risk += 10;
    }

    // Yüksek sokak itibarı riski azaltır
    if (player.streetReputation > 70) {
      risk -= 15;
    }

    // Yüksek borç riski artırır
    if (player.debt > 50000) {
      risk += 20;
    } else if (player.debt > 20000) {
      risk += 10;
    }

    return risk.clamp(0, 100);
  }

  /// İşlem riski hesaplama
  static double calculateTransactionRisk({
    required String productCategory,
    required double transactionValue,
    required int currentRiskLevel,
    required int legalReputation,
  }) {
    double risk = 0.0;

    // Ürün kategorisi riski
    if (productCategory == 'illegal') {
      risk += 0.6;
    } else if (productCategory == 'suspicious') {
      risk += 0.3;
    } else {
      risk += 0.1;
    }

    // Büyük işlemler daha riskli
    if (transactionValue > 100000) {
      risk += 0.3;
    } else if (transactionValue > 50000) {
      risk += 0.2;
    } else if (transactionValue > 20000) {
      risk += 0.1;
    }

    // Mevcut risk seviyesi etkisi
    risk += (currentRiskLevel / 200);

    // Düşük yasal itibar riski artırır
    risk += ((100 - legalReputation) / 200);

    return risk.clamp(0.0, 1.0);
  }

  /// Yakalanma kontrolü (true = yakalandı)
  static bool checkIfCaught({
    required double riskLevel,
    required int suspicionLevel,
  }) {
    // Risk seviyesine göre yakalanma şansı
    final catchChance = (riskLevel * 0.5) + (suspicionLevel / 100 * 0.3);

    return _random.nextDouble() < catchChance;
  }

  /// Ceza hesaplama
  static PenaltyResult calculatePenalty({
    required Player player,
    required String violationType,
    required double violationValue,
  }) {
    double fine = 0.0;
    int jailDays = 0;
    int reputationLoss = 0;

    switch (violationType) {
      case 'illegal_trade':
        fine = violationValue * 2.0; // 2x ceza
        jailDays = _random.nextInt(3) + 1; // 1-3 gün
        reputationLoss = 20;
        break;

      case 'tax_evasion':
        fine = violationValue * 1.5; // 1.5x ceza
        jailDays = _random.nextInt(2) + 1; // 1-2 gün
        reputationLoss = 15;
        break;

      case 'minor_violation':
        fine = violationValue * 0.5; // 0.5x ceza
        jailDays = 0;
        reputationLoss = 5;
        break;

      case 'major_violation':
        fine = violationValue * 3.0; // 3x ceza
        jailDays = _random.nextInt(7) + 3; // 3-10 gün
        reputationLoss = 30;
        break;
    }

    // Yasal itibar cezayı etkiler
    if (player.legalReputation > 70) {
      fine *= 0.7; // İyi itibar %30 indirim
      jailDays = (jailDays * 0.5).round();
    } else if (player.legalReputation < 30) {
      fine *= 1.3; // Kötü itibar %30 artış
      jailDays = (jailDays * 1.5).round();
    }

    // Ödeyemezse hapis süresi artar
    if (player.cash < fine) {
      jailDays += ((fine - player.cash) / 5000).ceil();
    }

    return PenaltyResult(
      fine: fine,
      jailDays: jailDays,
      reputationLoss: reputationLoss,
      description: _getPenaltyDescription(violationType),
    );
  }

  static String _getPenaltyDescription(String type) {
    switch (type) {
      case 'illegal_trade':
        return 'Yasadışı Ticaret - Kaçakçılık suçu';
      case 'tax_evasion':
        return 'Vergi Kaçırma - Mali suç';
      case 'minor_violation':
        return 'Küçük İhlal - Uyarı cezası';
      case 'major_violation':
        return 'Ağır İhlal - Ciddi suç';
      default:
        return 'Bilinmeyen ihlal';
    }
  }

  /// Risk azaltma stratejileri
  static List<RiskReduction> getRiskReductionStrategies({
    required Player player,
    required int currentRisk,
  }) {
    final strategies = <RiskReduction>[];

    // Yasal ticaret yap
    if (currentRisk > 50) {
      strategies.add(RiskReduction(
        action: 'Yasal ürünlerle ticaret yap',
        riskReduction: 20,
        cost: 0,
      ));
    }

    // Rüşvet
    if (player.cash >= 10000) {
      strategies.add(RiskReduction(
        action: 'Yetkililere rüşvet ver',
        riskReduction: 30,
        cost: 10000,
      ));
    }

    // Tatil (dinlenme)
    if (player.cash >= 5000) {
      strategies.add(RiskReduction(
        action: 'Bir süre saklan (3 gün)',
        riskReduction: 40,
        cost: 5000,
      ));
    }

    // Hayır işi
    strategies.add(RiskReduction(
      action: 'Hayır işi yap (itibar artışı)',
      riskReduction: 15,
      cost: 2000,
    ));

    return strategies;
  }

  /// Şüphe seviyesi güncelleme
  static int updateSuspicionLevel({
    required int currentSuspicion,
    required bool caughtToday,
    required int riskLevel,
  }) {
    int newSuspicion = currentSuspicion;

    if (caughtToday) {
      newSuspicion += 30; // Yakalandıysa şüphe artar
    } else {
      // Her gün azalır
      newSuspicion -= 5;
    }

    // Risk seviyesi şüpheyi etkiler
    newSuspicion += (riskLevel / 20).round();

    return newSuspicion.clamp(0, 100);
  }

  /// Risk uyarısı mesajı
  static String getRiskWarning(int riskLevel) {
    if (riskLevel >= 90) {
      return '🚨 EXTREMEly DANGEROUS! Hemen saklanın!';
    } else if (riskLevel >= 70) {
      return '⚠️ Çok Yüksek Risk - Dikkatli olun!';
    } else if (riskLevel >= 50) {
      return '⚠️ Yüksek Risk - Yasal ticarete geçin';
    } else if (riskLevel >= 30) {
      return '📊 Orta Risk - Kontrol altında';
    } else {
      return '✅ Düşük Risk - Güvendesiniz';
    }
  }

  /// Risk-kar dengesi önerisi
  static String getRiskRewardAdvice({
    required int riskLevel,
    required double potentialProfit,
  }) {
    final riskScore = riskLevel / 100;
    final profitScore = (potentialProfit / 50000).clamp(0, 1);

    if (profitScore > riskScore * 2) {
      return '⭐ Değer! Kar/risk oranı iyi.';
    } else if (profitScore > riskScore) {
      return '✅ Makul - Kar risk almaya değer.';
    } else if (profitScore < riskScore / 2) {
      return '❌ Değmez! Risk çok yüksek, kar çok düşük.';
    } else {
      return '⚠️ Sınırda - Dikkatli düşünün.';
    }
  }

  /// Güvenli işlem limiti
  static double getSafeTransactionLimit({
    required int riskLevel,
    required int legalReputation,
  }) {
    // Temel limit: 50,000₺
    double limit = 50000;

    // Düşük risk = yüksek limit
    limit *= (1.0 - (riskLevel / 200));

    // Yüksek itibar = yüksek limit
    limit *= (1.0 + (legalReputation / 200));

    return limit;
  }

  /// Risk sıfırlama (temiz başlangıç) maliyeti
  static double calculateRiskResetCost(int currentRisk) {
    // Risk seviyesi başına 1000₺
    return currentRisk * 1000.0;
  }
}

/// Ceza sonucu
class PenaltyResult {
  final double fine;
  final int jailDays;
  final int reputationLoss;
  final String description;

  PenaltyResult({
    required this.fine,
    required this.jailDays,
    required this.reputationLoss,
    required this.description,
  });
}

/// Risk azaltma stratejisi
class RiskReduction {
  final String action;
  final int riskReduction;
  final double cost;

  RiskReduction({
    required this.action,
    required this.riskReduction,
    required this.cost,
  });
}
