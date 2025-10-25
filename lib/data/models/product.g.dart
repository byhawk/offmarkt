// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceHistoryImpl _$$PriceHistoryImplFromJson(Map<String, dynamic> json) =>
    _$PriceHistoryImpl(
      price: (json['price'] as num).toDouble(),
      changedAt: DateTime.parse(json['changedAt'] as String),
      reason: json['reason'] as String? ?? 'manual',
    );

Map<String, dynamic> _$$PriceHistoryImplToJson(_$PriceHistoryImpl instance) =>
    <String, dynamic>{
      'price': instance.price,
      'changedAt': instance.changedAt.toIso8601String(),
      'reason': instance.reason,
    };

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      emoji: json['emoji'] as String,
      basePrice: (json['basePrice'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
      demand: (json['demand'] as num?)?.toInt() ?? 50,
      volatility: (json['volatility'] as num?)?.toDouble() ?? 1.0,
      isTrending: json['isTrending'] as bool? ?? false,
      seasonalFactor: (json['seasonalFactor'] as num?)?.toDouble() ?? 1.0,
      category: json['category'] as String? ?? 'legal',
      minPrice: (json['minPrice'] as num?)?.toDouble() ?? 0.0,
      maxPrice: (json['maxPrice'] as num?)?.toDouble() ?? 1000.0,
      priceHistory:
          (json['priceHistory'] as List<dynamic>?)
              ?.map((e) => PriceHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'emoji': instance.emoji,
      'basePrice': instance.basePrice,
      'currentPrice': instance.currentPrice,
      'demand': instance.demand,
      'volatility': instance.volatility,
      'isTrending': instance.isTrending,
      'seasonalFactor': instance.seasonalFactor,
      'category': instance.category,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'priceHistory': instance.priceHistory,
      'imageUrl': instance.imageUrl,
    };

_$InventoryItemImpl _$$InventoryItemImplFromJson(Map<String, dynamic> json) =>
    _$InventoryItemImpl(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      source: json['source'] as String? ?? 'legal',
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
    );

Map<String, dynamic> _$$InventoryItemImplToJson(_$InventoryItemImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'purchasePrice': instance.purchasePrice,
      'source': instance.source,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
    };
