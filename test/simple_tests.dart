import 'package:flutter_test/flutter_test.dart';

/// 5 Basit Test Örneği - Deal Baron
///
/// Bu dosya 5 farklı test örneği içerir:
/// 1. Basit matematik testi
/// 2. String işlemleri testi
/// 3. Liste işlemleri testi
/// 4. Nesne eşitlik testi
/// 5. Hesaplama fonksiyon testi

void main() {
  // ============================================
  // TEST 1: Kar Hesaplama (Basit Matematik)
  // ============================================
  group('Test 1: Kar Hesaplama', () {
    test('Pozitif kar hesaplanır', () {
      // Setup: Alış ve satış fiyatları
      double buyPrice = 100.0;
      double sellPrice = 150.0;
      int quantity = 10;

      // Action: Kar hesapla
      double profit = (sellPrice - buyPrice) * quantity;

      // Assert: Kar doğru hesaplanmış mı?
      expect(profit, 500.0); // (150 - 100) * 10 = 500
      print('✅ Test 1 geçti: Kar = $profit TL');
    });

    test('Zarar hesaplanır', () {
      // Setup
      double buyPrice = 150.0;
      double sellPrice = 100.0;
      int quantity = 5;

      // Action
      double profit = (sellPrice - buyPrice) * quantity;

      // Assert: Zarar (negatif kar) doğru
      expect(profit, -250.0); // (100 - 150) * 5 = -250
      print('✅ Test 1 geçti: Zarar = $profit TL');
    });

    test('Başabaş durumu', () {
      // Setup
      double buyPrice = 200.0;
      double sellPrice = 200.0;
      int quantity = 100;

      // Action
      double profit = (sellPrice - buyPrice) * quantity;

      // Assert: Kar 0 olmalı
      expect(profit, 0.0);
      print('✅ Test 1 geçti: Başabaş = $profit TL');
    });
  });

  // ============================================
  // TEST 2: Seviye Sistemi (Exp Hesaplama)
  // ============================================
  group('Test 2: Level System - Exp Hesaplama', () {
    test('Level 1 için 100 exp gerekir', () {
      // Setup
      int level = 1;

      // Action: Gereken exp (formül: level * 100)
      int requiredExp = level * 100;

      // Assert
      expect(requiredExp, 100);
      print('✅ Test 2 geçti: Level $level için $requiredExp exp gerekli');
    });

    test('Oyuncu level atlayabilir mi?', () {
      // Setup: Oyuncu bilgileri
      int playerLevel = 1;
      int playerExp = 150;
      int requiredExp = playerLevel * 100; // 100

      // Action: Level atlayabilir mi?
      bool canLevelUp = playerExp >= requiredExp;

      // Assert: Evet, atlayabilir
      expect(canLevelUp, true);
      expect(playerExp >= requiredExp, true);
      print('✅ Test 2 geçti: Oyuncu level atlayabilir (Exp: $playerExp >= $requiredExp)');
    });

    test('Oyuncu level atlayamaz (yetersiz exp)', () {
      // Setup
      int playerLevel = 2;
      int playerExp = 150;
      int requiredExp = playerLevel * 100; // 200

      // Action
      bool canLevelUp = playerExp >= requiredExp;

      // Assert: Hayır, atlayamaz
      expect(canLevelUp, false);
      print('✅ Test 2 geçti: Oyuncu level atlayamaz (Exp: $playerExp < $requiredExp)');
    });
  });

  // ============================================
  // TEST 3: Dükkan Sistemi (Çarpanlar)
  // ============================================
  group('Test 3: Shop System - Lokasyon Çarpanları', () {
    test('Mall lokasyonu en yüksek çarpana sahip', () {
      // Setup: Lokasyon çarpanları
      Map<String, double> locationMultipliers = {
        'Mall': 1.5,
        'Market': 1.3,
        'Street': 1.0,
        'Warehouse': 0.8,
      };

      // Assert: Mall en yüksek
      expect(locationMultipliers['Mall'], 1.5);
      expect(locationMultipliers['Mall']! > locationMultipliers['Market']!, true);
      expect(locationMultipliers['Mall']! > locationMultipliers['Street']!, true);
      print('✅ Test 3 geçti: Mall çarpanı = ${locationMultipliers['Mall']}');
    });

    test('Gelir tahmini doğru hesaplanır', () {
      // Setup
      double baseRent = 5000.0;
      double locationMultiplier = 1.5; // Mall
      double categoryMultiplier = 1.4; // Restaurant

      // Action: Tahmini aylık gelir
      double estimatedRevenue = baseRent * locationMultiplier * categoryMultiplier;

      // Assert: 5000 * 1.5 * 1.4 = 10,500
      expect(estimatedRevenue, 10500.0);
      print('✅ Test 3 geçti: Tahmini gelir = $estimatedRevenue TL');
    });

    test('Kar marjı hesaplama', () {
      // Setup
      double revenue = 15000.0;
      double rent = 5000.0;
      double expenses = 3000.0;

      // Action
      double profit = revenue - rent - expenses;
      double profitMargin = (profit / revenue) * 100;

      // Assert
      expect(profit, 7000.0);
      expect(profitMargin.round(), 47); // %46.67 ≈ 47
      print('✅ Test 3 geçti: Kar marjı = ${profitMargin.toStringAsFixed(2)}%');
    });
  });

  // ============================================
  // TEST 4: Para Yeterliliği Kontrolü
  // ============================================
  group('Test 4: Satın Alma - Para Kontrolü', () {
    test('Yeterli para varsa satın alınabilir', () {
      // Setup: Oyuncu parası
      double playerCash = 10000.0;
      double productPrice = 500.0;
      int quantity = 10;
      double totalCost = productPrice * quantity; // 5000

      // Action: Para yeterli mi?
      bool canAfford = playerCash >= totalCost;

      // Assert: Evet, alabilir
      expect(canAfford, true);
      expect(playerCash, greaterThanOrEqualTo(totalCost));
      print('✅ Test 4 geçti: Para yeterli ($playerCash >= $totalCost)');
    });

    test('Yetersiz para varsa satın alınamaz', () {
      // Setup
      double playerCash = 1000.0;
      double productPrice = 500.0;
      int quantity = 10;
      double totalCost = productPrice * quantity; // 5000

      // Action
      bool canAfford = playerCash >= totalCost;

      // Assert: Hayır, alamaz
      expect(canAfford, false);
      expect(playerCash, lessThan(totalCost));
      print('✅ Test 4 geçti: Para yetersiz ($playerCash < $totalCost)');
    });

    test('Satın alma sonrası kalan para', () {
      // Setup
      double playerCash = 10000.0;
      double totalCost = 3500.0;

      // Action
      double remainingCash = playerCash - totalCost;

      // Assert
      expect(remainingCash, 6500.0);
      expect(remainingCash > 0, true);
      print('✅ Test 4 geçti: Kalan para = $remainingCash TL');
    });
  });

  // ============================================
  // TEST 5: Fiyat Değişim Yüzdesi
  // ============================================
  group('Test 5: Fiyat Değişim Hesaplama', () {
    test('Fiyat artış yüzdesi hesaplanır', () {
      // Setup
      double oldPrice = 100.0;
      double newPrice = 120.0;

      // Action: Artış yüzdesi
      double changePercent = ((newPrice - oldPrice) / oldPrice) * 100;

      // Assert: %20 artış
      expect(changePercent, 20.0);
      print('✅ Test 5 geçti: Fiyat %$changePercent arttı');
    });

    test('Fiyat düşüş yüzdesi hesaplanır', () {
      // Setup
      double oldPrice = 100.0;
      double newPrice = 80.0;

      // Action
      double changePercent = ((newPrice - oldPrice) / oldPrice) * 100;

      // Assert: -%20 düşüş
      expect(changePercent, -20.0);
      print('✅ Test 5 geçti: Fiyat %${changePercent.abs()} düştü');
    });

    test('İndirim hesaplama', () {
      // Setup
      double originalPrice = 1000.0;
      double discountPercent = 15.0;

      // Action: İndirimli fiyat
      double discountAmount = originalPrice * (discountPercent / 100);
      double finalPrice = originalPrice - discountAmount;

      // Assert
      expect(discountAmount, 150.0);
      expect(finalPrice, 850.0);
      print('✅ Test 5 geçti: %$discountPercent indirim = $finalPrice TL');
    });

    test('Liste işlemleri - ortalama fiyat', () {
      // Setup: Fiyat listesi
      List<double> prices = [100.0, 200.0, 300.0, 400.0, 500.0];

      // Action: Ortalama fiyat
      double average = prices.reduce((a, b) => a + b) / prices.length;

      // Assert
      expect(average, 300.0);
      expect(prices.length, 5);
      print('✅ Test 5 geçti: Ortalama fiyat = $average TL');
    });

    test('En yüksek ve en düşük fiyat', () {
      // Setup
      List<double> prices = [150.0, 200.0, 100.0, 300.0, 250.0];

      // Action
      double maxPrice = prices.reduce((a, b) => a > b ? a : b);
      double minPrice = prices.reduce((a, b) => a < b ? a : b);

      // Assert
      expect(maxPrice, 300.0);
      expect(minPrice, 100.0);
      print('✅ Test 5 geçti: Max = $maxPrice, Min = $minPrice');
    });
  });

  // ============================================
  // BONUS: String İşlemleri
  // ============================================
  group('Bonus: String İşlemleri', () {
    test('Kullanıcı adı formatı kontrolü', () {
      // Setup
      String username = 'DealBaron123';

      // Assert
      expect(username.length, greaterThanOrEqualTo(3));
      expect(username.contains('Baron'), true);
      print('✅ Bonus test geçti: Username = $username');
    });

    test('Email formatı kontrolü', () {
      // Setup
      String email = 'user@dealbaron.com';

      // Assert
      expect(email.contains('@'), true);
      expect(email.split('@').length, 2);
      expect(email.endsWith('.com'), true);
      print('✅ Bonus test geçti: Email = $email');
    });
  });
}
