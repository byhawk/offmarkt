// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_development.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResearchNodeImpl _$$ResearchNodeImplFromJson(Map<String, dynamic> json) =>
    _$ResearchNodeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      researchPointsCost: (json['researchPointsCost'] as num).toInt(),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      bonusType: $enumDecode(_$ResearchBonusTypeEnumMap, json['bonusType']),
      bonusValue: (json['bonusValue'] as num).toDouble(),
    );

Map<String, dynamic> _$$ResearchNodeImplToJson(_$ResearchNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'researchPointsCost': instance.researchPointsCost,
      'durationSeconds': instance.durationSeconds,
      'dependencies': instance.dependencies,
      'bonusType': _$ResearchBonusTypeEnumMap[instance.bonusType]!,
      'bonusValue': instance.bonusValue,
    };

const _$ResearchBonusTypeEnumMap = {
  ResearchBonusType.productionSpeed: 'productionSpeed',
  ResearchBonusType.marketDemand: 'marketDemand',
  ResearchBonusType.costReduction: 'costReduction',
};

_$ActiveResearchImpl _$$ActiveResearchImplFromJson(Map<String, dynamic> json) =>
    _$ActiveResearchImpl(
      nodeId: json['nodeId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$$ActiveResearchImplToJson(
  _$ActiveResearchImpl instance,
) => <String, dynamic>{
  'nodeId': instance.nodeId,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
};

_$RdRequestImpl _$$RdRequestImplFromJson(Map<String, dynamic> json) =>
    _$RdRequestImpl(
      projectName: json['projectName'] as String,
      projectDescription: json['projectDescription'] as String?,
      type: $enumDecode(_$RdProjectTypeEnumMap, json['type']),
      level: $enumDecode(_$RdProjectLevelEnumMap, json['level']),
      usePremiumResources: json['usePremiumResources'] as bool,
      hireExternalExperts: json['hireExternalExperts'] as bool? ?? false,
      playerId: json['playerId'] as String?,
      durationInDays: (json['durationInDays'] as num?)?.toInt(),
      budget: (json['budget'] as num?)?.toDouble(),
      successProbability: (json['successProbability'] as num?)?.toDouble(),
      potentialValue: (json['potentialValue'] as num?)?.toDouble(),
      qualityImprovement: (json['qualityImprovement'] as num?)?.toDouble(),
      marketAdvantage: (json['marketAdvantage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$RdRequestImplToJson(_$RdRequestImpl instance) =>
    <String, dynamic>{
      'projectName': instance.projectName,
      'projectDescription': instance.projectDescription,
      'type': _$RdProjectTypeEnumMap[instance.type]!,
      'level': _$RdProjectLevelEnumMap[instance.level]!,
      'usePremiumResources': instance.usePremiumResources,
      'hireExternalExperts': instance.hireExternalExperts,
      'playerId': instance.playerId,
      'durationInDays': instance.durationInDays,
      'budget': instance.budget,
      'successProbability': instance.successProbability,
      'potentialValue': instance.potentialValue,
      'qualityImprovement': instance.qualityImprovement,
      'marketAdvantage': instance.marketAdvantage,
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

_$RdMilestoneImpl _$$RdMilestoneImplFromJson(Map<String, dynamic> json) =>
    _$RdMilestoneImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      completed: json['completed'] as bool? ?? false,
      progressRequirement:
          (json['progressRequirement'] as num?)?.toDouble() ?? 0.0,
      targetDate: json['targetDate'] == null
          ? null
          : DateTime.parse(json['targetDate'] as String),
      completionDate: json['completionDate'] == null
          ? null
          : DateTime.parse(json['completionDate'] as String),
      bonusValue: (json['bonusValue'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$RdMilestoneImplToJson(_$RdMilestoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'completed': instance.completed,
      'progressRequirement': instance.progressRequirement,
      'targetDate': instance.targetDate?.toIso8601String(),
      'completionDate': instance.completionDate?.toIso8601String(),
      'bonusValue': instance.bonusValue,
    };

_$RdResourceImpl _$$RdResourceImplFromJson(Map<String, dynamic> json) =>
    _$RdResourceImpl(
      id: json['id'] as String,
      type: $enumDecode(_$RdResourceTypeEnumMap, json['type']),
      name: json['name'] as String,
      description: json['description'] as String,
      acquired: json['acquired'] as bool? ?? false,
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitCost: (json['unitCost'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$RdResourceImplToJson(_$RdResourceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$RdResourceTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'acquired': instance.acquired,
      'cost': instance.cost,
      'quantity': instance.quantity,
      'unitCost': instance.unitCost,
    };

const _$RdResourceTypeEnumMap = {
  RdResourceType.equipment: 'equipment',
  RdResourceType.material: 'material',
  RdResourceType.software: 'software',
  RdResourceType.personnel: 'personnel',
};

_$RdProjectImpl _$$RdProjectImplFromJson(
  Map<String, dynamic> json,
) => _$RdProjectImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  level: $enumDecode(_$RdProjectLevelEnumMap, json['level']),
  status: $enumDecode(_$RdProjectStatusEnumMap, json['status']),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
  efficiencyIncrease: (json['efficiencyIncrease'] as num?)?.toDouble() ?? 0.0,
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
  durationInDays: (json['durationInDays'] as num?)?.toInt() ?? 30,
  successProbability: (json['successProbability'] as num?)?.toDouble() ?? 0.5,
  completionDate: json['completionDate'] == null
      ? null
      : DateTime.parse(json['completionDate'] as String),
);

Map<String, dynamic> _$$RdProjectImplToJson(_$RdProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level': _$RdProjectLevelEnumMap[instance.level]!,
      'status': _$RdProjectStatusEnumMap[instance.status]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'progress': instance.progress,
      'efficiencyIncrease': instance.efficiencyIncrease,
      'milestones': instance.milestones,
      'requiredResources': instance.requiredResources,
      'durationInDays': instance.durationInDays,
      'successProbability': instance.successProbability,
      'completionDate': instance.completionDate?.toIso8601String(),
    };

const _$RdProjectStatusEnumMap = {
  RdProjectStatus.inProgress: 'inProgress',
  RdProjectStatus.completed: 'completed',
  RdProjectStatus.failed: 'failed',
  RdProjectStatus.cancelled: 'cancelled',
};

_$RdLabImpl _$$RdLabImplFromJson(Map<String, dynamic> json) => _$RdLabImpl(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  level: (json['level'] as num?)?.toInt() ?? 1,
  maxProjects: (json['maxProjects'] as num?)?.toInt() ?? 100,
  researchPointsPerDay: (json['researchPointsPerDay'] as num?)?.toInt() ?? 50,
  activeProjects:
      (json['activeProjects'] as List<dynamic>?)
          ?.map((e) => RdProject.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  completedProjects:
      (json['completedProjects'] as List<dynamic>?)
          ?.map((e) => RdProject.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalInvestment: (json['totalInvestment'] as num?)?.toDouble() ?? 0.0,
  currentBudget: (json['currentBudget'] as num?)?.toDouble() ?? 0.0,
  efficiencyBonus: (json['efficiencyBonus'] as num?)?.toDouble() ?? 0.0,
  safetyFactor: (json['safetyFactor'] as num?)?.toDouble() ?? 0.5,
  innovationRate: (json['innovationRate'] as num?)?.toDouble() ?? 0.1,
);

Map<String, dynamic> _$$RdLabImplToJson(_$RdLabImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'level': instance.level,
      'maxProjects': instance.maxProjects,
      'researchPointsPerDay': instance.researchPointsPerDay,
      'activeProjects': instance.activeProjects,
      'completedProjects': instance.completedProjects,
      'totalInvestment': instance.totalInvestment,
      'currentBudget': instance.currentBudget,
      'efficiencyBonus': instance.efficiencyBonus,
      'safetyFactor': instance.safetyFactor,
      'innovationRate': instance.innovationRate,
    };
