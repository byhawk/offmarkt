// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'research_development.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ResearchNode _$ResearchNodeFromJson(Map<String, dynamic> json) {
  return _ResearchNode.fromJson(json);
}

/// @nodoc
mixin _$ResearchNode {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get researchPointsCost =>
      throw _privateConstructorUsedError; // Araştırma maliyeti (örn: puan)
  int get durationSeconds =>
      throw _privateConstructorUsedError; // Araştırma süresi (saniye)
  List<String> get dependencies =>
      throw _privateConstructorUsedError; // Bu araştırmayı açmak için gereken diğer node'ların ID'leri
  ResearchBonusType get bonusType => throw _privateConstructorUsedError;
  double get bonusValue => throw _privateConstructorUsedError;

  /// Serializes this ResearchNode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResearchNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResearchNodeCopyWith<ResearchNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchNodeCopyWith<$Res> {
  factory $ResearchNodeCopyWith(
    ResearchNode value,
    $Res Function(ResearchNode) then,
  ) = _$ResearchNodeCopyWithImpl<$Res, ResearchNode>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    int researchPointsCost,
    int durationSeconds,
    List<String> dependencies,
    ResearchBonusType bonusType,
    double bonusValue,
  });
}

/// @nodoc
class _$ResearchNodeCopyWithImpl<$Res, $Val extends ResearchNode>
    implements $ResearchNodeCopyWith<$Res> {
  _$ResearchNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResearchNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? researchPointsCost = null,
    Object? durationSeconds = null,
    Object? dependencies = null,
    Object? bonusType = null,
    Object? bonusValue = null,
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
            researchPointsCost: null == researchPointsCost
                ? _value.researchPointsCost
                : researchPointsCost // ignore: cast_nullable_to_non_nullable
                      as int,
            durationSeconds: null == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            dependencies: null == dependencies
                ? _value.dependencies
                : dependencies // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            bonusType: null == bonusType
                ? _value.bonusType
                : bonusType // ignore: cast_nullable_to_non_nullable
                      as ResearchBonusType,
            bonusValue: null == bonusValue
                ? _value.bonusValue
                : bonusValue // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResearchNodeImplCopyWith<$Res>
    implements $ResearchNodeCopyWith<$Res> {
  factory _$$ResearchNodeImplCopyWith(
    _$ResearchNodeImpl value,
    $Res Function(_$ResearchNodeImpl) then,
  ) = __$$ResearchNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    int researchPointsCost,
    int durationSeconds,
    List<String> dependencies,
    ResearchBonusType bonusType,
    double bonusValue,
  });
}

/// @nodoc
class __$$ResearchNodeImplCopyWithImpl<$Res>
    extends _$ResearchNodeCopyWithImpl<$Res, _$ResearchNodeImpl>
    implements _$$ResearchNodeImplCopyWith<$Res> {
  __$$ResearchNodeImplCopyWithImpl(
    _$ResearchNodeImpl _value,
    $Res Function(_$ResearchNodeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResearchNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? researchPointsCost = null,
    Object? durationSeconds = null,
    Object? dependencies = null,
    Object? bonusType = null,
    Object? bonusValue = null,
  }) {
    return _then(
      _$ResearchNodeImpl(
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
        researchPointsCost: null == researchPointsCost
            ? _value.researchPointsCost
            : researchPointsCost // ignore: cast_nullable_to_non_nullable
                  as int,
        durationSeconds: null == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        dependencies: null == dependencies
            ? _value._dependencies
            : dependencies // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        bonusType: null == bonusType
            ? _value.bonusType
            : bonusType // ignore: cast_nullable_to_non_nullable
                  as ResearchBonusType,
        bonusValue: null == bonusValue
            ? _value.bonusValue
            : bonusValue // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchNodeImpl implements _ResearchNode {
  const _$ResearchNodeImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.researchPointsCost,
    required this.durationSeconds,
    required final List<String> dependencies,
    required this.bonusType,
    required this.bonusValue,
  }) : _dependencies = dependencies;

  factory _$ResearchNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchNodeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final int researchPointsCost;
  // Araştırma maliyeti (örn: puan)
  @override
  final int durationSeconds;
  // Araştırma süresi (saniye)
  final List<String> _dependencies;
  // Araştırma süresi (saniye)
  @override
  List<String> get dependencies {
    if (_dependencies is EqualUnmodifiableListView) return _dependencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dependencies);
  }

  // Bu araştırmayı açmak için gereken diğer node'ların ID'leri
  @override
  final ResearchBonusType bonusType;
  @override
  final double bonusValue;

  @override
  String toString() {
    return 'ResearchNode(id: $id, name: $name, description: $description, researchPointsCost: $researchPointsCost, durationSeconds: $durationSeconds, dependencies: $dependencies, bonusType: $bonusType, bonusValue: $bonusValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.researchPointsCost, researchPointsCost) ||
                other.researchPointsCost == researchPointsCost) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            const DeepCollectionEquality().equals(
              other._dependencies,
              _dependencies,
            ) &&
            (identical(other.bonusType, bonusType) ||
                other.bonusType == bonusType) &&
            (identical(other.bonusValue, bonusValue) ||
                other.bonusValue == bonusValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    researchPointsCost,
    durationSeconds,
    const DeepCollectionEquality().hash(_dependencies),
    bonusType,
    bonusValue,
  );

  /// Create a copy of ResearchNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchNodeImplCopyWith<_$ResearchNodeImpl> get copyWith =>
      __$$ResearchNodeImplCopyWithImpl<_$ResearchNodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResearchNodeImplToJson(this);
  }
}

