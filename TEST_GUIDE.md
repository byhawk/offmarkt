# 🧪 Flutter Test Yazımı - Kapsamlı Rehber

## Test Nedir?

**Test**, yazdığınız kodun doğru çalıştığını otomatik olarak kontrol eden koddur.

### Günlük Hayattan Örnek

Bir araba üretiyorsunuz:
- ❌ **Testsiz**: Arabayı üretip müşteriye veriyorsunuz. Fren çalışmıyorsa kaza!
- ✅ **Testli**: Arabayı ürettikten sonra frenleri, motoru, direksiyonu test ediyorsunuz. Sorun varsa müşteriye vermeden düzeltiyorsunuz.

### Yazılımda Test

```dart
// ❌ TESTSIZ KOD - Risk yüksek
double calculateProfit(double sellPrice, double buyPrice) {
  return sellPrice - buyPrice;
}
// Kod çalışıyor mu? Negatif sayılar gelirse ne olur? Bilmiyoruz!

// ✅ TESTLİ KOD - Güvenli
double calculateProfit(double sellPrice, double buyPrice) {
  return sellPrice - buyPrice;
}

// TEST: Kodun doğru çalıştığını garanti eder
void main() {
  test('kar hesaplama doğru çalışmalı', () {
    expect(calculateProfit(100, 80), 20);  // ✅ PASS
    expect(calculateProfit(50, 100), -50); // ✅ PASS (zarar)
  });
}
```

---

## Neden Test Yazmalıyız?

### 1. **Bug'ları Erkenden Yakala**

```dart
// Kod yazdık
class TradingSystem {
  bool canBuy(Player player, Product product, int quantity) {
    return player.cash >= product.price;  // ❌ BUG: quantity unutulmuş!
  }
}

// Manuel test: Her seferinde uygulamayı açıp denememiz gerekir (5 dakika)
// Otomatik test: 1 saniyede hatayı yakalar!

test('quantity ile fiyat çarpılmalı', () {
  final player = Player(cash: 100);
  final product = Product(price: 10);

  final result = TradingSystem.canBuy(player, product, 20);

  // Beklenen: false (100 < 200)
  // Gerçek: true (100 >= 10) ← BUG YAKALANDI!
  expect(result, false); // ❌ FAIL - Bug tespit edildi!
});
```

### 2. **Refactoring Güvenliği**

Kodu değiştirdiğinizde hiçbir şeyi bozmadığınızdan emin olursunuz:

```dart
// Eski kod
double calculateTotal(List<Product> products) {
  double total = 0;
  for (var product in products) {
    total += product.price;
  }
  return total;
}

// Yeni kod (daha kısa)
double calculateTotal(List<Product> products) {
  return products.fold(0, (sum, product) => sum + product.price);
}

// Test zaten yazılı - çalıştır ve doğrula
test('toplam fiyat doğru hesaplanmalı', () {
  final products = [
    Product(price: 10),
    Product(price: 20),
    Product(price: 30),
  ];

  expect(calculateTotal(products), 60); // ✅ PASS - Refactoring güvenli!
});
```

### 3. **Dokümantasyon Olarak Kullanım**

Test, kodunuzun nasıl kullanılacağını gösterir:

```dart
// TradingSystem nasıl kullanılır? Test'e bak!
test('ticaret sistemi kullanım örneği', () {
  // 1. Setup
  final player = Player(cash: 1000, inventory: []);
  final product = Product(name: 'iPhone', price: 500);

  // 2. Action
  final result = TradingSystem.buy(player, product, quantity: 2);

  // 3. Assert
  expect(result.success, true);
  expect(player.cash, 0);  // 1000 - (500 * 2) = 0
  expect(player.inventory.length, 1);
  expect(player.inventory.first.quantity, 2);
});
```

### 4. **Zaman Tasarrufu**

