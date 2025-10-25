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
