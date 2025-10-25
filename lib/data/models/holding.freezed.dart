// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Holding _$HoldingFromJson(Map<String, dynamic> json) {
  return _Holding.fromJson(json);
}

/// @nodoc
mixin _$Holding {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get tag =>
      throw _privateConstructorUsedError; // Holding tag'i (örn: [DEAL])
  double get treasury => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  List<HoldingMember> get members => throw _privateConstructorUsedError;

  /// Serializes this Holding to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Holding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldingCopyWith<Holding> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldingCopyWith<$Res> {
  factory $HoldingCopyWith(Holding value, $Res Function(Holding) then) =
      _$HoldingCopyWithImpl<$Res, Holding>;
  @useResult
  $Res call({
    String id,
    String name,
    String tag,
    double treasury,
    int level,
    List<HoldingMember> members,
  });
}

/// @nodoc
class _$HoldingCopyWithImpl<$Res, $Val extends Holding>
    implements $HoldingCopyWith<$Res> {
  _$HoldingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Holding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tag = null,
    Object? treasury = null,
    Object? level = null,
    Object? members = null,
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
            tag: null == tag
                ? _value.tag
                : tag // ignore: cast_nullable_to_non_nullable
                      as String,
            treasury: null == treasury
                ? _value.treasury
                : treasury // ignore: cast_nullable_to_non_nullable
                      as double,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            members: null == members
                ? _value.members
                : members // ignore: cast_nullable_to_non_nullable
                      as List<HoldingMember>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HoldingImplCopyWith<$Res> implements $HoldingCopyWith<$Res> {
  factory _$$HoldingImplCopyWith(
    _$HoldingImpl value,
    $Res Function(_$HoldingImpl) then,
  ) = __$$HoldingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String tag,
    double treasury,
    int level,
    List<HoldingMember> members,
  });
}

/// @nodoc
class __$$HoldingImplCopyWithImpl<$Res>
    extends _$HoldingCopyWithImpl<$Res, _$HoldingImpl>
    implements _$$HoldingImplCopyWith<$Res> {
  __$$HoldingImplCopyWithImpl(
    _$HoldingImpl _value,
    $Res Function(_$HoldingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Holding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tag = null,
    Object? treasury = null,
    Object? level = null,
    Object? members = null,
  }) {
    return _then(
      _$HoldingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        tag: null == tag
            ? _value.tag
            : tag // ignore: cast_nullable_to_non_nullable
                  as String,
        treasury: null == treasury
            ? _value.treasury
            : treasury // ignore: cast_nullable_to_non_nullable
                  as double,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        members: null == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<HoldingMember>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldingImpl implements _Holding {
  const _$HoldingImpl({
    required this.id,
    required this.name,
    required this.tag,
    required this.treasury,
    required this.level,
    required final List<HoldingMember> members,
  }) : _members = members;

  factory _$HoldingImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldingImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String tag;
  // Holding tag'i (örn: [DEAL])
  @override
  final double treasury;
  @override
  final int level;
  final List<HoldingMember> _members;
  @override
  List<HoldingMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'Holding(id: $id, name: $name, tag: $tag, treasury: $treasury, level: $level, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.treasury, treasury) ||
                other.treasury == treasury) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    tag,
    treasury,
    level,
    const DeepCollectionEquality().hash(_members),
  );

  /// Create a copy of Holding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldingImplCopyWith<_$HoldingImpl> get copyWith =>
      __$$HoldingImplCopyWithImpl<_$HoldingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldingImplToJson(this);
  }
}

abstract class _Holding implements Holding {
  const factory _Holding({
    required final String id,
    required final String name,
    required final String tag,
    required final double treasury,
    required final int level,
    required final List<HoldingMember> members,
  }) = _$HoldingImpl;

  factory _Holding.fromJson(Map<String, dynamic> json) = _$HoldingImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get tag; // Holding tag'i (örn: [DEAL])
  @override
  double get treasury;
  @override
  int get level;
  @override
  List<HoldingMember> get members;

