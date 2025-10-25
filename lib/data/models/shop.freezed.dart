// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ListedProduct _$ListedProductFromJson(Map<String, dynamic> json) {
  return _ListedProduct.fromJson(json);
}

/// @nodoc
mixin _$ListedProduct {
  String get productId => throw _privateConstructorUsedError;
  ProductSummary get product => throw _privateConstructorUsedError;
  int get minStock => throw _privateConstructorUsedError;
  int get maxStock => throw _privateConstructorUsedError;
  int get currentStock => throw _privateConstructorUsedError;
  double get listPrice => throw _privateConstructorUsedError;
  bool get autoPurchase => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get totalSold => throw _privateConstructorUsedError;
  DateTime? get lastPurchaseDate => throw _privateConstructorUsedError;
  List<PriceHistory> get priceHistory => throw _privateConstructorUsedError;

  /// Serializes this ListedProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListedProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListedProductCopyWith<ListedProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListedProductCopyWith<$Res> {
  factory $ListedProductCopyWith(
    ListedProduct value,
    $Res Function(ListedProduct) then,
  ) = _$ListedProductCopyWithImpl<$Res, ListedProduct>;
  @useResult
  $Res call({
    String productId,
    ProductSummary product,
    int minStock,
    int maxStock,
    int currentStock,
    double listPrice,
    bool autoPurchase,
    bool isActive,
    int totalSold,
    DateTime? lastPurchaseDate,
    List<PriceHistory> priceHistory,
  });

  $ProductSummaryCopyWith<$Res> get product;
}

/// @nodoc
class _$ListedProductCopyWithImpl<$Res, $Val extends ListedProduct>
    implements $ListedProductCopyWith<$Res> {
  _$ListedProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListedProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? product = null,
    Object? minStock = null,
    Object? maxStock = null,
    Object? currentStock = null,
    Object? listPrice = null,
    Object? autoPurchase = null,
    Object? isActive = null,
    Object? totalSold = null,
    Object? lastPurchaseDate = freezed,
    Object? priceHistory = null,
  }) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            product: null == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as ProductSummary,
            minStock: null == minStock
                ? _value.minStock
                : minStock // ignore: cast_nullable_to_non_nullable
                      as int,
            maxStock: null == maxStock
                ? _value.maxStock
                : maxStock // ignore: cast_nullable_to_non_nullable
                      as int,
            currentStock: null == currentStock
                ? _value.currentStock
                : currentStock // ignore: cast_nullable_to_non_nullable
                      as int,
            listPrice: null == listPrice
                ? _value.listPrice
                : listPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            autoPurchase: null == autoPurchase
                ? _value.autoPurchase
                : autoPurchase // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalSold: null == totalSold
                ? _value.totalSold
                : totalSold // ignore: cast_nullable_to_non_nullable
                      as int,
            lastPurchaseDate: freezed == lastPurchaseDate
                ? _value.lastPurchaseDate
                : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            priceHistory: null == priceHistory
                ? _value.priceHistory
                : priceHistory // ignore: cast_nullable_to_non_nullable
                      as List<PriceHistory>,
          )
          as $Val,
    );
  }

  /// Create a copy of ListedProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductSummaryCopyWith<$Res> get product {
    return $ProductSummaryCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ListedProductImplCopyWith<$Res>
    implements $ListedProductCopyWith<$Res> {
  factory _$$ListedProductImplCopyWith(
    _$ListedProductImpl value,
    $Res Function(_$ListedProductImpl) then,
  ) = __$$ListedProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productId,
    ProductSummary product,
    int minStock,
    int maxStock,
    int currentStock,
    double listPrice,
    bool autoPurchase,
    bool isActive,
    int totalSold,
    DateTime? lastPurchaseDate,
    List<PriceHistory> priceHistory,
  });

  @override
  $ProductSummaryCopyWith<$Res> get product;
}

/// @nodoc
class __$$ListedProductImplCopyWithImpl<$Res>
    extends _$ListedProductCopyWithImpl<$Res, _$ListedProductImpl>
    implements _$$ListedProductImplCopyWith<$Res> {
  __$$ListedProductImplCopyWithImpl(
    _$ListedProductImpl _value,
    $Res Function(_$ListedProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ListedProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? product = null,
    Object? minStock = null,
    Object? maxStock = null,
    Object? currentStock = null,
    Object? listPrice = null,
    Object? autoPurchase = null,
    Object? isActive = null,
    Object? totalSold = null,
    Object? lastPurchaseDate = freezed,
    Object? priceHistory = null,
  }) {
    return _then(
      _$ListedProductImpl(
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        product: null == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as ProductSummary,
        minStock: null == minStock
            ? _value.minStock
            : minStock // ignore: cast_nullable_to_non_nullable
                  as int,
        maxStock: null == maxStock
            ? _value.maxStock
            : maxStock // ignore: cast_nullable_to_non_nullable
                  as int,
        currentStock: null == currentStock
            ? _value.currentStock
            : currentStock // ignore: cast_nullable_to_non_nullable
                  as int,
        listPrice: null == listPrice
            ? _value.listPrice
            : listPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        autoPurchase: null == autoPurchase
            ? _value.autoPurchase
            : autoPurchase // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalSold: null == totalSold
            ? _value.totalSold
            : totalSold // ignore: cast_nullable_to_non_nullable
                  as int,
        lastPurchaseDate: freezed == lastPurchaseDate
            ? _value.lastPurchaseDate
            : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        priceHistory: null == priceHistory
            ? _value._priceHistory
            : priceHistory // ignore: cast_nullable_to_non_nullable
                  as List<PriceHistory>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ListedProductImpl implements _ListedProduct {
  const _$ListedProductImpl({
    required this.productId,
    required this.product,
    this.minStock = 5,
    this.maxStock = 20,
    this.currentStock = 0,
    required this.listPrice,
    this.autoPurchase = true,
    this.isActive = true,
    this.totalSold = 0,
    this.lastPurchaseDate,
    final List<PriceHistory> priceHistory = const [],
  }) : _priceHistory = priceHistory;

  factory _$ListedProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListedProductImplFromJson(json);

  @override
  final String productId;
  @override
  final ProductSummary product;
  @override
  @JsonKey()
  final int minStock;
  @override
  @JsonKey()
  final int maxStock;
  @override
  @JsonKey()
  final int currentStock;
  @override
  final double listPrice;
  @override
  @JsonKey()
  final bool autoPurchase;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int totalSold;
  @override
  final DateTime? lastPurchaseDate;
  final List<PriceHistory> _priceHistory;
  @override
  @JsonKey()
  List<PriceHistory> get priceHistory {
    if (_priceHistory is EqualUnmodifiableListView) return _priceHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_priceHistory);
  }

  @override
  String toString() {
    return 'ListedProduct(productId: $productId, product: $product, minStock: $minStock, maxStock: $maxStock, currentStock: $currentStock, listPrice: $listPrice, autoPurchase: $autoPurchase, isActive: $isActive, totalSold: $totalSold, lastPurchaseDate: $lastPurchaseDate, priceHistory: $priceHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListedProductImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.minStock, minStock) ||
                other.minStock == minStock) &&
            (identical(other.maxStock, maxStock) ||
                other.maxStock == maxStock) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.listPrice, listPrice) ||
                other.listPrice == listPrice) &&
            (identical(other.autoPurchase, autoPurchase) ||
                other.autoPurchase == autoPurchase) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.totalSold, totalSold) ||
                other.totalSold == totalSold) &&
            (identical(other.lastPurchaseDate, lastPurchaseDate) ||
                other.lastPurchaseDate == lastPurchaseDate) &&
            const DeepCollectionEquality().equals(
              other._priceHistory,
              _priceHistory,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productId,
    product,
    minStock,
    maxStock,
    currentStock,
    listPrice,
    autoPurchase,
    isActive,
    totalSold,
    lastPurchaseDate,
    const DeepCollectionEquality().hash(_priceHistory),
  );

  /// Create a copy of ListedProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListedProductImplCopyWith<_$ListedProductImpl> get copyWith =>
      __$$ListedProductImplCopyWithImpl<_$ListedProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListedProductImplToJson(this);
  }
}