**Manuel Test** (Her kod değişikliğinde):
1. Uygulamayı çalıştır (30 saniye)
2. Login yap (10 saniye)
3. Market'e git (5 saniye)
4. Ürün seç (5 saniye)
5. Satın al butonu (5 saniye)
6. Sonucu kontrol et (5 saniye)
**Toplam**: ~1 dakika

**Otomatik Test**:
```bash
flutter test
# Running 50 tests...
# All tests passed! (2.5s)
```
**Toplam**: 2.5 saniye (24x daha hızlı!)

---

## Flutter'da 3 Tür Test

### 1. Unit Test (Birim Test) - En Hızlı ⚡

**Ne test eder?**: Tek bir fonksiyon/class
**Hız**: Çok hızlı (milisaniyeler)
**Kullanım**: Business logic, hesaplamalar

**Örnek**:
```dart
// lib/game/systems/trading_system.dart
class TradingSystem {
  static double calculateProfit(double sellPrice, double buyPrice, int quantity) {
    return (sellPrice - buyPrice) * quantity;
  }
}

// test/game/trading_system_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/game/systems/trading_system.dart';

void main() {
  group('TradingSystem', () {
    test('kar hesaplama - pozitif', () {
      final profit = TradingSystem.calculateProfit(100, 80, 5);
      expect(profit, 100); // (100-80) * 5 = 100
    });

    test('kar hesaplama - zarar', () {
      final profit = TradingSystem.calculateProfit(50, 100, 2);
      expect(profit, -100); // (50-100) * 2 = -100
    });

    test('kar hesaplama - başabaş', () {
      final profit = TradingSystem.calculateProfit(100, 100, 10);
      expect(profit, 0);
    });
  });
}
```

**Çalıştırma**:
```bash
flutter test test/game/trading_system_test.dart
# 3 tests passed (150ms)
```

---

### 2. Widget Test - Orta Hızlı 🎨

**Ne test eder?**: UI component'leri
**Hız**: Orta (saniyeler)
**Kullanım**: Button'lar, form'lar, ekran elementleri

**Örnek**:
```dart
// lib/presentation/widgets/common/stat_card.dart
class StatCard extends StatelessWidget {
  final String label;
  final String value;

  const StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(label),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// test/widgets/stat_card_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:deal_baron/presentation/widgets/common/stat_card.dart';

void main() {
  testWidgets('StatCard doğru gösterilmeli', (WidgetTester tester) async {
    // Widget'ı build et
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatCard(label: 'Para', value: '1,000 TL'),
        ),
      ),
    );

    // Widget'ların var olduğunu doğrula
    expect(find.text('Para'), findsOneWidget);
    expect(find.text('1,000 TL'), findsOneWidget);

    // Stil kontrolü
    final valueText = tester.widget<Text>(find.text('1,000 TL'));
    expect(valueText.style?.fontSize, 24);
    expect(valueText.style?.fontWeight, FontWeight.bold);
  });

  testWidgets('StatCard button tıklanabilmeli', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GestureDetector(
            onTap: () => tapped = true,
            child: StatCard(label: 'Tıkla', value: '123'),
          ),
        ),
      ),
    );

    // Widget'a tıkla
    await tester.tap(find.text('123'));
    await tester.pump();

    // Tıklama doğrulaması
    expect(tapped, true);
  });
}
```

**Çalıştırma**:
```bash
flutter test test/widgets/stat_card_test.dart
# 2 tests passed (1.2s)
```

---

### 3. Integration Test - En Yavaş 🐢

**Ne test eder?**: Tüm uygulama akışı
**Hız**: Yavaş (dakikalar)
**Kullanım**: Login flow, alım-satım süreci, navigasyon

