// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_development.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RdProjectImpl _$$RdProjectImplFromJson(
  Map<String, dynamic> json,
) => _$RdProjectImpl(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  type: $enumDecode(_$RdProjectTypeEnumMap, json['type']),
  level: $enumDecode(_$RdProjectLevelEnumMap, json['level']),
  status: $enumDecode(_$RdProjectStatusEnumMap, json['status']),
  name: json['name'] as String,
  description: json['description'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  durationInDays: (json['durationInDays'] as num).toInt(),
  budget: (json['budget'] as num).toDouble(),
  costIncurred: (json['costIncurred'] as num?)?.toDouble() ?? 0.0,
  progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
  successProbability: (json['successProbability'] as num?)?.toDouble() ?? 0.0,
  potentialValue: (json['potentialValue'] as num?)?.toDouble() ?? 0.0,
  efficiencyIncrease: (json['efficiencyIncrease'] as num?)?.toDouble() ?? 0.0,
  qualityImprovement: (json['qualityImprovement'] as num?)?.toDouble() ?? 0.0,
  marketAdvantage: (json['marketAdvantage'] as num?)?.toDouble() ?? 0.0,
  milestones:
      (json['milestones'] as List<dynamic>?)
          ?.map((e) => RdMilestone.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  requiredResources:
      (json['requiredResources'] as List<dynamic>?)
          ?.map((e) => RdResource.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  teamMembers:
      (json['teamMembers'] as List<dynamic>?)
          ?.map((e) => RdTeamMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  achievements:
      (json['achievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$RdProjectImplToJson(_$RdProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'type': _$RdProjectTypeEnumMap[instance.type]!,
      'level': _$RdProjectLevelEnumMap[instance.level]!,
      'status': _$RdProjectStatusEnumMap[instance.status]!,
      'name': instance.name,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'durationInDays': instance.durationInDays,
      'budget': instance.budget,
      'costIncurred': instance.costIncurred,
      'progress': instance.progress,
      'successProbability': instance.successProbability,
      'potentialValue': instance.potentialValue,
      'efficiencyIncrease': instance.efficiencyIncrease,
      'qualityImprovement': instance.qualityImprovement,
      'marketAdvantage': instance.marketAdvantage,
      'milestones': instance.milestones,
      'requiredResources': instance.requiredResources,
      'teamMembers': instance.teamMembers,
      'achievements': instance.achievements,
    };

const _$RdProjectTypeEnumMap = {
  RdProjectType.productDevelopment: 'productDevelopment',
  RdProjectType.processImprovement: 'processImprovement',
  RdProjectType.technologyUpgrade: 'technologyUpgrade',
  RdProjectType.marketInnovation: 'marketInnovation',
  RdProjectType.qualityEnhancement: 'qualityEnhancement',
  RdProjectType.efficiencyOptimization: 'efficiencyOptimization',
  RdProjectType.patentDevelopment: 'patentDevelopment',
  RdProjectType.rAndDCenter: 'rAndDCenter',
};

const _$RdProjectLevelEnumMap = {
  RdProjectLevel.basic: 'basic',
  RdProjectLevel.advanced: 'advanced',
  RdProjectLevel.expert: 'expert',
  RdProjectLevel.innovative: 'innovative',
  RdProjectLevel.revolutionary: 'revolutionary',
};

const _$RdProjectStatusEnumMap = {
  RdProjectStatus.planning: 'planning',
  RdProjectStatus.inProgress: 'inProgress',
  RdProjectStatus.paused: 'paused',
  RdProjectStatus.completed: 'completed',
  RdProjectStatus.failed: 'failed',
  RdProjectStatus.abandoned: 'abandoned',
};

_$RdMilestoneImpl _$$RdMilestoneImplFromJson(Map<String, dynamic> json) =>
    _$RdMilestoneImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      progressRequirement: (json['progressRequirement'] as num).toDouble(),
      targetDate: DateTime.parse(json['targetDate'] as String),
      completionDate: json['completionDate'] == null
          ? null
          : DateTime.parse(json['completionDate'] as String),
      completed: json['completed'] as bool? ?? false,
      bonusValue: (json['bonusValue'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$RdMilestoneImplToJson(_$RdMilestoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'progressRequirement': instance.progressRequirement,
      'targetDate': instance.targetDate.toIso8601String(),
      'completionDate': instance.completionDate?.toIso8601String(),
      'completed': instance.completed,
      'bonusValue': instance.bonusValue,
    };

_$RdResourceImpl _$$RdResourceImplFromJson(Map<String, dynamic> json) =>
    _$RdResourceImpl(
      type: $enumDecode(_$RdResourceTypeEnumMap, json['type']),
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitCost: (json['unitCost'] as num).toDouble(),
      acquired: json['acquired'] as bool? ?? false,
    );

Map<String, dynamic> _$$RdResourceImplToJson(_$RdResourceImpl instance) =>
    <String, dynamic>{
      'type': _$RdResourceTypeEnumMap[instance.type]!,
      'name': instance.name,
      'quantity': instance.quantity,
      'unitCost': instance.unitCost,
      'acquired': instance.acquired,
    };

const _$RdResourceTypeEnumMap = {
  RdResourceType.equipment: 'equipment',
  RdResourceType.material: 'material',
  RdResourceType.software: 'software',
  RdResourceType.facility: 'facility',
  RdResourceType.externalService: 'externalService',
};

_$RdTeamMemberImpl _$$RdTeamMemberImplFromJson(Map<String, dynamic> json) =>
    _$RdTeamMemberImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      position: $enumDecode(_$RdTeamPositionEnumMap, json['position']),
      skillLevel: (json['skillLevel'] as num).toInt(),
      dailyCost: (json['dailyCost'] as num).toDouble(),
      performanceRating: (json['performanceRating'] as num?)?.toDouble() ?? 0.0,
      contribution: (json['contribution'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$RdTeamMemberImplToJson(_$RdTeamMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': _$RdTeamPositionEnumMap[instance.position]!,
      'skillLevel': instance.skillLevel,
      'dailyCost': instance.dailyCost,
      'performanceRating': instance.performanceRating,
      'contribution': instance.contribution,
    };

const _$RdTeamPositionEnumMap = {
  RdTeamPosition.leadResearcher: 'leadResearcher',
  RdTeamPosition.seniorResearcher: 'seniorResearcher',
  RdTeamPosition.researcher: 'researcher',
  RdTeamPosition.assistant: 'assistant',
  RdTeamPosition.consultant: 'consultant',
};

_$RdLabImpl _$$RdLabImplFromJson(Map<String, dynamic> json) => _$RdLabImpl(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  totalInvestment: (json['totalInvestment'] as num?)?.toDouble() ?? 0.0,
  currentBudget: (json['currentBudget'] as num?)?.toDouble() ?? 0.0,
  efficiencyBonus: (json['efficiencyBonus'] as num?)?.toDouble() ?? 0.0,
  safetyFactor: (json['safetyFactor'] as num?)?.toDouble() ?? 0.0,
  innovationRate: (json['innovationRate'] as num?)?.toDouble() ?? 0.0,
  maxProjects: (json['maxProjects'] as num?)?.toInt() ?? 0,
  currentProjects: (json['currentProjects'] as num?)?.toInt() ?? 0,
  activeProjects:
      (json['activeProjects'] as List<dynamic>?)
          ?.map((e) => RdProject.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  staff:
      (json['staff'] as List<dynamic>?)
          ?.map((e) => RdTeamMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$RdLabImplToJson(_$RdLabImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'totalInvestment': instance.totalInvestment,
      'currentBudget': instance.currentBudget,
      'efficiencyBonus': instance.efficiencyBonus,
      'safetyFactor': instance.safetyFactor,
      'innovationRate': instance.innovationRate,
      'maxProjects': instance.maxProjects,
      'currentProjects': instance.currentProjects,
      'activeProjects': instance.activeProjects,
      'staff': instance.staff,
    };

_$RdRequestImpl _$$RdRequestImplFromJson(Map<String, dynamic> json) =>
    _$RdRequestImpl(
      playerId: json['playerId'] as String,
      type: $enumDecode(_$RdProjectTypeEnumMap, json['type']),
      level: $enumDecode(_$RdProjectLevelEnumMap, json['level']),
      projectName: json['projectName'] as String,
      projectDescription: json['projectDescription'] as String,
      usePremiumResources: json['usePremiumResources'] as bool? ?? false,
      hireExternalExperts: json['hireExternalExperts'] as bool? ?? false,
    );

Map<String, dynamic> _$$RdRequestImplToJson(_$RdRequestImpl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'type': _$RdProjectTypeEnumMap[instance.type]!,
      'level': _$RdProjectLevelEnumMap[instance.level]!,
      'projectName': instance.projectName,
      'projectDescription': instance.projectDescription,
      'usePremiumResources': instance.usePremiumResources,
      'hireExternalExperts': instance.hireExternalExperts,
    };
