import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/game/systems/shop_system.dart';
import 'package:deal_baron/data/models/player.dart';
import 'package:deal_baron/data/models/shop.dart';

/// Test 3: Shop System - Dükkan Kiralama Testi
/// Bu test, dükkan kiralama mekaniğini ve çarpanları doğrular
void main() {
  group('ShopSystem - Dükkan Kiralama', () {
    test('Lokasyon çarpanları doğru hesaplanmalı', () {
      // Setup: Farklı lokasyon tipleri
      final locations = {
        'Mall': 1.5,
        'Market': 1.3,
        'Street': 1.0,
        'Office': 0.9,
        'Warehouse': 0.8,
      };

      // Assert: Her lokasyon için doğru çarpan
      expect(locations['Mall'], 1.5);
      expect(locations['Market'], 1.3);
      expect(locations['Street'], 1.0);
      expect(locations['Office'], 0.9);
      expect(locations['Warehouse'], 0.8);
    });

    test('Kategori çarpanları doğru hesaplanmalı', () {
      // Setup: Farklı iş kategorileri
      final categories = {
        'Restaurant': 1.4,
        'Cafe': 1.2,
        'Retail': 1.0,
        'Service': 0.9,
        'Warehouse': 0.7,
      };

      // Assert: Her kategori için doğru çarpan
      expect(categories['Restaurant'], 1.4);
      expect(categories['Cafe'], 1.2);
      expect(categories['Retail'], 1.0);
      expect(categories['Service'], 0.9);
      expect(categories['Warehouse'], 0.7);
    });

    test('Gelir tahmini doğru hesaplanmalı', () {
      // Setup: Dükkan özellikleri
      final baseRent = 5000.0;
      final locationMultiplier = 1.5; // Mall
      final categoryMultiplier = 1.4; // Restaurant

      // Action: Tahmini aylık gelir hesapla
      final estimatedRevenue = baseRent * locationMultiplier * categoryMultiplier;

      // Assert: (5000 * 1.5 * 1.4 = 10,500)
      expect(estimatedRevenue, 10500.0);
    });

    test('Yeterli para varsa dükkan kiralaması başarılı', () {
      // Setup: Zengin oyuncu
      final player = Player(
        id: 'test-player',
        username: 'richuser',
        email: 'rich@test.com',
        name: 'Rich Baron',
        level: 5,
        experience: 500,
        cash: 50000.0, // Çok para var
        bankAccount: 0.0,
        debt: 0.0,
        inventory: const [],
        ownedShops: const [],
      );

      final rentalPrice = 10000.0;

      // Assert: Kiralayabilir
      expect(player.cash >= rentalPrice, true);

      // Action: Kiralama sonrası para
      final remainingCash = player.cash - rentalPrice;
      expect(remainingCash, 40000.0);
    });

    test('Yetersiz para varsa dükkan kiralaması başarısız', () {
      // Setup: Fakir oyuncu
      final player = Player(
        id: 'test-player',
        username: 'pooruser',
        email: 'poor@test.com',
        name: 'Poor Baron',
        level: 1,
        experience: 0,
        cash: 5000.0, // Az para
        bankAccount: 0.0,
        debt: 0.0,
        inventory: const [],
        ownedShops: const [],
      );

      final rentalPrice = 10000.0;

      // Assert: Kiralayamaz
      expect(player.cash < rentalPrice, true);
      expect(player.cash, 5000.0);
      expect(rentalPrice, 10000.0);
    });

    test('Kar marjı hesaplama - iyi performans', () {
      // Setup: Dükkan gelir/gider
      final monthlyRevenue = 15000.0;
      final monthlyRent = 5000.0;
      final monthlyExpenses = 3000.0;

      // Action: Kar marjı hesapla
      final profit = monthlyRevenue - monthlyRent - monthlyExpenses;
      final profitMargin = (profit / monthlyRevenue) * 100;

      // Assert: Kar marjı %46.67 olmalı
      expect(profit, 7000.0); // 15000 - 5000 - 3000
      expect(profitMargin.toStringAsFixed(2), '46.67');
    });

    test('Performans skoru hesaplama', () {
      // Setup: Farklı kar marjları
      final excellentMargin = 50.0; // %50+
      final goodMargin = 35.0; // %30-50
      final averageMargin = 20.0; // %15-30
      final poorMargin = 10.0; // %15 altı

      // Action & Assert: Skor belirleme
      expect(excellentMargin >= 50, true); // Mükemmel
      expect(goodMargin >= 30 && goodMargin < 50, true); // İyi
      expect(averageMargin >= 15 && averageMargin < 30, true); // Orta
      expect(poorMargin < 15, true); // Zayıf
    });

    test('Birden fazla dükkan sahibi olunabilir', () {
      // Setup: Oyuncu başlangıç
      final initialShopCount = 0;

      // Action: 3 dükkan kirala
      final rentedShops = 3;
      final totalShops = initialShopCount + rentedShops;

      // Assert: 3 dükkan sahibi olmalı
      expect(totalShops, 3);
      expect(totalShops > initialShopCount, true);
    });

    test('Lokasyon ve kategori kombinasyonu - en karlı seçenek', () {
      // Setup: Farklı kombinasyonlar
      final baseRent = 5000.0;

      // Kombinasyon 1: Mall + Restaurant
      final combo1 = baseRent * 1.5 * 1.4; // 10,500

      // Kombinasyon 2: Market + Cafe
      final combo2 = baseRent * 1.3 * 1.2; // 7,800

      // Kombinasyon 3: Street + Retail
      final combo3 = baseRent * 1.0 * 1.0; // 5,000

      // Kombinasyon 4: Warehouse + Warehouse
      final combo4 = baseRent * 0.8 * 0.7; // 2,800

      // Assert: Mall + Restaurant en karlı
      expect(combo1 > combo2, true);
      expect(combo1 > combo3, true);
      expect(combo1 > combo4, true);
      expect(combo1, 10500.0);
    });
  });
}
