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

RdProject _$RdProjectFromJson(Map<String, dynamic> json) {
  return _RdProject.fromJson(json);
}

/// @nodoc
mixin _$RdProject {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  RdProjectType get type => throw _privateConstructorUsedError;
  RdProjectLevel get level => throw _privateConstructorUsedError;
  RdProjectStatus get status => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  int get durationInDays => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  double get costIncurred => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError; // 0.0 - 1.0 arası
  double get successProbability => throw _privateConstructorUsedError;
  double get potentialValue => throw _privateConstructorUsedError;
  double get efficiencyIncrease => throw _privateConstructorUsedError;
  double get qualityImprovement => throw _privateConstructorUsedError;
  double get marketAdvantage => throw _privateConstructorUsedError;
  List<RdMilestone> get milestones => throw _privateConstructorUsedError;
  List<RdResource> get requiredResources => throw _privateConstructorUsedError;
  List<RdTeamMember> get teamMembers => throw _privateConstructorUsedError;
  List<String> get achievements => throw _privateConstructorUsedError;

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
    String playerId,
    RdProjectType type,
    RdProjectLevel level,
    RdProjectStatus status,
    String name,
    String description,
    DateTime startDate,
    DateTime? endDate,
    int durationInDays,
    double budget,
    double costIncurred,
    double progress,
    double successProbability,
    double potentialValue,
    double efficiencyIncrease,
    double qualityImprovement,
    double marketAdvantage,
    List<RdMilestone> milestones,
    List<RdResource> requiredResources,
    List<RdTeamMember> teamMembers,
    List<String> achievements,
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
    Object? playerId = null,
    Object? type = null,
    Object? level = null,
    Object? status = null,
    Object? name = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? durationInDays = null,
    Object? budget = null,
    Object? costIncurred = null,
    Object? progress = null,
    Object? successProbability = null,
    Object? potentialValue = null,
    Object? efficiencyIncrease = null,
    Object? qualityImprovement = null,
    Object? marketAdvantage = null,
    Object? milestones = null,
    Object? requiredResources = null,
    Object? teamMembers = null,
    Object? achievements = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RdProjectType,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as RdProjectLevel,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RdProjectStatus,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            durationInDays: null == durationInDays
                ? _value.durationInDays
                : durationInDays // ignore: cast_nullable_to_non_nullable
                      as int,
            budget: null == budget
                ? _value.budget
                : budget // ignore: cast_nullable_to_non_nullable
                      as double,
            costIncurred: null == costIncurred
                ? _value.costIncurred
                : costIncurred // ignore: cast_nullable_to_non_nullable
                      as double,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double,
            successProbability: null == successProbability
                ? _value.successProbability
                : successProbability // ignore: cast_nullable_to_non_nullable
                      as double,
            potentialValue: null == potentialValue
                ? _value.potentialValue
                : potentialValue // ignore: cast_nullable_to_non_nullable
                      as double,
            efficiencyIncrease: null == efficiencyIncrease
                ? _value.efficiencyIncrease
                : efficiencyIncrease // ignore: cast_nullable_to_non_nullable
                      as double,
            qualityImprovement: null == qualityImprovement
                ? _value.qualityImprovement
                : qualityImprovement // ignore: cast_nullable_to_non_nullable
                      as double,
            marketAdvantage: null == marketAdvantage
                ? _value.marketAdvantage
                : marketAdvantage // ignore: cast_nullable_to_non_nullable
                      as double,
            milestones: null == milestones
                ? _value.milestones
                : milestones // ignore: cast_nullable_to_non_nullable
                      as List<RdMilestone>,
            requiredResources: null == requiredResources
                ? _value.requiredResources
                : requiredResources // ignore: cast_nullable_to_non_nullable
                      as List<RdResource>,
            teamMembers: null == teamMembers
                ? _value.teamMembers
                : teamMembers // ignore: cast_nullable_to_non_nullable
                      as List<RdTeamMember>,
            achievements: null == achievements
                ? _value.achievements
                : achievements // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
    String playerId,
    RdProjectType type,
    RdProjectLevel level,
    RdProjectStatus status,
    String name,
    String description,
    DateTime startDate,
    DateTime? endDate,
    int durationInDays,
    double budget,
    double costIncurred,
    double progress,
    double successProbability,
    double potentialValue,
    double efficiencyIncrease,
    double qualityImprovement,
    double marketAdvantage,
    List<RdMilestone> milestones,
    List<RdResource> requiredResources,
    List<RdTeamMember> teamMembers,
    List<String> achievements,
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
    Object? playerId = null,
    Object? type = null,
    Object? level = null,
    Object? status = null,
    Object? name = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? durationInDays = null,
    Object? budget = null,
    Object? costIncurred = null,
    Object? progress = null,
    Object? successProbability = null,
    Object? potentialValue = null,
    Object? efficiencyIncrease = null,
    Object? qualityImprovement = null,
    Object? marketAdvantage = null,
    Object? milestones = null,
    Object? requiredResources = null,
    Object? teamMembers = null,
    Object? achievements = null,
  }) {
    return _then(
      _$RdProjectImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RdProjectType,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as RdProjectLevel,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RdProjectStatus,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        durationInDays: null == durationInDays
            ? _value.durationInDays
            : durationInDays // ignore: cast_nullable_to_non_nullable
                  as int,
        budget: null == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as double,
        costIncurred: null == costIncurred
            ? _value.costIncurred
            : costIncurred // ignore: cast_nullable_to_non_nullable
                  as double,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        successProbability: null == successProbability
            ? _value.successProbability
            : successProbability // ignore: cast_nullable_to_non_nullable
                  as double,
        potentialValue: null == potentialValue
            ? _value.potentialValue
            : potentialValue // ignore: cast_nullable_to_non_nullable
                  as double,
        efficiencyIncrease: null == efficiencyIncrease
            ? _value.efficiencyIncrease
            : efficiencyIncrease // ignore: cast_nullable_to_non_nullable
                  as double,
        qualityImprovement: null == qualityImprovement
            ? _value.qualityImprovement
            : qualityImprovement // ignore: cast_nullable_to_non_nullable
                  as double,
        marketAdvantage: null == marketAdvantage
            ? _value.marketAdvantage
            : marketAdvantage // ignore: cast_nullable_to_non_nullable
                  as double,
        milestones: null == milestones
            ? _value._milestones
            : milestones // ignore: cast_nullable_to_non_nullable
                  as List<RdMilestone>,
        requiredResources: null == requiredResources
            ? _value._requiredResources
            : requiredResources // ignore: cast_nullable_to_non_nullable
                  as List<RdResource>,
        teamMembers: null == teamMembers
            ? _value._teamMembers
            : teamMembers // ignore: cast_nullable_to_non_nullable
                  as List<RdTeamMember>,
        achievements: null == achievements
            ? _value._achievements
            : achievements // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RdProjectImpl extends _RdProject {
  const _$RdProjectImpl({
    required this.id,
    required this.playerId,
    required this.type,
    required this.level,
    required this.status,
    required this.name,
    required this.description,
    required this.startDate,
    this.endDate = null,
    required this.durationInDays,
    required this.budget,
    this.costIncurred = 0.0,
    this.progress = 0.0,
    this.successProbability = 0.0,
    this.potentialValue = 0.0,
    this.efficiencyIncrease = 0.0,
    this.qualityImprovement = 0.0,
    this.marketAdvantage = 0.0,
    final List<RdMilestone> milestones = const [],
    final List<RdResource> requiredResources = const [],
    final List<RdTeamMember> teamMembers = const [],
    final List<String> achievements = const [],
  }) : _milestones = milestones,
       _requiredResources = requiredResources,
       _teamMembers = teamMembers,
       _achievements = achievements,
       super._();

  factory _$RdProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdProjectImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final RdProjectType type;
  @override
  final RdProjectLevel level;
  @override
  final RdProjectStatus status;
  @override
  final String name;
  @override
  final String description;
  @override
  final DateTime startDate;
  @override
  @JsonKey()
  final DateTime? endDate;
  @override
  final int durationInDays;
  @override
  final double budget;
  @override
  @JsonKey()
  final double costIncurred;
  @override
  @JsonKey()
  final double progress;
  // 0.0 - 1.0 arası
  @override
  @JsonKey()
  final double successProbability;
  @override
  @JsonKey()
  final double potentialValue;
  @override
  @JsonKey()
  final double efficiencyIncrease;
  @override
  @JsonKey()
  final double qualityImprovement;
  @override
  @JsonKey()
  final double marketAdvantage;
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

  final List<RdTeamMember> _teamMembers;
  @override
  @JsonKey()
  List<RdTeamMember> get teamMembers {
    if (_teamMembers is EqualUnmodifiableListView) return _teamMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamMembers);
  }

  final List<String> _achievements;
  @override
  @JsonKey()
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  @override
  String toString() {
    return 'RdProject(id: $id, playerId: $playerId, type: $type, level: $level, status: $status, name: $name, description: $description, startDate: $startDate, endDate: $endDate, durationInDays: $durationInDays, budget: $budget, costIncurred: $costIncurred, progress: $progress, successProbability: $successProbability, potentialValue: $potentialValue, efficiencyIncrease: $efficiencyIncrease, qualityImprovement: $qualityImprovement, marketAdvantage: $marketAdvantage, milestones: $milestones, requiredResources: $requiredResources, teamMembers: $teamMembers, achievements: $achievements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.durationInDays, durationInDays) ||
                other.durationInDays == durationInDays) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.costIncurred, costIncurred) ||
                other.costIncurred == costIncurred) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.successProbability, successProbability) ||
                other.successProbability == successProbability) &&
            (identical(other.potentialValue, potentialValue) ||
                other.potentialValue == potentialValue) &&
            (identical(other.efficiencyIncrease, efficiencyIncrease) ||
                other.efficiencyIncrease == efficiencyIncrease) &&
            (identical(other.qualityImprovement, qualityImprovement) ||
                other.qualityImprovement == qualityImprovement) &&
            (identical(other.marketAdvantage, marketAdvantage) ||
                other.marketAdvantage == marketAdvantage) &&
            const DeepCollectionEquality().equals(
              other._milestones,
              _milestones,
            ) &&
            const DeepCollectionEquality().equals(
              other._requiredResources,
              _requiredResources,
            ) &&
            const DeepCollectionEquality().equals(
              other._teamMembers,
              _teamMembers,
            ) &&
            const DeepCollectionEquality().equals(
              other._achievements,
              _achievements,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    playerId,
    type,
    level,
    status,
    name,
    description,
    startDate,
    endDate,
    durationInDays,
    budget,
    costIncurred,
    progress,
    successProbability,
    potentialValue,
    efficiencyIncrease,
    qualityImprovement,
    marketAdvantage,
    const DeepCollectionEquality().hash(_milestones),
    const DeepCollectionEquality().hash(_requiredResources),
    const DeepCollectionEquality().hash(_teamMembers),
    const DeepCollectionEquality().hash(_achievements),
  ]);

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

