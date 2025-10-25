// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
  name: json['name'] as String? ?? 'Oyuncu',
  level: (json['level'] as num?)?.toInt() ?? 1,
  experience: (json['experience'] as num?)?.toInt() ?? 0,
  cash: (json['cash'] as num?)?.toDouble() ?? 5000.0,
  bankAccount: (json['bankAccount'] as num?)?.toDouble() ?? 0.0,
  debt: (json['debt'] as num?)?.toDouble() ?? 0.0,
  currentDay: (json['currentDay'] as num?)?.toInt() ?? 1,
  totalTransactions: (json['totalTransactions'] as num?)?.toInt() ?? 0,
  totalProfit: (json['totalProfit'] as num?)?.toDouble() ?? 0.0,
  portfolioValue: (json['portfolioValue'] as num?)?.toDouble() ?? 0.0,
  legalReputation: (json['legalReputation'] as num?)?.toInt() ?? 0,
  streetReputation: (json['streetReputation'] as num?)?.toInt() ?? 0,
  activeResearch: json['activeResearch'] == null
      ? null
      : ActiveResearch.fromJson(json['activeResearch'] as Map<String, dynamic>),
  completedResearchIds:
      (json['completedResearchIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  researchPoints: (json['researchPoints'] as num?)?.toInt() ?? 10,
  holdingId: json['holdingId'] as String?,
);

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'level': instance.level,
      'experience': instance.experience,
      'cash': instance.cash,
      'bankAccount': instance.bankAccount,
      'debt': instance.debt,
      'currentDay': instance.currentDay,
      'totalTransactions': instance.totalTransactions,
      'totalProfit': instance.totalProfit,
      'portfolioValue': instance.portfolioValue,
      'legalReputation': instance.legalReputation,
      'streetReputation': instance.streetReputation,
      'activeResearch': instance.activeResearch,
      'completedResearchIds': instance.completedResearchIds,
      'researchPoints': instance.researchPoints,
      'holdingId': instance.holdingId,
    };
