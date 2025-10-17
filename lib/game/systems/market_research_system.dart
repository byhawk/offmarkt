import '../../data/models/player.dart';
import '../../data/models/product.dart';
import '../../data/models/market_research.dart';

/// Pazar araştırmaları sistemi
class MarketResearchSystem {
  /// Pazar araştırması maliyeti hesaplama
  static double calculateResearchCost({
    required ResearchType type,
    required ResearchQuality quality,
    required bool useAdvancedTools,
    required bool payForExpedited,
    required int playerLevel,
  }) {
    // Temel maliyet türüne göre
    double baseCost = 0;
    switch (type) {
      case ResearchType.trendAnalysis:
        baseCost = 1000;
      case ResearchType.competitorIntelligence:
        baseCost = 1500;
      case ResearchType.consumerBehavior:
        baseCost = 2000;
      case ResearchType.marketSize:
        baseCost = 1200;
      case ResearchType.priceForecasting:
        baseCost = 1800;
      case ResearchType.seasonalTrends:
        baseCost = 1400;
      case ResearchType.demandForecasting:
        baseCost = 1600;
      case ResearchType.riskAssessment:
        baseCost = 2200;
    }
    
    // Kaliteye göre maliyet çarpanı
    double qualityMultiplier = 1.0;
    switch (quality) {
      case ResearchQuality.preliminary:
        qualityMultiplier = 0.5;
      case ResearchQuality.standard:
        qualityMultiplier = 1.0;
      case ResearchQuality.comprehensive:
        qualityMultiplier = 2.0;
      case ResearchQuality.expert:
        qualityMultiplier = 4.0;
      case ResearchQuality.insider:
        qualityMultiplier = 8.0;
    }
    
    // İleri düzey araçlar kullanma
    double advancedToolCost = useAdvancedTools ? 500 : 0;
    
    // Hızlandırılmış araştırma
    double expeditedCost = payForExpedited ? baseCost * 0.5 : 0;
    
    // Seviyeye göre indirim
    double levelDiscount = playerLevel * 10; // Her seviyede 10₺ indirim
    
    double totalCost = (baseCost * qualityMultiplier) + advancedToolCost + expeditedCost - levelDiscount;
    
    return totalCost.clamp(100, double.infinity); // Minimum 100₺
  }

  /// Pazar araştırması süresi hesaplama
  static int calculateResearchDuration({
    required ResearchType type,
    required ResearchQuality quality,
    required bool useAdvancedTools,
    required bool payForExpedited,
    required int playerLevel,
  }) {
    // Temel süre (saat cinsinden)
    int baseDuration = 0;
    switch (type) {
      case ResearchType.trendAnalysis:
        baseDuration = 24;
      case ResearchType.competitorIntelligence:
        baseDuration = 48;
      case ResearchType.consumerBehavior:
        baseDuration = 72;
      case ResearchType.marketSize:
        baseDuration = 36;
      case ResearchType.priceForecasting:
        baseDuration = 60;
      case ResearchType.seasonalTrends:
        baseDuration = 48;
      case ResearchType.demandForecasting:
        baseDuration = 54;
      case ResearchType.riskAssessment:
        baseDuration = 84;
    }
    
    // Kaliteye göre süre çarpanı
    double qualityMultiplier = 1.0;
    switch (quality) {
      case ResearchQuality.preliminary:
        qualityMultiplier = 0.5;
      case ResearchQuality.standard:
        qualityMultiplier = 1.0;
      case ResearchQuality.comprehensive:
        qualityMultiplier = 2.0;
      case ResearchQuality.expert:
        qualityMultiplier = 3.0;
      case ResearchQuality.insider:
        qualityMultiplier = 5.0;
    }
    
    // İleri düzey araçlar zamanı azaltır
    double toolReduction = useAdvancedTools ? 0.3 : 0;
    
    // Hızlandırılmış araştırma zamanı azaltır
    double expeditedReduction = payForExpedited ? 0.5 : 0;
    
    // Seviyeye göre zaman azalması
    double levelReduction = playerLevel * 0.01; // Her seviyede %1 azalma
    
    double totalDuration = baseDuration * qualityMultiplier;
    totalDuration *= (1 - toolReduction);
    totalDuration *= (1 - expeditedReduction);
    totalDuration *= (1 - levelReduction);
    
    return totalDuration.round().clamp(1, 168); // 1 saat - 1 hafta arası
  }

  /// Pazar araştırması doğruluk hesaplama
  static double calculateResearchAccuracy({
    required ResearchQuality quality,
    required bool useAdvancedTools,
    required int playerLevel,
    required int legalReputation,
  }) {
    // Taban doğruluk
    double baseAccuracy = 0;
    switch (quality) {
      case ResearchQuality.preliminary:
        baseAccuracy = 0.4;
      case ResearchQuality.standard:
        baseAccuracy = 0.6;
      case ResearchQuality.comprehensive:
        baseAccuracy = 0.75;
      case ResearchQuality.expert:
        baseAccuracy = 0.85;
      case ResearchQuality.insider:
        baseAccuracy = 0.95;
    }
    
    // İleri düzey araçlar doğruluğu artırır
    double toolBonus = useAdvancedTools ? 0.1 : 0;
    
    // Seviye bonusu
    double levelBonus = (playerLevel / 200).clamp(0, 0.15); // Maksimum %15
    
    // Yasal itibar bonusu
    double reputationBonus = (legalReputation / 1000).clamp(0, 0.1); // Maksimum %10
    
    double totalAccuracy = baseAccuracy + toolBonus + levelBonus + reputationBonus;
    
    return totalAccuracy.clamp(0.4, 0.98); // Minimum %40, maksimum %98 doğruluk
  }