abstract class _RdProject extends RdProject {
  const factory _RdProject({
    required final String id,
    required final String playerId,
    required final RdProjectType type,
    required final RdProjectLevel level,
    required final RdProjectStatus status,
    required final String name,
    required final String description,
    required final DateTime startDate,
    final DateTime? endDate,
    required final int durationInDays,
    required final double budget,
    final double costIncurred,
    final double progress,
    final double successProbability,
    final double potentialValue,
    final double efficiencyIncrease,
    final double qualityImprovement,
    final double marketAdvantage,
    final List<RdMilestone> milestones,
    final List<RdResource> requiredResources,
    final List<RdTeamMember> teamMembers,
    final List<String> achievements,
  }) = _$RdProjectImpl;
  const _RdProject._() : super._();

  factory _RdProject.fromJson(Map<String, dynamic> json) =
      _$RdProjectImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  RdProjectType get type;
  @override
  RdProjectLevel get level;
  @override
  RdProjectStatus get status;
  @override
  String get name;
  @override
  String get description;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  int get durationInDays;
  @override
  double get budget;
  @override
  double get costIncurred;
  @override
  double get progress; // 0.0 - 1.0 arası
  @override
  double get successProbability;
  @override
  double get potentialValue;
  @override
  double get efficiencyIncrease;
  @override
  double get qualityImprovement;
  @override
  double get marketAdvantage;
  @override
  List<RdMilestone> get milestones;
  @override
  List<RdResource> get requiredResources;
  @override
  List<RdTeamMember> get teamMembers;
  @override
  List<String> get achievements;

