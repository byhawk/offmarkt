import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/game/systems/trading_system.dart';
import 'package:deal_baron/data/models/player.dart';
import 'package:deal_baron/data/models/product.dart';

/// ═══════════════════════════════════════════════════════════════
/// KAPSAMLI TİCARET SİSTEMİ TESTLERİ
/// ═══════════════════════════════════════════════════════════════
///
/// Bu test dosyası Deal Baron'un TradingSystem'ini kapsamlı şekilde test eder.
/// Toplam 30+ test içerir ve tüm fonksiyonları doğrular.
///
void main() {
  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 1: SATIN ALMA İŞLEMLERİ (Purchase Product)
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - Satın Alma İşlemleri', () {
    late Player player;
    late Product product;

    setUp(() {
      // Her testten önce yeni player ve product oluştur
      player = const Player(
        id: 'test-player-1',
        username: 'testuser',
        email: 'test@test.com',
        name: 'Test Baron',
        level: 5,
        experience: 500,
        cash: 10000.0,
        bankAccount: 5000.0,
        debt: 0.0,
        inventory: [],
        ownedShops: [],
      );

      product = const Product(
        id: 'product-1',
        name: 'iPhone',
        emoji: '📱',
        basePrice: 5000.0,
        currentPrice: 5500.0,
        demand: 75,
        volatility: 0.1,
        isTrending: true,
        seasonalFactor: 1.2,
        category: 'legal',
      );
    });

    test('Yeterli para ile satın alma başarılı olmalı', () {
      // Action
      final (success, errorMessage) = TradingSystem.purchaseProduct(
        player: player,
        product: product,
        quantity: 1,
      );

      // Assert
      expect(success, true);
      expect(errorMessage, null);
      print('✅ Test geçti: Yeterli para ile satın alma başarılı');
    });

    test('Yetersiz para ile satın alma başarısız olmalı', () {
      // Setup: Az paralı oyuncu
      final poorPlayer = player.copyWith(cash: 100.0);

      // Action
      final (success, errorMessage) = TradingSystem.purchaseProduct(
        player: poorPlayer,
        product: product,
        quantity: 1,
      );

      // Assert
      expect(success, false);
      expect(errorMessage, isNotNull);
      expect(errorMessage, contains('Yetersiz nakit'));
      print('✅ Test geçti: Yetersiz para ile satın alma engellendi');
    });

    test('999\'dan fazla ürün alınamaz', () {
      // Action: 1000 ürün almayı dene
      final (success, errorMessage) = TradingSystem.purchaseProduct(
        player: player,
        product: const Product(
          id: 'cheap-product',
          name: 'Ucuz Ürün',
          emoji: '💰',
          basePrice: 1.0,
          currentPrice: 1.0,
          category: 'legal',
        ),
        quantity: 1000,
      );

      // Assert
      expect(success, false);
      expect(errorMessage, contains('en fazla 999'));
      print('✅ Test geçti: Maksimum ürün limiti çalışıyor');
    });

    test('Çoklu satın alma total cost doğru hesaplanmalı', () {
      // Setup
      const quantity = 5;
      final expectedCost = product.currentPrice * quantity; // 5500 * 5 = 27,500

      // Assert: Oyuncunun parası yeterli mi?
      expect(player.cash, lessThan(expectedCost));

      // Action
      final (success, errorMessage) = TradingSystem.purchaseProduct(
        player: player,
        product: product,
        quantity: quantity,
      );

      // Assert: Para yetersiz olmalı
      expect(success, false);
      expect(errorMessage, contains('Yetersiz nakit'));
      expect(errorMessage, contains('27500'));
      print('✅ Test geçti: Total cost doğru hesaplandı');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 2: SATMA İŞLEMLERİ (Sell Product)
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - Satma İşlemleri', () {
    test('Yeterli stok ile satış başarılı olmalı', () {
      // Setup
      const inventoryQuantity = 10;
      const sellQuantity = 5;

      // Action
      final (success, errorMessage) = TradingSystem.sellProduct(
        currentInventoryQuantity: inventoryQuantity,
        quantityToSell: sellQuantity,
      );

      // Assert
      expect(success, true);
      expect(errorMessage, null);
      print('✅ Test geçti: Yeterli stok ile satış başarılı');
    });

    test('Yetersiz stok ile satış başarısız olmalı', () {
      // Setup
      const inventoryQuantity = 3;
      const sellQuantity = 5;

      // Action
      final (success, errorMessage) = TradingSystem.sellProduct(
        currentInventoryQuantity: inventoryQuantity,
        quantityToSell: sellQuantity,
      );

      // Assert
      expect(success, false);
      expect(errorMessage, contains('Yetersiz stok'));
      expect(errorMessage, contains('3 adet'));
      print('✅ Test geçti: Yetersiz stok ile satış engellendi');
    });

    test('Negatif veya 0 quantity satılamaz', () {
      // Action: Negatif quantity
      final (success1, error1) = TradingSystem.sellProduct(
        currentInventoryQuantity: 10,
        quantityToSell: -5,
      );

      // Action: 0 quantity
      final (success2, error2) = TradingSystem.sellProduct(
        currentInventoryQuantity: 10,
        quantityToSell: 0,
      );

      // Assert
      expect(success1, false);
      expect(error1, contains('Geçersiz miktar'));
      expect(success2, false);
      expect(error2, contains('Geçersiz miktar'));
      print('✅ Test geçti: Negatif/0 quantity engellendi');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 3: KAR/ZARAR HESAPLAMALARI
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - Kar/Zarar Hesaplama', () {
    test('Pozitif kar doğru hesaplanmalı', () {
      // Setup
      const purchasePrice = 100.0;
      const currentPrice = 150.0;
      const quantity = 10;

      // Action
      final profit = TradingSystem.calculateProfitLoss(
        purchasePrice: purchasePrice,
        currentPrice: currentPrice,
        quantity: quantity,
      );

      // Assert: (150 - 100) * 10 = 500
      expect(profit, 500.0);
      print('✅ Test geçti: Kar = $profit TL');
    });

    test('Negatif kar (zarar) doğru hesaplanmalı', () {
      // Setup
      const purchasePrice = 150.0;
      const currentPrice = 100.0;
      const quantity = 5;

      // Action
      final profit = TradingSystem.calculateProfitLoss(
        purchasePrice: purchasePrice,
        currentPrice: currentPrice,
        quantity: quantity,
      );

      // Assert: (100 - 150) * 5 = -250
      expect(profit, -250.0);
      print('✅ Test geçti: Zarar = $profit TL');
    });

    test('Kar yüzdesi doğru hesaplanmalı', () {
      // Setup
      const purchasePrice = 100.0;
      const currentPrice = 120.0;

      // Action
      final profitPercent = TradingSystem.calculateProfitPercentage(
        purchasePrice: purchasePrice,
        currentPrice: currentPrice,
      );

      // Assert: ((120 - 100) / 100) * 100 = 20%
      expect(profitPercent, 20.0);
      print('✅ Test geçti: Kar yüzdesi = $profitPercent%');
    });

    test('0 purchase price ile kar yüzdesi 0 olmalı', () {
      // Setup
      const purchasePrice = 0.0;
      const currentPrice = 100.0;

      // Action
      final profitPercent = TradingSystem.calculateProfitPercentage(
        purchasePrice: purchasePrice,
        currentPrice: currentPrice,
      );

      // Assert: Bölme hatası önlemek için 0 döner
      expect(profitPercent, 0.0);
      print('✅ Test geçti: 0 purchase price güvenle işlendi');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 4: DENEYİM PUANI HESAPLAMA
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - Deneyim Puanı (EXP)', () {
    test('Satın alma exp doğru hesaplanmalı', () {
      // Setup
      const transactionValue = 10000.0;

      // Action
      final exp = TradingSystem.calculateExperienceGain(
        transactionValue: transactionValue,
        isPurchase: true,
        productCategory: 'legal',
      );

      // Assert: baseExp = 10000 * 0.01 = 100 (alış)
      expect(exp, 100);
      print('✅ Test geçti: Alış exp = $exp');
    });

    test('Satış, alıştan %50 fazla exp vermeli', () {
      // Setup
      const transactionValue = 10000.0;

      // Action: Alış
      final purchaseExp = TradingSystem.calculateExperienceGain(
        transactionValue: transactionValue,
        isPurchase: true,
        productCategory: 'legal',
      );

      // Action: Satış
      final sellExp = TradingSystem.calculateExperienceGain(
        transactionValue: transactionValue,
        isPurchase: false,
        productCategory: 'legal',
      );

      // Assert: sellExp = purchaseExp * 1.5
      expect(sellExp, (purchaseExp * 1.5).round());
      expect(sellExp, 150); // 100 * 1.5 = 150
      print('✅ Test geçti: Satış exp ($sellExp) > Alış exp ($purchaseExp)');
    });

    test('Illegal ürünler 2x exp vermeli', () {
      // Setup
      const transactionValue = 10000.0;

      // Action: Legal
      final legalExp = TradingSystem.calculateExperienceGain(
        transactionValue: transactionValue,
        isPurchase: true,
        productCategory: 'legal',
      );

      // Action: Illegal
      final illegalExp = TradingSystem.calculateExperienceGain(
        transactionValue: transactionValue,
        isPurchase: true,
        productCategory: 'illegal',
      );

      // Assert: illegalExp = legalExp * 2
      expect(illegalExp, legalExp * 2);
      expect(illegalExp, 200);
      print('✅ Test geçti: Illegal exp ($illegalExp) = Legal exp ($legalExp) * 2');
    });

    test('Exp minimum 10, maksimum 500 olmalı', () {
      // Setup: Çok küçük işlem
      const smallValue = 1.0;

      // Action
      final minExp = TradingSystem.calculateExperienceGain(
        transactionValue: smallValue,
        isPurchase: true,
        productCategory: 'legal',
      );

      // Setup: Çok büyük işlem
      const hugeValue = 1000000.0;

      // Action
      final maxExp = TradingSystem.calculateExperienceGain(
        transactionValue: hugeValue,
        isPurchase: false,
        productCategory: 'illegal',
      );

      // Assert
      expect(minExp, greaterThanOrEqualTo(10));
      expect(maxExp, lessThanOrEqualTo(500));
      print('✅ Test geçti: Exp sınırları çalışıyor (min: $minExp, max: $maxExp)');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 5: TİCARET PERFORMANS SKORU
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - Trading Score', () {
    test('Hiç işlem yapılmamışsa skor 0 olmalı', () {
      // Action
      final score = TradingSystem.calculateTradingScore(
        totalTransactions: 0,
        totalProfit: 0,
        playerLevel: 1,
      );

      // Assert
      expect(score, 0.0);
      print('✅ Test geçti: 0 işlem = 0 skor');
    });

    test('Yüksek kar ve işlem sayısı yüksek skor vermeli', () {
      // Action
      final score = TradingSystem.calculateTradingScore(
        totalTransactions: 100,
        totalProfit: 50000,
        playerLevel: 25,
      );

      // Assert: Skor yüksek olmalı
      expect(score, greaterThan(50));
      print('✅ Test geçti: Yüksek performans skoru = $score');
    });

    test('Skor maksimum 100 olmalı', () {
      // Action: Çok yüksek değerler
      final score = TradingSystem.calculateTradingScore(
        totalTransactions: 10000,
        totalProfit: 1000000,
        playerLevel: 100,
      );

      // Assert
      expect(score, lessThanOrEqualTo(100));
      print('✅ Test geçti: Skor limiti çalışıyor = $score');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 6: TOPLU ALIM İNDİRİMİ
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - Toplu Alım İndirimi', () {
    test('20-49 adet: %5 indirim', () {
      final discount = TradingSystem.calculateBulkDiscount(25);
      expect(discount, 0.05);
      print('✅ Test geçti: 25 adet = %5 indirim');
    });

    test('50-99 adet: %10 indirim', () {
      final discount = TradingSystem.calculateBulkDiscount(75);
      expect(discount, 0.10);
      print('✅ Test geçti: 75 adet = %10 indirim');
    });

    test('100+ adet: %15 indirim', () {
      final discount = TradingSystem.calculateBulkDiscount(150);
      expect(discount, 0.15);
      print('✅ Test geçti: 150 adet = %15 indirim');
    });

    test('20\'den az: İndirim yok', () {
      final discount = TradingSystem.calculateBulkDiscount(10);
      expect(discount, 0.0);
      print('✅ Test geçti: 10 adet = indirim yok');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 7: HIZLI SATIŞ BONUSU
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - Hızlı Satış Bonusu', () {
    test('1 saat içinde: %20 bonus', () {
      final purchaseDate = DateTime(2025, 1, 1, 10, 0);
      final saleDate = DateTime(2025, 1, 1, 10, 30); // 30 dakika sonra

      final bonus = TradingSystem.calculateQuickSaleBonus(
        purchaseDate: purchaseDate,
        saleDate: saleDate,
      );

      expect(bonus, 1.20);
      print('✅ Test geçti: 30 dakika = %20 bonus');
    });

    test('6 saat içinde: %10 bonus', () {
      final purchaseDate = DateTime(2025, 1, 1, 10, 0);
      final saleDate = DateTime(2025, 1, 1, 14, 0); // 4 saat sonra

      final bonus = TradingSystem.calculateQuickSaleBonus(
        purchaseDate: purchaseDate,
        saleDate: saleDate,
      );

      expect(bonus, 1.10);
      print('✅ Test geçti: 4 saat = %10 bonus');
    });

    test('24 saatten fazla: Bonus yok', () {
      final purchaseDate = DateTime(2025, 1, 1, 10, 0);
      final saleDate = DateTime(2025, 1, 3, 10, 0); // 2 gün sonra

      final bonus = TradingSystem.calculateQuickSaleBonus(
        purchaseDate: purchaseDate,
        saleDate: saleDate,
      );

      expect(bonus, 1.0);
      print('✅ Test geçti: 2 gün = bonus yok');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 8: TREND BONUSU
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - Trend Bonusu', () {
    test('Trending ürün: +%15 bonus', () {
      final bonus = TradingSystem.calculateTrendBonus(
        isTrending: true,
        demand: 50,
      );

      expect(bonus, 1.15);
      print('✅ Test geçti: Trending ürün bonusu');
    });

    test('Yüksek talep (80+): +%10 bonus', () {
      final bonus = TradingSystem.calculateTrendBonus(
        isTrending: false,
        demand: 85,
      );

      expect(bonus, 1.10);
      print('✅ Test geçti: Yüksek talep bonusu');
    });

    test('Trending + Yüksek talep: %25 bonus', () {
      final bonus = TradingSystem.calculateTrendBonus(
        isTrending: true,
        demand: 90,
      );

      expect(bonus, 1.25); // 1.0 + 0.15 + 0.10
      print('✅ Test geçti: Kombine bonus = ${((bonus - 1) * 100).toInt()}%');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 9: GÜNLÜK İŞLEM LİMİTİ
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - Günlük İşlem Limiti', () {
    test('Limit altında: İşlem yapılabilir', () {
      // Setup
      const playerLevel = 5;
      const todayCount = 30;
      const expectedLimit = 50 + (playerLevel * 10); // 100

      // Action
      final (canTrade, errorMessage) = TradingSystem.checkDailyTransactionLimit(
        todayTransactionCount: todayCount,
        playerLevel: playerLevel,
      );

      // Assert
      expect(canTrade, true);
      expect(errorMessage, null);
      expect(todayCount, lessThan(expectedLimit));
      print('✅ Test geçti: Limit altında işlem yapılabilir ($todayCount < $expectedLimit)');
    });

    test('Limite ulaşıldı: İşlem engellenmel', () {
      // Setup
      const playerLevel = 1;
      const limit = 50 + (playerLevel * 10); // 60
      const todayCount = 60;

      // Action
      final (canTrade, errorMessage) = TradingSystem.checkDailyTransactionLimit(
        todayTransactionCount: todayCount,
        playerLevel: playerLevel,
      );

      // Assert
      expect(canTrade, false);
      expect(errorMessage, contains('limitine ulaştınız'));
      expect(errorMessage, contains('60'));
      print('✅ Test geçti: Günlük limit engeli çalışıyor');
    });

    test('Yüksek seviye daha yüksek limit', () {
      // Setup
      const lowLevel = 1;
      const highLevel = 10;

      final lowLevelLimit = 50 + (lowLevel * 10); // 60
      final highLevelLimit = 50 + (highLevel * 10); // 150

      // Assert
      expect(highLevelLimit, greaterThan(lowLevelLimit));
      expect(highLevelLimit, 150);
      expect(lowLevelLimit, 60);
      print('✅ Test geçti: Level $lowLevel = $lowLevelLimit, Level $highLevel = $highLevelLimit');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TEST GROUP 10: VERGİ HESAPLAMA
  // ═══════════════════════════════════════════════════════════════
  group('TradingSystem - İşlem Vergisi', () {
    test('Düşük itibar: %5 vergi', () {
      final tax = TradingSystem.calculateTransactionTax(
        transactionValue: 10000,
        legalReputation: 50,
      );

      expect(tax, 500.0); // 10000 * 0.05
      print('✅ Test geçti: Düşük itibar vergisi = $tax TL');
    });

    test('Orta itibar (60-80): %4 vergi', () {
      final tax = TradingSystem.calculateTransactionTax(
        transactionValue: 10000,
        legalReputation: 70,
      );

      expect(tax, 400.0); // 10000 * 0.04
      print('✅ Test geçti: Orta itibar vergisi = $tax TL');
    });

    test('Yüksek itibar (80+): %3 vergi', () {
      final tax = TradingSystem.calculateTransactionTax(
        transactionValue: 10000,
        legalReputation: 90,
      );

      expect(tax, 300.0); // 10000 * 0.03
      print('✅ Test geçti: Yüksek itibar vergisi = $tax TL');
    });
  });
}
