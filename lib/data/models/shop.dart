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