  /// Create a copy of RdProject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdProjectImplCopyWith<_$RdProjectImpl> get copyWith =>
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
  double get progressRequirement =>
      throw _privateConstructorUsedError; // 0.0 - 1.0 arası
  DateTime get targetDate => throw _privateConstructorUsedError;
  DateTime? get completionDate => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
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
    double progressRequirement,
    DateTime targetDate,
    DateTime? completionDate,
    bool completed,
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
    Object? progressRequirement = null,
    Object? targetDate = null,
    Object? completionDate = freezed,
    Object? completed = null,
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
            progressRequirement: null == progressRequirement
                ? _value.progressRequirement
                : progressRequirement // ignore: cast_nullable_to_non_nullable
                      as double,
            targetDate: null == targetDate
                ? _value.targetDate
                : targetDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completionDate: freezed == completionDate
                ? _value.completionDate
                : completionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
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
    double progressRequirement,
    DateTime targetDate,
    DateTime? completionDate,
    bool completed,
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
    Object? progressRequirement = null,
    Object? targetDate = null,
    Object? completionDate = freezed,
    Object? completed = null,
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
        progressRequirement: null == progressRequirement
            ? _value.progressRequirement
            : progressRequirement // ignore: cast_nullable_to_non_nullable
                  as double,
        targetDate: null == targetDate
            ? _value.targetDate
            : targetDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completionDate: freezed == completionDate
            ? _value.completionDate
            : completionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
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
    required this.progressRequirement,
    required this.targetDate,
    this.completionDate = null,
    this.completed = false,
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
  final double progressRequirement;
  // 0.0 - 1.0 arası
  @override
  final DateTime targetDate;
  @override
  @JsonKey()
  final DateTime? completionDate;
  @override
  @JsonKey()
  final bool completed;
  @override
  @JsonKey()
  final double bonusValue;