**Örnek**:
```dart
// integration_test/auth_flow_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:deal_baron/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login → Ana Sayfa → Market → Satın Alma akışı', (WidgetTester tester) async {
    // Uygulamayı başlat
    app.main();
    await tester.pumpAndSettle();

    // 1. Login ekranı
    expect(find.text('Giriş Yap'), findsOneWidget);

    await tester.enterText(find.byKey(Key('email_field')), 'test@example.com');
    await tester.enterText(find.byKey(Key('password_field')), 'password123');
    await tester.tap(find.text('Giriş Yap'));
    await tester.pumpAndSettle();

    // 2. Ana sayfa gösterilmeli
    expect(find.text('Hoşgeldin'), findsOneWidget);

    // 3. Market'e git
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    // 4. Ürün seç
    await tester.tap(find.text('iPhone'));
    await tester.pumpAndSettle();

    // 5. Satın al
    await tester.enterText(find.byKey(Key('quantity_field')), '2');
    await tester.tap(find.text('Satın Al'));
    await tester.pumpAndSettle();

    // 6. Başarı mesajı
    expect(find.text('Satın alım başarılı'), findsOneWidget);

    // 7. Inventory'de ürün var mı?
    await tester.tap(find.byIcon(Icons.inventory));
    await tester.pumpAndSettle();
    expect(find.text('iPhone'), findsOneWidget);
    expect(find.text('2 adet'), findsOneWidget);
  });
}
```

**Çalıştırma**:
```bash
flutter test integration_test/auth_flow_test.dart
# 1 test passed (45s)
```

---

## Deal Baron İçin Pratik Test Örnekleri

### Örnek 1: Level System Testi

```dart
// test/game/level_system_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/game/systems/level_system.dart';
import 'package:deal_baron/data/models/player.dart';

void main() {
  group('LevelSystem', () {
    test('level 1 → 2 için 100 exp gerekir', () {
      final player = Player(level: 1, experience: 0);
      final requiredExp = LevelSystem.getRequiredExp(player.level);

      expect(requiredExp, 100);
    });

    test('yeterli exp varsa level atlar', () {
      final player = Player(level: 1, experience: 100);
      final canLevelUp = LevelSystem.canLevelUp(player);

      expect(canLevelUp, true);
    });

    test('exp yetersizse level atlamaz', () {
      final player = Player(level: 1, experience: 50);
      final canLevelUp = LevelSystem.canLevelUp(player);

      expect(canLevelUp, false);
    });

    test('level atlayınca bonus para verir', () {
      final player = Player(level: 1, experience: 150, cash: 1000);
      final updatedPlayer = LevelSystem.levelUp(player);

      expect(updatedPlayer.level, 2);
      expect(updatedPlayer.cash, greaterThan(1000)); // Bonus aldı
      expect(updatedPlayer.experience, 50); // Kalan exp: 150 - 100 = 50
    });
  });
}
```

### Örnek 2: Shop System Testi

```dart
// test/game/shop_system_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/game/systems/shop_system.dart';

void main() {
  group('ShopSystem', () {
    test('yeterli para varsa dükkan kiralaması başarılı', () {
      final player = Player(cash: 10000);
      final shop = Shop(rentalPrice: 5000);

      final result = ShopSystem.rentShop(player, shop);

      expect(result.success, true);
      expect(result.player.cash, 5000);
      expect(result.player.ownedShops.length, 1);
    });

    test('yetersiz para varsa kiralama başarısız', () {
      final player = Player(cash: 1000);
      final shop = Shop(rentalPrice: 5000);

      final result = ShopSystem.rentShop(player, shop);

      expect(result.success, false);
      expect(result.error, 'Yetersiz bakiye');
      expect(result.player.cash, 1000); // Para azalmadı
    });

    test('lokasyon çarpanı doğru hesaplanmalı', () {
      expect(ShopSystem.getLocationMultiplier('Mall'), 1.5);
      expect(ShopSystem.getLocationMultiplier('Market'), 1.3);
      expect(ShopSystem.getLocationMultiplier('Street'), 1.0);
      expect(ShopSystem.getLocationMultiplier('Warehouse'), 0.8);
    });
  });
}
```

### Örnek 3: Login Screen Widget Testi

