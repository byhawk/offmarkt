import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/shop.dart';
import '../../services/api_service.dart';

part 'shops_provider.g.dart';

final apiService = ApiService();

// Shop Types Provider - Aktif dükkan çeşitleri
@riverpod
class ShopTypesNotifier extends _$ShopTypesNotifier {
  @override
  List<ShopType> build() {
    // Backend'den yükle
    loadShopTypes();
    return [];
  }

  Future<void> loadShopTypes() async {
    try {
      final response = await apiService.get('/shop/types');
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
      final response = await apiService.get('/shop/owned');
      print('📍 loadPlayerShops response: ${response.data}');
      if (response.data['success']) {
        final shopsList = response.data['data']['shops'] as List;
        print('📦 Found ${shopsList.length} owned shops');
        state = shopsList
            .map((json) => ShopInstance.fromJson(json))
            .toList();
      }
    } catch (error) {
      print('❌ Error loading player shops: $error');
    }
  }

  Future<bool> purchaseShop({
    required String shopId,
    required String businessCategory,
    String? customName,
  }) async {
    try {
      print('🛒 Attempting to rent shop: $shopId with category: $businessCategory');
      final response = await apiService.post(
        '/shop/rent',
        data: {
          'shopId': shopId,
          'businessCategory': businessCategory,
          'customName': customName,
        },
      );

      print('📍 Rent response: ${response.data}');
      if (response.data['success']) {
        await loadPlayerShops();
        return true;
      } else {
        print('❌ Rent failed: ${response.data['message']}');
        return false;
      }
    } catch (error) {
      print('❌ Error renting shop: $error');
      return false;
    }
  }

  Future<bool> sellShop(String shopId) async {
    try {
      print('🏚️ Attempting to leave shop: $shopId');
      final response = await apiService.post('/shop/leave', data: {'shopId': shopId});
      print('📍 Leave response: ${response.data}');
      if (response.data['success']) {
        await loadPlayerShops();
        return true;
      } else {
        print('❌ Leave failed: ${response.data['message']}');
        return false;
      }
    } catch (error) {
      print('❌ Error leaving shop: $error');
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

  // Load available shops from backend
  Future<void> loadAvailableShops() async {
    try {
      final response = await apiService.get('/shop/available');
      if (response.data['success']) {
        state = (response.data['data']['shops'] as List)
            .map((json) => Shop.fromJson(json))
            .toList();
      }
    } catch (error) {
      print('Error loading available shops: $error');
    }
  }

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
      if (response.data['success'] ?? false) {
        // Reload shops after renting
        await loadAvailableShops();
        return true;
      }
      return false;
    } catch (error) {
      print('Error renting shop: $error');
      return false;
    }
  }

  List<Shop> getPlayerShops(String playerId) {
    return state.where((s) => !s.isAvailable).toList(); // Return rented shops
  }
}
