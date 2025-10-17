// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'investment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Investment _$InvestmentFromJson(Map<String, dynamic> json) {
  return _Investment.fromJson(json);
}

/// @nodoc
mixin _$Investment {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  int get shares => throw _privateConstructorUsedError;
  double get purchasePricePerShare => throw _privateConstructorUsedError;
  double get currentPricePerShare => throw _privateConstructorUsedError;
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  double get dividendsReceived => throw _privateConstructorUsedError;

  /// Serializes this Investment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvestmentCopyWith<Investment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvestmentCopyWith<$Res> {
  factory $InvestmentCopyWith(
    Investment value,
    $Res Function(Investment) then,
  ) = _$InvestmentCopyWithImpl<$Res, Investment>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String companyName,
    int shares,
    double purchasePricePerShare,
    double currentPricePerShare,
    DateTime purchaseDate,
    double dividendsReceived,
  });
}

/// @nodoc
class _$InvestmentCopyWithImpl<$Res, $Val extends Investment>
    implements $InvestmentCopyWith<$Res> {
  _$InvestmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? companyName = null,
    Object? shares = null,
    Object? purchasePricePerShare = null,
    Object? currentPricePerShare = null,
    Object? purchaseDate = null,
    Object? dividendsReceived = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyName: null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String,
            shares: null == shares
                ? _value.shares
                : shares // ignore: cast_nullable_to_non_nullable
                      as int,
            purchasePricePerShare: null == purchasePricePerShare
                ? _value.purchasePricePerShare
                : purchasePricePerShare // ignore: cast_nullable_to_non_nullable
                      as double,
            currentPricePerShare: null == currentPricePerShare
                ? _value.currentPricePerShare
                : currentPricePerShare // ignore: cast_nullable_to_non_nullable
                      as double,
            purchaseDate: null == purchaseDate
                ? _value.purchaseDate
                : purchaseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dividendsReceived: null == dividendsReceived
                ? _value.dividendsReceived
                : dividendsReceived // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InvestmentImplCopyWith<$Res>
    implements $InvestmentCopyWith<$Res> {
  factory _$$InvestmentImplCopyWith(
    _$InvestmentImpl value,
    $Res Function(_$InvestmentImpl) then,
  ) = __$$InvestmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String companyName,
    int shares,
    double purchasePricePerShare,
    double currentPricePerShare,
    DateTime purchaseDate,
    double dividendsReceived,
  });
}

/// @nodoc
class __$$InvestmentImplCopyWithImpl<$Res>
    extends _$InvestmentCopyWithImpl<$Res, _$InvestmentImpl>
    implements _$$InvestmentImplCopyWith<$Res> {
  __$$InvestmentImplCopyWithImpl(
    _$InvestmentImpl _value,
    $Res Function(_$InvestmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? companyName = null,
    Object? shares = null,
    Object? purchasePricePerShare = null,
    Object? currentPricePerShare = null,
    Object? purchaseDate = null,
    Object? dividendsReceived = null,
  }) {
    return _then(
      _$InvestmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        shares: null == shares
            ? _value.shares
            : shares // ignore: cast_nullable_to_non_nullable
                  as int,
        purchasePricePerShare: null == purchasePricePerShare
            ? _value.purchasePricePerShare
            : purchasePricePerShare // ignore: cast_nullable_to_non_nullable
                  as double,
        currentPricePerShare: null == currentPricePerShare
            ? _value.currentPricePerShare
            : currentPricePerShare // ignore: cast_nullable_to_non_nullable
                  as double,
        purchaseDate: null == purchaseDate
            ? _value.purchaseDate
            : purchaseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dividendsReceived: null == dividendsReceived
            ? _value.dividendsReceived
            : dividendsReceived // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InvestmentImpl implements _Investment {
  const _$InvestmentImpl({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.shares,
    required this.purchasePricePerShare,
    required this.currentPricePerShare,
    required this.purchaseDate,
    this.dividendsReceived = 0.0,
  });

  factory _$InvestmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvestmentImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String companyName;
  @override
  final int shares;
  @override
  final double purchasePricePerShare;
  @override
  final double currentPricePerShare;
  @override
  final DateTime purchaseDate;
  @override
  @JsonKey()
  final double dividendsReceived;

  @override
  String toString() {
    return 'Investment(id: $id, companyId: $companyId, companyName: $companyName, shares: $shares, purchasePricePerShare: $purchasePricePerShare, currentPricePerShare: $currentPricePerShare, purchaseDate: $purchaseDate, dividendsReceived: $dividendsReceived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvestmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.purchasePricePerShare, purchasePricePerShare) ||
                other.purchasePricePerShare == purchasePricePerShare) &&
            (identical(other.currentPricePerShare, currentPricePerShare) ||
                other.currentPricePerShare == currentPricePerShare) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.dividendsReceived, dividendsReceived) ||
                other.dividendsReceived == dividendsReceived));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    companyId,
    companyName,
    shares,
    purchasePricePerShare,
    currentPricePerShare,
    purchaseDate,
    dividendsReceived,
  );

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvestmentImplCopyWith<_$InvestmentImpl> get copyWith =>
      __$$InvestmentImplCopyWithImpl<_$InvestmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvestmentImplToJson(this);
  }
}

abstract class _Investment implements Investment {
  const factory _Investment({
    required final String id,
    required final String companyId,
    required final String companyName,
    required final int shares,
    required final double purchasePricePerShare,
    required final double currentPricePerShare,
    required final DateTime purchaseDate,
    final double dividendsReceived,
  }) = _$InvestmentImpl;

  factory _Investment.fromJson(Map<String, dynamic> json) =
      _$InvestmentImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get companyName;
  @override
  int get shares;
  @override
  double get purchasePricePerShare;
  @override
  double get currentPricePerShare;
  @override
  DateTime get purchaseDate;
  @override
  double get dividendsReceived;

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvestmentImplCopyWith<_$InvestmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
