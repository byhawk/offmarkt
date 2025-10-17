import '../../data/models/player.dart';

/// İtibar yönetim sistemi - Yasal ve sokak itibarı hesaplama
class ReputationSystem {
  /// İtibar kazanma/kaybetme
  /// Returns: (newLegalRep, newStreetRep)
  static (int, int) updateReputation({
    required Player player,
    required ReputationAction action,
    required int amount,
  }) {
    int newLegal = player.legalReputation;
    int newStreet = player.streetReputation;

    switch (action) {
      case ReputationAction.legalTrade:
        // Yasal ticaret: Yasal itibar artar, sokak itibarı azalır
        newLegal = (newLegal + amount).clamp(0, 100);
        newStreet = (newStreet - (amount ~/ 2)).clamp(0, 100);
        break;

      case ReputationAction.illegalTrade:
        // Yasadışı ticaret: Sokak itibarı artar, yasal itibar azalır
        newStreet = (newStreet + amount).clamp(0, 100);
        newLegal = (newLegal - (amount ~/ 2)).clamp(0, 100);
        break;

      case ReputationAction.rentShop:
        // Dükkan kiralama: Yasal itibar artar
        newLegal = (newLegal + amount).clamp(0, 100);
        break;

      case ReputationAction.payTax:
        // Vergi ödeme: Yasal itibar artar
        newLegal = (newLegal + amount).clamp(0, 100);
        break;

      case ReputationAction.evadeTax:
        // Vergi kaçırma: Yasal itibar azalır, sokak itibarı artar
        newLegal = (newLegal - amount).clamp(0, 100);
        newStreet = (newStreet + (amount ~/ 3)).clamp(0, 100);
        break;

      case ReputationAction.helpAuthority:
        // Yetkililere yardım: Yasal itibar artar
        newLegal = (newLegal + amount).clamp(0, 100);
        newStreet = (newStreet - amount).clamp(0, 100);
        break;

      case ReputationAction.helpCriminal:
        // Suçlulara yardım: Sokak itibarı artar
        newStreet = (newStreet + amount).clamp(0, 100);
        newLegal = (newLegal - amount).clamp(0, 100);
        break;

      case ReputationAction.charity:
        // Hayır işi: Her ikisi de az artar
        newLegal = (newLegal + amount).clamp(0, 100);
        newStreet = (newStreet + (amount ~/ 2)).clamp(0, 100);
        break;

      case ReputationAction.caught:
        // Yakalandı: Her ikisi de azalır
        newLegal = (newLegal - amount).clamp(0, 100);
        newStreet = (newStreet - (amount ~/ 2)).clamp(0, 100);
        break;
    }

    return (newLegal, newStreet);
  }

  /// İtibar seviyesi açıklaması
  static String getReputationLevel(int reputation) {
    if (reputation >= 90) {
      return 'Efsanevi';
    } else if (reputation >= 75) {
      return 'Çok Yüksek';
    } else if (reputation >= 60) {
      return 'Yüksek';
    } else if (reputation >= 40) {
      return 'Orta';
    } else if (reputation >= 25) {
      return 'Düşük';
    } else if (reputation >= 10) {
      return 'Çok Düşük';
    } else {
      return 'Kötü';
    }
  }

  /// Yasal itibar avantajları
  static List<String> getLegalReputationBenefits(int legalReputation) {
    final benefits = <String>[];

    if (legalReputation >= 80) {
      benefits.add('🏦 Banka kredisi faizi %30 indirimli');
      benefits.add('💼 Premium dükkan kiralama hakkı');
      benefits.add('💰 Vergi indirimi %40');
    } else if (legalReputation >= 60) {
      benefits.add('🏦 Banka kredisi faizi %15 indirimli');
      benefits.add('💼 Kaliteli dükkan kiralama hakkı');
      benefits.add('💰 Vergi indirimi %20');
    } else if (legalReputation >= 40) {
      benefits.add('🏦 Banka kredisine erişim');
      benefits.add('💼 Standart dükkan kiralama hakkı');
    } else if (legalReputation < 25) {
      benefits.add('⚠️ Banka kredisine erişim yok');
      benefits.add('⚠️ Resmi dükkan kiralama zorlaşır');
      benefits.add('⚠️ Yüksek vergi denetimi riski');
    }

    return benefits;
  }

