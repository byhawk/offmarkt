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

RdRequest _$RdRequestFromJson(Map<String, dynamic> json) {
  return _RdRequest.fromJson(json);
}

/// @nodoc
mixin _$RdRequest {
  String get projectName => throw _privateConstructorUsedError;
  String? get projectDescription => throw _privateConstructorUsedError;
  RdProjectType get type => throw _privateConstructorUsedError;
  RdProjectLevel get level => throw _privateConstructorUsedError;
  bool get usePremiumResources => throw _privateConstructorUsedError;
  bool get hireExternalExperts => throw _privateConstructorUsedError;
  String? get playerId => throw _privateConstructorUsedError;
  int? get durationInDays => throw _privateConstructorUsedError;
  double? get budget => throw _privateConstructorUsedError;
  double? get successProbability => throw _privateConstructorUsedError;
  double? get potentialValue => throw _privateConstructorUsedError;
  double? get qualityImprovement => throw _privateConstructorUsedError;
  double? get marketAdvantage => throw _privateConstructorUsedError;

  /// Serializes this RdRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RdRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RdRequestCopyWith<RdRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RdRequestCopyWith<$Res> {
  factory $RdRequestCopyWith(RdRequest value, $Res Function(RdRequest) then) =
      _$RdRequestCopyWithImpl<$Res, RdRequest>;
  @useResult
  $Res call({
    String projectName,
    String? projectDescription,
    RdProjectType type,
    RdProjectLevel level,
    bool usePremiumResources,
    bool hireExternalExperts,
    String? playerId,
    int? durationInDays,
    double? budget,
    double? successProbability,
    double? potentialValue,
    double? qualityImprovement,
    double? marketAdvantage,
  });
}

