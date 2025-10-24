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
  List<String> get memberIds => throw _privateConstructorUsedError;
  double get treasury => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;

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
    List<String> memberIds,
    double treasury,
    int level,
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
    Object? memberIds = null,
    Object? treasury = null,
    Object? level = null,
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
            memberIds: null == memberIds
                ? _value.memberIds
                : memberIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            treasury: null == treasury
                ? _value.treasury
                : treasury // ignore: cast_nullable_to_non_nullable
                      as double,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
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
    List<String> memberIds,
    double treasury,
    int level,
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
    Object? memberIds = null,
    Object? treasury = null,
    Object? level = null,
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
        memberIds: null == memberIds
            ? _value._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        treasury: null == treasury
            ? _value.treasury
            : treasury // ignore: cast_nullable_to_non_nullable
                  as double,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
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
    required final List<String> memberIds,
    required this.treasury,
    required this.level,
  }) : _memberIds = memberIds;

  factory _$HoldingImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldingImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _memberIds;
  @override
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  @override
  final double treasury;
  @override
  final int level;

  @override
  String toString() {
    return 'Holding(id: $id, name: $name, memberIds: $memberIds, treasury: $treasury, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._memberIds,
              _memberIds,
            ) &&
            (identical(other.treasury, treasury) ||
                other.treasury == treasury) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_memberIds),
    treasury,
    level,
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
    required final List<String> memberIds,
    required final double treasury,
    required final int level,
  }) = _$HoldingImpl;

  factory _Holding.fromJson(Map<String, dynamic> json) = _$HoldingImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get memberIds;
  @override
  double get treasury;
  @override
  int get level;

  /// Create a copy of Holding
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldingImplCopyWith<_$HoldingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
