import '../../data/models/player.dart';

/// Seviye ve deneyim sistemi
class LevelSystem {
  /// Seviye başına gereken exp
  static const int expPerLevel = 1000;

  /// Maksimum seviye
  static const int maxLevel = 100;

  /// Deneyim ekle ve seviye kontrolü yap
  /// Returns: (newLevel, newExp, leveledUp)
  static (int, int, bool) addExperience({
    required Player player,
    required int expGained,
  }) {
    int currentExp = player.experience + expGained;
    int currentLevel = player.level;
    bool leveledUp = false;

    // Seviye atlama kontrolü
    while (currentExp >= expPerLevel && currentLevel < maxLevel) {
      currentExp -= expPerLevel;
      currentLevel++;
      leveledUp = true;
    }

    // Max level'da kalan exp sıfırlanır
    if (currentLevel >= maxLevel) {
      currentExp = 0;
    }

    return (currentLevel, currentExp, leveledUp);
  }

  /// Seviye başına ödüller
  static LevelRewards getLevelRewards(int level) {
    return LevelRewards(
      cashBonus: level * 2000.0, // Her seviye 2000₺
      inventorySlots: level * 5, // Her seviye 5 slot
      maxEmployees: level ~/ 3, // Her 3 seviyede 1 çalışan
      reputationBonus: level * 2, // Her seviye 2 itibar
      unlocks: _getUnlocks(level),
    );
  }

  static List<String> _getUnlocks(int level) {
    final unlocks = <String>[];

    if (level >= 5) {
      unlocks.add('🏦 Banka kredisi açıldı');
    }
    if (level >= 10) {
      unlocks.add('🏪 İkinci dükkan kiralama hakkı');
    }
    if (level >= 15) {
      unlocks.add('🚚 Toplu ticaret açıldı');
    }
    if (level >= 20) {
      unlocks.add('💼 Şirket kurma hakkı');
    }
    if (level >= 25) {
      unlocks.add('🌃 Özel pazarlara erişim');
    }
    if (level >= 30) {
      unlocks.add('🏭 Fabrika kiralama açıldı');
    }
    if (level >= 40) {
      unlocks.add('✈️ Uluslararası ticaret');
    }
    if (level >= 50) {
      unlocks.add('👑 VIP statüsü - Tüm avantajlar');
    }

    return unlocks;
  }

  /// Sonraki seviyeye kalan exp
  static int getExpToNextLevel(int currentExp) {
    return expPerLevel - currentExp;
  }

  /// Seviye progress yüzdesi
  static double getLevelProgress(int currentExp) {
    return (currentExp / expPerLevel).clamp(0.0, 1.0);
  }

  /// Seviye açıklaması
  static String getLevelTitle(int level) {
    if (level >= 50) {
      return '👑 Ticaret İmparatoru';
    } else if (level >= 40) {
      return '🌟 Ticaret Dehası';
    } else if (level >= 30) {
      return '⭐ Üst Düzey Tüccar';
    } else if (level >= 20) {
      return '💼 Profesyonel Tüccar';
    } else if (level >= 15) {
      return '📈 Deneyimli Tüccar';
    } else if (level >= 10) {
      return '🏪 Orta Düzey Tüccar';
    } else if (level >= 5) {
      return '📊 Acemi Tüccar';
    } else {
      return '🆕 Yeni Başlayan';
    }
  }

  /// Seviye bonusu multiplikatörü
  static double getLevelBonusMultiplier(int level) {
    // Her 5 seviyede %5 bonus
    return 1.0 + (level ~/ 5 * 0.05);
  }

  /// Günlük görevler için exp
  static int getDailyTaskExp(String taskType) {
    switch (taskType) {
      case 'first_trade':
        return 50;
      case 'reach_profit':
        return 100;
      case 'rent_shop':
        return 200;
      case 'complete_transactions':
        return 150;
      case 'level_up_reputation':
        return 120;
      default:
        return 50;
    }
  }

