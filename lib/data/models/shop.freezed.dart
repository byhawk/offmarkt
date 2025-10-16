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

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return _Shop.fromJson(json);
}

/// @nodoc
mixin _$Shop {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
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
  int get monthlyCustomers => throw _privateConstructorUsedError;

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
  });
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
          )
          as $Val,
    );
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
  });
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
  });

  factory _$ShopImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
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

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, location: $location, locationType: $locationType, squareMeters: $squareMeters, floor: $floor, monthlyRent: $monthlyRent, deposit: $deposit, hasWindow: $hasWindow, parkingSpaces: $parkingSpaces, isAvailable: $isAvailable, rentedBy: $rentedBy, rentedDate: $rentedDate, businessCategory: $businessCategory, isActive: $isActive, monthlyRevenue: $monthlyRevenue, monthlyCustomers: $monthlyCustomers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
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
                other.monthlyCustomers == monthlyCustomers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
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
  );

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
  }) = _$ShopImpl;

  factory _Shop.fromJson(Map<String, dynamic> json) = _$ShopImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
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
  int get monthlyCustomers;

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopImplCopyWith<_$ShopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