/// @nodoc
class _$RdRequestCopyWithImpl<$Res, $Val extends RdRequest>
    implements $RdRequestCopyWith<$Res> {
  _$RdRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RdRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
    Object? projectDescription = freezed,
    Object? type = null,
    Object? level = null,
    Object? usePremiumResources = null,
    Object? hireExternalExperts = null,
    Object? playerId = freezed,
    Object? durationInDays = freezed,
    Object? budget = freezed,
    Object? successProbability = freezed,
    Object? potentialValue = freezed,
    Object? qualityImprovement = freezed,
    Object? marketAdvantage = freezed,
  }) {
    return _then(
      _value.copyWith(
            projectName: null == projectName
                ? _value.projectName
                : projectName // ignore: cast_nullable_to_non_nullable
                      as String,
            projectDescription: freezed == projectDescription
                ? _value.projectDescription
                : projectDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RdProjectType,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as RdProjectLevel,
            usePremiumResources: null == usePremiumResources
                ? _value.usePremiumResources
                : usePremiumResources // ignore: cast_nullable_to_non_nullable
                      as bool,
            hireExternalExperts: null == hireExternalExperts
                ? _value.hireExternalExperts
                : hireExternalExperts // ignore: cast_nullable_to_non_nullable
                      as bool,
            playerId: freezed == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationInDays: freezed == durationInDays
                ? _value.durationInDays
                : durationInDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            budget: freezed == budget
                ? _value.budget
                : budget // ignore: cast_nullable_to_non_nullable
                      as double?,
            successProbability: freezed == successProbability
                ? _value.successProbability
                : successProbability // ignore: cast_nullable_to_non_nullable
                      as double?,
            potentialValue: freezed == potentialValue
                ? _value.potentialValue
                : potentialValue // ignore: cast_nullable_to_non_nullable
                      as double?,
            qualityImprovement: freezed == qualityImprovement
                ? _value.qualityImprovement
                : qualityImprovement // ignore: cast_nullable_to_non_nullable
                      as double?,
            marketAdvantage: freezed == marketAdvantage
                ? _value.marketAdvantage
                : marketAdvantage // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RdRequestImplCopyWith<$Res>
    implements $RdRequestCopyWith<$Res> {
  factory _$$RdRequestImplCopyWith(
    _$RdRequestImpl value,
    $Res Function(_$RdRequestImpl) then,
  ) = __$$RdRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String projectName,
    String? projectDescription,
    RdProjectType type,
    RdProjectLevel level,
    bool usePremiumResources,
    bool hireExternalExperts,
    String? playerId,
    int? durationInDays,
    double? budget,
    double? successProbability,
    double? potentialValue,
    double? qualityImprovement,
    double? marketAdvantage,
  });
}

/// @nodoc
class __$$RdRequestImplCopyWithImpl<$Res>
    extends _$RdRequestCopyWithImpl<$Res, _$RdRequestImpl>
    implements _$$RdRequestImplCopyWith<$Res> {
  __$$RdRequestImplCopyWithImpl(
    _$RdRequestImpl _value,
    $Res Function(_$RdRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RdRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
    Object? projectDescription = freezed,
    Object? type = null,
    Object? level = null,
    Object? usePremiumResources = null,
    Object? hireExternalExperts = null,
    Object? playerId = freezed,
    Object? durationInDays = freezed,
    Object? budget = freezed,
    Object? successProbability = freezed,
    Object? potentialValue = freezed,
    Object? qualityImprovement = freezed,
    Object? marketAdvantage = freezed,
  }) {
    return _then(
      _$RdRequestImpl(
        projectName: null == projectName
            ? _value.projectName
            : projectName // ignore: cast_nullable_to_non_nullable
                  as String,
        projectDescription: freezed == projectDescription
            ? _value.projectDescription
            : projectDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RdProjectType,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as RdProjectLevel,
        usePremiumResources: null == usePremiumResources
            ? _value.usePremiumResources
            : usePremiumResources // ignore: cast_nullable_to_non_nullable
                  as bool,
        hireExternalExperts: null == hireExternalExperts
            ? _value.hireExternalExperts
            : hireExternalExperts // ignore: cast_nullable_to_non_nullable
                  as bool,
        playerId: freezed == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationInDays: freezed == durationInDays
            ? _value.durationInDays
            : durationInDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        budget: freezed == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as double?,
        successProbability: freezed == successProbability
            ? _value.successProbability
            : successProbability // ignore: cast_nullable_to_non_nullable
                  as double?,
        potentialValue: freezed == potentialValue
            ? _value.potentialValue
            : potentialValue // ignore: cast_nullable_to_non_nullable
                  as double?,
        qualityImprovement: freezed == qualityImprovement
            ? _value.qualityImprovement
            : qualityImprovement // ignore: cast_nullable_to_non_nullable
                  as double?,
        marketAdvantage: freezed == marketAdvantage
            ? _value.marketAdvantage
            : marketAdvantage // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RdRequestImpl implements _RdRequest {
  const _$RdRequestImpl({
    required this.projectName,
    this.projectDescription,
    required this.type,
    required this.level,
    required this.usePremiumResources,
    this.hireExternalExperts = false,
    this.playerId,
    this.durationInDays,
    this.budget,
    this.successProbability,
    this.potentialValue,
    this.qualityImprovement,
    this.marketAdvantage,
  });

  factory _$RdRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdRequestImplFromJson(json);

  @override
  final String projectName;
  @override
  final String? projectDescription;
  @override
  final RdProjectType type;
  @override
  final RdProjectLevel level;
  @override
  final bool usePremiumResources;
  @override
  @JsonKey()
  final bool hireExternalExperts;
  @override
  final String? playerId;
  @override
  final int? durationInDays;
  @override
  final double? budget;
  @override
  final double? successProbability;
  @override
  final double? potentialValue;
  @override
  final double? qualityImprovement;
  @override
  final double? marketAdvantage;

  @override
  String toString() {
    return 'RdRequest(projectName: $projectName, projectDescription: $projectDescription, type: $type, level: $level, usePremiumResources: $usePremiumResources, hireExternalExperts: $hireExternalExperts, playerId: $playerId, durationInDays: $durationInDays, budget: $budget, successProbability: $successProbability, potentialValue: $potentialValue, qualityImprovement: $qualityImprovement, marketAdvantage: $marketAdvantage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdRequestImpl &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.projectDescription, projectDescription) ||
                other.projectDescription == projectDescription) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.usePremiumResources, usePremiumResources) ||
                other.usePremiumResources == usePremiumResources) &&
            (identical(other.hireExternalExperts, hireExternalExperts) ||
                other.hireExternalExperts == hireExternalExperts) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.durationInDays, durationInDays) ||
                other.durationInDays == durationInDays) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.successProbability, successProbability) ||
                other.successProbability == successProbability) &&
            (identical(other.potentialValue, potentialValue) ||
                other.potentialValue == potentialValue) &&
            (identical(other.qualityImprovement, qualityImprovement) ||
                other.qualityImprovement == qualityImprovement) &&
            (identical(other.marketAdvantage, marketAdvantage) ||
                other.marketAdvantage == marketAdvantage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    projectName,
    projectDescription,
    type,
    level,
    usePremiumResources,
    hireExternalExperts,
    playerId,
    durationInDays,
    budget,
    successProbability,
    potentialValue,
    qualityImprovement,
    marketAdvantage,
  );

  /// Create a copy of RdRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RdRequestImplCopyWith<_$RdRequestImpl> get copyWith =>
      __$$RdRequestImplCopyWithImpl<_$RdRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RdRequestImplToJson(this);
  }
}

abstract class _RdRequest implements RdRequest {
  const factory _RdRequest({
    required final String projectName,
    final String? projectDescription,
    required final RdProjectType type,
    required final RdProjectLevel level,
    required final bool usePremiumResources,
    final bool hireExternalExperts,
    final String? playerId,
    final int? durationInDays,
    final double? budget,
    final double? successProbability,
    final double? potentialValue,
    final double? qualityImprovement,
    final double? marketAdvantage,
  }) = _$RdRequestImpl;