abstract class _ResearchNode implements ResearchNode {
  const factory _ResearchNode({
    required final String id,
    required final String name,
    required final String description,
    required final int researchPointsCost,
    required final int durationSeconds,
    required final List<String> dependencies,
    required final ResearchBonusType bonusType,
    required final double bonusValue,
  }) = _$ResearchNodeImpl;

  factory _ResearchNode.fromJson(Map<String, dynamic> json) =
      _$ResearchNodeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  int get researchPointsCost; // Araştırma maliyeti (örn: puan)
  @override
  int get durationSeconds; // Araştırma süresi (saniye)
  @override
  List<String> get dependencies; // Bu araştırmayı açmak için gereken diğer node'ların ID'leri
  @override
  ResearchBonusType get bonusType;
  @override
  double get bonusValue;

  /// Create a copy of ResearchNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResearchNodeImplCopyWith<_$ResearchNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActiveResearch _$ActiveResearchFromJson(Map<String, dynamic> json) {
  return _ActiveResearch.fromJson(json);
}

/// @nodoc
mixin _$ActiveResearch {
  String get nodeId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;

  /// Serializes this ActiveResearch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveResearch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveResearchCopyWith<ActiveResearch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveResearchCopyWith<$Res> {
  factory $ActiveResearchCopyWith(
    ActiveResearch value,
    $Res Function(ActiveResearch) then,
  ) = _$ActiveResearchCopyWithImpl<$Res, ActiveResearch>;
  @useResult
  $Res call({String nodeId, DateTime startTime, DateTime endTime});
}

/// @nodoc
class _$ActiveResearchCopyWithImpl<$Res, $Val extends ActiveResearch>
    implements $ActiveResearchCopyWith<$Res> {
  _$ActiveResearchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveResearch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(
      _value.copyWith(
            nodeId: null == nodeId
                ? _value.nodeId
                : nodeId // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$ActiveResearchImplCopyWith<$Res>
    implements $ActiveResearchCopyWith<$Res> {
  factory _$$ActiveResearchImplCopyWith(
    _$ActiveResearchImpl value,
    $Res Function(_$ActiveResearchImpl) then,
  ) = __$$ActiveResearchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nodeId, DateTime startTime, DateTime endTime});
}

/// @nodoc
class __$$ActiveResearchImplCopyWithImpl<$Res>
    extends _$ActiveResearchCopyWithImpl<$Res, _$ActiveResearchImpl>
    implements _$$ActiveResearchImplCopyWith<$Res> {
  __$$ActiveResearchImplCopyWithImpl(
    _$ActiveResearchImpl _value,
    $Res Function(_$ActiveResearchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActiveResearch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(
      _$ActiveResearchImpl(
        nodeId: null == nodeId
            ? _value.nodeId
            : nodeId // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$ActiveResearchImpl implements _ActiveResearch {
  const _$ActiveResearchImpl({
    required this.nodeId,
    required this.startTime,
    required this.endTime,
  });

  factory _$ActiveResearchImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveResearchImplFromJson(json);

  @override
  final String nodeId;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;

  @override
  String toString() {
    return 'ActiveResearch(nodeId: $nodeId, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveResearchImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nodeId, startTime, endTime);

  /// Create a copy of ActiveResearch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveResearchImplCopyWith<_$ActiveResearchImpl> get copyWith =>
      __$$ActiveResearchImplCopyWithImpl<_$ActiveResearchImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveResearchImplToJson(this);
  }
}

abstract class _ActiveResearch implements ActiveResearch {
  const factory _ActiveResearch({
    required final String nodeId,
    required final DateTime startTime,
    required final DateTime endTime,
  }) = _$ActiveResearchImpl;

  factory _ActiveResearch.fromJson(Map<String, dynamic> json) =
      _$ActiveResearchImpl.fromJson;

  @override
  String get nodeId;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;

  /// Create a copy of ActiveResearch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveResearchImplCopyWith<_$ActiveResearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
