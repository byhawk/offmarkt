import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/shop.dart';

part 'shops_provider.g.dart';

@riverpod
class ShopsNotifier extends _$ShopsNotifier {
  @override
  List<Shop> build() {
    // Başlangıç dükkanları
    return [
      const Shop(
        id: 'shop_1',
        name: 'Merkez Cadde Mağaza',
        location: 'Merkez Cadde No:45',
        locationType: 'street',
        squareMeters: 75,
        floor: 1,
        monthlyRent: 15000.0,
        deposit: 30000.0,
        hasWindow: true,
        parkingSpaces: 2,
        isAvailable: true,
      ),
      const Shop(
        id: 'shop_2',
        name: 'AVM İçi Dükkan',
        location: 'Forum AVM Kat:2',
        locationType: 'mall',
        squareMeters: 50,
        floor: 2,
        monthlyRent: 25000.0,
        deposit: 50000.0,
        hasWindow: false,
        parkingSpaces: 0,
        isAvailable: true,
      ),
      const Shop(
        id: 'shop_3',
        name: 'Semt Pazarı Standı',
        location: 'Kadıköy Pazarı',
        locationType: 'market',
        squareMeters: 25,
        floor: 1,
        monthlyRent: 8000.0,
        deposit: 16000.0,
        hasWindow: true,
        parkingSpaces: 0,
        isAvailable: true,
      ),
      const Shop(
        id: 'shop_4',
        name: 'Plaza Ofis',
        location: 'İş Plaza Kat:5',
        locationType: 'office',
        squareMeters: 100,
        floor: 5,
        monthlyRent: 35000.0,
        deposit: 70000.0,
        hasWindow: true,
        parkingSpaces: 3,
        isAvailable: true,
      ),
      const Shop(
        id: 'shop_5',
        name: 'Yan Sokak Depo',
        location: 'Yan Sokak No:12',
        locationType: 'warehouse',
        squareMeters: 150,
        floor: 1,
        monthlyRent: 12000.0,
        deposit: 24000.0,
        hasWindow: false,
        parkingSpaces: 5,
        isAvailable: true,
      ),
    ];
  }

  /// Dükkan kirala
  void rentShop(String shopId, String playerId, String businessCategory) {
    state = state.map((shop) {
      if (shop.id == shopId && shop.isAvailable) {
        return shop.copyWith(
          isAvailable: false,
          rentedBy: playerId,
          rentedDate: DateTime.now(),
          businessCategory: businessCategory,
          isActive: true,
        );
      }
      return shop;
    }).toList();
  }

  /// Dükkanı bırak
  void leaveShop(String shopId) {
    state = state.map((shop) {
      if (shop.id == shopId) {
        return shop.copyWith(
          isAvailable: true,
          rentedBy: null,
          rentedDate: null,
          businessCategory: null,
          isActive: false,
          monthlyRevenue: 0.0,
          monthlyCustomers: 0,
        );
      }
      return shop;
    }).toList();
  }

  /// Gelir güncelle
  void updateRevenue(String shopId, double revenue, int customers) {
    state = state.map((shop) {
      if (shop.id == shopId) {
        return shop.copyWith(
          monthlyRevenue: shop.monthlyRevenue + revenue,
          monthlyCustomers: shop.monthlyCustomers + customers,
        );
      }
      return shop;
    }).toList();
  }

  /// Oyuncunun kiraladığı dükkanları getir
  List<Shop> getPlayerShops(String playerId) {
    return state.where((shop) => shop.rentedBy == playerId).toList();
  }

  /// Müsait dükkanları getir
  List<Shop> getAvailableShops() {
    return state.where((shop) => shop.isAvailable).toList();
  }
}