abstract class _ListedProduct implements ListedProduct {
  const factory _ListedProduct({
    required final String productId,
    required final ProductSummary product,
    final int minStock,
    final int maxStock,
    final int currentStock,
    required final double listPrice,
    final bool autoPurchase,
    final bool isActive,
    final int totalSold,
    final DateTime? lastPurchaseDate,
    final List<PriceHistory> priceHistory,
  }) = _$ListedProductImpl;

  factory _ListedProduct.fromJson(Map<String, dynamic> json) =
      _$ListedProductImpl.fromJson;

  @override
  String get productId;
  @override
  ProductSummary get product;
  @override
  int get minStock;
  @override
  int get maxStock;
  @override
  int get currentStock;
  @override
  double get listPrice;
  @override
  bool get autoPurchase;
  @override
  bool get isActive;
  @override
  int get totalSold;
  @override
  DateTime? get lastPurchaseDate;
  @override
  List<PriceHistory> get priceHistory;

  /// Create a copy of ListedProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListedProductImplCopyWith<_$ListedProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceHistory _$PriceHistoryFromJson(Map<String, dynamic> json) {
  return _PriceHistory.fromJson(json);
}

/// @nodoc
mixin _$PriceHistory {
  double get price => throw _privateConstructorUsedError;
  DateTime get changedAt => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  /// Serializes this PriceHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceHistoryCopyWith<PriceHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceHistoryCopyWith<$Res> {
  factory $PriceHistoryCopyWith(
    PriceHistory value,
    $Res Function(PriceHistory) then,
  ) = _$PriceHistoryCopyWithImpl<$Res, PriceHistory>;
  @useResult
  $Res call({double price, DateTime changedAt, String reason});
}