  /// Pazar araştırması başlat
  static (bool, String?, MarketResearch?) initiateResearch({
    required ResearchRequest request,
    required Player player,
    required List<Product> marketProducts,
  }) {
    // Maliyet hesapla
    double cost = calculateResearchCost(
      type: request.type,
      quality: request.desiredQuality,
      useAdvancedTools: request.useAdvancedTools,
      payForExpedited: request.payForExpedited,
      playerLevel: player.level,
    );
    
    if (player.cash < cost) {
      return (false, 'Yetersiz bakiye! Gerekli: ₺${cost.toStringAsFixed(2)}', null);
    }
    
    // Seçilen hedef ürün var mı kontrol et
    if (!marketProducts.any((product) => product.name == request.targetProduct)) {
      return (false, 'Geçersiz ürün! ${request.targetProduct} mevcut değil.', null);
    }
    
    // Araştırma süresi
    int duration = calculateResearchDuration(
      type: request.type,
      quality: request.desiredQuality,
      useAdvancedTools: request.useAdvancedTools,
      payForExpedited: request.payForExpedited,
      playerLevel: player.level,
    );
    
    // Doğruluk
    double accuracy = calculateResearchAccuracy(
      quality: request.desiredQuality,
      useAdvancedTools: request.useAdvancedTools,
      playerLevel: player.level,
      legalReputation: player.legalReputation,
    );
    
    // Tahminler oluştur
    List<MarketForecast> forecasts = _generateForecasts(
      request: request,
      accuracy: accuracy,
      marketProducts: marketProducts,
    );
    
    // Bulgular oluştur
    String insights = _generateInsights(request, forecasts, accuracy);
    
    // Pazar araştırması oluştur
    final research = MarketResearch(
      id: 'research_${DateTime.now().millisecondsSinceEpoch}',
      playerId: request.playerId,
      type: request.type,
      targetProduct: request.targetProduct,
      quality: request.desiredQuality,
      date: DateTime.now(),
      cost: cost,
      durationInHours: duration,
      accuracy: accuracy,
      insights: insights,
      forecasts: forecasts,
    );
    
    return (true, null, research);
  }

  /// Tahminler oluştur
  static List<MarketForecast> _generateForecasts({
    required ResearchRequest request,
    required double accuracy,
    required List<Product> marketProducts,
  }) {
    final forecasts = <MarketForecast>[];

    // Rastgele ama mantıklı tahminler oluştur
    for (int i = 1; i <= 7; i++) { // 7 günlük tahmin
      // Mevcut ürün fiyatını bul
      final product = marketProducts.firstWhere(
        (p) => p.name == request.targetProduct,
        orElse: () => const Product(id: 'unknown', emoji: '❓', name: 'Unknown', basePrice: 100, currentPrice: 100, demand: 50, volatility: 0.1),
      );
      
      // Doğruluk etkisini hesaba kat
      double accuracyFactor = (accuracy - 0.5) * 2; // 0.5'de 0, 1.0'da 1 olur
      
      // Rastgele ama mantıklı değişiklikler
      double priceChange = (0.5 - (DateTime.now().millisecond % 100) / 200) * (1 + accuracyFactor);
      double demandChange = (0.5 - (DateTime.now().second % 100) / 200) * (1 + accuracyFactor);
      
      double predictedPrice = product.currentPrice * (1 + priceChange * 0.2); // %20'ye kadar fiyat değişimi
      double predictedDemand = (product.demand + demandChange * 20).clamp(0, 100); // Talep 0-100 arası
      double confidence = accuracy + (0.1 - (DateTime.now().millisecond % 20) / 200); // %10'luk varyasyon
      
      forecasts.add(
        MarketForecast(
          dayOffset: i,
          predictedPrice: predictedPrice,
          predictedDemand: predictedDemand,
          confidence: confidence.clamp(0.5, 1.0),
          volatility: product.volatility * (1 + priceChange * 0.5),
          trendStrength: (0.5 + demandChange * 0.02).clamp(0.1, 1.0),
        ),
      );
    }
    
    return forecasts;
  }