  factory _RdRequest.fromJson(Map<String, dynamic> json) =
      _$RdRequestImpl.fromJson;

  @override
  String get projectName;
  @override
  String? get projectDescription;
  @override
  RdProjectType get type;
  @override
  RdProjectLevel get level;
  @override
  bool get usePremiumResources;
  @override
  bool get hireExternalExperts;
  @override
  String? get playerId;
  @override
  int? get durationInDays;
  @override
  double? get budget;
  @override
  double? get successProbability;
  @override
  double? get potentialValue;
  @override
  double? get qualityImprovement;
  @override
  double? get marketAdvantage;

  /// Create a copy of RdRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdRequestImplCopyWith<_$RdRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RdMilestone _$RdMilestoneFromJson(Map<String, dynamic> json) {
  return _RdMilestone.fromJson(json);
}

/// @nodoc
mixin _$RdMilestone {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  double get progressRequirement => throw _privateConstructorUsedError;
  DateTime? get targetDate => throw _privateConstructorUsedError;
  DateTime? get completionDate => throw _privateConstructorUsedError;
  double get bonusValue => throw _privateConstructorUsedError;

  /// Serializes this RdMilestone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RdMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RdMilestoneCopyWith<RdMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RdMilestoneCopyWith<$Res> {
  factory $RdMilestoneCopyWith(
    RdMilestone value,
    $Res Function(RdMilestone) then,
  ) = _$RdMilestoneCopyWithImpl<$Res, RdMilestone>;
  @useResult
  $Res call({
    int id,
    String name,
    String description,
    bool completed,
    double progressRequirement,
    DateTime? targetDate,
    DateTime? completionDate,
    double bonusValue,
  });
}

/// @nodoc
class _$RdMilestoneCopyWithImpl<$Res, $Val extends RdMilestone>
    implements $RdMilestoneCopyWith<$Res> {
  _$RdMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RdMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? completed = null,
    Object? progressRequirement = null,
    Object? targetDate = freezed,
    Object? completionDate = freezed,
    Object? bonusValue = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
            progressRequirement: null == progressRequirement
                ? _value.progressRequirement
                : progressRequirement // ignore: cast_nullable_to_non_nullable
                      as double,
            targetDate: freezed == targetDate
                ? _value.targetDate
                : targetDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completionDate: freezed == completionDate
                ? _value.completionDate
                : completionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
abstract class _$$RdMilestoneImplCopyWith<$Res>
    implements $RdMilestoneCopyWith<$Res> {
  factory _$$RdMilestoneImplCopyWith(
    _$RdMilestoneImpl value,
    $Res Function(_$RdMilestoneImpl) then,
  ) = __$$RdMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String description,
    bool completed,
    double progressRequirement,
    DateTime? targetDate,
    DateTime? completionDate,
    double bonusValue,
  });
}

/// @nodoc
class __$$RdMilestoneImplCopyWithImpl<$Res>
    extends _$RdMilestoneCopyWithImpl<$Res, _$RdMilestoneImpl>
    implements _$$RdMilestoneImplCopyWith<$Res> {
  __$$RdMilestoneImplCopyWithImpl(
    _$RdMilestoneImpl _value,
    $Res Function(_$RdMilestoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RdMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? completed = null,
    Object? progressRequirement = null,
    Object? targetDate = freezed,
    Object? completionDate = freezed,
    Object? bonusValue = null,
  }) {
    return _then(
      _$RdMilestoneImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
        progressRequirement: null == progressRequirement
            ? _value.progressRequirement
            : progressRequirement // ignore: cast_nullable_to_non_nullable
                  as double,
        targetDate: freezed == targetDate
            ? _value.targetDate
            : targetDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completionDate: freezed == completionDate
            ? _value.completionDate
            : completionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
class _$RdMilestoneImpl implements _RdMilestone {
  const _$RdMilestoneImpl({
    required this.id,
    required this.name,
    required this.description,
    this.completed = false,
    this.progressRequirement = 0.0,
    this.targetDate,
    this.completionDate,
    this.bonusValue = 0.0,
  });

  factory _$RdMilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdMilestoneImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey()
  final bool completed;
  @override
  @JsonKey()
  final double progressRequirement;
  @override
  final DateTime? targetDate;
  @override
  final DateTime? completionDate;
  @override
  @JsonKey()
  final double bonusValue;

  @override
  String toString() {
    return 'RdMilestone(id: $id, name: $name, description: $description, completed: $completed, progressRequirement: $progressRequirement, targetDate: $targetDate, completionDate: $completionDate, bonusValue: $bonusValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdMilestoneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.progressRequirement, progressRequirement) ||
                other.progressRequirement == progressRequirement) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.completionDate, completionDate) ||
                other.completionDate == completionDate) &&
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
    completed,
    progressRequirement,
    targetDate,
    completionDate,
    bonusValue,
  );

  /// Create a copy of RdMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RdMilestoneImplCopyWith<_$RdMilestoneImpl> get copyWith =>
      __$$RdMilestoneImplCopyWithImpl<_$RdMilestoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RdMilestoneImplToJson(this);
  }
}