  /// Sokak itibarı avantajları
  static List<String> getStreetReputationBenefits(int streetReputation) {
    final benefits = <String>[];

    if (streetReputation >= 80) {
      benefits.add('🌃 Yasadışı ürün %40 indirimli');
      benefits.add('🔐 Güvenlik artışı - Soygun riski %50 azalır');
      benefits.add('🤝 Özel anlaşmalar mevcut');
    } else if (streetReputation >= 60) {
      benefits.add('🌃 Yasadışı ürün %20 indirimli');
      benefits.add('🔐 Güvenlik artışı - Soygun riski %25 azalır');
    } else if (streetReputation >= 40) {
      benefits.add('🌃 Yasadışı ürünlere erişim');
    } else if (streetReputation < 25) {
      benefits.add('⚠️ Yasadışı ürünlere erişim yok');
      benefits.add('⚠️ Sokakta tehlike riski yüksek');
    }

    return benefits;
  }

  /// İtibar dengesini kontrol et (çok uç değerler kötü)
  static String getReputationBalance(int legalRep, int streetRep) {
    final diff = (legalRep - streetRep).abs();

    if (diff > 70) {
      return '⚠️ Dengesiz - Tek tarafa çok yüklenmişsiniz';
    } else if (diff > 50) {
      return '📊 Az Dengesiz - Dikkatli olun';
    } else if (diff > 30) {
      return '✅ Dengeli - İyi gidiyorsunuz';
    } else {
      return '⭐ Mükemmel Denge - Her iki tarafla da iyi ilişkileriniz var';
    }
  }

  /// İtibar kaybı riski (işleme göre)
  static double getReputationRiskLevel({
    required String actionType,
    required int currentLegalRep,
    required int currentStreetRep,
  }) {
    double risk = 0.0;

    // Yasal ticaret: Düşük risk
    if (actionType == 'legal_trade') {
      risk = 0.1;
    }
    // Yasadışı ticaret: Risk itibarla ters orantılı
    else if (actionType == 'illegal_trade') {
      risk = 0.5 - (currentStreetRep / 200);
    }
    // Vergi kaçırma: Yüksek risk
    else if (actionType == 'evade_tax') {
      risk = 0.7 - (currentStreetRep / 300);
    }

    return risk.clamp(0.0, 1.0);
  }

  /// Günlük itibar erime (aktif olmazsan itibar azalır)
  static (int, int) applyDailyDecay({
    required Player player,
    required int daysSinceLastActivity,
  }) {
    if (daysSinceLastActivity == 0) {
      return (player.legalReputation, player.streetReputation);
    }

    // Günde %1 erime
    final decayRate = 0.01 * daysSinceLastActivity;

    final newLegal = (player.legalReputation * (1 - decayRate)).round().clamp(0, 100);
    final newStreet = (player.streetReputation * (1 - decayRate)).round().clamp(0, 100);

    return (newLegal, newStreet);
  }

  /// İtibar önerileri
  static List<String> getReputationAdvice({
    required int legalReputation,
    required int streetReputation,
  }) {
    final advice = <String>[];

    if (legalReputation < 30) {
      advice.add('💡 Yasal itibarınız düşük! Resmi ticaret yapın ve vergi ödeyin.');
    }

    if (streetReputation < 30) {
      advice.add('💡 Sokak itibarınız düşük! Dikkatli olun, soyulabilirsiniz.');
    }

    if (legalReputation > 80 && streetReputation < 20) {
      advice.add('⚠️ Sokak itibarınız çok düşük! Alternatif gelir kaynaklarını kapatabilir.');
    }

    if (streetReputation > 80 && legalReputation < 20) {
      advice.add('⚠️ Yasal itibarınız çok düşük! Resmi işlemler zorlaşacak.');
    }

    if (legalReputation > 60 && streetReputation > 60) {
      advice.add('⭐ Harika! Her iki dünyada da saygınlığınız var.');
    }

    return advice;
  }

  /// İtibar kazanma hızı (seviye ve işlem sayısına göre)
  static double getReputationGainMultiplier({
    required int playerLevel,
    required int totalTransactions,
  }) {
    double multiplier = 1.0;

    // Yeni oyuncular daha hızlı itibar kazanır
    if (playerLevel <= 3) {
      multiplier += 0.5;
    }

    // Deneyimli oyuncular daha yavaş kazanır
    if (totalTransactions > 500) {
      multiplier -= 0.3;
    } else if (totalTransactions > 200) {
      multiplier -= 0.2;
    }

    return multiplier.clamp(0.5, 2.0);
  }
}

/// İtibar aksiyonları enum
enum ReputationAction {
  legalTrade,      // Yasal ticaret
  illegalTrade,    // Yasadışı ticaret
  rentShop,        // Dükkan kiralama
  payTax,          // Vergi ödeme
  evadeTax,        // Vergi kaçırma
  helpAuthority,   // Yetkililere yardım
  helpCriminal,    // Suçlulara yardım
  charity,         // Hayır işi
  caught,          // Yakalandı
}
