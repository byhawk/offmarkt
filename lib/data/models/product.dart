import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String emoji,
    required double basePrice,
    required double currentPrice,
    @Default(50) int demand,
    @Default(1.0) double volatility,
    @Default(false) bool isTrending,
    @Default(1.0) double seasonalFactor,
    @Default('legal') String category,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
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