abstract class _RdMilestone implements RdMilestone {
  const factory _RdMilestone({
    required final int id,
    required final String name,
    required final String description,
    final bool completed,
    final double progressRequirement,
    final DateTime? targetDate,
    final DateTime? completionDate,
    final double bonusValue,
  }) = _$RdMilestoneImpl;

  factory _RdMilestone.fromJson(Map<String, dynamic> json) =
      _$RdMilestoneImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  bool get completed;
  @override
  double get progressRequirement;
  @override
  DateTime? get targetDate;
  @override
  DateTime? get completionDate;
  @override
  double get bonusValue;

  /// Create a copy of RdMilestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdMilestoneImplCopyWith<_$RdMilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RdResource _$RdResourceFromJson(Map<String, dynamic> json) {
  return _RdResource.fromJson(json);
}

/// @nodoc
mixin _$RdResource {
  String get id => throw _privateConstructorUsedError;
  RdResourceType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get acquired => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get unitCost => throw _privateConstructorUsedError;

  /// Serializes this RdResource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RdResource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RdResourceCopyWith<RdResource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RdResourceCopyWith<$Res> {
  factory $RdResourceCopyWith(
    RdResource value,
    $Res Function(RdResource) then,
  ) = _$RdResourceCopyWithImpl<$Res, RdResource>;
  @useResult
  $Res call({
    String id,
    RdResourceType type,
    String name,
    String description,
    bool acquired,
    double cost,
    int quantity,
    double unitCost,
  });
}

/// @nodoc
class _$RdResourceCopyWithImpl<$Res, $Val extends RdResource>
    implements $RdResourceCopyWith<$Res> {
  _$RdResourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RdResource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? acquired = null,
    Object? cost = null,
    Object? quantity = null,
    Object? unitCost = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RdResourceType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            acquired: null == acquired
                ? _value.acquired
                : acquired // ignore: cast_nullable_to_non_nullable
                      as bool,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitCost: null == unitCost
                ? _value.unitCost
                : unitCost // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RdResourceImplCopyWith<$Res>
    implements $RdResourceCopyWith<$Res> {
  factory _$$RdResourceImplCopyWith(
    _$RdResourceImpl value,
    $Res Function(_$RdResourceImpl) then,
  ) = __$$RdResourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    RdResourceType type,
    String name,
    String description,
    bool acquired,
    double cost,
    int quantity,
    double unitCost,
  });
}

/// @nodoc
class __$$RdResourceImplCopyWithImpl<$Res>
    extends _$RdResourceCopyWithImpl<$Res, _$RdResourceImpl>
    implements _$$RdResourceImplCopyWith<$Res> {
  __$$RdResourceImplCopyWithImpl(
    _$RdResourceImpl _value,
    $Res Function(_$RdResourceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RdResource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? acquired = null,
    Object? cost = null,
    Object? quantity = null,
    Object? unitCost = null,
  }) {
    return _then(
      _$RdResourceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RdResourceType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        acquired: null == acquired
            ? _value.acquired
            : acquired // ignore: cast_nullable_to_non_nullable
                  as bool,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitCost: null == unitCost
            ? _value.unitCost
            : unitCost // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RdResourceImpl implements _RdResource {
  const _$RdResourceImpl({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    this.acquired = false,
    this.cost = 0.0,
    this.quantity = 0,
    this.unitCost = 0.0,
  });

  factory _$RdResourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdResourceImplFromJson(json);

  @override
  final String id;
  @override
  final RdResourceType type;
  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey()
  final bool acquired;
  @override
  @JsonKey()
  final double cost;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final double unitCost;

  @override
  String toString() {
    return 'RdResource(id: $id, type: $type, name: $name, description: $description, acquired: $acquired, cost: $cost, quantity: $quantity, unitCost: $unitCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdResourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.acquired, acquired) ||
                other.acquired == acquired) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    name,
    description,
    acquired,
    cost,
    quantity,
    unitCost,
  );

  /// Create a copy of RdResource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RdResourceImplCopyWith<_$RdResourceImpl> get copyWith =>
      __$$RdResourceImplCopyWithImpl<_$RdResourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RdResourceImplToJson(this);
  }
}

abstract class _RdResource implements RdResource {
  const factory _RdResource({
    required final String id,
    required final RdResourceType type,
    required final String name,
    required final String description,
    final bool acquired,
    final double cost,
    final int quantity,
    final double unitCost,
  }) = _$RdResourceImpl;

  factory _RdResource.fromJson(Map<String, dynamic> json) =
      _$RdResourceImpl.fromJson;