/// @nodoc
class _$PriceHistoryCopyWithImpl<$Res, $Val extends PriceHistory>
    implements $PriceHistoryCopyWith<$Res> {
  _$PriceHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? changedAt = null,
    Object? reason = null,
  }) {
    return _then(
      _value.copyWith(
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            changedAt: null == changedAt
                ? _value.changedAt
                : changedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceHistoryImplCopyWith<$Res>
    implements $PriceHistoryCopyWith<$Res> {
  factory _$$PriceHistoryImplCopyWith(
    _$PriceHistoryImpl value,
    $Res Function(_$PriceHistoryImpl) then,
  ) = __$$PriceHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double price, DateTime changedAt, String reason});
}

/// @nodoc
class __$$PriceHistoryImplCopyWithImpl<$Res>
    extends _$PriceHistoryCopyWithImpl<$Res, _$PriceHistoryImpl>
    implements _$$PriceHistoryImplCopyWith<$Res> {
  __$$PriceHistoryImplCopyWithImpl(
    _$PriceHistoryImpl _value,
    $Res Function(_$PriceHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? changedAt = null,
    Object? reason = null,
  }) {
    return _then(
      _$PriceHistoryImpl(
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        changedAt: null == changedAt
            ? _value.changedAt
            : changedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceHistoryImpl implements _PriceHistory {
  const _$PriceHistoryImpl({
    required this.price,
    required this.changedAt,
    this.reason = 'manual',
  });

  factory _$PriceHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceHistoryImplFromJson(json);

  @override
  final double price;
  @override
  final DateTime changedAt;
  @override
  @JsonKey()
  final String reason;

  @override
  String toString() {
    return 'PriceHistory(price: $price, changedAt: $changedAt, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceHistoryImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, price, changedAt, reason);

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceHistoryImplCopyWith<_$PriceHistoryImpl> get copyWith =>
      __$$PriceHistoryImplCopyWithImpl<_$PriceHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceHistoryImplToJson(this);
  }
}

abstract class _PriceHistory implements PriceHistory {
  const factory _PriceHistory({
    required final double price,
    required final DateTime changedAt,
    final String reason,
  }) = _$PriceHistoryImpl;

  factory _PriceHistory.fromJson(Map<String, dynamic> json) =
      _$PriceHistoryImpl.fromJson;

  @override
  double get price;
  @override
  DateTime get changedAt;
  @override
  String get reason;

  /// Create a copy of PriceHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceHistoryImplCopyWith<_$PriceHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductSummary _$ProductSummaryFromJson(Map<String, dynamic> json) {
  return _ProductSummary.fromJson(json);
}

/// @nodoc
mixin _$ProductSummary {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  /// Serializes this ProductSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductSummaryCopyWith<ProductSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductSummaryCopyWith<$Res> {
  factory $ProductSummaryCopyWith(
    ProductSummary value,
    $Res Function(ProductSummary) then,
  ) = _$ProductSummaryCopyWithImpl<$Res, ProductSummary>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? imageUrl,
    String category,
  });
}

/// @nodoc
class _$ProductSummaryCopyWithImpl<$Res, $Val extends ProductSummary>
    implements $ProductSummaryCopyWith<$Res> {
  _$ProductSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? category = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductSummaryImplCopyWith<$Res>
    implements $ProductSummaryCopyWith<$Res> {
  factory _$$ProductSummaryImplCopyWith(
    _$ProductSummaryImpl value,
    $Res Function(_$ProductSummaryImpl) then,
  ) = __$$ProductSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? imageUrl,
    String category,
  });
}

/// @nodoc
class __$$ProductSummaryImplCopyWithImpl<$Res>
    extends _$ProductSummaryCopyWithImpl<$Res, _$ProductSummaryImpl>
    implements _$$ProductSummaryImplCopyWith<$Res> {
  __$$ProductSummaryImplCopyWithImpl(
    _$ProductSummaryImpl _value,
    $Res Function(_$ProductSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? category = null,
  }) {
    return _then(
      _$ProductSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductSummaryImpl implements _ProductSummary {
  const _$ProductSummaryImpl({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.category,
  });

  factory _$ProductSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final String category;

  @override
  String toString() {
    return 'ProductSummary(id: $id, name: $name, description: $description, imageUrl: $imageUrl, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, imageUrl, category);

  /// Create a copy of ProductSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductSummaryImplCopyWith<_$ProductSummaryImpl> get copyWith =>
      __$$ProductSummaryImplCopyWithImpl<_$ProductSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductSummaryImplToJson(this);
  }
}

abstract class _ProductSummary implements ProductSummary {
  const factory _ProductSummary({
    required final String id,
    required final String name,
    final String? description,
    final String? imageUrl,
    required final String category,
  }) = _$ProductSummaryImpl;

  factory _ProductSummary.fromJson(Map<String, dynamic> json) =
      _$ProductSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  String get category;

  /// Create a copy of ProductSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductSummaryImplCopyWith<_$ProductSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AutoPurchaseSettings _$AutoPurchaseSettingsFromJson(Map<String, dynamic> json) {
  return _AutoPurchaseSettings.fromJson(json);
}

/// @nodoc
mixin _$AutoPurchaseSettings {
  bool get enableBalanceControl => throw _privateConstructorUsedError;
  int get balanceInterval => throw _privateConstructorUsedError; // 1 saat
  double get priceAdjustmentRate => throw _privateConstructorUsedError; // %2
  bool get smartPricing => throw _privateConstructorUsedError;

  /// Serializes this AutoPurchaseSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AutoPurchaseSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AutoPurchaseSettingsCopyWith<AutoPurchaseSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoPurchaseSettingsCopyWith<$Res> {
  factory $AutoPurchaseSettingsCopyWith(
    AutoPurchaseSettings value,
    $Res Function(AutoPurchaseSettings) then,
  ) = _$AutoPurchaseSettingsCopyWithImpl<$Res, AutoPurchaseSettings>;
  @useResult
  $Res call({
    bool enableBalanceControl,
    int balanceInterval,
    double priceAdjustmentRate,
    bool smartPricing,
  });
}

/// @nodoc
class _$AutoPurchaseSettingsCopyWithImpl<
  $Res,
  $Val extends AutoPurchaseSettings
>
    implements $AutoPurchaseSettingsCopyWith<$Res> {
  _$AutoPurchaseSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AutoPurchaseSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableBalanceControl = null,
    Object? balanceInterval = null,
    Object? priceAdjustmentRate = null,
    Object? smartPricing = null,
  }) {
    return _then(
      _value.copyWith(
            enableBalanceControl: null == enableBalanceControl
                ? _value.enableBalanceControl
                : enableBalanceControl // ignore: cast_nullable_to_non_nullable
                      as bool,
            balanceInterval: null == balanceInterval
                ? _value.balanceInterval
                : balanceInterval // ignore: cast_nullable_to_non_nullable
                      as int,
            priceAdjustmentRate: null == priceAdjustmentRate
                ? _value.priceAdjustmentRate
                : priceAdjustmentRate // ignore: cast_nullable_to_non_nullable
                      as double,
            smartPricing: null == smartPricing
                ? _value.smartPricing
                : smartPricing // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AutoPurchaseSettingsImplCopyWith<$Res>
    implements $AutoPurchaseSettingsCopyWith<$Res> {
  factory _$$AutoPurchaseSettingsImplCopyWith(
    _$AutoPurchaseSettingsImpl value,
    $Res Function(_$AutoPurchaseSettingsImpl) then,
  ) = __$$AutoPurchaseSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool enableBalanceControl,
    int balanceInterval,
    double priceAdjustmentRate,
    bool smartPricing,
  });
}

/// @nodoc
class __$$AutoPurchaseSettingsImplCopyWithImpl<$Res>
    extends _$AutoPurchaseSettingsCopyWithImpl<$Res, _$AutoPurchaseSettingsImpl>
    implements _$$AutoPurchaseSettingsImplCopyWith<$Res> {
  __$$AutoPurchaseSettingsImplCopyWithImpl(
    _$AutoPurchaseSettingsImpl _value,
    $Res Function(_$AutoPurchaseSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AutoPurchaseSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableBalanceControl = null,
    Object? balanceInterval = null,
    Object? priceAdjustmentRate = null,
    Object? smartPricing = null,
  }) {
    return _then(
      _$AutoPurchaseSettingsImpl(
        enableBalanceControl: null == enableBalanceControl
            ? _value.enableBalanceControl
            : enableBalanceControl // ignore: cast_nullable_to_non_nullable
                  as bool,
        balanceInterval: null == balanceInterval
            ? _value.balanceInterval
            : balanceInterval // ignore: cast_nullable_to_non_nullable
                  as int,
        priceAdjustmentRate: null == priceAdjustmentRate
            ? _value.priceAdjustmentRate
            : priceAdjustmentRate // ignore: cast_nullable_to_non_nullable
                  as double,
        smartPricing: null == smartPricing
            ? _value.smartPricing
            : smartPricing // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AutoPurchaseSettingsImpl implements _AutoPurchaseSettings {
  const _$AutoPurchaseSettingsImpl({
    this.enableBalanceControl = true,
    this.balanceInterval = 3600000,
    this.priceAdjustmentRate = 0.02,
    this.smartPricing = true,
  });

  factory _$AutoPurchaseSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AutoPurchaseSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool enableBalanceControl;
  @override
  @JsonKey()
  final int balanceInterval;
  // 1 saat
  @override
  @JsonKey()
  final double priceAdjustmentRate;
  // %2
  @override
  @JsonKey()
  final bool smartPricing;

  @override
  String toString() {
    return 'AutoPurchaseSettings(enableBalanceControl: $enableBalanceControl, balanceInterval: $balanceInterval, priceAdjustmentRate: $priceAdjustmentRate, smartPricing: $smartPricing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoPurchaseSettingsImpl &&
            (identical(other.enableBalanceControl, enableBalanceControl) ||
                other.enableBalanceControl == enableBalanceControl) &&
            (identical(other.balanceInterval, balanceInterval) ||
                other.balanceInterval == balanceInterval) &&
            (identical(other.priceAdjustmentRate, priceAdjustmentRate) ||
                other.priceAdjustmentRate == priceAdjustmentRate) &&
            (identical(other.smartPricing, smartPricing) ||
                other.smartPricing == smartPricing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    enableBalanceControl,
    balanceInterval,
    priceAdjustmentRate,
    smartPricing,
  );

  /// Create a copy of AutoPurchaseSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoPurchaseSettingsImplCopyWith<_$AutoPurchaseSettingsImpl>
  get copyWith =>
      __$$AutoPurchaseSettingsImplCopyWithImpl<_$AutoPurchaseSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AutoPurchaseSettingsImplToJson(this);
  }
}

abstract class _AutoPurchaseSettings implements AutoPurchaseSettings {
  const factory _AutoPurchaseSettings({
    final bool enableBalanceControl,
    final int balanceInterval,
    final double priceAdjustmentRate,
    final bool smartPricing,
  }) = _$AutoPurchaseSettingsImpl;

  factory _AutoPurchaseSettings.fromJson(Map<String, dynamic> json) =
      _$AutoPurchaseSettingsImpl.fromJson;

  @override
  bool get enableBalanceControl;
  @override
  int get balanceInterval; // 1 saat
  @override
  double get priceAdjustmentRate; // %2
  @override
  bool get smartPricing;

  /// Create a copy of AutoPurchaseSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AutoPurchaseSettingsImplCopyWith<_$AutoPurchaseSettingsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StockStatistics _$StockStatisticsFromJson(Map<String, dynamic> json) {
  return _StockStatistics.fromJson(json);
}

/// @nodoc
mixin _$StockStatistics {
  int get totalProducts => throw _privateConstructorUsedError;
  double get totalStockValue => throw _privateConstructorUsedError;
  int get lowStockProducts => throw _privateConstructorUsedError;
  int get highStockProducts => throw _privateConstructorUsedError;

  /// Serializes this StockStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockStatisticsCopyWith<StockStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockStatisticsCopyWith<$Res> {
  factory $StockStatisticsCopyWith(
    StockStatistics value,
    $Res Function(StockStatistics) then,
  ) = _$StockStatisticsCopyWithImpl<$Res, StockStatistics>;
  @useResult
  $Res call({
    int totalProducts,
    double totalStockValue,
    int lowStockProducts,
    int highStockProducts,
  });
}

/// @nodoc
class _$StockStatisticsCopyWithImpl<$Res, $Val extends StockStatistics>
    implements $StockStatisticsCopyWith<$Res> {
  _$StockStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalProducts = null,
    Object? totalStockValue = null,
    Object? lowStockProducts = null,
    Object? highStockProducts = null,
  }) {
    return _then(
      _value.copyWith(
            totalProducts: null == totalProducts
                ? _value.totalProducts
                : totalProducts // ignore: cast_nullable_to_non_nullable
                      as int,
            totalStockValue: null == totalStockValue
                ? _value.totalStockValue
                : totalStockValue // ignore: cast_nullable_to_non_nullable
                      as double,
            lowStockProducts: null == lowStockProducts
                ? _value.lowStockProducts
                : lowStockProducts // ignore: cast_nullable_to_non_nullable
                      as int,
            highStockProducts: null == highStockProducts
                ? _value.highStockProducts
                : highStockProducts // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StockStatisticsImplCopyWith<$Res>
    implements $StockStatisticsCopyWith<$Res> {
  factory _$$StockStatisticsImplCopyWith(
    _$StockStatisticsImpl value,
    $Res Function(_$StockStatisticsImpl) then,
  ) = __$$StockStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalProducts,
    double totalStockValue,
    int lowStockProducts,
    int highStockProducts,
  });
}

/// @nodoc
class __$$StockStatisticsImplCopyWithImpl<$Res>
    extends _$StockStatisticsCopyWithImpl<$Res, _$StockStatisticsImpl>
    implements _$$StockStatisticsImplCopyWith<$Res> {
  __$$StockStatisticsImplCopyWithImpl(
    _$StockStatisticsImpl _value,
    $Res Function(_$StockStatisticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StockStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalProducts = null,
    Object? totalStockValue = null,
    Object? lowStockProducts = null,
    Object? highStockProducts = null,
  }) {
    return _then(
      _$StockStatisticsImpl(
        totalProducts: null == totalProducts
            ? _value.totalProducts
            : totalProducts // ignore: cast_nullable_to_non_nullable
                  as int,
        totalStockValue: null == totalStockValue
            ? _value.totalStockValue
            : totalStockValue // ignore: cast_nullable_to_non_nullable
                  as double,
        lowStockProducts: null == lowStockProducts
            ? _value.lowStockProducts
            : lowStockProducts // ignore: cast_nullable_to_non_nullable
                  as int,
        highStockProducts: null == highStockProducts
            ? _value.highStockProducts
            : highStockProducts // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StockStatisticsImpl implements _StockStatistics {
  const _$StockStatisticsImpl({
    this.totalProducts = 0,
    this.totalStockValue = 0.0,
    this.lowStockProducts = 0,
    this.highStockProducts = 0,
  });

  factory _$StockStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockStatisticsImplFromJson(json);

  @override
  @JsonKey()
  final int totalProducts;
  @override
  @JsonKey()
  final double totalStockValue;
  @override
  @JsonKey()
  final int lowStockProducts;
  @override
  @JsonKey()
  final int highStockProducts;

  @override
  String toString() {
    return 'StockStatistics(totalProducts: $totalProducts, totalStockValue: $totalStockValue, lowStockProducts: $lowStockProducts, highStockProducts: $highStockProducts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockStatisticsImpl &&
            (identical(other.totalProducts, totalProducts) ||
                other.totalProducts == totalProducts) &&
            (identical(other.totalStockValue, totalStockValue) ||
                other.totalStockValue == totalStockValue) &&
            (identical(other.lowStockProducts, lowStockProducts) ||
                other.lowStockProducts == lowStockProducts) &&
            (identical(other.highStockProducts, highStockProducts) ||
                other.highStockProducts == highStockProducts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalProducts,
    totalStockValue,
    lowStockProducts,
    highStockProducts,
  );

  /// Create a copy of StockStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockStatisticsImplCopyWith<_$StockStatisticsImpl> get copyWith =>
      __$$StockStatisticsImplCopyWithImpl<_$StockStatisticsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StockStatisticsImplToJson(this);
  }
}

abstract class _StockStatistics implements StockStatistics {
  const factory _StockStatistics({
    final int totalProducts,
    final double totalStockValue,
    final int lowStockProducts,
    final int highStockProducts,
  }) = _$StockStatisticsImpl;

  factory _StockStatistics.fromJson(Map<String, dynamic> json) =
      _$StockStatisticsImpl.fromJson;

  @override
  int get totalProducts;
  @override
  double get totalStockValue;
  @override
  int get lowStockProducts;
  @override
  int get highStockProducts;

  /// Create a copy of StockStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockStatisticsImplCopyWith<_$StockStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return _Shop.fromJson(json);
}

/// @nodoc
mixin _$Shop {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError; // Ülke/şehir bilgileri
  String? get country => throw _privateConstructorUsedError;
  String? get city =>
      throw _privateConstructorUsedError; // Eski locationalan tutmak için
  String get location => throw _privateConstructorUsedError;
  String get locationType => throw _privateConstructorUsedError;
  int get squareMeters => throw _privateConstructorUsedError;
  int get floor => throw _privateConstructorUsedError;
  double get monthlyRent => throw _privateConstructorUsedError;
  double get deposit => throw _privateConstructorUsedError;
  bool get hasWindow => throw _privateConstructorUsedError;
  int get parkingSpaces => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  String? get rentedBy => throw _privateConstructorUsedError;
  DateTime? get rentedDate => throw _privateConstructorUsedError;
  String? get businessCategory => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  double get monthlyRevenue => throw _privateConstructorUsedError;
  int get monthlyCustomers =>
      throw _privateConstructorUsedError; // Ekonomik sistem alanları
  List<ListedProduct> get listedProducts => throw _privateConstructorUsedError;
  AutoPurchaseSettings? get autoPurchaseSettings =>
      throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this Shop to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopCopyWith<Shop> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopCopyWith<$Res> {
  factory $ShopCopyWith(Shop value, $Res Function(Shop) then) =
      _$ShopCopyWithImpl<$Res, Shop>;
  @useResult
  $Res call({
    String id,
    String name,
    String? country,
    String? city,
    String location,
    String locationType,
    int squareMeters,
    int floor,
    double monthlyRent,
    double deposit,
    bool hasWindow,
    int parkingSpaces,
    bool isAvailable,
    String? rentedBy,
    DateTime? rentedDate,
    String? businessCategory,
    bool isActive,
    double monthlyRevenue,
    int monthlyCustomers,
    List<ListedProduct> listedProducts,
    AutoPurchaseSettings? autoPurchaseSettings,
    String? imageUrl,
  });

  $AutoPurchaseSettingsCopyWith<$Res>? get autoPurchaseSettings;
}

/// @nodoc
class _$ShopCopyWithImpl<$Res, $Val extends Shop>
    implements $ShopCopyWith<$Res> {
  _$ShopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? country = freezed,
    Object? city = freezed,
    Object? location = null,
    Object? locationType = null,
    Object? squareMeters = null,
    Object? floor = null,
    Object? monthlyRent = null,
    Object? deposit = null,
    Object? hasWindow = null,
    Object? parkingSpaces = null,
    Object? isAvailable = null,
    Object? rentedBy = freezed,
    Object? rentedDate = freezed,
    Object? businessCategory = freezed,
    Object? isActive = null,
    Object? monthlyRevenue = null,
    Object? monthlyCustomers = null,
    Object? listedProducts = null,
    Object? autoPurchaseSettings = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            locationType: null == locationType
                ? _value.locationType
                : locationType // ignore: cast_nullable_to_non_nullable
                      as String,
            squareMeters: null == squareMeters
                ? _value.squareMeters
                : squareMeters // ignore: cast_nullable_to_non_nullable
                      as int,
            floor: null == floor
                ? _value.floor
                : floor // ignore: cast_nullable_to_non_nullable
                      as int,
            monthlyRent: null == monthlyRent
                ? _value.monthlyRent
                : monthlyRent // ignore: cast_nullable_to_non_nullable
                      as double,
            deposit: null == deposit
                ? _value.deposit
                : deposit // ignore: cast_nullable_to_non_nullable
                      as double,
            hasWindow: null == hasWindow
                ? _value.hasWindow
                : hasWindow // ignore: cast_nullable_to_non_nullable
                      as bool,
            parkingSpaces: null == parkingSpaces
                ? _value.parkingSpaces
                : parkingSpaces // ignore: cast_nullable_to_non_nullable
                      as int,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            rentedBy: freezed == rentedBy
                ? _value.rentedBy
                : rentedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            rentedDate: freezed == rentedDate
                ? _value.rentedDate
                : rentedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            businessCategory: freezed == businessCategory
                ? _value.businessCategory
                : businessCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            monthlyRevenue: null == monthlyRevenue
                ? _value.monthlyRevenue
                : monthlyRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            monthlyCustomers: null == monthlyCustomers
                ? _value.monthlyCustomers
                : monthlyCustomers // ignore: cast_nullable_to_non_nullable
                      as int,
            listedProducts: null == listedProducts
                ? _value.listedProducts
                : listedProducts // ignore: cast_nullable_to_non_nullable
                      as List<ListedProduct>,
            autoPurchaseSettings: freezed == autoPurchaseSettings
                ? _value.autoPurchaseSettings
                : autoPurchaseSettings // ignore: cast_nullable_to_non_nullable
                      as AutoPurchaseSettings?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AutoPurchaseSettingsCopyWith<$Res>? get autoPurchaseSettings {
    if (_value.autoPurchaseSettings == null) {
      return null;
    }

    return $AutoPurchaseSettingsCopyWith<$Res>(_value.autoPurchaseSettings!, (
      value,
    ) {
      return _then(_value.copyWith(autoPurchaseSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShopImplCopyWith<$Res> implements $ShopCopyWith<$Res> {
  factory _$$ShopImplCopyWith(
    _$ShopImpl value,
    $Res Function(_$ShopImpl) then,
  ) = __$$ShopImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? country,
    String? city,
    String location,
    String locationType,
    int squareMeters,
    int floor,
    double monthlyRent,
    double deposit,
    bool hasWindow,
    int parkingSpaces,
    bool isAvailable,
    String? rentedBy,
    DateTime? rentedDate,
    String? businessCategory,
    bool isActive,
    double monthlyRevenue,
    int monthlyCustomers,
    List<ListedProduct> listedProducts,
    AutoPurchaseSettings? autoPurchaseSettings,
    String? imageUrl,
  });

  @override
  $AutoPurchaseSettingsCopyWith<$Res>? get autoPurchaseSettings;
}

/// @nodoc
class __$$ShopImplCopyWithImpl<$Res>
    extends _$ShopCopyWithImpl<$Res, _$ShopImpl>
    implements _$$ShopImplCopyWith<$Res> {
  __$$ShopImplCopyWithImpl(_$ShopImpl _value, $Res Function(_$ShopImpl) _then)
    : super(_value, _then);

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? country = freezed,
    Object? city = freezed,
    Object? location = null,
    Object? locationType = null,
    Object? squareMeters = null,
    Object? floor = null,
    Object? monthlyRent = null,
    Object? deposit = null,
    Object? hasWindow = null,
    Object? parkingSpaces = null,
    Object? isAvailable = null,
    Object? rentedBy = freezed,
    Object? rentedDate = freezed,
    Object? businessCategory = freezed,
    Object? isActive = null,
    Object? monthlyRevenue = null,
    Object? monthlyCustomers = null,
    Object? listedProducts = null,
    Object? autoPurchaseSettings = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$ShopImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        locationType: null == locationType
            ? _value.locationType
            : locationType // ignore: cast_nullable_to_non_nullable
                  as String,
        squareMeters: null == squareMeters
            ? _value.squareMeters
            : squareMeters // ignore: cast_nullable_to_non_nullable
                  as int,
        floor: null == floor
            ? _value.floor
            : floor // ignore: cast_nullable_to_non_nullable
                  as int,
        monthlyRent: null == monthlyRent
            ? _value.monthlyRent
            : monthlyRent // ignore: cast_nullable_to_non_nullable
                  as double,
        deposit: null == deposit
            ? _value.deposit
            : deposit // ignore: cast_nullable_to_non_nullable
                  as double,
        hasWindow: null == hasWindow
            ? _value.hasWindow
            : hasWindow // ignore: cast_nullable_to_non_nullable
                  as bool,
        parkingSpaces: null == parkingSpaces
            ? _value.parkingSpaces
            : parkingSpaces // ignore: cast_nullable_to_non_nullable
                  as int,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        rentedBy: freezed == rentedBy
            ? _value.rentedBy
            : rentedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        rentedDate: freezed == rentedDate
            ? _value.rentedDate
            : rentedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        businessCategory: freezed == businessCategory
            ? _value.businessCategory
            : businessCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        monthlyRevenue: null == monthlyRevenue
            ? _value.monthlyRevenue
            : monthlyRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        monthlyCustomers: null == monthlyCustomers
            ? _value.monthlyCustomers
            : monthlyCustomers // ignore: cast_nullable_to_non_nullable
                  as int,
        listedProducts: null == listedProducts
            ? _value._listedProducts
            : listedProducts // ignore: cast_nullable_to_non_nullable
                  as List<ListedProduct>,
        autoPurchaseSettings: freezed == autoPurchaseSettings
            ? _value.autoPurchaseSettings
            : autoPurchaseSettings // ignore: cast_nullable_to_non_nullable
                  as AutoPurchaseSettings?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopImpl implements _Shop {
  const _$ShopImpl({
    required this.id,
    required this.name,
    this.country,
    this.city,
    required this.location,
    this.locationType = 'street',
    this.squareMeters = 50,
    this.floor = 1,
    required this.monthlyRent,
    required this.deposit,
    this.hasWindow = false,
    this.parkingSpaces = 0,
    this.isAvailable = true,
    this.rentedBy,
    this.rentedDate,
    this.businessCategory,
    this.isActive = false,
    this.monthlyRevenue = 0.0,
    this.monthlyCustomers = 0,
    final List<ListedProduct> listedProducts = const [],
    this.autoPurchaseSettings,
    this.imageUrl,
  }) : _listedProducts = listedProducts;

  factory _$ShopImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  // Ülke/şehir bilgileri
  @override
  final String? country;
  @override
  final String? city;
  // Eski locationalan tutmak için
  @override
  final String location;
  @override
  @JsonKey()
  final String locationType;
  @override
  @JsonKey()
  final int squareMeters;
  @override
  @JsonKey()
  final int floor;
  @override
  final double monthlyRent;
  @override
  final double deposit;
  @override
  @JsonKey()
  final bool hasWindow;
  @override
  @JsonKey()
  final int parkingSpaces;
  @override
  @JsonKey()
  final bool isAvailable;
  @override
  final String? rentedBy;
  @override
  final DateTime? rentedDate;
  @override
  final String? businessCategory;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final double monthlyRevenue;
  @override
  @JsonKey()
  final int monthlyCustomers;
  // Ekonomik sistem alanları
  final List<ListedProduct> _listedProducts;
  // Ekonomik sistem alanları
  @override
  @JsonKey()
  List<ListedProduct> get listedProducts {
    if (_listedProducts is EqualUnmodifiableListView) return _listedProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listedProducts);
  }

  @override
  final AutoPurchaseSettings? autoPurchaseSettings;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, country: $country, city: $city, location: $location, locationType: $locationType, squareMeters: $squareMeters, floor: $floor, monthlyRent: $monthlyRent, deposit: $deposit, hasWindow: $hasWindow, parkingSpaces: $parkingSpaces, isAvailable: $isAvailable, rentedBy: $rentedBy, rentedDate: $rentedDate, businessCategory: $businessCategory, isActive: $isActive, monthlyRevenue: $monthlyRevenue, monthlyCustomers: $monthlyCustomers, listedProducts: $listedProducts, autoPurchaseSettings: $autoPurchaseSettings, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType) &&
            (identical(other.squareMeters, squareMeters) ||
                other.squareMeters == squareMeters) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.monthlyRent, monthlyRent) ||
                other.monthlyRent == monthlyRent) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.hasWindow, hasWindow) ||
                other.hasWindow == hasWindow) &&
            (identical(other.parkingSpaces, parkingSpaces) ||
                other.parkingSpaces == parkingSpaces) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.rentedBy, rentedBy) ||
                other.rentedBy == rentedBy) &&
            (identical(other.rentedDate, rentedDate) ||
                other.rentedDate == rentedDate) &&
            (identical(other.businessCategory, businessCategory) ||
                other.businessCategory == businessCategory) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.monthlyRevenue, monthlyRevenue) ||
                other.monthlyRevenue == monthlyRevenue) &&
            (identical(other.monthlyCustomers, monthlyCustomers) ||
                other.monthlyCustomers == monthlyCustomers) &&
            const DeepCollectionEquality().equals(
              other._listedProducts,
              _listedProducts,
            ) &&
            (identical(other.autoPurchaseSettings, autoPurchaseSettings) ||
                other.autoPurchaseSettings == autoPurchaseSettings) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    country,
    city,
    location,
    locationType,
    squareMeters,
    floor,
    monthlyRent,
    deposit,
    hasWindow,
    parkingSpaces,
    isAvailable,
    rentedBy,
    rentedDate,
    businessCategory,
    isActive,
    monthlyRevenue,
    monthlyCustomers,
    const DeepCollectionEquality().hash(_listedProducts),
    autoPurchaseSettings,
    imageUrl,
  ]);

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopImplCopyWith<_$ShopImpl> get copyWith =>
      __$$ShopImplCopyWithImpl<_$ShopImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopImplToJson(this);
  }
}

abstract class _Shop implements Shop {
  const factory _Shop({
    required final String id,
    required final String name,
    final String? country,
    final String? city,
    required final String location,
    final String locationType,
    final int squareMeters,
    final int floor,
    required final double monthlyRent,
    required final double deposit,
    final bool hasWindow,
    final int parkingSpaces,
    final bool isAvailable,
    final String? rentedBy,
    final DateTime? rentedDate,
    final String? businessCategory,
    final bool isActive,
    final double monthlyRevenue,
    final int monthlyCustomers,
    final List<ListedProduct> listedProducts,
    final AutoPurchaseSettings? autoPurchaseSettings,
    final String? imageUrl,
  }) = _$ShopImpl;

  factory _Shop.fromJson(Map<String, dynamic> json) = _$ShopImpl.fromJson;

  @override
  String get id;
  @override
  String get name; // Ülke/şehir bilgileri
  @override
  String? get country;
  @override
  String? get city; // Eski locationalan tutmak için
  @override
  String get location;
  @override
  String get locationType;
  @override
  int get squareMeters;
  @override
  int get floor;
  @override
  double get monthlyRent;
  @override
  double get deposit;
  @override
  bool get hasWindow;
  @override
  int get parkingSpaces;
  @override
  bool get isAvailable;
  @override
  String? get rentedBy;
  @override
  DateTime? get rentedDate;
  @override
  String? get businessCategory;
  @override
  bool get isActive;
  @override
  double get monthlyRevenue;
  @override
  int get monthlyCustomers; // Ekonomik sistem alanları
  @override
  List<ListedProduct> get listedProducts;
  @override
  AutoPurchaseSettings? get autoPurchaseSettings;
  @override
  String? get imageUrl;

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopImplCopyWith<_$ShopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShopType _$ShopTypeFromJson(Map<String, dynamic> json) {
  return _ShopType.fromJson(json);
}

/// @nodoc
mixin _$ShopType {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get shopType =>
      throw _privateConstructorUsedError; // kodu: 'flower_shop', 'supermarket' vs
  String get displayName =>
      throw _privateConstructorUsedError; // görünüm adı: 'Çiçekçi Mağazası'
  String get nameTemplate =>
      throw _privateConstructorUsedError; // '{ŞEHİR} {TÜR}'
  double get purchasePrice =>
      throw _privateConstructorUsedError; // satın alma ücreti
  int get rackCapacity => throw _privateConstructorUsedError; // raf kapasitesi
  int get storageCapacity =>
      throw _privateConstructorUsedError; // depo kapasitesi (adet)
  int get minCustomers => throw _privateConstructorUsedError; // minimum müşteri
  String get locationType =>
      throw _privateConstructorUsedError; // 'street', 'mall' vs
  List<String> get allowedCategories =>
      throw _privateConstructorUsedError; // izin verilen ürün kategorileri
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this ShopType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopTypeCopyWith<ShopType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopTypeCopyWith<$Res> {
  factory $ShopTypeCopyWith(ShopType value, $Res Function(ShopType) then) =
      _$ShopTypeCopyWithImpl<$Res, ShopType>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String shopType,
    String displayName,
    String nameTemplate,
    double purchasePrice,
    int rackCapacity,
    int storageCapacity,
    int minCustomers,
    String locationType,
    List<String> allowedCategories,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
  });
}

/// @nodoc
class _$ShopTypeCopyWithImpl<$Res, $Val extends ShopType>
    implements $ShopTypeCopyWith<$Res> {
  _$ShopTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopType = null,
    Object? displayName = null,
    Object? nameTemplate = null,
    Object? purchasePrice = null,
    Object? rackCapacity = null,
    Object? storageCapacity = null,
    Object? minCustomers = null,
    Object? locationType = null,
    Object? allowedCategories = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            shopType: null == shopType
                ? _value.shopType
                : shopType // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            nameTemplate: null == nameTemplate
                ? _value.nameTemplate
                : nameTemplate // ignore: cast_nullable_to_non_nullable
                      as String,
            purchasePrice: null == purchasePrice
                ? _value.purchasePrice
                : purchasePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            rackCapacity: null == rackCapacity
                ? _value.rackCapacity
                : rackCapacity // ignore: cast_nullable_to_non_nullable
                      as int,
            storageCapacity: null == storageCapacity
                ? _value.storageCapacity
                : storageCapacity // ignore: cast_nullable_to_non_nullable
                      as int,
            minCustomers: null == minCustomers
                ? _value.minCustomers
                : minCustomers // ignore: cast_nullable_to_non_nullable
                      as int,
            locationType: null == locationType
                ? _value.locationType
                : locationType // ignore: cast_nullable_to_non_nullable
                      as String,
            allowedCategories: null == allowedCategories
                ? _value.allowedCategories
                : allowedCategories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShopTypeImplCopyWith<$Res>
    implements $ShopTypeCopyWith<$Res> {
  factory _$$ShopTypeImplCopyWith(
    _$ShopTypeImpl value,
    $Res Function(_$ShopTypeImpl) then,
  ) = __$$ShopTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String shopType,
    String displayName,
    String nameTemplate,
    double purchasePrice,
    int rackCapacity,
    int storageCapacity,
    int minCustomers,
    String locationType,
    List<String> allowedCategories,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
  });
}

/// @nodoc
class __$$ShopTypeImplCopyWithImpl<$Res>
    extends _$ShopTypeCopyWithImpl<$Res, _$ShopTypeImpl>
    implements _$$ShopTypeImplCopyWith<$Res> {
  __$$ShopTypeImplCopyWithImpl(
    _$ShopTypeImpl _value,
    $Res Function(_$ShopTypeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopType = null,
    Object? displayName = null,
    Object? nameTemplate = null,
    Object? purchasePrice = null,
    Object? rackCapacity = null,
    Object? storageCapacity = null,
    Object? minCustomers = null,
    Object? locationType = null,
    Object? allowedCategories = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$ShopTypeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        shopType: null == shopType
            ? _value.shopType
            : shopType // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        nameTemplate: null == nameTemplate
            ? _value.nameTemplate
            : nameTemplate // ignore: cast_nullable_to_non_nullable
                  as String,
        purchasePrice: null == purchasePrice
            ? _value.purchasePrice
            : purchasePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        rackCapacity: null == rackCapacity
            ? _value.rackCapacity
            : rackCapacity // ignore: cast_nullable_to_non_nullable
                  as int,
        storageCapacity: null == storageCapacity
            ? _value.storageCapacity
            : storageCapacity // ignore: cast_nullable_to_non_nullable
                  as int,
        minCustomers: null == minCustomers
            ? _value.minCustomers
            : minCustomers // ignore: cast_nullable_to_non_nullable
                  as int,
        locationType: null == locationType
            ? _value.locationType
            : locationType // ignore: cast_nullable_to_non_nullable
                  as String,
        allowedCategories: null == allowedCategories
            ? _value._allowedCategories
            : allowedCategories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopTypeImpl implements _ShopType {
  const _$ShopTypeImpl({
    @JsonKey(name: '_id') required this.id,
    required this.shopType,
    required this.displayName,
    required this.nameTemplate,
    required this.purchasePrice,
    required this.rackCapacity,
    required this.storageCapacity,
    required this.minCustomers,
    required this.locationType,
    final List<String> allowedCategories = const [],
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  }) : _allowedCategories = allowedCategories;

  factory _$ShopTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopTypeImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String shopType;
  // kodu: 'flower_shop', 'supermarket' vs
  @override
  final String displayName;
  // görünüm adı: 'Çiçekçi Mağazası'
  @override
  final String nameTemplate;
  // '{ŞEHİR} {TÜR}'
  @override
  final double purchasePrice;
  // satın alma ücreti
  @override
  final int rackCapacity;
  // raf kapasitesi
  @override
  final int storageCapacity;
  // depo kapasitesi (adet)
  @override
  final int minCustomers;
  // minimum müşteri
  @override
  final String locationType;
  // 'street', 'mall' vs
  final List<String> _allowedCategories;
  // 'street', 'mall' vs
  @override
  @JsonKey()
  List<String> get allowedCategories {
    if (_allowedCategories is EqualUnmodifiableListView)
      return _allowedCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedCategories);
  }

  // izin verilen ürün kategorileri
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'ShopType(id: $id, shopType: $shopType, displayName: $displayName, nameTemplate: $nameTemplate, purchasePrice: $purchasePrice, rackCapacity: $rackCapacity, storageCapacity: $storageCapacity, minCustomers: $minCustomers, locationType: $locationType, allowedCategories: $allowedCategories, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shopType, shopType) ||
                other.shopType == shopType) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.nameTemplate, nameTemplate) ||
                other.nameTemplate == nameTemplate) &&
            (identical(other.purchasePrice, purchasePrice) ||
                other.purchasePrice == purchasePrice) &&
            (identical(other.rackCapacity, rackCapacity) ||
                other.rackCapacity == rackCapacity) &&
            (identical(other.storageCapacity, storageCapacity) ||
                other.storageCapacity == storageCapacity) &&
            (identical(other.minCustomers, minCustomers) ||
                other.minCustomers == minCustomers) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType) &&
            const DeepCollectionEquality().equals(
              other._allowedCategories,
              _allowedCategories,
            ) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    shopType,
    displayName,
    nameTemplate,
    purchasePrice,
    rackCapacity,
    storageCapacity,
    minCustomers,
    locationType,
    const DeepCollectionEquality().hash(_allowedCategories),
    isActive,
    createdAt,
    updatedAt,
    imageUrl,
  );

  /// Create a copy of ShopType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopTypeImplCopyWith<_$ShopTypeImpl> get copyWith =>
      __$$ShopTypeImplCopyWithImpl<_$ShopTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopTypeImplToJson(this);
  }
}

