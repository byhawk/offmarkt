import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

// Listed Product Model
@freezed
class ListedProduct with _$ListedProduct {
  const factory ListedProduct({
    required String productId,
    required ProductSummary product,
    @Default(5) int minStock,
    @Default(20) int maxStock,
    @Default(0) int currentStock,
    required double listPrice,
    @Default(true) bool autoPurchase,
    @Default(true) bool isActive,
    @Default(0) int totalSold,
    DateTime? lastPurchaseDate,
    @Default([]) List<PriceHistory> priceHistory,
  }) = _ListedProduct;

  factory ListedProduct.fromJson(Map<String, dynamic> json) =>
      _$ListedProductFromJson(json);
}

// Price History Model
@freezed
class PriceHistory with _$PriceHistory {
  const factory PriceHistory({
    required double price,
    required DateTime changedAt,
    @Default('manual') String reason,
  }) = _PriceHistory;

  factory PriceHistory.fromJson(Map<String, dynamic> json) =>
      _$PriceHistoryFromJson(json);
}

// Product Summary Model
@freezed
class ProductSummary with _$ProductSummary {
  const factory ProductSummary({
    required String id,
    required String name,
    String? description,
    String? imageUrl,
    required String category,
  }) = _ProductSummary;

  factory ProductSummary.fromJson(Map<String, dynamic> json) =>
      _$ProductSummaryFromJson(json);
}

// Auto Purchase Settings Model
@freezed
class AutoPurchaseSettings with _$AutoPurchaseSettings {
  const factory AutoPurchaseSettings({
    @Default(true) bool enableBalanceControl,
    @Default(3600000) int balanceInterval, // 1 saat
    @Default(0.02) double priceAdjustmentRate, // %2
    @Default(true) bool smartPricing,
  }) = _AutoPurchaseSettings;

  factory AutoPurchaseSettings.fromJson(Map<String, dynamic> json) =>
      _$AutoPurchaseSettingsFromJson(json);
}

// Stock Statistics Model
@freezed
class StockStatistics with _$StockStatistics {
  const factory StockStatistics({
    @Default(0) int totalProducts,
    @Default(0.0) double totalStockValue,
    @Default(0) int lowStockProducts,
    @Default(0) int highStockProducts,
  }) = _StockStatistics;

  factory StockStatistics.fromJson(Map<String, dynamic> json) =>
      _$StockStatisticsFromJson(json);
}

@freezed
class Shop with _$Shop {
  const factory Shop({
    required String id,
    required String name,
    // Ülke/şehir bilgileri
    String? country,
    String? city,
    // Eski locationalan tutmak için
    required String location,
    @Default('street') String locationType,
    @Default(50) int squareMeters,
    @Default(1) int floor,
    required double monthlyRent,
    required double deposit,
    @Default(false) bool hasWindow,
    @Default(0) int parkingSpaces,
    @Default(true) bool isAvailable,
    String? rentedBy,
    DateTime? rentedDate,
    String? businessCategory,
    @Default(false) bool isActive,
    @Default(0.0) double monthlyRevenue,
    @Default(0) int monthlyCustomers,
    // Ekonomik sistem alanları
    @Default([]) List<ListedProduct> listedProducts,
    AutoPurchaseSettings? autoPurchaseSettings,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}

// ===== YENİ ÇOKLU MAĞAZA SİSTEMİ MODELLERİ =====

// Shop Type Model - Admin tarafından oluşturulan template'lar
@freezed
class ShopType with _$ShopType {
  const factory ShopType({
    required String id,
    required String shopType, // kodu: 'flower_shop', 'supermarket' vs
    required String displayName, // görünüm adı: 'Çiçekçi Mağazası'
    required String nameTemplate, // '{ŞEHİR} {TÜR}'
    required double purchasePrice, // satın alma ücreti
    required int rackCapacity, // raf kapasitesi
    required int storageCapacity, // depo kapasitesi (adet)
    required int minCustomers, // minimum müşteri
    required String locationType, // 'street', 'mall' vs
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ShopType;

  factory ShopType.fromJson(Map<String, dynamic> json) =>
      _$ShopTypeFromJson(json);
}

// Shop Instance Model - Oyuncuların satın aldığı mağazalar
@freezed
class ShopInstance with _$ShopInstance {
  const factory ShopInstance({
    required String id,
    required String shopType, // bağlı olduğu type kodu
    ShopType? shopTypeData, // populate edildiğinde gelir
    required String ownerId,
    required String country,
    required String city,
    required String customName, // mağaza adı
    required DateTime purchasedAt,
    // İşletme istatistikleri
    @Default(0.0) double monthlyRevenue,
    @Default(0) int monthlyCustomers,
    @Default(true) bool isActive,
    // Ürün sistemi (eski sistemden)
    @Default([]) List<ListedProduct> listedProducts,
    AutoPurchaseSettings? autoPurchaseSettings,
  }) = _ShopInstance;

  factory ShopInstance.fromJson(Map<String, dynamic> json) =>
      _$ShopInstanceFromJson(json);
}