  @override
  String get id;
  @override
  RdResourceType get type;
  @override
  String get name;
  @override
  String get description;
  @override
  bool get acquired;
  @override
  double get cost;
  @override
  int get quantity;
  @override
  double get unitCost;

  /// Create a copy of RdResource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdResourceImplCopyWith<_$RdResourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RdProject _$RdProjectFromJson(Map<String, dynamic> json) {
  return _RdProject.fromJson(json);
}

/// @nodoc
mixin _$RdProject {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  RdProjectLevel get level => throw _privateConstructorUsedError;
  RdProjectStatus get status => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  double get efficiencyIncrease => throw _privateConstructorUsedError;
  List<RdMilestone> get milestones => throw _privateConstructorUsedError;
  List<RdResource> get requiredResources => throw _privateConstructorUsedError;
  int get durationInDays => throw _privateConstructorUsedError;
  double get successProbability => throw _privateConstructorUsedError;
  DateTime? get completionDate => throw _privateConstructorUsedError;

  /// Serializes this RdProject to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RdProject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RdProjectCopyWith<RdProject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RdProjectCopyWith<$Res> {
  factory $RdProjectCopyWith(RdProject value, $Res Function(RdProject) then) =
      _$RdProjectCopyWithImpl<$Res, RdProject>;
  @useResult
  $Res call({
    String id,
    String name,
    RdProjectLevel level,
    RdProjectStatus status,
    DateTime startDate,
    DateTime? endDate,
    double progress,
    double efficiencyIncrease,
    List<RdMilestone> milestones,
    List<RdResource> requiredResources,
    int durationInDays,
    double successProbability,
    DateTime? completionDate,
  });
}

/// @nodoc
class _$RdProjectCopyWithImpl<$Res, $Val extends RdProject>
    implements $RdProjectCopyWith<$Res> {
  _$RdProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RdProject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? level = null,
    Object? status = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? progress = null,
    Object? efficiencyIncrease = null,
    Object? milestones = null,
    Object? requiredResources = null,
    Object? durationInDays = null,
    Object? successProbability = null,
    Object? completionDate = freezed,
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
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as RdProjectLevel,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RdProjectStatus,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double,
            efficiencyIncrease: null == efficiencyIncrease
                ? _value.efficiencyIncrease
                : efficiencyIncrease // ignore: cast_nullable_to_non_nullable
                      as double,
            milestones: null == milestones
                ? _value.milestones
                : milestones // ignore: cast_nullable_to_non_nullable
                      as List<RdMilestone>,
            requiredResources: null == requiredResources
                ? _value.requiredResources
                : requiredResources // ignore: cast_nullable_to_non_nullable
                      as List<RdResource>,
            durationInDays: null == durationInDays
                ? _value.durationInDays
                : durationInDays // ignore: cast_nullable_to_non_nullable
                      as int,
            successProbability: null == successProbability
                ? _value.successProbability
                : successProbability // ignore: cast_nullable_to_non_nullable
                      as double,
            completionDate: freezed == completionDate
                ? _value.completionDate
                : completionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RdProjectImplCopyWith<$Res>
    implements $RdProjectCopyWith<$Res> {
  factory _$$RdProjectImplCopyWith(
    _$RdProjectImpl value,
    $Res Function(_$RdProjectImpl) then,
  ) = __$$RdProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    RdProjectLevel level,
    RdProjectStatus status,
    DateTime startDate,
    DateTime? endDate,
    double progress,
    double efficiencyIncrease,
    List<RdMilestone> milestones,
    List<RdResource> requiredResources,
    int durationInDays,
    double successProbability,
    DateTime? completionDate,
  });
}

