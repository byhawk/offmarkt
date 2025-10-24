// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Auction _$AuctionFromJson(Map<String, dynamic> json) {
  return _Auction.fromJson(json);
}

/// @nodoc
mixin _$Auction {
  String get id => throw _privateConstructorUsedError;
  String get itemId => throw _privateConstructorUsedError;
  String get itemName => throw _privateConstructorUsedError;
  double get highestBid => throw _privateConstructorUsedError;
  String get highestBidderId => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;

  /// Serializes this Auction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Auction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuctionCopyWith<Auction> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuctionCopyWith<$Res> {
  factory $AuctionCopyWith(Auction value, $Res Function(Auction) then) =
      _$AuctionCopyWithImpl<$Res, Auction>;
  @useResult
  $Res call({
    String id,
    String itemId,
    String itemName,
    double highestBid,
    String highestBidderId,
    DateTime endTime,
  });
}

/// @nodoc
class _$AuctionCopyWithImpl<$Res, $Val extends Auction>
    implements $AuctionCopyWith<$Res> {
  _$AuctionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Auction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? itemName = null,
    Object? highestBid = null,
    Object? highestBidderId = null,
    Object? endTime = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            itemName: null == itemName
                ? _value.itemName
                : itemName // ignore: cast_nullable_to_non_nullable
                      as String,
            highestBid: null == highestBid
                ? _value.highestBid
                : highestBid // ignore: cast_nullable_to_non_nullable
                      as double,
            highestBidderId: null == highestBidderId
                ? _value.highestBidderId
                : highestBidderId // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuctionImplCopyWith<$Res> implements $AuctionCopyWith<$Res> {
  factory _$$AuctionImplCopyWith(
    _$AuctionImpl value,
    $Res Function(_$AuctionImpl) then,
  ) = __$$AuctionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String itemId,
    String itemName,
    double highestBid,
    String highestBidderId,
    DateTime endTime,
  });
}

/// @nodoc
class __$$AuctionImplCopyWithImpl<$Res>
    extends _$AuctionCopyWithImpl<$Res, _$AuctionImpl>
    implements _$$AuctionImplCopyWith<$Res> {
  __$$AuctionImplCopyWithImpl(
    _$AuctionImpl _value,
    $Res Function(_$AuctionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Auction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? itemName = null,
    Object? highestBid = null,
    Object? highestBidderId = null,
    Object? endTime = null,
  }) {
    return _then(
      _$AuctionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        itemName: null == itemName
            ? _value.itemName
            : itemName // ignore: cast_nullable_to_non_nullable
                  as String,
        highestBid: null == highestBid
            ? _value.highestBid
            : highestBid // ignore: cast_nullable_to_non_nullable
                  as double,
        highestBidderId: null == highestBidderId
            ? _value.highestBidderId
            : highestBidderId // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuctionImpl implements _Auction {
  const _$AuctionImpl({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.highestBid,
    required this.highestBidderId,
    required this.endTime,
  });

  factory _$AuctionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuctionImplFromJson(json);

  @override
  final String id;
  @override
  final String itemId;
  @override
  final String itemName;
  @override
  final double highestBid;
  @override
  final String highestBidderId;
  @override
  final DateTime endTime;

  @override
  String toString() {
    return 'Auction(id: $id, itemId: $itemId, itemName: $itemName, highestBid: $highestBid, highestBidderId: $highestBidderId, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuctionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.highestBid, highestBid) ||
                other.highestBid == highestBid) &&
            (identical(other.highestBidderId, highestBidderId) ||
                other.highestBidderId == highestBidderId) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    itemId,
    itemName,
    highestBid,
    highestBidderId,
    endTime,
  );

  /// Create a copy of Auction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuctionImplCopyWith<_$AuctionImpl> get copyWith =>
      __$$AuctionImplCopyWithImpl<_$AuctionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuctionImplToJson(this);
  }
}

abstract class _Auction implements Auction {
  const factory _Auction({
    required final String id,
    required final String itemId,
    required final String itemName,
    required final double highestBid,
    required final String highestBidderId,
    required final DateTime endTime,
  }) = _$AuctionImpl;

  factory _Auction.fromJson(Map<String, dynamic> json) = _$AuctionImpl.fromJson;

  @override
  String get id;
  @override
  String get itemId;
  @override
  String get itemName;
  @override
  double get highestBid;
  @override
  String get highestBidderId;
  @override
  DateTime get endTime;

  /// Create a copy of Auction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuctionImplCopyWith<_$AuctionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
