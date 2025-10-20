import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/shop.dart';
import '../../services/api_service.dart';

part 'shops_provider.g.dart';

final apiService = ApiService();

// Shop Types Provider - Aktif dükkan çeşitleri
@riverpod
class ShopTypesNotifier extends _$ShopTypesNotifier {
  @override
  List<ShopType> build() => [];

  Future<void> loadShopTypes() async {
    try {
      final response = await apiService.get('/player/shop-types');
      if (response.data['success']) {
        state = (response.data['data']['shopTypes'] as List)
            .map((json) => ShopType.fromJson(json))
            .toList();
      }
    } catch (error) {
      // Error handling
      print('Error loading shop types: $error');
    }
  }
}

// Player Shops Provider - Oyuncunun mağazaları
@riverpod
class PlayerShopsNotifier extends _$PlayerShopsNotifier {
  @override
  List<ShopInstance> build() => [];

  Future<void> loadPlayerShops() async {
    try {
      final response = await apiService.get('/player/shops');
      if (response.data['success']) {
        state = (response.data['data']['shops'] as List)
            .map((json) => ShopInstance.fromJson(json))
            .toList();
      }
    } catch (error) {
      print('Error loading player shops: $error');
    }
  }

  Future<bool> purchaseShop({
    required String shopType,
    required String country,
    required String city,
    String? customName,
  }) async {
    try {
      final response = await apiService.post(
        '/player/shops/purchase',
        data: {
          'shopType': shopType,
          'country': country,
          'city': city,
          'customName': customName,
        },
      );

      if (response.data['success']) {
        await loadPlayerShops();
        return true;
      } else {
        print('Purchase failed: ${response.data['message']}');
        return false;
      }
    } catch (error) {
      print('Error purchasing shop: $error');
      return false;
    }
  }

  Future<bool> sellShop(String shopId) async {
    try {
      final response = await apiService.delete('/player/shops/$shopId');
      if (response.data['success']) {
        await loadPlayerShops();
        return true;
      } else {
        print('Sell failed: ${response.data['message']}');
        return false;
      }
    } catch (error) {
      print('Error selling shop: $error');
      return false;
    }
  }

  // Arama ve filtreleme helper'ları
  List<ShopInstance> getShopsByType(String shopType) {
    return state.where((shop) => shop.shopType == shopType).toList();
  }

  List<ShopInstance> getShopsByCity(String country, String city) {
    return state
        .where((shop) => shop.country == country && shop.city == city)
        .toList();
  }

  double getTotalRevenue() {
    return state.fold(0, (sum, shop) => sum + shop.monthlyRevenue);
  }

  int getTotalCustomers() {
    return state.fold(0, (sum, shop) => sum + shop.monthlyCustomers);
  }
}

// Eski sistem uyumluluğu için backward compatibility provider
@riverpod
class ShopsNotifier extends _$ShopsNotifier {
  @override
  List<Shop> build() => []; // Boş bırakacak artık kullanılmıyor

  // Compatibility methods for old screens
  Future<bool> rentShop(String shopId, String businessCategory) async {
    try {
      final response = await apiService.post(
        '/shop/rent',
        data: {
          'shopId': shopId,
          'businessCategory': businessCategory,
        },
      );
      return response.data['success'] ?? false;
    } catch (error) {
      print('Error renting shop: $error');
      return false;
    }
  }

  List<Shop> getPlayerShops(String playerId) {
    return state; // Return current state
  }
}