abstract class _ShopType implements ShopType {
  const factory _ShopType({
    @JsonKey(name: '_id') required final String id,
    required final String shopType,
    required final String displayName,
    required final String nameTemplate,
    required final double purchasePrice,
    required final int rackCapacity,
    required final int storageCapacity,
    required final int minCustomers,
    required final String locationType,
    final List<String> allowedCategories,
    final bool isActive,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final String? imageUrl,
  }) = _$ShopTypeImpl;

  factory _ShopType.fromJson(Map<String, dynamic> json) =
      _$ShopTypeImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get shopType; // kodu: 'flower_shop', 'supermarket' vs
  @override
  String get displayName; // görünüm adı: 'Çiçekçi Mağazası'
  @override
  String get nameTemplate; // '{ŞEHİR} {TÜR}'
  @override
  double get purchasePrice; // satın alma ücreti
  @override
  int get rackCapacity; // raf kapasitesi
  @override
  int get storageCapacity; // depo kapasitesi (adet)
  @override
  int get minCustomers; // minimum müşteri
  @override
  String get locationType; // 'street', 'mall' vs
  @override
  List<String> get allowedCategories; // izin verilen ürün kategorileri
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get imageUrl;

  /// Create a copy of ShopType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopTypeImplCopyWith<_$ShopTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShopInstance _$ShopInstanceFromJson(Map<String, dynamic> json) {
  return _ShopInstance.fromJson(json);
}