/// @nodoc
class __$$RdProjectImplCopyWithImpl<$Res>
    extends _$RdProjectCopyWithImpl<$Res, _$RdProjectImpl>
    implements _$$RdProjectImplCopyWith<$Res> {
  __$$RdProjectImplCopyWithImpl(
    _$RdProjectImpl _value,
    $Res Function(_$RdProjectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RdProject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? level = null,
    Object? status = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? progress = null,
    Object? efficiencyIncrease = null,
    Object? milestones = null,
    Object? requiredResources = null,
    Object? durationInDays = null,
    Object? successProbability = null,
    Object? completionDate = freezed,
  }) {
    return _then(
      _$RdProjectImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as RdProjectLevel,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RdProjectStatus,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        efficiencyIncrease: null == efficiencyIncrease
            ? _value.efficiencyIncrease
            : efficiencyIncrease // ignore: cast_nullable_to_non_nullable
                  as double,
        milestones: null == milestones
            ? _value._milestones
            : milestones // ignore: cast_nullable_to_non_nullable
                  as List<RdMilestone>,
        requiredResources: null == requiredResources
            ? _value._requiredResources
            : requiredResources // ignore: cast_nullable_to_non_nullable
                  as List<RdResource>,
        durationInDays: null == durationInDays
            ? _value.durationInDays
            : durationInDays // ignore: cast_nullable_to_non_nullable
                  as int,
        successProbability: null == successProbability
            ? _value.successProbability
            : successProbability // ignore: cast_nullable_to_non_nullable
                  as double,
        completionDate: freezed == completionDate
            ? _value.completionDate
            : completionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RdProjectImpl implements _RdProject {
  const _$RdProjectImpl({
    required this.id,
    required this.name,
    required this.level,
    required this.status,
    required this.startDate,
    this.endDate,
    this.progress = 0.0,
    this.efficiencyIncrease = 0.0,
    final List<RdMilestone> milestones = const [],
    final List<RdResource> requiredResources = const [],
    this.durationInDays = 30,
    this.successProbability = 0.5,
    this.completionDate,
  }) : _milestones = milestones,
       _requiredResources = requiredResources;

  factory _$RdProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdProjectImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final RdProjectLevel level;
  @override
  final RdProjectStatus status;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final double progress;
  @override
  @JsonKey()
  final double efficiencyIncrease;
  final List<RdMilestone> _milestones;
  @override
  @JsonKey()
  List<RdMilestone> get milestones {
    if (_milestones is EqualUnmodifiableListView) return _milestones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_milestones);
  }

  final List<RdResource> _requiredResources;
  @override
  @JsonKey()
  List<RdResource> get requiredResources {
    if (_requiredResources is EqualUnmodifiableListView)
      return _requiredResources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredResources);
  }

  @override
  @JsonKey()
  final int durationInDays;
  @override
  @JsonKey()
  final double successProbability;
  @override
  final DateTime? completionDate;

  @override
  String toString() {
    return 'RdProject(id: $id, name: $name, level: $level, status: $status, startDate: $startDate, endDate: $endDate, progress: $progress, efficiencyIncrease: $efficiencyIncrease, milestones: $milestones, requiredResources: $requiredResources, durationInDays: $durationInDays, successProbability: $successProbability, completionDate: $completionDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.efficiencyIncrease, efficiencyIncrease) ||
                other.efficiencyIncrease == efficiencyIncrease) &&
            const DeepCollectionEquality().equals(
              other._milestones,
              _milestones,
            ) &&
            const DeepCollectionEquality().equals(
              other._requiredResources,
              _requiredResources,
            ) &&
            (identical(other.durationInDays, durationInDays) ||
                other.durationInDays == durationInDays) &&
            (identical(other.successProbability, successProbability) ||
                other.successProbability == successProbability) &&
            (identical(other.completionDate, completionDate) ||
                other.completionDate == completionDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    level,
    status,
    startDate,
    endDate,
    progress,
    efficiencyIncrease,
    const DeepCollectionEquality().hash(_milestones),
    const DeepCollectionEquality().hash(_requiredResources),
    durationInDays,
    successProbability,
    completionDate,
  );

  /// Create a copy of RdProject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RdProjectImplCopyWith<_$RdProjectImpl> get copyWith =>
      __$$RdProjectImplCopyWithImpl<_$RdProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RdProjectImplToJson(this);
  }
}

abstract class _RdProject implements RdProject {
  const factory _RdProject({
    required final String id,
    required final String name,
    required final RdProjectLevel level,
    required final RdProjectStatus status,
    required final DateTime startDate,
    final DateTime? endDate,
    final double progress,
    final double efficiencyIncrease,
    final List<RdMilestone> milestones,
    final List<RdResource> requiredResources,
    final int durationInDays,
    final double successProbability,
    final DateTime? completionDate,
  }) = _$RdProjectImpl;

  factory _RdProject.fromJson(Map<String, dynamic> json) =
      _$RdProjectImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  RdProjectLevel get level;
  @override
  RdProjectStatus get status;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  double get progress;
  @override
  double get efficiencyIncrease;
  @override
  List<RdMilestone> get milestones;
  @override
  List<RdResource> get requiredResources;
  @override
  int get durationInDays;
  @override
  double get successProbability;
  @override
  DateTime? get completionDate;

  /// Create a copy of RdProject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdProjectImplCopyWith<_$RdProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RdLab _$RdLabFromJson(Map<String, dynamic> json) {
  return _RdLab.fromJson(json);
}

