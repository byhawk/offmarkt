import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

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
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}