/// @nodoc
mixin _$ShopInstance {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get shopType =>
      throw _privateConstructorUsedError; // bağlı olduğu type kodu
  ShopType? get shopTypeData =>
      throw _privateConstructorUsedError; // populate edildiğinde gelir
  String get ownerId => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get customName => throw _privateConstructorUsedError; // mağaza adı
  DateTime get purchasedAt =>
      throw _privateConstructorUsedError; // İşletme istatistikleri
  double get monthlyRevenue => throw _privateConstructorUsedError;
  int get monthlyCustomers => throw _privateConstructorUsedError;
  bool get isActive =>
      throw _privateConstructorUsedError; // Ürün sistemi (eski sistemden)
  List<ListedProduct> get listedProducts => throw _privateConstructorUsedError;
  AutoPurchaseSettings? get autoPurchaseSettings =>
      throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this ShopInstance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopInstance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopInstanceCopyWith<ShopInstance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopInstanceCopyWith<$Res> {
  factory $ShopInstanceCopyWith(
    ShopInstance value,
    $Res Function(ShopInstance) then,
  ) = _$ShopInstanceCopyWithImpl<$Res, ShopInstance>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String shopType,
    ShopType? shopTypeData,
    String ownerId,
    String country,
    String city,
    String customName,
    DateTime purchasedAt,
    double monthlyRevenue,
    int monthlyCustomers,
    bool isActive,
    List<ListedProduct> listedProducts,
    AutoPurchaseSettings? autoPurchaseSettings,
    String? imageUrl,
  });

  $ShopTypeCopyWith<$Res>? get shopTypeData;
  $AutoPurchaseSettingsCopyWith<$Res>? get autoPurchaseSettings;
}