/// @nodoc
mixin _$RdLab {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get maxProjects => throw _privateConstructorUsedError;
  int get researchPointsPerDay => throw _privateConstructorUsedError;
  List<RdProject> get activeProjects => throw _privateConstructorUsedError;
  List<RdProject> get completedProjects => throw _privateConstructorUsedError;
  double get totalInvestment => throw _privateConstructorUsedError;
  double get currentBudget => throw _privateConstructorUsedError;
  double get efficiencyBonus => throw _privateConstructorUsedError;
  double get safetyFactor => throw _privateConstructorUsedError;
  double get innovationRate => throw _privateConstructorUsedError;

  /// Serializes this RdLab to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RdLab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RdLabCopyWith<RdLab> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RdLabCopyWith<$Res> {
  factory $RdLabCopyWith(RdLab value, $Res Function(RdLab) then) =
      _$RdLabCopyWithImpl<$Res, RdLab>;
  @useResult
  $Res call({
    String id,
    String playerId,
    int level,
    int maxProjects,
    int researchPointsPerDay,
    List<RdProject> activeProjects,
    List<RdProject> completedProjects,
    double totalInvestment,
    double currentBudget,
    double efficiencyBonus,
    double safetyFactor,
    double innovationRate,
  });
}

/// @nodoc
class _$RdLabCopyWithImpl<$Res, $Val extends RdLab>
    implements $RdLabCopyWith<$Res> {
  _$RdLabCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RdLab
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? level = null,
    Object? maxProjects = null,
    Object? researchPointsPerDay = null,
    Object? activeProjects = null,
    Object? completedProjects = null,
    Object? totalInvestment = null,
    Object? currentBudget = null,
    Object? efficiencyBonus = null,
    Object? safetyFactor = null,
    Object? innovationRate = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            maxProjects: null == maxProjects
                ? _value.maxProjects
                : maxProjects // ignore: cast_nullable_to_non_nullable
                      as int,
            researchPointsPerDay: null == researchPointsPerDay
                ? _value.researchPointsPerDay
                : researchPointsPerDay // ignore: cast_nullable_to_non_nullable
                      as int,
            activeProjects: null == activeProjects
                ? _value.activeProjects
                : activeProjects // ignore: cast_nullable_to_non_nullable
                      as List<RdProject>,
            completedProjects: null == completedProjects
                ? _value.completedProjects
                : completedProjects // ignore: cast_nullable_to_non_nullable
                      as List<RdProject>,
            totalInvestment: null == totalInvestment
                ? _value.totalInvestment
                : totalInvestment // ignore: cast_nullable_to_non_nullable
                      as double,
            currentBudget: null == currentBudget
                ? _value.currentBudget
                : currentBudget // ignore: cast_nullable_to_non_nullable
                      as double,
            efficiencyBonus: null == efficiencyBonus
                ? _value.efficiencyBonus
                : efficiencyBonus // ignore: cast_nullable_to_non_nullable
                      as double,
            safetyFactor: null == safetyFactor
                ? _value.safetyFactor
                : safetyFactor // ignore: cast_nullable_to_non_nullable
                      as double,
            innovationRate: null == innovationRate
                ? _value.innovationRate
                : innovationRate // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RdLabImplCopyWith<$Res> implements $RdLabCopyWith<$Res> {
  factory _$$RdLabImplCopyWith(
    _$RdLabImpl value,
    $Res Function(_$RdLabImpl) then,
  ) = __$$RdLabImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    int level,
    int maxProjects,
    int researchPointsPerDay,
    List<RdProject> activeProjects,
    List<RdProject> completedProjects,
    double totalInvestment,
    double currentBudget,
    double efficiencyBonus,
    double safetyFactor,
    double innovationRate,
  });
}

