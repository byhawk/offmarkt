// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

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

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  double get basePrice => throw _privateConstructorUsedError;
  double get currentPrice => throw _privateConstructorUsedError;
  int get demand => throw _privateConstructorUsedError;
  double get volatility => throw _privateConstructorUsedError;
  bool get isTrending => throw _privateConstructorUsedError;
  double get seasonalFactor => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  double get minPrice => throw _privateConstructorUsedError;
  double get maxPrice => throw _privateConstructorUsedError;
  List<PriceHistory> get priceHistory => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String emoji,
    double basePrice,
    double currentPrice,
    int demand,
    double volatility,
    bool isTrending,
    double seasonalFactor,
    String category,
    double minPrice,
    double maxPrice,
    List<PriceHistory> priceHistory,
    String? imageUrl,
  });
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? emoji = null,
    Object? basePrice = null,
    Object? currentPrice = null,
    Object? demand = null,
    Object? volatility = null,
    Object? isTrending = null,
    Object? seasonalFactor = null,
    Object? category = null,
    Object? minPrice = null,
    Object? maxPrice = null,
    Object? priceHistory = null,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            emoji: null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String,
            basePrice: null == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            currentPrice: null == currentPrice
                ? _value.currentPrice
                : currentPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            demand: null == demand
                ? _value.demand
                : demand // ignore: cast_nullable_to_non_nullable
                      as int,
            volatility: null == volatility
                ? _value.volatility
                : volatility // ignore: cast_nullable_to_non_nullable
                      as double,
            isTrending: null == isTrending
                ? _value.isTrending
                : isTrending // ignore: cast_nullable_to_non_nullable
                      as bool,
            seasonalFactor: null == seasonalFactor
                ? _value.seasonalFactor
                : seasonalFactor // ignore: cast_nullable_to_non_nullable
                      as double,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            minPrice: null == minPrice
                ? _value.minPrice
                : minPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            maxPrice: null == maxPrice
                ? _value.maxPrice
                : maxPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            priceHistory: null == priceHistory
                ? _value.priceHistory
                : priceHistory // ignore: cast_nullable_to_non_nullable
                      as List<PriceHistory>,
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
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String emoji,
    double basePrice,
    double currentPrice,
    int demand,
    double volatility,
    bool isTrending,
    double seasonalFactor,
    String category,
    double minPrice,
    double maxPrice,
    List<PriceHistory> priceHistory,
    String? imageUrl,
  });
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? emoji = null,
    Object? basePrice = null,
    Object? currentPrice = null,
    Object? demand = null,
    Object? volatility = null,
    Object? isTrending = null,
    Object? seasonalFactor = null,
    Object? category = null,
    Object? minPrice = null,
    Object? maxPrice = null,
    Object? priceHistory = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$ProductImpl(
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
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
        basePrice: null == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        currentPrice: null == currentPrice
            ? _value.currentPrice
            : currentPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        demand: null == demand
            ? _value.demand
            : demand // ignore: cast_nullable_to_non_nullable
                  as int,
        volatility: null == volatility
            ? _value.volatility
            : volatility // ignore: cast_nullable_to_non_nullable
                  as double,
        isTrending: null == isTrending
            ? _value.isTrending
            : isTrending // ignore: cast_nullable_to_non_nullable
                  as bool,
        seasonalFactor: null == seasonalFactor
            ? _value.seasonalFactor
            : seasonalFactor // ignore: cast_nullable_to_non_nullable
                  as double,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        minPrice: null == minPrice
            ? _value.minPrice
            : minPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        maxPrice: null == maxPrice
            ? _value.maxPrice
            : maxPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        priceHistory: null == priceHistory
            ? _value._priceHistory
            : priceHistory // ignore: cast_nullable_to_non_nullable
                  as List<PriceHistory>,
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
class _$ProductImpl implements _Product {
  const _$ProductImpl({
    required this.id,
    required this.name,
    this.description,
    required this.emoji,
    required this.basePrice,
    required this.currentPrice,
    this.demand = 50,
    this.volatility = 1.0,
    this.isTrending = false,
    this.seasonalFactor = 1.0,
    this.category = 'legal',
    this.minPrice = 0.0,
    this.maxPrice = 1000.0,
    final List<PriceHistory> priceHistory = const [],
    this.imageUrl,
  }) : _priceHistory = priceHistory;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String emoji;
  @override
  final double basePrice;
  @override
  final double currentPrice;
  @override
  @JsonKey()
  final int demand;
  @override
  @JsonKey()
  final double volatility;
  @override
  @JsonKey()
  final bool isTrending;
  @override
  @JsonKey()
  final double seasonalFactor;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final double minPrice;
  @override
  @JsonKey()
  final double maxPrice;
  final List<PriceHistory> _priceHistory;
  @override
  @JsonKey()
  List<PriceHistory> get priceHistory {
    if (_priceHistory is EqualUnmodifiableListView) return _priceHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_priceHistory);
  }

  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, emoji: $emoji, basePrice: $basePrice, currentPrice: $currentPrice, demand: $demand, volatility: $volatility, isTrending: $isTrending, seasonalFactor: $seasonalFactor, category: $category, minPrice: $minPrice, maxPrice: $maxPrice, priceHistory: $priceHistory, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.demand, demand) || other.demand == demand) &&
            (identical(other.volatility, volatility) ||
                other.volatility == volatility) &&
            (identical(other.isTrending, isTrending) ||
                other.isTrending == isTrending) &&
            (identical(other.seasonalFactor, seasonalFactor) ||
                other.seasonalFactor == seasonalFactor) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            const DeepCollectionEquality().equals(
              other._priceHistory,
              _priceHistory,
            ) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    emoji,
    basePrice,
    currentPrice,
    demand,
    volatility,
    isTrending,
    seasonalFactor,
    category,
    minPrice,
    maxPrice,
    const DeepCollectionEquality().hash(_priceHistory),
    imageUrl,
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product({
    required final String id,
    required final String name,
    final String? description,
    required final String emoji,
    required final double basePrice,
    required final double currentPrice,
    final int demand,
    final double volatility,
    final bool isTrending,
    final double seasonalFactor,
    final String category,
    final double minPrice,
    final double maxPrice,
    final List<PriceHistory> priceHistory,
    final String? imageUrl,
  }) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get emoji;
  @override
  double get basePrice;
  @override
  double get currentPrice;
  @override
  int get demand;
  @override
  double get volatility;
  @override
  bool get isTrending;
  @override
  double get seasonalFactor;
  @override
  String get category;
  @override
  double get minPrice;
  @override
  double get maxPrice;
  @override
  List<PriceHistory> get priceHistory;
  @override
  String? get imageUrl;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) {
  return _InventoryItem.fromJson(json);
}

