import 'package:flutter_test/flutter_test.dart';
import 'package:deal_baron/data/models/product.dart';

/// Test 5: Product Model - JSON Serialization Testi
/// Bu test, Product modelinin JSON dönüşümlerini doğrular
void main() {
  group('Product Model', () {
    test('Product oluşturulabilir', () {
      // Setup: Product nesnesi oluştur
      final product = Product(
        id: 'product-1',
        name: 'iPhone 15',
        emoji: '📱',
        category: 'legal',
        basePrice: 1000.0,
        currentPrice: 1050.0,
        demand: 75,
        volatility: 0.15,
        isTrending: true,
        seasonalFactor: 1.2,
      );

      // Assert: Değerler doğru atanmış mı?
      expect(product.id, 'product-1');
      expect(product.name, 'iPhone 15');
      expect(product.emoji, '📱');
      expect(product.category, 'legal');
      expect(product.basePrice, 1000.0);
      expect(product.currentPrice, 1050.0);
      expect(product.demand, 75);
      expect(product.volatility, 0.15);
      expect(product.isTrending, true);
      expect(product.seasonalFactor, 1.2);
    });

    test('Product JSON\'dan oluşturulabilir (fromJson)', () {
      // Setup: JSON data
      final json = {
        'id': 'product-2',
        'name': 'Laptop',
        'category': 'Electronics',
        'basePrice': 5000.0,
        'currentPrice': 5200.0,
        'demand': 60.0,
        'volatility': 0.2,
        'description': 'Gaming laptop',
        'minPrice': 4500.0,
        'maxPrice': 6000.0,
        'priceHistory': [5000.0, 5100.0, 5200.0],
        'trending': false,
      };

      // Action: JSON'dan Product oluştur
      final product = Product.fromJson(json);

      // Assert: Değerler doğru parse edilmiş mi?
      expect(product.id, 'product-2');
      expect(product.name, 'Laptop');
      expect(product.currentPrice, 5200.0);
      expect(product.priceHistory.length, 3);
      expect(product.trending, false);
    });

    test('Product JSON\'a dönüştürülebilir (toJson)', () {
      // Setup: Product nesnesi
      final product = Product(
        id: 'product-3',
        name: 'Tablet',
        category: 'Electronics',
        basePrice: 800.0,
        currentPrice: 850.0,
        demand: 50.0,
        volatility: 0.1,
        description: 'iPad Pro',
        minPrice: 700.0,
        maxPrice: 1000.0,
        priceHistory: const [800.0, 825.0, 850.0],
        trending: true,
      );

      // Action: JSON'a dönüştür
      final json = product.toJson();

      // Assert: JSON doğru oluşturulmuş mu?
      expect(json['id'], 'product-3');
      expect(json['name'], 'Tablet');
      expect(json['currentPrice'], 850.0);
      expect(json['priceHistory'], isA<List>());
      expect(json['trending'], true);
    });

    test('Product copyWith ile güncellenebilir', () {
      // Setup: Orijinal product
      final original = Product(
        id: 'product-4',
        name: 'Phone',
        category: 'Electronics',
        basePrice: 500.0,
        currentPrice: 500.0,
        demand: 50.0,
        volatility: 0.1,
        description: 'Basic phone',
        minPrice: 400.0,
        maxPrice: 600.0,
        priceHistory: const [500.0],
        trending: false,
      );

      // Action: Sadece fiyatı güncelle
      final updated = original.copyWith(currentPrice: 550.0);

      // Assert: Sadece fiyat değişmiş, diğerleri aynı
      expect(updated.id, original.id);
      expect(updated.name, original.name);
      expect(updated.currentPrice, 550.0); // Değişti
      expect(original.currentPrice, 500.0); // Orijinal değişmedi (immutable)
    });

    test('Product fiyat yüzdesi hesaplanabilir', () {
      // Setup: İki product - biri indirimli, biri zamlı
      final discountedProduct = Product(
        id: 'product-5',
        name: 'Discounted Item',
        category: 'Sale',
        basePrice: 1000.0,
        currentPrice: 800.0, // %20 indirim
        demand: 80.0,
        volatility: 0.1,
        description: 'On sale',
        minPrice: 500.0,
        maxPrice: 1000.0,
        priceHistory: const [],
        trending: false,
      );

      final expensiveProduct = Product(
        id: 'product-6',
        name: 'Expensive Item',
        category: 'Premium',
        basePrice: 1000.0,
        currentPrice: 1200.0, // %20 zam
        demand: 30.0,
        volatility: 0.1,
        description: 'Price increased',
        minPrice: 1000.0,
        maxPrice: 1500.0,
        priceHistory: const [],
        trending: true,
      );

      // Action: Yüzde hesapla
      final discountPercent =
          ((discountedProduct.currentPrice - discountedProduct.basePrice) / discountedProduct.basePrice) * 100;
      final increasePercent =
          ((expensiveProduct.currentPrice - expensiveProduct.basePrice) / expensiveProduct.basePrice) * 100;

      // Assert: Yüzdeler doğru
      expect(discountPercent, -20.0); // %20 indirim (negatif)
      expect(increasePercent, 20.0); // %20 zam (pozitif)
    });

    test('Product fiyat aralığında mı kontrolü', () {
      // Setup: Product
      final product = Product(
        id: 'product-7',
        name: 'Test Product',
        category: 'Test',
        basePrice: 100.0,
        currentPrice: 120.0,
        demand: 50.0,
        volatility: 0.1,
        description: 'Test',
        minPrice: 80.0,
        maxPrice: 150.0,
        priceHistory: const [],
        trending: false,
      );

      // Assert: Fiyat aralıkta mı?
      expect(product.currentPrice >= product.minPrice, true);
      expect(product.currentPrice <= product.maxPrice, true);

      // Min ve max fiyat doğru mu?
      expect(product.minPrice, 80.0);
      expect(product.maxPrice, 150.0);
      expect(product.minPrice < product.maxPrice, true);
    });

    test('Product priceHistory doğru çalışır', () {
      // Setup: Fiyat geçmişi olan product
      final product = Product(
        id: 'product-8',
        name: 'Historical Product',
        category: 'Test',
        basePrice: 100.0,
        currentPrice: 130.0,
        demand: 50.0,
        volatility: 0.1,
        description: 'Test',
        minPrice: 80.0,
        maxPrice: 150.0,
        priceHistory: const [100.0, 110.0, 120.0, 130.0],
        trending: true,
      );

      // Assert: Geçmiş var mı?
      expect(product.priceHistory.length, 4);
      expect(product.priceHistory.first, 100.0); // İlk fiyat
      expect(product.priceHistory.last, 130.0); // Son fiyat (current price)

      // Fiyat artmış mı?
      expect(product.priceHistory.last > product.priceHistory.first, true);
    });

    test('Product eşitlik kontrolü', () {
      // Setup: İki aynı product
      final product1 = Product(
        id: 'same-id',
        name: 'Product',
        category: 'Test',
        basePrice: 100.0,
        currentPrice: 100.0,
        demand: 50.0,
        volatility: 0.1,
        description: 'Test',
        minPrice: 80.0,
        maxPrice: 120.0,
        priceHistory: const [],
        trending: false,
      );

      final product2 = Product(
        id: 'same-id',
        name: 'Product',
        category: 'Test',
        basePrice: 100.0,
        currentPrice: 100.0,
        demand: 50.0,
        volatility: 0.1,
        description: 'Test',
        minPrice: 80.0,
        maxPrice: 120.0,
        priceHistory: const [],
        trending: false,
      );

      // Assert: Freezed equality (tüm field'lar aynıysa eşit)
      expect(product1, equals(product2));
      expect(product1.hashCode, equals(product2.hashCode));
    });
  });
}