  /// Create a copy of Holding
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldingImplCopyWith<_$HoldingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HoldingMember _$HoldingMemberFromJson(Map<String, dynamic> json) {
  return _HoldingMember.fromJson(json);
}

/// @nodoc
mixin _$HoldingMember {
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  HoldingRank get rank => throw _privateConstructorUsedError;
  double get totalContribution => throw _privateConstructorUsedError;

  /// Serializes this HoldingMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldingMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldingMemberCopyWith<HoldingMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldingMemberCopyWith<$Res> {
  factory $HoldingMemberCopyWith(
    HoldingMember value,
    $Res Function(HoldingMember) then,
  ) = _$HoldingMemberCopyWithImpl<$Res, HoldingMember>;
  @useResult
  $Res call({
    String playerId,
    String playerName,
    HoldingRank rank,
    double totalContribution,
  });
}

/// @nodoc
class _$HoldingMemberCopyWithImpl<$Res, $Val extends HoldingMember>
    implements $HoldingMemberCopyWith<$Res> {
  _$HoldingMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldingMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? rank = null,
    Object? totalContribution = null,
  }) {
    return _then(
      _value.copyWith(
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            playerName: null == playerName
                ? _value.playerName
                : playerName // ignore: cast_nullable_to_non_nullable
                      as String,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as HoldingRank,
            totalContribution: null == totalContribution
                ? _value.totalContribution
                : totalContribution // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HoldingMemberImplCopyWith<$Res>
    implements $HoldingMemberCopyWith<$Res> {
  factory _$$HoldingMemberImplCopyWith(
    _$HoldingMemberImpl value,
    $Res Function(_$HoldingMemberImpl) then,
  ) = __$$HoldingMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String playerId,
    String playerName,
    HoldingRank rank,
    double totalContribution,
  });
}

/// @nodoc
class __$$HoldingMemberImplCopyWithImpl<$Res>
    extends _$HoldingMemberCopyWithImpl<$Res, _$HoldingMemberImpl>
    implements _$$HoldingMemberImplCopyWith<$Res> {
  __$$HoldingMemberImplCopyWithImpl(
    _$HoldingMemberImpl _value,
    $Res Function(_$HoldingMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HoldingMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? rank = null,
    Object? totalContribution = null,
  }) {
    return _then(
      _$HoldingMemberImpl(
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        playerName: null == playerName
            ? _value.playerName
            : playerName // ignore: cast_nullable_to_non_nullable
                  as String,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as HoldingRank,
        totalContribution: null == totalContribution
            ? _value.totalContribution
            : totalContribution // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldingMemberImpl implements _HoldingMember {
  const _$HoldingMemberImpl({
    required this.playerId,
    required this.playerName,
    required this.rank,
    required this.totalContribution,
  });

  factory _$HoldingMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldingMemberImplFromJson(json);

  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final HoldingRank rank;
  @override
  final double totalContribution;

  @override
  String toString() {
    return 'HoldingMember(playerId: $playerId, playerName: $playerName, rank: $rank, totalContribution: $totalContribution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldingMemberImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.totalContribution, totalContribution) ||
                other.totalContribution == totalContribution));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, playerId, playerName, rank, totalContribution);

  /// Create a copy of HoldingMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldingMemberImplCopyWith<_$HoldingMemberImpl> get copyWith =>
      __$$HoldingMemberImplCopyWithImpl<_$HoldingMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldingMemberImplToJson(this);
  }
}

abstract class _HoldingMember implements HoldingMember {
  const factory _HoldingMember({
    required final String playerId,
    required final String playerName,
    required final HoldingRank rank,
    required final double totalContribution,
  }) = _$HoldingMemberImpl;

  factory _HoldingMember.fromJson(Map<String, dynamic> json) =
      _$HoldingMemberImpl.fromJson;

  @override
  String get playerId;
  @override
  String get playerName;
  @override
  HoldingRank get rank;
  @override
  double get totalContribution;

  /// Create a copy of HoldingMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldingMemberImplCopyWith<_$HoldingMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