```dart
// test/widgets/login_screen_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:deal_baron/presentation/screens/auth/login_screen.dart';

void main() {
  testWidgets('Login ekranı elementleri gösterilmeli', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen()),
    );

    // UI elementleri var mı?
    expect(find.text('Deal Baron'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // Email + Şifre
    expect(find.text('Giriş Yap'), findsOneWidget);
    expect(find.text('Kayıt Ol'), findsOneWidget);
  });

  testWidgets('Boş email ile login yapılamaz', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen()),
    );

    // Sadece şifre gir
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.text('Giriş Yap'));
    await tester.pump();

    // Hata mesajı gösterilmeli
    expect(find.text('Email boş olamaz'), findsOneWidget);
  });

  testWidgets('Email formatı kontrolü', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen()),
    );

    // Geçersiz email
    await tester.enterText(find.byType(TextField).at(0), 'invalid-email');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.text('Giriş Yap'));
    await tester.pump();

    // Hata mesajı
    expect(find.text('Geçersiz email formatı'), findsOneWidget);
  });
}
```

---

## Test Yazma Adımları (Pratik)

### Adım 1: Test Dosyası Oluştur

```bash
# Game system testi için
mkdir -p test/game
touch test/game/trading_system_test.dart

# Widget testi için
mkdir -p test/widgets
touch test/widgets/stat_card_test.dart
```

### Adım 2: Import'ları Ekle

```dart
import 'package:flutter_test/flutter_test.dart';  // Test framework
import 'package:deal_baron/game/systems/trading_system.dart';  // Test edilecek kod
```

### Adım 3: Test Yaz

```dart
void main() {
  test('test açıklaması', () {
    // 1. Setup: Test verilerini hazırla
    final player = Player(cash: 1000);

    // 2. Action: Test edilecek kodu çalıştır
    final result = TradingSystem.buy(player, product, 5);

    // 3. Assert: Sonucu doğrula
    expect(result.success, true);
  });
}
```

### Adım 4: Çalıştır

```bash
flutter test test/game/trading_system_test.dart
```

---

## Test Komutları

```bash
# Tüm testleri çalıştır
flutter test

# Belirli bir test dosyası
flutter test test/game/trading_system_test.dart

# Test coverage (hangi kodlar test edilmiş?)
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Sadece belirli bir test
flutter test --plain-name "kar hesaplama"

# Watch mode (kod değişince otomatik test)
flutter test --watch
```

---

## Gerçek Senaryolar

### Senaryo 1: Bug Bulma

**Durum**: Kullanıcı şikayet ediyor: "Negatif ürün alabildim!"

**Manuel Test**:
- Uygulamayı aç
- Login ol
- Market'e git
- -5 adet girmeyi dene
- Bug'ı gör

**Otomatik Test**:
```dart
test('negatif quantity ile satın alınamaz', () {
  final player = Player(cash: 1000);
  final product = Product(price: 100);

  final result = TradingSystem.buy(player, product, -5);

  expect(result.success, false);
  expect(result.error, 'Quantity pozitif olmalı');
});
```

**Sonuç**: Test FAIL eder → Bug bulundu → Kod düzelt → Test PASS → Problem çözüldü!

### Senaryo 2: Refactoring Güvenliği

**Durum**: Kod çok karmaşık, temizlemek istiyorsun ama bir şey bozmaktan korkuyorsun.

```dart
// Eski kod (karmaşık)
double calculateTotal(List<Product> products, bool applyDiscount, double discountRate) {
  double total = 0;
  for (var product in products) {
    double price = product.price;
    if (applyDiscount) {
      price = price - (price * discountRate);
    }
    total += price;
  }
  return total;
}

// Test yaz
test('toplam hesaplama - indirimli', () {
  final products = [Product(price: 100), Product(price: 200)];
  expect(calculateTotal(products, true, 0.1), 270); // %10 indirim
});

// Yeni kod (temiz)
double calculateTotal(List<Product> products, bool applyDiscount, double discountRate) {
  return products
      .map((p) => applyDiscount ? p.price * (1 - discountRate) : p.price)
      .fold(0, (sum, price) => sum + price);
}

// Test çalıştır
flutter test
# ✅ PASS - Refactoring güvenli!
```

