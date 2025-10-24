// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListedProductImpl _$$ListedProductImplFromJson(Map<String, dynamic> json) =>
    _$ListedProductImpl(
      productId: json['productId'] as String,
      product: ProductSummary.fromJson(json['product'] as Map<String, dynamic>),
      minStock: (json['minStock'] as num?)?.toInt() ?? 5,
      maxStock: (json['maxStock'] as num?)?.toInt() ?? 20,
      currentStock: (json['currentStock'] as num?)?.toInt() ?? 0,
      listPrice: (json['listPrice'] as num).toDouble(),
      autoPurchase: json['autoPurchase'] as bool? ?? true,
      isActive: json['isActive'] as bool? ?? true,
      totalSold: (json['totalSold'] as num?)?.toInt() ?? 0,
      lastPurchaseDate: json['lastPurchaseDate'] == null
          ? null
          : DateTime.parse(json['lastPurchaseDate'] as String),
      priceHistory:
          (json['priceHistory'] as List<dynamic>?)
              ?.map((e) => PriceHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ListedProductImplToJson(_$ListedProductImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'product': instance.product,
      'minStock': instance.minStock,
      'maxStock': instance.maxStock,
      'currentStock': instance.currentStock,
      'listPrice': instance.listPrice,
      'autoPurchase': instance.autoPurchase,
      'isActive': instance.isActive,
      'totalSold': instance.totalSold,
      'lastPurchaseDate': instance.lastPurchaseDate?.toIso8601String(),
      'priceHistory': instance.priceHistory,
    };

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

_$ProductSummaryImpl _$$ProductSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ProductSummaryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String,
    );

Map<String, dynamic> _$$ProductSummaryImplToJson(
  _$ProductSummaryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'category': instance.category,
};

_$AutoPurchaseSettingsImpl _$$AutoPurchaseSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$AutoPurchaseSettingsImpl(
  enableBalanceControl: json['enableBalanceControl'] as bool? ?? true,
  balanceInterval: (json['balanceInterval'] as num?)?.toInt() ?? 3600000,
  priceAdjustmentRate:
      (json['priceAdjustmentRate'] as num?)?.toDouble() ?? 0.02,
  smartPricing: json['smartPricing'] as bool? ?? true,
);

Map<String, dynamic> _$$AutoPurchaseSettingsImplToJson(
  _$AutoPurchaseSettingsImpl instance,
) => <String, dynamic>{
  'enableBalanceControl': instance.enableBalanceControl,
  'balanceInterval': instance.balanceInterval,
  'priceAdjustmentRate': instance.priceAdjustmentRate,
  'smartPricing': instance.smartPricing,
};

_$StockStatisticsImpl _$$StockStatisticsImplFromJson(
  Map<String, dynamic> json,
) => _$StockStatisticsImpl(
  totalProducts: (json['totalProducts'] as num?)?.toInt() ?? 0,
  totalStockValue: (json['totalStockValue'] as num?)?.toDouble() ?? 0.0,
  lowStockProducts: (json['lowStockProducts'] as num?)?.toInt() ?? 0,
  highStockProducts: (json['highStockProducts'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$StockStatisticsImplToJson(
  _$StockStatisticsImpl instance,
) => <String, dynamic>{
  'totalProducts': instance.totalProducts,
  'totalStockValue': instance.totalStockValue,
  'lowStockProducts': instance.lowStockProducts,
  'highStockProducts': instance.highStockProducts,
};

_$ShopImpl _$$ShopImplFromJson(Map<String, dynamic> json) => _$ShopImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  country: json['country'] as String?,
  city: json['city'] as String?,
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
  listedProducts:
      (json['listedProducts'] as List<dynamic>?)
          ?.map((e) => ListedProduct.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  autoPurchaseSettings: json['autoPurchaseSettings'] == null
      ? null
      : AutoPurchaseSettings.fromJson(
          json['autoPurchaseSettings'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$ShopImplToJson(_$ShopImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'city': instance.city,
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
      'listedProducts': instance.listedProducts,
      'autoPurchaseSettings': instance.autoPurchaseSettings,
    };

_$ShopTypeImpl _$$ShopTypeImplFromJson(Map<String, dynamic> json) =>
    _$ShopTypeImpl(
      id: json['_id'] as String,
      shopType: json['shopType'] as String,
      displayName: json['displayName'] as String,
      nameTemplate: json['nameTemplate'] as String,
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      rackCapacity: (json['rackCapacity'] as num).toInt(),
      storageCapacity: (json['storageCapacity'] as num).toInt(),
      minCustomers: (json['minCustomers'] as num).toInt(),
      locationType: json['locationType'] as String,
      allowedCategories:
          (json['allowedCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ShopTypeImplToJson(_$ShopTypeImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'shopType': instance.shopType,
      'displayName': instance.displayName,
      'nameTemplate': instance.nameTemplate,
      'purchasePrice': instance.purchasePrice,
      'rackCapacity': instance.rackCapacity,
      'storageCapacity': instance.storageCapacity,
      'minCustomers': instance.minCustomers,
      'locationType': instance.locationType,
      'allowedCategories': instance.allowedCategories,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$ShopInstanceImpl _$$ShopInstanceImplFromJson(Map<String, dynamic> json) =>
    _$ShopInstanceImpl(
      id: json['_id'] as String,
      shopType: json['shopType'] as String,
      shopTypeData: json['shopTypeData'] == null
          ? null
          : ShopType.fromJson(json['shopTypeData'] as Map<String, dynamic>),
      ownerId: json['ownerId'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      customName: json['customName'] as String,
      purchasedAt: DateTime.parse(json['purchasedAt'] as String),
      monthlyRevenue: (json['monthlyRevenue'] as num?)?.toDouble() ?? 0.0,
      monthlyCustomers: (json['monthlyCustomers'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      listedProducts:
          (json['listedProducts'] as List<dynamic>?)
              ?.map((e) => ListedProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      autoPurchaseSettings: json['autoPurchaseSettings'] == null
          ? null
          : AutoPurchaseSettings.fromJson(
              json['autoPurchaseSettings'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$ShopInstanceImplToJson(_$ShopInstanceImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'shopType': instance.shopType,
      'shopTypeData': instance.shopTypeData,
      'ownerId': instance.ownerId,
      'country': instance.country,
      'city': instance.city,
      'customName': instance.customName,
      'purchasedAt': instance.purchasedAt.toIso8601String(),
      'monthlyRevenue': instance.monthlyRevenue,
      'monthlyCustomers': instance.monthlyCustomers,
      'isActive': instance.isActive,
      'listedProducts': instance.listedProducts,
      'autoPurchaseSettings': instance.autoPurchaseSettings,
    };
