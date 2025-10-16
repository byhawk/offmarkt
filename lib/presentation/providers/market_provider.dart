import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/product.dart';

part 'market_provider.g.dart';

@riverpod
class MarketNotifier extends _$MarketNotifier {
  @override
  List<Product> build() {
    // Başlangıç ürünleri (React Native'deki products.json'dan basitleştirilmiş)
    return [
      const Product(
        id: 'electronics',
        name: 'Elektronik',
        emoji: '📱',
        basePrice: 1000.0,
        currentPrice: 1000.0,
        demand: 60,
        volatility: 1.2,
        isTrending: true,
      ),
      const Product(
        id: 'clothing',
        name: 'Giyim',
        emoji: '👕',
        basePrice: 500.0,
        currentPrice: 500.0,
        demand: 70,
        volatility: 0.8,
      ),
      const Product(
        id: 'food',
        name: 'Gıda',
        emoji: '🍔',
        basePrice: 200.0,
        currentPrice: 200.0,
        demand: 80,
        volatility: 0.5,
      ),
      const Product(
        id: 'jewelry',
        name: 'Mücevher',
        emoji: '💎',
        basePrice: 5000.0,
        currentPrice: 5000.0,
        demand: 40,
        volatility: 1.5,
      ),
      const Product(
        id: 'vehicles',
        name: 'Araç',
        emoji: '🚗',
        basePrice: 50000.0,
        currentPrice: 50000.0,
        demand: 30,
        volatility: 1.3,
      ),
    ];
  }

  /// Fiyatları güncelle (pazar dinamiği)
  void updatePrices() {
    state = state.map((product) {
      // Basit fiyat değişimi simülasyonu
      final priceChange = (product.volatility * 0.1) - 0.05;
      final newPrice = product.currentPrice * (1 + priceChange);

      return product.copyWith(
        currentPrice: newPrice.clamp(
          product.basePrice * 0.5,
          product.basePrice * 2.0,
        ),
      );
    }).toList();
  }

  /// Ürün ID'sine göre bul
  Product? getProductById(String id) {
    try {
      return state.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}

/// Envanter provider'ı
@riverpod
class InventoryNotifier extends _$InventoryNotifier {
  @override
  List<InventoryItem> build() {
    return [];
  }

  /// Envantere ürün ekle
  void addItem(InventoryItem item) {
    state = [...state, item];
  }

  /// Envanterden ürün çıkar
  void removeItem(String productId, int quantity) {
    final items = [...state];
    items.removeWhere(
      (item) => item.productId == productId && item.quantity <= quantity,
    );
    state = items;
  }

  /// Belirli ürünün toplam miktarını al
  int getQuantity(String productId) {
    return state
        .where((item) => item.productId == productId)
        .fold(0, (sum, item) => sum + item.quantity);
  }
}