/// @nodoc
mixin _$InventoryItem {
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get purchasePrice => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  DateTime get purchaseDate => throw _privateConstructorUsedError;

  /// Serializes this InventoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryItemCopyWith<InventoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryItemCopyWith<$Res> {
  factory $InventoryItemCopyWith(
    InventoryItem value,
    $Res Function(InventoryItem) then,
  ) = _$InventoryItemCopyWithImpl<$Res, InventoryItem>;
  @useResult
  $Res call({
    String productId,
    int quantity,
    double purchasePrice,
    String source,
    DateTime purchaseDate,
  });
}

/// @nodoc
class _$InventoryItemCopyWithImpl<$Res, $Val extends InventoryItem>
    implements $InventoryItemCopyWith<$Res> {
  _$InventoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? purchasePrice = null,
    Object? source = null,
    Object? purchaseDate = null,
  }) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            purchasePrice: null == purchasePrice
                ? _value.purchasePrice
                : purchasePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            purchaseDate: null == purchaseDate
                ? _value.purchaseDate
                : purchaseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryItemImplCopyWith<$Res>
    implements $InventoryItemCopyWith<$Res> {
  factory _$$InventoryItemImplCopyWith(
    _$InventoryItemImpl value,
    $Res Function(_$InventoryItemImpl) then,
  ) = __$$InventoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productId,
    int quantity,
    double purchasePrice,
    String source,
    DateTime purchaseDate,
  });
}

/// @nodoc
class __$$InventoryItemImplCopyWithImpl<$Res>
    extends _$InventoryItemCopyWithImpl<$Res, _$InventoryItemImpl>
    implements _$$InventoryItemImplCopyWith<$Res> {
  __$$InventoryItemImplCopyWithImpl(
    _$InventoryItemImpl _value,
    $Res Function(_$InventoryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? purchasePrice = null,
    Object? source = null,
    Object? purchaseDate = null,
  }) {
    return _then(
      _$InventoryItemImpl(
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        purchasePrice: null == purchasePrice
            ? _value.purchasePrice
            : purchasePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        purchaseDate: null == purchaseDate
            ? _value.purchaseDate
            : purchaseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryItemImpl implements _InventoryItem {
  const _$InventoryItemImpl({
    required this.productId,
    required this.quantity,
    required this.purchasePrice,
    this.source = 'legal',
    required this.purchaseDate,
  });

  factory _$InventoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryItemImplFromJson(json);

  @override
  final String productId;
  @override
  final int quantity;
  @override
  final double purchasePrice;
  @override
  @JsonKey()
  final String source;
  @override
  final DateTime purchaseDate;

  @override
  String toString() {
    return 'InventoryItem(productId: $productId, quantity: $quantity, purchasePrice: $purchasePrice, source: $source, purchaseDate: $purchaseDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.purchasePrice, purchasePrice) ||
                other.purchasePrice == purchasePrice) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productId,
    quantity,
    purchasePrice,
    source,
    purchaseDate,
  );

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryItemImplCopyWith<_$InventoryItemImpl> get copyWith =>
      __$$InventoryItemImplCopyWithImpl<_$InventoryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryItemImplToJson(this);
  }
}

abstract class _InventoryItem implements InventoryItem {
  const factory _InventoryItem({
    required final String productId,
    required final int quantity,
    required final double purchasePrice,
    final String source,
    required final DateTime purchaseDate,
  }) = _$InventoryItemImpl;

  factory _InventoryItem.fromJson(Map<String, dynamic> json) =
      _$InventoryItemImpl.fromJson;

  @override
  String get productId;
  @override
  int get quantity;
  @override
  double get purchasePrice;
  @override
  String get source;
  @override
  DateTime get purchaseDate;

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryItemImplCopyWith<_$InventoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