  @override
  String toString() {
    return 'RdMilestone(id: $id, name: $name, description: $description, progressRequirement: $progressRequirement, targetDate: $targetDate, completionDate: $completionDate, completed: $completed, bonusValue: $bonusValue)';
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
            (identical(other.progressRequirement, progressRequirement) ||
                other.progressRequirement == progressRequirement) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.completionDate, completionDate) ||
                other.completionDate == completionDate) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
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
    progressRequirement,
    targetDate,
    completionDate,
    completed,
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
    required final double progressRequirement,
    required final DateTime targetDate,
    final DateTime? completionDate,
    final bool completed,
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
  double get progressRequirement; // 0.0 - 1.0 arası
  @override
  DateTime get targetDate;
  @override
  DateTime? get completionDate;
  @override
  bool get completed;
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
  RdResourceType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get unitCost => throw _privateConstructorUsedError;
  bool get acquired => throw _privateConstructorUsedError;

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
    RdResourceType type,
    String name,
    int quantity,
    double unitCost,
    bool acquired,
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
    Object? type = null,
    Object? name = null,
    Object? quantity = null,
    Object? unitCost = null,
    Object? acquired = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RdResourceType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitCost: null == unitCost
                ? _value.unitCost
                : unitCost // ignore: cast_nullable_to_non_nullable
                      as double,
            acquired: null == acquired
                ? _value.acquired
                : acquired // ignore: cast_nullable_to_non_nullable
                      as bool,
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
    RdResourceType type,
    String name,
    int quantity,
    double unitCost,
    bool acquired,
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
    Object? type = null,
    Object? name = null,
    Object? quantity = null,
    Object? unitCost = null,
    Object? acquired = null,
  }) {
    return _then(
      _$RdResourceImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RdResourceType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitCost: null == unitCost
            ? _value.unitCost
            : unitCost // ignore: cast_nullable_to_non_nullable
                  as double,
        acquired: null == acquired
            ? _value.acquired
            : acquired // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RdResourceImpl extends _RdResource {
  const _$RdResourceImpl({
    required this.type,
    required this.name,
    required this.quantity,
    required this.unitCost,
    this.acquired = false,
  }) : super._();

  factory _$RdResourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdResourceImplFromJson(json);

  @override
  final RdResourceType type;
  @override
  final String name;
  @override
  final int quantity;
  @override
  final double unitCost;
  @override
  @JsonKey()
  final bool acquired;

  @override
  String toString() {
    return 'RdResource(type: $type, name: $name, quantity: $quantity, unitCost: $unitCost, acquired: $acquired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdResourceImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.acquired, acquired) ||
                other.acquired == acquired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, name, quantity, unitCost, acquired);

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

abstract class _RdResource extends RdResource {
  const factory _RdResource({
    required final RdResourceType type,
    required final String name,
    required final int quantity,
    required final double unitCost,
    final bool acquired,
  }) = _$RdResourceImpl;
  const _RdResource._() : super._();

  factory _RdResource.fromJson(Map<String, dynamic> json) =
      _$RdResourceImpl.fromJson;

  @override
  RdResourceType get type;
  @override
  String get name;
  @override
  int get quantity;
  @override
  double get unitCost;
  @override
  bool get acquired;

  /// Create a copy of RdResource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdResourceImplCopyWith<_$RdResourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RdTeamMember _$RdTeamMemberFromJson(Map<String, dynamic> json) {
  return _RdTeamMember.fromJson(json);
}

/// @nodoc
mixin _$RdTeamMember {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  RdTeamPosition get position => throw _privateConstructorUsedError;
  int get skillLevel => throw _privateConstructorUsedError; // 1-10 arası
  double get dailyCost => throw _privateConstructorUsedError;
  double get performanceRating => throw _privateConstructorUsedError;
  double get contribution => throw _privateConstructorUsedError;

  /// Serializes this RdTeamMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RdTeamMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RdTeamMemberCopyWith<RdTeamMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RdTeamMemberCopyWith<$Res> {
  factory $RdTeamMemberCopyWith(
    RdTeamMember value,
    $Res Function(RdTeamMember) then,
  ) = _$RdTeamMemberCopyWithImpl<$Res, RdTeamMember>;
  @useResult
  $Res call({
    String id,
    String name,
    RdTeamPosition position,
    int skillLevel,
    double dailyCost,
    double performanceRating,
    double contribution,
  });
}

/// @nodoc
class _$RdTeamMemberCopyWithImpl<$Res, $Val extends RdTeamMember>
    implements $RdTeamMemberCopyWith<$Res> {
  _$RdTeamMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RdTeamMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? position = null,
    Object? skillLevel = null,
    Object? dailyCost = null,
    Object? performanceRating = null,
    Object? contribution = null,
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
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as RdTeamPosition,
            skillLevel: null == skillLevel
                ? _value.skillLevel
                : skillLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            dailyCost: null == dailyCost
                ? _value.dailyCost
                : dailyCost // ignore: cast_nullable_to_non_nullable
                      as double,
            performanceRating: null == performanceRating
                ? _value.performanceRating
                : performanceRating // ignore: cast_nullable_to_non_nullable
                      as double,
            contribution: null == contribution
                ? _value.contribution
                : contribution // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RdTeamMemberImplCopyWith<$Res>
    implements $RdTeamMemberCopyWith<$Res> {
  factory _$$RdTeamMemberImplCopyWith(
    _$RdTeamMemberImpl value,
    $Res Function(_$RdTeamMemberImpl) then,
  ) = __$$RdTeamMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    RdTeamPosition position,
    int skillLevel,
    double dailyCost,
    double performanceRating,
    double contribution,
  });
}

/// @nodoc
class __$$RdTeamMemberImplCopyWithImpl<$Res>
    extends _$RdTeamMemberCopyWithImpl<$Res, _$RdTeamMemberImpl>
    implements _$$RdTeamMemberImplCopyWith<$Res> {
  __$$RdTeamMemberImplCopyWithImpl(
    _$RdTeamMemberImpl _value,
    $Res Function(_$RdTeamMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RdTeamMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? position = null,
    Object? skillLevel = null,
    Object? dailyCost = null,
    Object? performanceRating = null,
    Object? contribution = null,
  }) {
    return _then(
      _$RdTeamMemberImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as RdTeamPosition,
        skillLevel: null == skillLevel
            ? _value.skillLevel
            : skillLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        dailyCost: null == dailyCost
            ? _value.dailyCost
            : dailyCost // ignore: cast_nullable_to_non_nullable
                  as double,
        performanceRating: null == performanceRating
            ? _value.performanceRating
            : performanceRating // ignore: cast_nullable_to_non_nullable
                  as double,
        contribution: null == contribution
            ? _value.contribution
            : contribution // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RdTeamMemberImpl implements _RdTeamMember {
  const _$RdTeamMemberImpl({
    required this.id,
    required this.name,
    required this.position,
    required this.skillLevel,
    required this.dailyCost,
    this.performanceRating = 0.0,
    this.contribution = 0.0,
  });

  factory _$RdTeamMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdTeamMemberImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final RdTeamPosition position;
  @override
  final int skillLevel;
  // 1-10 arası
  @override
  final double dailyCost;
  @override
  @JsonKey()
  final double performanceRating;
  @override
  @JsonKey()
  final double contribution;

  @override
  String toString() {
    return 'RdTeamMember(id: $id, name: $name, position: $position, skillLevel: $skillLevel, dailyCost: $dailyCost, performanceRating: $performanceRating, contribution: $contribution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdTeamMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel) &&
            (identical(other.dailyCost, dailyCost) ||
                other.dailyCost == dailyCost) &&
            (identical(other.performanceRating, performanceRating) ||
                other.performanceRating == performanceRating) &&
            (identical(other.contribution, contribution) ||
                other.contribution == contribution));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    position,
    skillLevel,
    dailyCost,
    performanceRating,
    contribution,
  );

  /// Create a copy of RdTeamMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RdTeamMemberImplCopyWith<_$RdTeamMemberImpl> get copyWith =>
      __$$RdTeamMemberImplCopyWithImpl<_$RdTeamMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RdTeamMemberImplToJson(this);
  }
}

abstract class _RdTeamMember implements RdTeamMember {
  const factory _RdTeamMember({
    required final String id,
    required final String name,
    required final RdTeamPosition position,
    required final int skillLevel,
    required final double dailyCost,
    final double performanceRating,
    final double contribution,
  }) = _$RdTeamMemberImpl;

  factory _RdTeamMember.fromJson(Map<String, dynamic> json) =
      _$RdTeamMemberImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  RdTeamPosition get position;
  @override
  int get skillLevel; // 1-10 arası
  @override
  double get dailyCost;
  @override
  double get performanceRating;
  @override
  double get contribution;

  /// Create a copy of RdTeamMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdTeamMemberImplCopyWith<_$RdTeamMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RdLab _$RdLabFromJson(Map<String, dynamic> json) {
  return _RdLab.fromJson(json);
}

/// @nodoc
mixin _$RdLab {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  double get totalInvestment => throw _privateConstructorUsedError;
  double get currentBudget => throw _privateConstructorUsedError;
  double get efficiencyBonus => throw _privateConstructorUsedError;
  double get safetyFactor => throw _privateConstructorUsedError;
  double get innovationRate => throw _privateConstructorUsedError;
  int get maxProjects => throw _privateConstructorUsedError;
  int get currentProjects => throw _privateConstructorUsedError;
  List<RdProject> get activeProjects => throw _privateConstructorUsedError;
  List<RdTeamMember> get staff => throw _privateConstructorUsedError;

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
    double totalInvestment,
    double currentBudget,
    double efficiencyBonus,
    double safetyFactor,
    double innovationRate,
    int maxProjects,
    int currentProjects,
    List<RdProject> activeProjects,
    List<RdTeamMember> staff,
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
    Object? totalInvestment = null,
    Object? currentBudget = null,
    Object? efficiencyBonus = null,
    Object? safetyFactor = null,
    Object? innovationRate = null,
    Object? maxProjects = null,
    Object? currentProjects = null,
    Object? activeProjects = null,
    Object? staff = null,
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
            maxProjects: null == maxProjects
                ? _value.maxProjects
                : maxProjects // ignore: cast_nullable_to_non_nullable
                      as int,
            currentProjects: null == currentProjects
                ? _value.currentProjects
                : currentProjects // ignore: cast_nullable_to_non_nullable
                      as int,
            activeProjects: null == activeProjects
                ? _value.activeProjects
                : activeProjects // ignore: cast_nullable_to_non_nullable
                      as List<RdProject>,
            staff: null == staff
                ? _value.staff
                : staff // ignore: cast_nullable_to_non_nullable
                      as List<RdTeamMember>,
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
    double totalInvestment,
    double currentBudget,
    double efficiencyBonus,
    double safetyFactor,
    double innovationRate,
    int maxProjects,
    int currentProjects,
    List<RdProject> activeProjects,
    List<RdTeamMember> staff,
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
    Object? totalInvestment = null,
    Object? currentBudget = null,
    Object? efficiencyBonus = null,
    Object? safetyFactor = null,
    Object? innovationRate = null,
    Object? maxProjects = null,
    Object? currentProjects = null,
    Object? activeProjects = null,
    Object? staff = null,
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
        maxProjects: null == maxProjects
            ? _value.maxProjects
            : maxProjects // ignore: cast_nullable_to_non_nullable
                  as int,
        currentProjects: null == currentProjects
            ? _value.currentProjects
            : currentProjects // ignore: cast_nullable_to_non_nullable
                  as int,
        activeProjects: null == activeProjects
            ? _value._activeProjects
            : activeProjects // ignore: cast_nullable_to_non_nullable
                  as List<RdProject>,
        staff: null == staff
            ? _value._staff
            : staff // ignore: cast_nullable_to_non_nullable
                  as List<RdTeamMember>,
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
    this.totalInvestment = 0.0,
    this.currentBudget = 0.0,
    this.efficiencyBonus = 0.0,
    this.safetyFactor = 0.0,
    this.innovationRate = 0.0,
    this.maxProjects = 0,
    this.currentProjects = 0,
    final List<RdProject> activeProjects = const [],
    final List<RdTeamMember> staff = const [],
  }) : _activeProjects = activeProjects,
       _staff = staff;

  factory _$RdLabImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdLabImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
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
  @JsonKey()
  final int maxProjects;
  @override
  @JsonKey()
  final int currentProjects;
  final List<RdProject> _activeProjects;
  @override
  @JsonKey()
  List<RdProject> get activeProjects {
    if (_activeProjects is EqualUnmodifiableListView) return _activeProjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeProjects);
  }

  final List<RdTeamMember> _staff;
  @override
  @JsonKey()
  List<RdTeamMember> get staff {
    if (_staff is EqualUnmodifiableListView) return _staff;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_staff);
  }

  @override
  String toString() {
    return 'RdLab(id: $id, playerId: $playerId, totalInvestment: $totalInvestment, currentBudget: $currentBudget, efficiencyBonus: $efficiencyBonus, safetyFactor: $safetyFactor, innovationRate: $innovationRate, maxProjects: $maxProjects, currentProjects: $currentProjects, activeProjects: $activeProjects, staff: $staff)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdLabImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.totalInvestment, totalInvestment) ||
                other.totalInvestment == totalInvestment) &&
            (identical(other.currentBudget, currentBudget) ||
                other.currentBudget == currentBudget) &&
            (identical(other.efficiencyBonus, efficiencyBonus) ||
                other.efficiencyBonus == efficiencyBonus) &&
            (identical(other.safetyFactor, safetyFactor) ||
                other.safetyFactor == safetyFactor) &&
            (identical(other.innovationRate, innovationRate) ||
                other.innovationRate == innovationRate) &&
            (identical(other.maxProjects, maxProjects) ||
                other.maxProjects == maxProjects) &&
            (identical(other.currentProjects, currentProjects) ||
                other.currentProjects == currentProjects) &&
            const DeepCollectionEquality().equals(
              other._activeProjects,
              _activeProjects,
            ) &&
            const DeepCollectionEquality().equals(other._staff, _staff));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    playerId,
    totalInvestment,
    currentBudget,
    efficiencyBonus,
    safetyFactor,
    innovationRate,
    maxProjects,
    currentProjects,
    const DeepCollectionEquality().hash(_activeProjects),
    const DeepCollectionEquality().hash(_staff),
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
    final double totalInvestment,
    final double currentBudget,
    final double efficiencyBonus,
    final double safetyFactor,
    final double innovationRate,
    final int maxProjects,
    final int currentProjects,
    final List<RdProject> activeProjects,
    final List<RdTeamMember> staff,
  }) = _$RdLabImpl;

  factory _RdLab.fromJson(Map<String, dynamic> json) = _$RdLabImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
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
  @override
  int get maxProjects;
  @override
  int get currentProjects;
  @override
  List<RdProject> get activeProjects;
  @override
  List<RdTeamMember> get staff;

  /// Create a copy of RdLab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdLabImplCopyWith<_$RdLabImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RdRequest _$RdRequestFromJson(Map<String, dynamic> json) {
  return _RdRequest.fromJson(json);
}