---

## En Sık Kullanılan Test Assertion'ları

```dart
// Eşitlik
expect(actual, expected);
expect(2 + 2, 4);

// Boolean
expect(player.isActive, true);
expect(player.isBanned, false);

// Null kontrolü
expect(player.name, isNotNull);
expect(player.shop, isNull);

// Sayı karşılaştırma
expect(player.cash, greaterThan(0));
expect(player.debt, lessThan(1000));
expect(player.level, greaterThanOrEqualTo(1));

// String kontrolü
expect(player.name, contains('Baron'));
expect(player.email, startsWith('user@'));
expect(player.email, endsWith('@example.com'));

// Liste kontrolü
expect(player.inventory, isEmpty);
expect(player.inventory, isNotEmpty);
expect(player.inventory.length, 5);
expect(player.inventory, contains(product));

// Tip kontrolü
expect(player, isA<Player>());
expect(result, isA<Map<String, dynamic>>());

// Exception kontrolü
expect(() => TradingSystem.buy(null, product, 1), throwsException);
expect(() => divide(10, 0), throwsA(isA<DivisionByZeroException>()));
```

---

## Deal Baron İçin Test Planı

### Phase 1: Game Systems (Öncelik 1)

```bash
test/game/
├── trading_system_test.dart       # 10 test
├── shop_system_test.dart          # 8 test
├── level_system_test.dart         # 6 test
├── loan_system_test.dart          # 7 test
└── event_system_test.dart         # 5 test
```

**Tahmini süre**: 2 gün

### Phase 2: Providers (Öncelik 2)

```bash
test/providers/
├── player_provider_test.dart      # 8 test
├── market_provider_test.dart      # 6 test
└── shops_provider_test.dart       # 5 test
```

**Tahmini süre**: 1 gün

### Phase 3: Widgets (Öncelik 3)

```bash
test/widgets/
├── stat_card_test.dart            # 4 test
├── gradient_card_test.dart        # 3 test
└── employee_card_test.dart        # 5 test
```

**Tahmini süre**: 1 gün

### Phase 4: Screens (Öncelik 4)

```bash
test/screens/
├── login_screen_test.dart         # 6 test
├── market_screen_test.dart        # 8 test
└── inventory_screen_test.dart     # 5 test
```

**Tahmini süre**: 2 gün

**Toplam**: ~60 test, 6 iş günü

---

## Özet: Test Yazımı Neden Önemli?

| Durum | Testsiz | Testli |
|-------|---------|--------|
| **Bug bulma** | Kullanıcı şikayet eder (gün/hafta sonra) | Test fail eder (anında) |
| **Kod değişikliği** | Korku ve panik | Güven ve hız |
| **Yeni geliştirici** | "Bu kod ne yapıyor?" | "Test'e bak, anla" |
| **Production bug** | Kullanıcılar etkilenir | Test catch eder, canlıya çıkmaz |
| **Refactoring** | Risk yüksek | Risk düşük |
| **Manuel test süresi** | Her değişiklikte 5-10 dakika | 2 saniye |

---

## İlk Test'inizi Yazın! 🚀

### Pratik Egzersiz

1. **Dosya oluştur**:
```bash
touch test/game/trading_system_test.dart
```

2. **Test yaz**:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/game/systems/trading_system.dart';

void main() {
  test('ilk test: kar hesaplama', () {
    final profit = TradingSystem.calculateProfit(100, 80, 5);
    expect(profit, 100);
  });
}
```

3. **Çalıştır**:
```bash
flutter test test/game/trading_system_test.dart
```

4. **Sonuç**:
```
00:01 +1: All tests passed!
```

**Tebrikler! İlk test'inizi yazdınız! 🎉**

---

**Sonuç**: Test yazmak, kodunuzun kalite sigortasıdır. Başta zaman alır gibi görünse de, uzun vadede çok fazla zaman ve sinir tasarrufu sağlar!

