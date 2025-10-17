// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_research.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarketResearchImpl _$$MarketResearchImplFromJson(Map<String, dynamic> json) =>
    _$MarketResearchImpl(
      id: json['id'] as String,
      playerId: json['playerId'] as String,
      type: $enumDecode(_$ResearchTypeEnumMap, json['type']),
      targetProduct: json['targetProduct'] as String,
      quality: $enumDecode(_$ResearchQualityEnumMap, json['quality']),
      date: DateTime.parse(json['date'] as String),
      cost: (json['cost'] as num).toDouble(),
      durationInHours: (json['durationInHours'] as num).toInt(),
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
      insights: json['insights'] as String? ?? '',
      pricePrediction: (json['pricePrediction'] as num?)?.toDouble() ?? 0.0,
      demandPrediction: (json['demandPrediction'] as num?)?.toDouble() ?? 0.0,
      riskAssessment: (json['riskAssessment'] as num?)?.toDouble() ?? 0.0,
      forecasts:
          (json['forecasts'] as List<dynamic>?)
              ?.map((e) => MarketForecast.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      additionalData:
          json['additionalData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$MarketResearchImplToJson(
  _$MarketResearchImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'playerId': instance.playerId,
  'type': _$ResearchTypeEnumMap[instance.type]!,
  'targetProduct': instance.targetProduct,
  'quality': _$ResearchQualityEnumMap[instance.quality]!,
  'date': instance.date.toIso8601String(),
  'cost': instance.cost,
  'durationInHours': instance.durationInHours,
  'accuracy': instance.accuracy,
  'insights': instance.insights,
  'pricePrediction': instance.pricePrediction,
  'demandPrediction': instance.demandPrediction,
  'riskAssessment': instance.riskAssessment,
  'forecasts': instance.forecasts,
  'additionalData': instance.additionalData,
};

const _$ResearchTypeEnumMap = {
  ResearchType.trendAnalysis: 'trendAnalysis',
  ResearchType.competitorIntelligence: 'competitorIntelligence',
  ResearchType.consumerBehavior: 'consumerBehavior',
  ResearchType.marketSize: 'marketSize',
  ResearchType.priceForecasting: 'priceForecasting',
  ResearchType.seasonalTrends: 'seasonalTrends',
  ResearchType.demandForecasting: 'demandForecasting',
  ResearchType.riskAssessment: 'riskAssessment',
};

const _$ResearchQualityEnumMap = {
  ResearchQuality.preliminary: 'preliminary',
  ResearchQuality.standard: 'standard',
  ResearchQuality.comprehensive: 'comprehensive',
  ResearchQuality.expert: 'expert',
  ResearchQuality.insider: 'insider',
};

_$MarketForecastImpl _$$MarketForecastImplFromJson(Map<String, dynamic> json) =>
    _$MarketForecastImpl(
      dayOffset: (json['dayOffset'] as num).toInt(),
      predictedPrice: (json['predictedPrice'] as num).toDouble(),
      predictedDemand: (json['predictedDemand'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      volatility: (json['volatility'] as num?)?.toDouble() ?? 0.0,
      trendStrength: (json['trendStrength'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$MarketForecastImplToJson(
  _$MarketForecastImpl instance,
) => <String, dynamic>{
  'dayOffset': instance.dayOffset,
  'predictedPrice': instance.predictedPrice,
  'predictedDemand': instance.predictedDemand,
  'confidence': instance.confidence,
  'volatility': instance.volatility,
  'trendStrength': instance.trendStrength,
};

_$MarketIntelligenceImpl _$$MarketIntelligenceImplFromJson(
  Map<String, dynamic> json,
) => _$MarketIntelligenceImpl(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  targetProduct: json['targetProduct'] as String,
  date: DateTime.parse(json['date'] as String),
  competitorPrice: (json['competitorPrice'] as num?)?.toDouble() ?? 0.0,
  competitorDemand: (json['competitorDemand'] as num?)?.toDouble() ?? 0.0,
  marketShare: (json['marketShare'] as num?)?.toDouble() ?? 0.0,
  supplyLevel: (json['supplyLevel'] as num?)?.toDouble() ?? 0.0,
  marketConditions: json['marketConditions'] as String? ?? '',
  additionalData: json['additionalData'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$$MarketIntelligenceImplToJson(
  _$MarketIntelligenceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'playerId': instance.playerId,
  'targetProduct': instance.targetProduct,
  'date': instance.date.toIso8601String(),
  'competitorPrice': instance.competitorPrice,
  'competitorDemand': instance.competitorDemand,
  'marketShare': instance.marketShare,
  'supplyLevel': instance.supplyLevel,
  'marketConditions': instance.marketConditions,
  'additionalData': instance.additionalData,
};

_$ConsumerBehaviorAnalysisImpl _$$ConsumerBehaviorAnalysisImplFromJson(
  Map<String, dynamic> json,
) => _$ConsumerBehaviorAnalysisImpl(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  targetProduct: json['targetProduct'] as String,
  date: DateTime.parse(json['date'] as String),
  priceSensitivity: (json['priceSensitivity'] as num?)?.toDouble() ?? 0.0,
  brandLoyalty: (json['brandLoyalty'] as num?)?.toDouble() ?? 0.0,
  seasonalPreference: (json['seasonalPreference'] as num?)?.toDouble() ?? 0.0,
  trendInfluence: (json['trendInfluence'] as num?)?.toDouble() ?? 0.0,
  riskAversion: (json['riskAversion'] as num?)?.toDouble() ?? 0.0,
  preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$$ConsumerBehaviorAnalysisImplToJson(
  _$ConsumerBehaviorAnalysisImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'playerId': instance.playerId,
  'targetProduct': instance.targetProduct,
  'date': instance.date.toIso8601String(),
  'priceSensitivity': instance.priceSensitivity,
  'brandLoyalty': instance.brandLoyalty,
  'seasonalPreference': instance.seasonalPreference,
  'trendInfluence': instance.trendInfluence,
  'riskAversion': instance.riskAversion,
  'preferences': instance.preferences,
};

_$ResearchRequestImpl _$$ResearchRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ResearchRequestImpl(
  playerId: json['playerId'] as String,
  type: $enumDecode(_$ResearchTypeEnumMap, json['type']),
  targetProduct: json['targetProduct'] as String,
  desiredQuality:
      $enumDecodeNullable(_$ResearchQualityEnumMap, json['desiredQuality']) ??
      ResearchQuality.standard,
  useAdvancedTools: json['useAdvancedTools'] as bool? ?? false,
  payForExpedited: json['payForExpedited'] as bool? ?? false,
);

Map<String, dynamic> _$$ResearchRequestImplToJson(
  _$ResearchRequestImpl instance,
) => <String, dynamic>{
  'playerId': instance.playerId,
  'type': _$ResearchTypeEnumMap[instance.type]!,
  'targetProduct': instance.targetProduct,
  'desiredQuality': _$ResearchQualityEnumMap[instance.desiredQuality]!,
  'useAdvancedTools': instance.useAdvancedTools,
  'payForExpedited': instance.payForExpedited,
};
