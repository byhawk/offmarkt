import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

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

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    String? description,
    required String emoji,
    required double basePrice,
    required double currentPrice,
    @Default(50) int demand,
    @Default(1.0) double volatility,
    @Default(false) bool isTrending,
    @Default(1.0) double seasonalFactor,
    @Default('legal') String category,
    @Default(0.0) double minPrice,
    @Default(1000.0) double maxPrice,
    @Default([]) List<PriceHistory> priceHistory,
    String? imageUrl,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class InventoryItem with _$InventoryItem {
  const factory InventoryItem({
    required String productId,
    required int quantity,
    required double purchasePrice,
    @Default('legal') String source,
    required DateTime purchaseDate,
  }) = _InventoryItem;

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);
}
