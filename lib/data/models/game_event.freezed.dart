// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameEvent _$GameEventFromJson(Map<String, dynamic> json) {
  return _GameEvent.fromJson(json);
}

/// @nodoc
mixin _$GameEvent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get sector => throw _privateConstructorUsedError;
  EventEffectType get effectType => throw _privateConstructorUsedError;
  double get effectMagnitude => throw _privateConstructorUsedError;
  DateTime get expiry => throw _privateConstructorUsedError;

  /// Serializes this GameEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameEventCopyWith<GameEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventCopyWith<$Res> {
  factory $GameEventCopyWith(GameEvent value, $Res Function(GameEvent) then) =
      _$GameEventCopyWithImpl<$Res, GameEvent>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String sector,
    EventEffectType effectType,
    double effectMagnitude,
    DateTime expiry,
  });
}

/// @nodoc
class _$GameEventCopyWithImpl<$Res, $Val extends GameEvent>
    implements $GameEventCopyWith<$Res> {
  _$GameEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? sector = null,
    Object? effectType = null,
    Object? effectMagnitude = null,
    Object? expiry = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            sector: null == sector
                ? _value.sector
                : sector // ignore: cast_nullable_to_non_nullable
                      as String,
            effectType: null == effectType
                ? _value.effectType
                : effectType // ignore: cast_nullable_to_non_nullable
                      as EventEffectType,
            effectMagnitude: null == effectMagnitude
                ? _value.effectMagnitude
                : effectMagnitude // ignore: cast_nullable_to_non_nullable
                      as double,
            expiry: null == expiry
                ? _value.expiry
                : expiry // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameEventImplCopyWith<$Res>
    implements $GameEventCopyWith<$Res> {
  factory _$$GameEventImplCopyWith(
    _$GameEventImpl value,
    $Res Function(_$GameEventImpl) then,
  ) = __$$GameEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String sector,
    EventEffectType effectType,
    double effectMagnitude,
    DateTime expiry,
  });
}

/// @nodoc
class __$$GameEventImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$GameEventImpl>
    implements _$$GameEventImplCopyWith<$Res> {
  __$$GameEventImplCopyWithImpl(
    _$GameEventImpl _value,
    $Res Function(_$GameEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? sector = null,
    Object? effectType = null,
    Object? effectMagnitude = null,
    Object? expiry = null,
  }) {
    return _then(
      _$GameEventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        sector: null == sector
            ? _value.sector
            : sector // ignore: cast_nullable_to_non_nullable
                  as String,
        effectType: null == effectType
            ? _value.effectType
            : effectType // ignore: cast_nullable_to_non_nullable
                  as EventEffectType,
        effectMagnitude: null == effectMagnitude
            ? _value.effectMagnitude
            : effectMagnitude // ignore: cast_nullable_to_non_nullable
                  as double,
        expiry: null == expiry
            ? _value.expiry
            : expiry // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameEventImpl implements _GameEvent {
  const _$GameEventImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.sector,
    required this.effectType,
    required this.effectMagnitude,
    required this.expiry,
  });

  factory _$GameEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameEventImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String sector;
  @override
  final EventEffectType effectType;
  @override
  final double effectMagnitude;
  @override
  final DateTime expiry;

  @override
  String toString() {
    return 'GameEvent(id: $id, name: $name, description: $description, sector: $sector, effectType: $effectType, effectMagnitude: $effectMagnitude, expiry: $expiry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sector, sector) || other.sector == sector) &&
            (identical(other.effectType, effectType) ||
                other.effectType == effectType) &&
            (identical(other.effectMagnitude, effectMagnitude) ||
                other.effectMagnitude == effectMagnitude) &&
            (identical(other.expiry, expiry) || other.expiry == expiry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    sector,
    effectType,
    effectMagnitude,
    expiry,
  );

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      __$$GameEventImplCopyWithImpl<_$GameEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameEventImplToJson(this);
  }
}

abstract class _GameEvent implements GameEvent {
  const factory _GameEvent({
    required final String id,
    required final String name,
    required final String description,
    required final String sector,
    required final EventEffectType effectType,
    required final double effectMagnitude,
    required final DateTime expiry,
  }) = _$GameEventImpl;

  factory _GameEvent.fromJson(Map<String, dynamic> json) =
      _$GameEventImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get sector;
  @override
  EventEffectType get effectType;
  @override
  double get effectMagnitude;
  @override
  DateTime get expiry;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
