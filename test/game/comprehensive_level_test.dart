import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/game/systems/level_system.dart';
import 'package:deal_baron/data/models/player.dart';

/// ═══════════════════════════════════════════════════════════════
/// KAPSAMLI SEVİYE SİSTEMİ TESTLERİ
/// ═══════════════════════════════════════════════════════════════
///
/// Bu test dosyası Deal Baron'un LevelSystem'ini kapsamlı şekilde test eder.
/// Toplam 25+ test içerir ve tüm fonksiyonları doğrular.
///
void main() {
  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 1: DENEYİM EKLEME VE SEVİYE ATLAMA
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Deneyim Ekleme ve Level Atlama', () {
    test('Exp ekleme: Level atlamadan', () {
      // Setup
      final player = const Player(
        id: 'test-1',
        username: 'user1',
        email: 'test@test.com',
        name: 'Baron',
        level: 1,
        experience: 500,
        cash: 1000,
        bankAccount: 0,
        debt: 0,
        inventory: [],
        ownedShops: [],
      );

      // Action: 200 exp ekle (toplam 700, 1000'e ulaşmaz)
      final (newLevel, newExp, leveledUp) = LevelSystem.addExperience(
        player: player,
        expGained: 200,
      );

      // Assert
      expect(newLevel, 1); // Level değişmedi
      expect(newExp, 700); // 500 + 200
      expect(leveledUp, false);
      print('✅ Test geçti: Exp eklendi, level atlamadı (Exp: $newExp)');
    });

    test('Exp ekleme: Tek level atlama', () {
      // Setup
      final player = const Player(
        id: 'test-2',
        username: 'user2',
        email: 'test@test.com',
        name: 'Baron',
        level: 1,
        experience: 900,
        cash: 1000,
        bankAccount: 0,
        debt: 0,
        inventory: [],
        ownedShops: [],
      );

      // Action: 200 exp ekle (toplam 1100, 1 level atlar)
      final (newLevel, newExp, leveledUp) = LevelSystem.addExperience(
        player: player,
        expGained: 200,
      );

      // Assert
      expect(newLevel, 2); // 1 → 2
      expect(newExp, 100); // 1100 - 1000 = 100 kalan
      expect(leveledUp, true);
      print('✅ Test geçti: Level atladı! Level: $newLevel, Kalan exp: $newExp');
    });

    test('Exp ekleme: Birden fazla level atlama', () {
      // Setup
      final player = const Player(
        id: 'test-3',
        username: 'user3',
        email: 'test@test.com',
        name: 'Baron',
        level: 1,
        experience: 0,
        cash: 1000,
        bankAccount: 0,
        debt: 0,
        inventory: [],
        ownedShops: [],
      );

      // Action: 3500 exp ekle (3 level atlar)
      final (newLevel, newExp, leveledUp) = LevelSystem.addExperience(
        player: player,
        expGained: 3500,
      );

      // Assert: 3500 exp = 3 level (3000 exp) + 500 kalan
      expect(newLevel, 4); // 1 → 4 (3 level atladı)
      expect(newExp, 500);
      expect(leveledUp, true);
      print('✅ Test geçti: 3 level atladı! Level: 1 → $newLevel, Kalan: $newExp');
    });

    test('Max level (100) sonrası exp sıfırlanır', () {
      // Setup
      final player = const Player(
        id: 'test-4',
        username: 'user4',
        email: 'test@test.com',
        name: 'Baron',
        level: 100, // Max level
        experience: 500,
        cash: 1000,
        bankAccount: 0,
        debt: 0,
        inventory: [],
        ownedShops: [],
      );

      // Action: Max level'da exp ekle
      final (newLevel, newExp, leveledUp) = LevelSystem.addExperience(
        player: player,
        expGained: 5000,
      );

      // Assert
      expect(newLevel, 100); // Max level'da kalır
      expect(newExp, 0); // Exp sıfırlanır
      expect(leveledUp, false);
      print('✅ Test geçti: Max level exp sıfırlandı');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 2: SEVİYE ÖDÜLLERİ
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Seviye Ödülleri', () {
    test('Level 1 ödülleri doğru', () {
      final rewards = LevelSystem.getLevelRewards(1);

      expect(rewards.cashBonus, 2000.0); // 1 * 2000
      expect(rewards.inventorySlots, 5); // 1 * 5
      expect(rewards.maxEmployees, 0); // 1 ~/ 3 = 0
      expect(rewards.reputationBonus, 2); // 1 * 2
      print('✅ Test geçti: Level 1 ödülleri = ${rewards.cashBonus} TL');
    });

    test('Level 10 ödülleri doğru', () {
      final rewards = LevelSystem.getLevelRewards(10);

      expect(rewards.cashBonus, 20000.0); // 10 * 2000
      expect(rewards.inventorySlots, 50); // 10 * 5
      expect(rewards.maxEmployees, 3); // 10 ~/ 3 = 3
      expect(rewards.reputationBonus, 20); // 10 * 2
      print('✅ Test geçti: Level 10 ödülleri = ${rewards.cashBonus} TL, ${rewards.maxEmployees} çalışan');
    });

    test('Level 50 unlocks kontrolü', () {
      final rewards = LevelSystem.getLevelRewards(50);

      expect(rewards.unlocks, isNotEmpty);
      expect(rewards.unlocks, contains('👑 VIP statüsü - Tüm avantajlar'));
      print('✅ Test geçti: Level 50 unlocks = ${rewards.unlocks.length} özellik');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 3: EXP HESAPLAMALARI
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Exp Hesaplamaları', () {
    test('Sonraki levele kalan exp doğru', () {
      const currentExp = 750;
      final remaining = LevelSystem.getExpToNextLevel(currentExp);

      expect(remaining, 250); // 1000 - 750
      print('✅ Test geçti: Kalan exp = $remaining');
    });

    test('Level progress yüzdesi doğru', () {
      const currentExp = 500;
      final progress = LevelSystem.getLevelProgress(currentExp);

      expect(progress, 0.5); // 500 / 1000 = 0.5
      print('✅ Test geçti: Progress = ${(progress * 100).toInt()}%');
    });

    test('Max exp progress %100', () {
      const currentExp = 1000;
      final progress = LevelSystem.getLevelProgress(currentExp);

      expect(progress, 1.0);
      print('✅ Test geçti: Max progress = ${(progress * 100).toInt()}%');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 4: SEVİYE ÜNVANLARI
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Seviye Ünvanları', () {
    test('Level 1: Yeni Başlayan', () {
      final title = LevelSystem.getLevelTitle(1);
      expect(title, '🆕 Yeni Başlayan');
      print('✅ Test geçti: $title');
    });

    test('Level 10: Orta Düzey Tüccar', () {
      final title = LevelSystem.getLevelTitle(10);
      expect(title, '🏪 Orta Düzey Tüccar');
      print('✅ Test geçti: $title');
    });

    test('Level 50: Ticaret İmparatoru', () {
      final title = LevelSystem.getLevelTitle(50);
      expect(title, '👑 Ticaret İmparatoru');
      print('✅ Test geçti: $title');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 5: SEVİYE BONUSU MULTİPLİKATÖRÜ
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Bonus Multiplikatör', () {
    test('Level 1-4: Bonus yok (1.0x)', () {
      final multiplier = LevelSystem.getLevelBonusMultiplier(4);
      expect(multiplier, 1.0); // 4 ~/ 5 = 0, 1.0 + 0
      print('✅ Test geçti: Level 4 bonus = ${multiplier}x');
    });

    test('Level 5: %5 bonus (1.05x)', () {
      final multiplier = LevelSystem.getLevelBonusMultiplier(5);
      expect(multiplier, 1.05); // 5 ~/ 5 = 1, 1.0 + 0.05
      print('✅ Test geçti: Level 5 bonus = ${multiplier}x');
    });

    test('Level 50: %50 bonus (1.50x)', () {
      final multiplier = LevelSystem.getLevelBonusMultiplier(50);
      expect(multiplier, 1.50); // 50 ~/ 5 = 10, 1.0 + (10 * 0.05)
      print('✅ Test geçti: Level 50 bonus = ${multiplier}x');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 6: GÜNLÜK GÖREV EXP
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Günlük Görev Exp', () {
    test('first_trade görevi 50 exp', () {
      final exp = LevelSystem.getDailyTaskExp('first_trade');
      expect(exp, 50);
      print('✅ Test geçti: first_trade = $exp exp');
    });

    test('rent_shop görevi en yüksek exp (200)', () {
      final exp = LevelSystem.getDailyTaskExp('rent_shop');
      expect(exp, 200);
      print('✅ Test geçti: rent_shop = $exp exp');
    });

    test('Bilinmeyen görev default 50 exp', () {
      final exp = LevelSystem.getDailyTaskExp('unknown_task');
      expect(exp, 50);
      print('✅ Test geçti: unknown_task = $exp exp');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 7: BAŞARIM EXP
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Başarım Exp', () {
    test('first_trade başarımı 100 exp', () {
      final exp = LevelSystem.getAchievementExp('first_trade');
      expect(exp, 100);
      print('✅ Test geçti: first_trade achievement = $exp exp');
    });

    test('level_50 başarımı en yüksek (5000 exp)', () {
      final exp = LevelSystem.getAchievementExp('level_50');
      expect(exp, 5000);
      print('✅ Test geçti: level_50 achievement = $exp exp');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 8: AKSİYON EXP KAZANIMI
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Aksiyon Exp Kazanımı', () {
    test('Satın alma exp: Value bazlı', () {
      final exp = LevelSystem.getExpForAction(
        actionType: 'purchase',
        value: 50000, // 50,000 / 500 = 100
        currentLevel: 1,
      );

      expect(exp, 100);
      print('✅ Test geçti: Purchase exp = $exp');
    });

    test('Satış, alımdan daha fazla exp', () {
      // Setup: Aynı value
      const value = 50000.0;
      const level = 1;

      // Action
      final purchaseExp = LevelSystem.getExpForAction(
        actionType: 'purchase',
        value: value,
        currentLevel: level,
      );

      final sellExp = LevelSystem.getExpForAction(
        actionType: 'sell',
        value: value,
        currentLevel: level,
      );

      // Assert: Satış daha fazla exp vermeli
      expect(sellExp, greaterThan(purchaseExp));
      print('✅ Test geçti: Sell exp ($sellExp) > Purchase exp ($purchaseExp)');
    });

    test('Yüksek seviyede exp azalır', () {
      // Setup
      const value = 50000.0;

      // Action: Düşük level
      final lowLevelExp = LevelSystem.getExpForAction(
        actionType: 'purchase',
        value: value,
        currentLevel: 10,
      );

      // Action: Yüksek level
      final highLevelExp = LevelSystem.getExpForAction(
        actionType: 'purchase',
        value: value,
        currentLevel: 50,
      );

      // Assert: Yüksek level daha az exp
      expect(highLevelExp, lessThan(lowLevelExp));
      print('✅ Test geçti: Level 10 = $lowLevelExp exp, Level 50 = $highLevelExp exp');
    });

    test('Exp minimum 5, maksimum 500', () {
      // Setup: Çok küçük işlem
      final minExp = LevelSystem.getExpForAction(
        actionType: 'purchase',
        value: 1,
        currentLevel: 1,
      );

      // Setup: Çok büyük işlem
      final maxExp = LevelSystem.getExpForAction(
        actionType: 'sell',
        value: 1000000,
        currentLevel: 1,
      );

      // Assert
      expect(minExp, greaterThanOrEqualTo(5));
      expect(maxExp, lessThanOrEqualTo(500));
      print('✅ Test geçti: Exp limitleri (min: $minExp, max: $maxExp)');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 9: ÖZELLİK KİLİT AÇMA
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Özellik Kilit Açma', () {
    test('Level 5: Banka kredisi açılır', () {
      expect(LevelSystem.isFeatureUnlocked(5, 'bank_loan'), true);
      expect(LevelSystem.isFeatureUnlocked(4, 'bank_loan'), false);
      print('✅ Test geçti: Level 5\'te bank_loan açıldı');
    });

    test('Level 10: İkinci dükkan açılır', () {
      expect(LevelSystem.isFeatureUnlocked(10, 'second_shop'), true);
      expect(LevelSystem.isFeatureUnlocked(9, 'second_shop'), false);
      print('✅ Test geçti: Level 10\'da second_shop açıldı');
    });

    test('Level 50: VIP statüsü', () {
      expect(LevelSystem.isFeatureUnlocked(50, 'vip'), true);
      expect(LevelSystem.isFeatureUnlocked(49, 'vip'), false);
      print('✅ Test geçti: Level 50\'de VIP açıldı');
    });

    test('Bilinmeyen özellik her zaman false', () {
      expect(LevelSystem.isFeatureUnlocked(100, 'unknown_feature'), false);
      print('✅ Test geçti: Bilinmeyen özellik kilitli');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 10: SEVİYE İSTATİSTİKLERİ
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Seviye İstatistikleri', () {
    test('Level stats doğru hesaplanır', () {
      // Setup
      final player = const Player(
        id: 'test-stats',
        username: 'statuser',
        email: 'stats@test.com',
        name: 'Stats Baron',
        level: 15,
        experience: 600,
        cash: 10000,
        bankAccount: 5000,
        debt: 0,
        inventory: [],
        ownedShops: [],
      );

      // Action
      final stats = LevelSystem.getLevelStats(player);

      // Assert
      expect(stats.currentLevel, 15);
      expect(stats.currentExp, 600);
      expect(stats.expToNextLevel, 400); // 1000 - 600
      expect(stats.progressPercent, 60.0); // 600 / 1000 * 100
      expect(stats.title, '📈 Deneyimli Tüccar');
      expect(stats.bonusMultiplier, 1.15); // 15 ~/ 5 = 3, 1.0 + (3 * 0.05)
      print('✅ Test geçti: Level stats hesaplandı');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 11: PRESTİJ SİSTEMİ
  // ═══════════════════════════════════════════════════════════════
  group('LevelSystem - Prestij Sistemi', () {
    test('Level 50 altında prestij yok', () {
      final prestige = LevelSystem.getPrestigeOption(49);
      expect(prestige, null);
      print('✅ Test geçti: Level 49\'da prestij yok');
    });

    test('Level 50\'de prestij açılır', () {
      final prestige = LevelSystem.getPrestigeOption(50);

      expect(prestige, isNotNull);
      expect(prestige!.requiredLevel, 50);
      expect(prestige.permanentBonuses, isNotEmpty);
      expect(prestige.permanentBonuses.length, 4);
      print('✅ Test geçti: Level 50 prestij bonusları = ${prestige.permanentBonuses.length}');
    });
  });
}