  /// Başarım exp'leri
  static int getAchievementExp(String achievementId) {
    switch (achievementId) {
      case 'first_trade':
        return 100;
      case 'rich_10k':
        return 250;
      case 'shop_owner':
        return 300;
      case 'successful_trader':
        return 500;
      case 'level_10':
        return 1000;
      case 'level_25':
        return 2500;
      case 'level_50':
        return 5000;
      default:
        return 100;
    }
  }

  /// İşlem türüne göre exp kazanımı
  static int getExpForAction({
    required String actionType,
    required double value,
    required int currentLevel,
  }) {
    int baseExp = 0;

    switch (actionType) {
      case 'purchase':
        baseExp = (value / 500).round().clamp(10, 100);
        break;
      case 'sell':
        baseExp = (value / 400).round().clamp(15, 150);
        break;
      case 'rent_shop':
        baseExp = 200;
        break;
      case 'complete_day':
        baseExp = 50;
        break;
      case 'pay_debt':
        baseExp = 75;
        break;
    }

    // Yüksek seviyede daha az exp kazanılır
    if (currentLevel > 20) {
      baseExp = (baseExp * 0.8).round();
    }
    if (currentLevel > 40) {
      baseExp = (baseExp * 0.6).round();
    }

    return baseExp.clamp(5, 500);
  }

  /// Seviye ile açılan özellikler kontrolü
  static bool isFeatureUnlocked(int playerLevel, String featureId) {
    switch (featureId) {
      case 'bank_loan':
        return playerLevel >= 5;
      case 'second_shop':
        return playerLevel >= 10;
      case 'bulk_trade':
        return playerLevel >= 15;
      case 'company':
        return playerLevel >= 20;
      case 'special_markets':
        return playerLevel >= 25;
      case 'factory':
        return playerLevel >= 30;
      case 'international':
        return playerLevel >= 40;
      case 'vip':
        return playerLevel >= 50;
      default:
        return false;
    }
  }

  /// Seviye istatistikleri
  static LevelStats getLevelStats(Player player) {
    final expToNext = getExpToNextLevel(player.experience);
    final progress = getLevelProgress(player.experience);
    final title = getLevelTitle(player.level);
    final rewards = getLevelRewards(player.level);
    final bonusMultiplier = getLevelBonusMultiplier(player.level);

    return LevelStats(
      currentLevel: player.level,
      currentExp: player.experience,
      expToNextLevel: expToNext,
      progressPercent: progress * 100,
      title: title,
      rewards: rewards,
      bonusMultiplier: bonusMultiplier,
    );
  }

  /// Prestige sistem (seviye sıfırlama bonusları)
  static PrestigeBonus? getPrestigeOption(int currentLevel) {
    if (currentLevel < 50) return null;

    return PrestigeBonus(
      requiredLevel: 50,
      permanentBonuses: [
        '🌟 Tüm exp kazanımı %20 artar',
        '💰 Başlangıç parası 50,000₺',
        '⭐ Başlangıç itibarı 30',
        '🎯 Özel prestij rozeti',
      ],
      description: 'Seviye 1\'den başla ama kalıcı bonuslarla',
    );
  }
}

/// Seviye ödülleri
class LevelRewards {
  final double cashBonus;
  final int inventorySlots;
  final int maxEmployees;
  final int reputationBonus;
  final List<String> unlocks;

  LevelRewards({
    required this.cashBonus,
    required this.inventorySlots,
    required this.maxEmployees,
    required this.reputationBonus,
    required this.unlocks,
  });
}

/// Seviye istatistikleri
class LevelStats {
  final int currentLevel;
  final int currentExp;
  final int expToNextLevel;
  final double progressPercent;
  final String title;
  final LevelRewards rewards;
  final double bonusMultiplier;

  LevelStats({
    required this.currentLevel,
    required this.currentExp,
    required this.expToNextLevel,
    required this.progressPercent,
    required this.title,
    required this.rewards,
    required this.bonusMultiplier,
  });
}

/// Prestij bonusu
class PrestigeBonus {
  final int requiredLevel;
  final List<String> permanentBonuses;
  final String description;

  PrestigeBonus({
    required this.requiredLevel,
    required this.permanentBonuses,
    required this.description,
  });
}