/// @nodoc
class __$$RdLabImplCopyWithImpl<$Res>
    extends _$RdLabCopyWithImpl<$Res, _$RdLabImpl>
    implements _$$RdLabImplCopyWith<$Res> {
  __$$RdLabImplCopyWithImpl(
    _$RdLabImpl _value,
    $Res Function(_$RdLabImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RdLab
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? level = null,
    Object? maxProjects = null,
    Object? researchPointsPerDay = null,
    Object? activeProjects = null,
    Object? completedProjects = null,
    Object? totalInvestment = null,
    Object? currentBudget = null,
    Object? efficiencyBonus = null,
    Object? safetyFactor = null,
    Object? innovationRate = null,
  }) {
    return _then(
      _$RdLabImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        maxProjects: null == maxProjects
            ? _value.maxProjects
            : maxProjects // ignore: cast_nullable_to_non_nullable
                  as int,
        researchPointsPerDay: null == researchPointsPerDay
            ? _value.researchPointsPerDay
            : researchPointsPerDay // ignore: cast_nullable_to_non_nullable
                  as int,
        activeProjects: null == activeProjects
            ? _value._activeProjects
            : activeProjects // ignore: cast_nullable_to_non_nullable
                  as List<RdProject>,
        completedProjects: null == completedProjects
            ? _value._completedProjects
            : completedProjects // ignore: cast_nullable_to_non_nullable
                  as List<RdProject>,
        totalInvestment: null == totalInvestment
            ? _value.totalInvestment
            : totalInvestment // ignore: cast_nullable_to_non_nullable
                  as double,
        currentBudget: null == currentBudget
            ? _value.currentBudget
            : currentBudget // ignore: cast_nullable_to_non_nullable
                  as double,
        efficiencyBonus: null == efficiencyBonus
            ? _value.efficiencyBonus
            : efficiencyBonus // ignore: cast_nullable_to_non_nullable
                  as double,
        safetyFactor: null == safetyFactor
            ? _value.safetyFactor
            : safetyFactor // ignore: cast_nullable_to_non_nullable
                  as double,
        innovationRate: null == innovationRate
            ? _value.innovationRate
            : innovationRate // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RdLabImpl implements _RdLab {
  const _$RdLabImpl({
    required this.id,
    required this.playerId,
    this.level = 1,
    this.maxProjects = 100,
    this.researchPointsPerDay = 50,
    final List<RdProject> activeProjects = const [],
    final List<RdProject> completedProjects = const [],
    this.totalInvestment = 0.0,
    this.currentBudget = 0.0,
    this.efficiencyBonus = 0.0,
    this.safetyFactor = 0.5,
    this.innovationRate = 0.1,
  }) : _activeProjects = activeProjects,
       _completedProjects = completedProjects;

  factory _$RdLabImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdLabImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int maxProjects;
  @override
  @JsonKey()
  final int researchPointsPerDay;
  final List<RdProject> _activeProjects;
  @override
  @JsonKey()
  List<RdProject> get activeProjects {
    if (_activeProjects is EqualUnmodifiableListView) return _activeProjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeProjects);
  }

  final List<RdProject> _completedProjects;
  @override
  @JsonKey()
  List<RdProject> get completedProjects {
    if (_completedProjects is EqualUnmodifiableListView)
      return _completedProjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedProjects);
  }

  @override
  @JsonKey()
  final double totalInvestment;
  @override
  @JsonKey()
  final double currentBudget;
  @override
  @JsonKey()
  final double efficiencyBonus;
  @override
  @JsonKey()
  final double safetyFactor;
  @override
  @JsonKey()
  final double innovationRate;

  @override
  String toString() {
    return 'RdLab(id: $id, playerId: $playerId, level: $level, maxProjects: $maxProjects, researchPointsPerDay: $researchPointsPerDay, activeProjects: $activeProjects, completedProjects: $completedProjects, totalInvestment: $totalInvestment, currentBudget: $currentBudget, efficiencyBonus: $efficiencyBonus, safetyFactor: $safetyFactor, innovationRate: $innovationRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdLabImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.maxProjects, maxProjects) ||
                other.maxProjects == maxProjects) &&
            (identical(other.researchPointsPerDay, researchPointsPerDay) ||
                other.researchPointsPerDay == researchPointsPerDay) &&
            const DeepCollectionEquality().equals(
              other._activeProjects,
              _activeProjects,
            ) &&
            const DeepCollectionEquality().equals(
              other._completedProjects,
              _completedProjects,
            ) &&
            (identical(other.totalInvestment, totalInvestment) ||
                other.totalInvestment == totalInvestment) &&
            (identical(other.currentBudget, currentBudget) ||
                other.currentBudget == currentBudget) &&
            (identical(other.efficiencyBonus, efficiencyBonus) ||
                other.efficiencyBonus == efficiencyBonus) &&
            (identical(other.safetyFactor, safetyFactor) ||
                other.safetyFactor == safetyFactor) &&
            (identical(other.innovationRate, innovationRate) ||
                other.innovationRate == innovationRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    playerId,
    level,
    maxProjects,
    researchPointsPerDay,
    const DeepCollectionEquality().hash(_activeProjects),
    const DeepCollectionEquality().hash(_completedProjects),
    totalInvestment,
    currentBudget,
    efficiencyBonus,
    safetyFactor,
    innovationRate,
  );

  /// Create a copy of RdLab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RdLabImplCopyWith<_$RdLabImpl> get copyWith =>
      __$$RdLabImplCopyWithImpl<_$RdLabImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RdLabImplToJson(this);
  }
}

abstract class _RdLab implements RdLab {
  const factory _RdLab({
    required final String id,
    required final String playerId,
    final int level,
    final int maxProjects,
    final int researchPointsPerDay,
    final List<RdProject> activeProjects,
    final List<RdProject> completedProjects,
    final double totalInvestment,
    final double currentBudget,
    final double efficiencyBonus,
    final double safetyFactor,
    final double innovationRate,
  }) = _$RdLabImpl;

  factory _RdLab.fromJson(Map<String, dynamic> json) = _$RdLabImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  int get level;
  @override
  int get maxProjects;
  @override
  int get researchPointsPerDay;
  @override
  List<RdProject> get activeProjects;
  @override
  List<RdProject> get completedProjects;
  @override
  double get totalInvestment;
  @override
  double get currentBudget;
  @override
  double get efficiencyBonus;
  @override
  double get safetyFactor;
  @override
  double get innovationRate;

  /// Create a copy of RdLab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdLabImplCopyWith<_$RdLabImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