/// @nodoc
mixin _$RdRequest {
  String get playerId => throw _privateConstructorUsedError;
  RdProjectType get type => throw _privateConstructorUsedError;
  RdProjectLevel get level => throw _privateConstructorUsedError;
  String get projectName => throw _privateConstructorUsedError;
  String get projectDescription => throw _privateConstructorUsedError;
  bool get usePremiumResources => throw _privateConstructorUsedError;
  bool get hireExternalExperts => throw _privateConstructorUsedError;

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
    String playerId,
    RdProjectType type,
    RdProjectLevel level,
    String projectName,
    String projectDescription,
    bool usePremiumResources,
    bool hireExternalExperts,
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
    Object? playerId = null,
    Object? type = null,
    Object? level = null,
    Object? projectName = null,
    Object? projectDescription = null,
    Object? usePremiumResources = null,
    Object? hireExternalExperts = null,
  }) {
    return _then(
      _value.copyWith(
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RdProjectType,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as RdProjectLevel,
            projectName: null == projectName
                ? _value.projectName
                : projectName // ignore: cast_nullable_to_non_nullable
                      as String,
            projectDescription: null == projectDescription
                ? _value.projectDescription
                : projectDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            usePremiumResources: null == usePremiumResources
                ? _value.usePremiumResources
                : usePremiumResources // ignore: cast_nullable_to_non_nullable
                      as bool,
            hireExternalExperts: null == hireExternalExperts
                ? _value.hireExternalExperts
                : hireExternalExperts // ignore: cast_nullable_to_non_nullable
                      as bool,
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
    String playerId,
    RdProjectType type,
    RdProjectLevel level,
    String projectName,
    String projectDescription,
    bool usePremiumResources,
    bool hireExternalExperts,
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
    Object? playerId = null,
    Object? type = null,
    Object? level = null,
    Object? projectName = null,
    Object? projectDescription = null,
    Object? usePremiumResources = null,
    Object? hireExternalExperts = null,
  }) {
    return _then(
      _$RdRequestImpl(
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RdProjectType,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as RdProjectLevel,
        projectName: null == projectName
            ? _value.projectName
            : projectName // ignore: cast_nullable_to_non_nullable
                  as String,
        projectDescription: null == projectDescription
            ? _value.projectDescription
            : projectDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        usePremiumResources: null == usePremiumResources
            ? _value.usePremiumResources
            : usePremiumResources // ignore: cast_nullable_to_non_nullable
                  as bool,
        hireExternalExperts: null == hireExternalExperts
            ? _value.hireExternalExperts
            : hireExternalExperts // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RdRequestImpl implements _RdRequest {
  const _$RdRequestImpl({
    required this.playerId,
    required this.type,
    required this.level,
    required this.projectName,
    required this.projectDescription,
    this.usePremiumResources = false,
    this.hireExternalExperts = false,
  });

  factory _$RdRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RdRequestImplFromJson(json);

  @override
  final String playerId;
  @override
  final RdProjectType type;
  @override
  final RdProjectLevel level;
  @override
  final String projectName;
  @override
  final String projectDescription;
  @override
  @JsonKey()
  final bool usePremiumResources;
  @override
  @JsonKey()
  final bool hireExternalExperts;

  @override
  String toString() {
    return 'RdRequest(playerId: $playerId, type: $type, level: $level, projectName: $projectName, projectDescription: $projectDescription, usePremiumResources: $usePremiumResources, hireExternalExperts: $hireExternalExperts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RdRequestImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.projectDescription, projectDescription) ||
                other.projectDescription == projectDescription) &&
            (identical(other.usePremiumResources, usePremiumResources) ||
                other.usePremiumResources == usePremiumResources) &&
            (identical(other.hireExternalExperts, hireExternalExperts) ||
                other.hireExternalExperts == hireExternalExperts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    playerId,
    type,
    level,
    projectName,
    projectDescription,
    usePremiumResources,
    hireExternalExperts,
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
    required final String playerId,
    required final RdProjectType type,
    required final RdProjectLevel level,
    required final String projectName,
    required final String projectDescription,
    final bool usePremiumResources,
    final bool hireExternalExperts,
  }) = _$RdRequestImpl;

  factory _RdRequest.fromJson(Map<String, dynamic> json) =
      _$RdRequestImpl.fromJson;

  @override
  String get playerId;
  @override
  RdProjectType get type;
  @override
  RdProjectLevel get level;
  @override
  String get projectName;
  @override
  String get projectDescription;
  @override
  bool get usePremiumResources;
  @override
  bool get hireExternalExperts;

  /// Create a copy of RdRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RdRequestImplCopyWith<_$RdRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
