// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopImpl _$$ShopImplFromJson(Map<String, dynamic> json) => _$ShopImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  location: json['location'] as String,
  locationType: json['locationType'] as String? ?? 'street',
  squareMeters: (json['squareMeters'] as num?)?.toInt() ?? 50,
  floor: (json['floor'] as num?)?.toInt() ?? 1,
  monthlyRent: (json['monthlyRent'] as num).toDouble(),
  deposit: (json['deposit'] as num).toDouble(),
  hasWindow: json['hasWindow'] as bool? ?? false,
  parkingSpaces: (json['parkingSpaces'] as num?)?.toInt() ?? 0,
  isAvailable: json['isAvailable'] as bool? ?? true,
  rentedBy: json['rentedBy'] as String?,
  rentedDate: json['rentedDate'] == null
      ? null
      : DateTime.parse(json['rentedDate'] as String),
  businessCategory: json['businessCategory'] as String?,
  isActive: json['isActive'] as bool? ?? false,
  monthlyRevenue: (json['monthlyRevenue'] as num?)?.toDouble() ?? 0.0,
  monthlyCustomers: (json['monthlyCustomers'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ShopImplToJson(_$ShopImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'locationType': instance.locationType,
      'squareMeters': instance.squareMeters,
      'floor': instance.floor,
      'monthlyRent': instance.monthlyRent,
      'deposit': instance.deposit,
      'hasWindow': instance.hasWindow,
      'parkingSpaces': instance.parkingSpaces,
      'isAvailable': instance.isAvailable,
      'rentedBy': instance.rentedBy,
      'rentedDate': instance.rentedDate?.toIso8601String(),
      'businessCategory': instance.businessCategory,
      'isActive': instance.isActive,
      'monthlyRevenue': instance.monthlyRevenue,
      'monthlyCustomers': instance.monthlyCustomers,
    };
