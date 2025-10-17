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
  legalReputation: (json['legalReputation'] as num?)?.toInt() ?? 50,
  streetReputation: (json['streetReputation'] as num?)?.toInt() ?? 50,
  riskLevel: (json['riskLevel'] as num?)?.toInt() ?? 0,
  suspicionLevel: (json['suspicionLevel'] as num?)?.toInt() ?? 0,
  currentDay: (json['currentDay'] as num?)?.toInt() ?? 1,
  totalTransactions: (json['totalTransactions'] as num?)?.toInt() ?? 0,
  totalProfit: (json['totalProfit'] as num?)?.toDouble() ?? 0.0,
  portfolioValue: (json['portfolioValue'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'level': instance.level,
      'experience': instance.experience,
      'cash': instance.cash,
      'bankAccount': instance.bankAccount,
      'debt': instance.debt,
      'legalReputation': instance.legalReputation,
      'streetReputation': instance.streetReputation,
      'riskLevel': instance.riskLevel,
      'suspicionLevel': instance.suspicionLevel,
      'currentDay': instance.currentDay,
      'totalTransactions': instance.totalTransactions,
      'totalProfit': instance.totalProfit,
      'portfolioValue': instance.portfolioValue,
    };
