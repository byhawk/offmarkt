// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvestmentImpl _$$InvestmentImplFromJson(Map<String, dynamic> json) =>
    _$InvestmentImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      companyName: json['companyName'] as String,
      shares: (json['shares'] as num).toInt(),
      purchasePricePerShare: (json['purchasePricePerShare'] as num).toDouble(),
      currentPricePerShare: (json['currentPricePerShare'] as num).toDouble(),
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      dividendsReceived: (json['dividendsReceived'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$InvestmentImplToJson(_$InvestmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'shares': instance.shares,
      'purchasePricePerShare': instance.purchasePricePerShare,
      'currentPricePerShare': instance.currentPricePerShare,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'dividendsReceived': instance.dividendsReceived,
    };
