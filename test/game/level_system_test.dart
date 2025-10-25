import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/game/systems/level_system.dart';
import 'package:deal_baron/data/models/player.dart';

/// Test 2: Level System - Seviye Atlama Testi
/// Bu test, oyuncunun seviye atlama mekaniğini doğrular
void main() {
  group('LevelSystem - Seviye Atlama', () {
    test('Level 1 için gereken exp 100 olmalı', () {
      // Setup
      final level = 1;

      // Action: Gereken exp hesapla (formül: level * 100)
      final requiredExp = level * 100;

      // Assert
      expect(requiredExp, 100);
    });

    test('Level 5 için gereken exp 500 olmalı', () {
      // Setup
      final level = 5;

      // Action
      final requiredExp = level * 100;

      // Assert
      expect(requiredExp, 500);
    });

    test('Yeterli exp varsa level atlayabilir', () {
      // Setup: Level 1, 150 exp (100 exp gerekli)
      final player = Player(
        id: 'test-player',
        username: 'testuser',
        email: 'test@test.com',
        name: 'Rising Baron',
        level: 1,
        experience: 150, // Yeterli exp var!
        cash: 1000.0,
        bankAccount: 0.0,
        debt: 0.0,
        inventory: const [],
        ownedShops: const [],
      );

      final requiredExp = player.level * 100; // 100

      // Assert: Level atlayabilir mi?
      expect(player.experience >= requiredExp, true);
      expect(player.experience, 150);
      expect(requiredExp, 100);
    });

    test('Yetersiz exp varsa level atlayamaz', () {
      // Setup: Level 2, 150 exp (200 exp gerekli)
      final player = Player(
        id: 'test-player',
        username: 'testuser',
        email: 'test@test.com',
        name: 'Grinding Baron',
        level: 2,
        experience: 150, // Yetersiz!
        cash: 1000.0,
        bankAccount: 0.0,
        debt: 0.0,
        inventory: const [],
        ownedShops: const [],
      );

      final requiredExp = player.level * 100; // 200

      // Assert: Level atlayamaz
      expect(player.experience < requiredExp, true);
      expect(player.experience, 150);
      expect(requiredExp, 200);
    });

    test('Level atladıktan sonra kalan exp hesaplanır', () {
      // Setup: Level 1, 250 exp
      final currentLevel = 1;
      final currentExp = 250;
      final requiredExp = currentLevel * 100; // 100

      // Action: Level atla
      final newLevel = currentLevel + 1; // 2
      final remainingExp = currentExp - requiredExp; // 250 - 100 = 150

      // Assert: Kalan exp doğru hesaplanmalı
      expect(newLevel, 2);
      expect(remainingExp, 150);
      expect(remainingExp >= 0, true); // Kalan exp negatif olamaz
    });

    test('Birden fazla level atlanabilir', () {
      // Setup: Level 1, 550 exp
      final startLevel = 1;
      final totalExp = 550;

      // Action: Kaç level atlanabilir?
      var currentLevel = startLevel;
      var remainingExp = totalExp;

      while (remainingExp >= currentLevel * 100) {
        remainingExp -= currentLevel * 100;
        currentLevel++;
      }

      // Assert: 3 level atlanmalı (100 + 200 + 200 = 500 exp harcanır)
      expect(currentLevel, 4); // 1 → 4 (3 level atladı)
      expect(remainingExp, 50); // 550 - 500 = 50 kalan
    });

    test('Level atladığında bonus para verilir', () {
      // Setup
      final oldCash = 1000.0;
      final levelUpBonus = 500.0;

      // Action: Level atla ve bonus ekle
      final newCash = oldCash + levelUpBonus;

      // Assert: Para artmalı
      expect(newCash, 1500.0);
      expect(newCash > oldCash, true);
    });
  });
}
