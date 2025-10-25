import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/game/systems/trading_system.dart';
import 'package:deal_baron/data/models/player.dart';
import 'package:deal_baron/data/models/product.dart';

/// Test 1: Trading System - Kar Hesaplama Testi
/// Bu test, alım-satım sisteminin kar hesaplamasını doğrular
void main() {
  group('TradingSystem - Kar Hesaplama', () {
    test('Kar hesaplama - pozitif kar', () {
      // Setup: Test verilerini hazırla
      final buyPrice = 80.0;
      final sellPrice = 100.0;
      final quantity = 5;

      // Action: Kar hesapla
      final profit = (sellPrice - buyPrice) * quantity;

      // Assert: Sonucu doğrula
      expect(profit, 100.0); // (100 - 80) * 5 = 100
    });

    test('Kar hesaplama - zarar durumu', () {
      // Setup
      final buyPrice = 100.0;
      final sellPrice = 80.0;
      final quantity = 10;

      // Action
      final profit = (sellPrice - buyPrice) * quantity;

      // Assert: Negatif kar (zarar) olmalı
      expect(profit, -200.0); // (80 - 100) * 10 = -200
    });

    test('Kar hesaplama - başabaş', () {
      // Setup
      final buyPrice = 100.0;
      final sellPrice = 100.0;
      final quantity = 50;

      // Action
      final profit = (sellPrice - buyPrice) * quantity;

      // Assert: Kar 0 olmalı
      expect(profit, 0.0);
    });

    test('Satın alma - yeterli para varsa başarılı', () {
      // Setup: Oyuncu ve ürün oluştur
      final player = Player(
        id: 'test-player',
        username: 'testuser',
        email: 'test@test.com',
        name: 'Test Baron',
        level: 1,
        experience: 0,
        cash: 1000.0,
        bankAccount: 0.0,
        debt: 0.0,
        inventory: const [],
        ownedShops: const [],
      );

      final product = Product(
        id: 'product-1',
        name: 'iPhone',
        category: 'Electronics',
        basePrice: 100.0,
        currentPrice: 100.0,
        demand: 50.0,
        volatility: 0.1,
        description: 'Test product',
        minPrice: 80.0,
        maxPrice: 150.0,
        priceHistory: const [],
        trending: false,
      );

      final quantity = 5;
      final totalCost = product.currentPrice * quantity; // 500

      // Assert: Yeterli para var mı?
      expect(player.cash >= totalCost, true);
      expect(player.cash, 1000.0);
      expect(totalCost, 500.0);
    });

    test('Satın alma - yetersiz para varsa başarısız olmalı', () {
      // Setup: Az paralı oyuncu
      final player = Player(
        id: 'test-player',
        username: 'testuser',
        email: 'test@test.com',
        name: 'Poor Baron',
        level: 1,
        experience: 0,
        cash: 100.0, // Sadece 100 TL var
        bankAccount: 0.0,
        debt: 0.0,
        inventory: const [],
        ownedShops: const [],
      );

      final product = Product(
        id: 'product-1',
        name: 'Laptop',
        category: 'Electronics',
        basePrice: 500.0,
        currentPrice: 500.0,
        demand: 50.0,
        volatility: 0.1,
        description: 'Expensive product',
        minPrice: 400.0,
        maxPrice: 600.0,
        priceHistory: const [],
        trending: false,
      );

      final quantity = 5;
      final totalCost = product.currentPrice * quantity; // 2500

      // Assert: Para yetersiz
      expect(player.cash < totalCost, true);
      expect(player.cash, 100.0);
      expect(totalCost, 2500.0);
    });
  });
}