  /// Bulgular oluştur
  static String _generateInsights(ResearchRequest request, List<MarketForecast> forecasts, double accuracy) {
    final buffer = StringBuffer();
    
    final firstForecast = forecasts.first;
    final lastForecast = forecasts.last;
    
    buffer.writeln('🎯 ${request.targetProduct} Ürünü İçin Pazar Bulguları:');
    
    if (request.type == ResearchType.trendAnalysis || request.type == ResearchType.priceForecasting) {
      if (firstForecast.predictedPrice < lastForecast.predictedPrice) {
        buffer.writeln('📈 Fiyatlar uzun vadede artış gösterebilir (${firstForecast.predictedPrice.toStringAsFixed(2)} → ${lastForecast.predictedPrice.toStringAsFixed(2)})');
      } else {
        buffer.writeln('📉 Fiyatlar uzun vadede düşüş gösterebilir (${firstForecast.predictedPrice.toStringAsFixed(2)} → ${lastForecast.predictedPrice.toStringAsFixed(2)})');
      }
    }
    
    if (request.type == ResearchType.demandForecasting || request.type == ResearchType.consumerBehavior) {
      if (firstForecast.predictedDemand < lastForecast.predictedDemand) {
        buffer.writeln('📈 Talep artabilir (${firstForecast.predictedDemand.toStringAsFixed(1)}% → ${lastForecast.predictedDemand.toStringAsFixed(1)}%)');
      } else {
        buffer.writeln('📉 Talep düşebilir (${firstForecast.predictedDemand.toStringAsFixed(1)}% → ${lastForecast.predictedDemand.toStringAsFixed(1)})');
      }
    }
    
    if (request.type == ResearchType.riskAssessment) {
      double avgRisk = forecasts.map((f) => f.volatility).reduce((a, b) => a + b) / forecasts.length;
      if (avgRisk > 0.2) {
        buffer.writeln('⚠️  Yüksek riskli bir ürün. Fiyat volatilitesi dikkatli takip edilmeli.');
      } else {
        buffer.writeln('✅ Orta veya düşük riskli bir ürün. Stabil bir yatırım seçeneği olabilir.');
      }
    }
    
    buffer.writeln('');
    buffer.writeln('ℹ️  Tahmin Doğruluğu: ${(accuracy * 100).toStringAsFixed(1)}%');
    
    return buffer.toString();
  }

  /// Pazar istihbaratı oluştur
  static MarketIntelligence generateIntelligence({
    required String playerId,
    required String targetProduct,
    required List<Product> marketProducts,
    required double accuracy,
  }) {
    // Mevcut ürün bilgilerini al
    final product = marketProducts.firstWhere(
      (p) => p.name == targetProduct,
      orElse: () => const Product(id: 'unknown', emoji: '❓', name: 'Unknown', basePrice: 100, currentPrice: 100, demand: 50, volatility: 0.1),
    );
    
    // Doğruluk etkisini hesaba kat
    double accuracyFactor = (accuracy - 0.5) * 2; // 0.5'de 0, 1.0'da 1 olur
    
    // Rakip fiyat tahmini (benzer ürün fiyatlarına göre)
    double competitorPrice = product.currentPrice * (0.8 + (0.4 * accuracyFactor));
    
    // Pazar paylaşımı tahmini
    double marketShare = (10 + (playerId.length * 0.5)).clamp(10, 80);
    
    // Arz seviyesi
    double supplyLevel = product.demand * (0.5 + (0.5 * accuracyFactor));
    
    return MarketIntelligence(
      id: 'intel_${DateTime.now().millisecondsSinceEpoch}',
      playerId: playerId,
      targetProduct: targetProduct,
      date: DateTime.now(),
      competitorPrice: competitorPrice,
      competitorDemand: product.demand * (0.7 + (0.3 * accuracyFactor)),
      marketShare: marketShare,
      supplyLevel: supplyLevel,
      marketConditions: _generateMarketConditions(product, accuracy),
    );
  }

  /// Pazar koşulları metni oluştur
  static String _generateMarketConditions(Product product, double accuracy) {
    if (product.demand > 70) {
      return 'Yüksek talep gören ürün. Fiyatlar yükselebilir.';
    } else if (product.demand < 30) {
      return 'Düşük talep gören ürün. Fiyat baskısı olabilir.';
    } else {
      return 'Dengeli talep. Fiyat istikrarı devam edebilir.';
    }
  }

  /// Tüketici davranış analizi oluştur
  static ConsumerBehaviorAnalysis generateConsumerBehavior({
    required String playerId,
    required String targetProduct,
    required double accuracy,
  }) {
    // Doğruluk etkisini hesaba kat
    double accuracyFactor = (accuracy - 0.5) * 2; // 0.5'de 0, 1.0'da 1 olur
    
    return ConsumerBehaviorAnalysis(
      id: 'behavior_${DateTime.now().millisecondsSinceEpoch}',
      playerId: playerId,
      targetProduct: targetProduct,
      date: DateTime.now(),
      priceSensitivity: (0.3 + (0.4 * accuracyFactor)).clamp(0.1, 0.9),
      brandLoyalty: (0.4 + (0.4 * accuracyFactor)).clamp(0.2, 0.8),
      seasonalPreference: (0.5 + (0.3 * accuracyFactor)).clamp(0.2, 0.9),
      trendInfluence: (0.6 + (0.3 * accuracyFactor)).clamp(0.3, 0.9),
      riskAversion: (0.4 + (0.2 * accuracyFactor)).clamp(0.2, 0.7),
    );
  }
}