/// @nodoc
class _$ShopInstanceCopyWithImpl<$Res, $Val extends ShopInstance>
    implements $ShopInstanceCopyWith<$Res> {
  _$ShopInstanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopInstance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopType = null,
    Object? shopTypeData = freezed,
    Object? ownerId = null,
    Object? country = null,
    Object? city = null,
    Object? customName = null,
    Object? purchasedAt = null,
    Object? monthlyRevenue = null,
    Object? monthlyCustomers = null,
    Object? isActive = null,
    Object? listedProducts = null,
    Object? autoPurchaseSettings = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            shopType: null == shopType
                ? _value.shopType
                : shopType // ignore: cast_nullable_to_non_nullable
                      as String,
            shopTypeData: freezed == shopTypeData
                ? _value.shopTypeData
                : shopTypeData // ignore: cast_nullable_to_non_nullable
                      as ShopType?,
            ownerId: null == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as String,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            customName: null == customName
                ? _value.customName
                : customName // ignore: cast_nullable_to_non_nullable
                      as String,
            purchasedAt: null == purchasedAt
                ? _value.purchasedAt
                : purchasedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            monthlyRevenue: null == monthlyRevenue
                ? _value.monthlyRevenue
                : monthlyRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            monthlyCustomers: null == monthlyCustomers
                ? _value.monthlyCustomers
                : monthlyCustomers // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            listedProducts: null == listedProducts
                ? _value.listedProducts
                : listedProducts // ignore: cast_nullable_to_non_nullable
                      as List<ListedProduct>,
            autoPurchaseSettings: freezed == autoPurchaseSettings
                ? _value.autoPurchaseSettings
                : autoPurchaseSettings // ignore: cast_nullable_to_non_nullable
                      as AutoPurchaseSettings?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ShopInstance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShopTypeCopyWith<$Res>? get shopTypeData {
    if (_value.shopTypeData == null) {
      return null;
    }

    return $ShopTypeCopyWith<$Res>(_value.shopTypeData!, (value) {
      return _then(_value.copyWith(shopTypeData: value) as $Val);
    });
  }

  /// Create a copy of ShopInstance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AutoPurchaseSettingsCopyWith<$Res>? get autoPurchaseSettings {
    if (_value.autoPurchaseSettings == null) {
      return null;
    }

    return $AutoPurchaseSettingsCopyWith<$Res>(_value.autoPurchaseSettings!, (
      value,
    ) {
      return _then(_value.copyWith(autoPurchaseSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShopInstanceImplCopyWith<$Res>
    implements $ShopInstanceCopyWith<$Res> {
  factory _$$ShopInstanceImplCopyWith(
    _$ShopInstanceImpl value,
    $Res Function(_$ShopInstanceImpl) then,
  ) = __$$ShopInstanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String shopType,
    ShopType? shopTypeData,
    String ownerId,
    String country,
    String city,
    String customName,
    DateTime purchasedAt,
    double monthlyRevenue,
    int monthlyCustomers,
    bool isActive,
    List<ListedProduct> listedProducts,
    AutoPurchaseSettings? autoPurchaseSettings,
    String? imageUrl,
  });

  @override
  $ShopTypeCopyWith<$Res>? get shopTypeData;
  @override
  $AutoPurchaseSettingsCopyWith<$Res>? get autoPurchaseSettings;
}

/// @nodoc
class __$$ShopInstanceImplCopyWithImpl<$Res>
    extends _$ShopInstanceCopyWithImpl<$Res, _$ShopInstanceImpl>
    implements _$$ShopInstanceImplCopyWith<$Res> {
  __$$ShopInstanceImplCopyWithImpl(
    _$ShopInstanceImpl _value,
    $Res Function(_$ShopInstanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopInstance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopType = null,
    Object? shopTypeData = freezed,
    Object? ownerId = null,
    Object? country = null,
    Object? city = null,
    Object? customName = null,
    Object? purchasedAt = null,
    Object? monthlyRevenue = null,
    Object? monthlyCustomers = null,
    Object? isActive = null,
    Object? listedProducts = null,
    Object? autoPurchaseSettings = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$ShopInstanceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        shopType: null == shopType
            ? _value.shopType
            : shopType // ignore: cast_nullable_to_non_nullable
                  as String,
        shopTypeData: freezed == shopTypeData
            ? _value.shopTypeData
            : shopTypeData // ignore: cast_nullable_to_non_nullable
                  as ShopType?,
        ownerId: null == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        customName: null == customName
            ? _value.customName
            : customName // ignore: cast_nullable_to_non_nullable
                  as String,
        purchasedAt: null == purchasedAt
            ? _value.purchasedAt
            : purchasedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        monthlyRevenue: null == monthlyRevenue
            ? _value.monthlyRevenue
            : monthlyRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        monthlyCustomers: null == monthlyCustomers
            ? _value.monthlyCustomers
            : monthlyCustomers // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        listedProducts: null == listedProducts
            ? _value._listedProducts
            : listedProducts // ignore: cast_nullable_to_non_nullable
                  as List<ListedProduct>,
        autoPurchaseSettings: freezed == autoPurchaseSettings
            ? _value.autoPurchaseSettings
            : autoPurchaseSettings // ignore: cast_nullable_to_non_nullable
                  as AutoPurchaseSettings?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopInstanceImpl implements _ShopInstance {
  const _$ShopInstanceImpl({
    @JsonKey(name: '_id') required this.id,
    required this.shopType,
    this.shopTypeData,
    required this.ownerId,
    required this.country,
    required this.city,
    required this.customName,
    required this.purchasedAt,
    this.monthlyRevenue = 0.0,
    this.monthlyCustomers = 0,
    this.isActive = true,
    final List<ListedProduct> listedProducts = const [],
    this.autoPurchaseSettings,
    this.imageUrl,
  }) : _listedProducts = listedProducts;

  factory _$ShopInstanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopInstanceImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String shopType;
  // bağlı olduğu type kodu
  @override
  final ShopType? shopTypeData;
  // populate edildiğinde gelir
  @override
  final String ownerId;
  @override
  final String country;
  @override
  final String city;
  @override
  final String customName;
  // mağaza adı
  @override
  final DateTime purchasedAt;
  // İşletme istatistikleri
  @override
  @JsonKey()
  final double monthlyRevenue;
  @override
  @JsonKey()
  final int monthlyCustomers;
  @override
  @JsonKey()
  final bool isActive;
  // Ürün sistemi (eski sistemden)
  final List<ListedProduct> _listedProducts;
  // Ürün sistemi (eski sistemden)
  @override
  @JsonKey()
  List<ListedProduct> get listedProducts {
    if (_listedProducts is EqualUnmodifiableListView) return _listedProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listedProducts);
  }

  @override
  final AutoPurchaseSettings? autoPurchaseSettings;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'ShopInstance(id: $id, shopType: $shopType, shopTypeData: $shopTypeData, ownerId: $ownerId, country: $country, city: $city, customName: $customName, purchasedAt: $purchasedAt, monthlyRevenue: $monthlyRevenue, monthlyCustomers: $monthlyCustomers, isActive: $isActive, listedProducts: $listedProducts, autoPurchaseSettings: $autoPurchaseSettings, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopInstanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shopType, shopType) ||
                other.shopType == shopType) &&
            (identical(other.shopTypeData, shopTypeData) ||
                other.shopTypeData == shopTypeData) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.customName, customName) ||
                other.customName == customName) &&
            (identical(other.purchasedAt, purchasedAt) ||
                other.purchasedAt == purchasedAt) &&
            (identical(other.monthlyRevenue, monthlyRevenue) ||
                other.monthlyRevenue == monthlyRevenue) &&
            (identical(other.monthlyCustomers, monthlyCustomers) ||
                other.monthlyCustomers == monthlyCustomers) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(
              other._listedProducts,
              _listedProducts,
            ) &&
            (identical(other.autoPurchaseSettings, autoPurchaseSettings) ||
                other.autoPurchaseSettings == autoPurchaseSettings) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    shopType,
    shopTypeData,
    ownerId,
    country,
    city,
    customName,
    purchasedAt,
    monthlyRevenue,
    monthlyCustomers,
    isActive,
    const DeepCollectionEquality().hash(_listedProducts),
    autoPurchaseSettings,
    imageUrl,
  );

  /// Create a copy of ShopInstance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopInstanceImplCopyWith<_$ShopInstanceImpl> get copyWith =>
      __$$ShopInstanceImplCopyWithImpl<_$ShopInstanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopInstanceImplToJson(this);
  }
}

