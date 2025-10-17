import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/product.dart';
import '../../services/api_service.dart';

part 'market_provider.g.dart';

@riverpod
class MarketNotifier extends _$MarketNotifier {
  @override
  List<Product> build() {
    // Backend'den ürünleri yükle
    loadProducts();
    return [];
  }

  /// Backend'den ürünleri yükle
  Future<void> loadProducts() async {
    try {
      final apiService = ApiService();
      final productsData = await apiService.getMarketProducts();

      final products = productsData.map((data) {
        return Product(
          id: data['_id'] ?? '',
          name: data['name'] ?? '',
          emoji: data['emoji'] ?? '📦',
          basePrice: (data['basePrice'] ?? 0).toDouble(),
          currentPrice: (data['currentPrice'] ?? 0).toDouble(),
          demand: (data['demand'] ?? 50).toInt(),
          volatility: (data['volatility'] ?? 0.1).toDouble(),
          isTrending: data['trending'] ?? false,
        );
      }).toList();

      state = products;
    } catch (e) {
      print('Error loading products: $e');
      // Hata durumunda boş liste
      state = [];
    }
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
