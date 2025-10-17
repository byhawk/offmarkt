import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_research.freezed.dart';
part 'market_research.g.dart';

/// Pazar araştırması türleri
enum ResearchType {
  trendAnalysis('Trend Analizi'),
  competitorIntelligence('Rakip İstihbaratı'),
  consumerBehavior('Tüketici Davranışı'),
  marketSize('Pazar Büyüklüğü'),
  priceForecasting('Fiyat Tahmini'),
  seasonalTrends('Mevsimsel Trendler'),
  demandForecasting('Talep Tahmini'),
  riskAssessment('Risk Değerlendirmesi');

  const ResearchType(this.displayName);
  final String displayName;
}

/// Pazar araştırması sonuç seviyeleri
enum ResearchQuality {
  preliminary('Birincil'),
  standard('Standart'),
  comprehensive('Kapsamlı'),
  expert('Uzman Seviyesi'),
  insider('İç Oyuncu');

  const ResearchQuality(this.displayName);
  final String displayName;
}

/// Pazar araştırması sonuçları
@freezed
class MarketResearch with _$MarketResearch {
  const MarketResearch._();

  const factory MarketResearch({
    required String id,
    required String playerId,
    required ResearchType type,
    required String targetProduct,
    required ResearchQuality quality,
    required DateTime date,
    required double cost,
    required int durationInHours,
    @Default(0.0) double accuracy, // 0.0 - 1.0 arası doğruluk
    @Default('') String insights,
    @Default(0.0) double pricePrediction,
    @Default(0.0) double demandPrediction,
    @Default(0.0) double riskAssessment,
    @Default([]) List<MarketForecast> forecasts,
    @Default({}) Map<String, dynamic> additionalData,
  }) = _MarketResearch;

  factory MarketResearch.fromJson(Map<String, dynamic> json) => _$MarketResearchFromJson(json);

  /// Araştırma raporunu formatla
  String get formattedReport {
    final buffer = StringBuffer();
    buffer.writeln('📊 Pazar Araştırması Raporu');
    buffer.writeln('Tür: ${type.displayName}');
    buffer.writeln('Hedef: $targetProduct');
    buffer.writeln('Doğruluk: ${(accuracy * 100).toStringAsFixed(1)}%');
    buffer.writeln('');
    buffer.writeln('💡 Bulgular:');
    buffer.writeln(insights);
    buffer.writeln('');
    buffer.writeln('📈 Tahminler:');
    buffer.writeln('Fiyat: ₺${pricePrediction.toStringAsFixed(2)}');
    buffer.writeln('Talep: ${(demandPrediction * 100).toStringAsFixed(1)}%');
    buffer.writeln('Risk: ${(riskAssessment * 100).toStringAsFixed(1)}%');
    
    return buffer.toString();
  }
}

/// Pazar tahminleri
@freezed
class MarketForecast with _$MarketForecast {
  const factory MarketForecast({
    required int dayOffset, // Gelecekteki gün sayısı
    required double predictedPrice,
    required double predictedDemand,
    required double confidence, // 0.0 - 1.0 arası güven
    @Default(0.0) double volatility, // Fiyat volatilitesi
    @Default(0.0) double trendStrength, // Trend gücü
  }) = _MarketForecast;

  factory MarketForecast.fromJson(Map<String, dynamic> json) => _$MarketForecastFromJson(json);
}

/// Pazar istihbaratı
@freezed
class MarketIntelligence with _$MarketIntelligence {
  const factory MarketIntelligence({
    required String id,
    required String playerId,
    required String targetProduct,
    required DateTime date,
    @Default(0.0) double competitorPrice,
    @Default(0.0) double competitorDemand,
    @Default(0.0) double marketShare,
    @Default(0.0) double supplyLevel,
    @Default('') String marketConditions,
    @Default({}) Map<String, dynamic> additionalData,
  }) = _MarketIntelligence;

  factory MarketIntelligence.fromJson(Map<String, dynamic> json) => _$MarketIntelligenceFromJson(json);
}

/// Tüketici davranış analizi
@freezed
class ConsumerBehaviorAnalysis with _$ConsumerBehaviorAnalysis {
  const factory ConsumerBehaviorAnalysis({
    required String id,
    required String playerId,
    required String targetProduct,
    required DateTime date,
    @Default(0.0) double priceSensitivity,
    @Default(0.0) double brandLoyalty,
    @Default(0.0) double seasonalPreference,
    @Default(0.0) double trendInfluence,
    @Default(0.0) double riskAversion,
    @Default({}) Map<String, dynamic> preferences,
  }) = _ConsumerBehaviorAnalysis;

  factory ConsumerBehaviorAnalysis.fromJson(Map<String, dynamic> json) => _$ConsumerBehaviorAnalysisFromJson(json);
}

/// Pazar araştırması isteği
@freezed
class ResearchRequest with _$ResearchRequest {
  const factory ResearchRequest({
    required String playerId,
    required ResearchType type,
    required String targetProduct,
    @Default(ResearchQuality.standard) ResearchQuality desiredQuality,
    @Default(false) bool useAdvancedTools,
    @Default(false) bool payForExpedited,
  }) = _ResearchRequest;

  factory ResearchRequest.fromJson(Map<String, dynamic> json) => _$ResearchRequestFromJson(json);
}