abstract class _ShopInstance implements ShopInstance {
  const factory _ShopInstance({
    @JsonKey(name: '_id') required final String id,
    required final String shopType,
    final ShopType? shopTypeData,
    required final String ownerId,
    required final String country,
    required final String city,
    required final String customName,
    required final DateTime purchasedAt,
    final double monthlyRevenue,
    final int monthlyCustomers,
    final bool isActive,
    final List<ListedProduct> listedProducts,
    final AutoPurchaseSettings? autoPurchaseSettings,
    final String? imageUrl,
  }) = _$ShopInstanceImpl;

  factory _ShopInstance.fromJson(Map<String, dynamic> json) =
      _$ShopInstanceImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get shopType; // bağlı olduğu type kodu
  @override
  ShopType? get shopTypeData; // populate edildiğinde gelir
  @override
  String get ownerId;
  @override
  String get country;
  @override
  String get city;
  @override
  String get customName; // mağaza adı
  @override
  DateTime get purchasedAt; // İşletme istatistikleri
  @override
  double get monthlyRevenue;
  @override
  int get monthlyCustomers;
  @override
  bool get isActive; // Ürün sistemi (eski sistemden)
  @override
  List<ListedProduct> get listedProducts;
  @override
  AutoPurchaseSettings? get autoPurchaseSettings;
  @override
  String? get imageUrl;

  /// Create a copy of ShopInstance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopInstanceImplCopyWith<_$ShopInstanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
