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
@Riverpod(keepAlive: true)
class InventoryNotifier extends _$InventoryNotifier {
  @override
  List<InventoryItem> build() {
    // Build sadece ilk kez çalışır, asıl veri loadInventoryFromBackend'den gelecek
    loadInventoryFromBackend();
    return [];
  }

  /// Backend'den inventory yükle
  Future<void> loadInventoryFromBackend() async {
    try {
      final apiService = ApiService();
      final response = await apiService.get('/auth/me');

      if (response.data['success'] == true) {
        final playerData = response.data['data']['player'];
        final inventoryList = playerData['inventory'] as List? ?? [];

        print('📦 Loading inventory from backend: ${inventoryList.length} items');

        state = inventoryList.map((item) {
          final productId = item['productId']?.toString() ?? '';
          final quantity = item['quantity'] ?? 0;
          print('  - ProductID: $productId, Quantity: $quantity');

          return InventoryItem(
            productId: productId,
            quantity: quantity,
            purchasePrice: (item['purchasePrice'] ?? 0).toDouble(),
            source: item['source'] ?? 'market',
            purchaseDate: item['purchaseDate'] != null
                ? DateTime.parse(item['purchaseDate'])
                : DateTime.now(),
          );
        }).toList();

        print('✅ Inventory loaded: ${state.length} items in state');
      }
    } catch (e) {
      print('❌ Error loading inventory: $e');
    }
  }

  /// Envantere ürün ekle (artık kullanılmıyor - backend'e gidiyor)
  void addItem(InventoryItem item) {
    state = [...state, item];
  }

  /// Envanterden ürün çıkar (artık kullanılmıyor - backend'e gidiyor)
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
