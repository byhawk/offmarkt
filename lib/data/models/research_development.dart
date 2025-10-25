import 'package:freezed_annotation/freezed_annotation.dart';

part 'research_development.freezed.dart';
part 'research_development.g.dart';

/// Araştırmanın oyuncu için durumu
enum ResearchStatus {
  locked,      // Henüz erişilemez
  available,   // Araştırılabilir
  inProgress,  // Araştırma devam ediyor
  completed,   // Araştırma tamamlandı
}

/// Araştırmanın getireceği bonus türü
enum ResearchBonusType {
  productionSpeed, // Üretim hızı
  marketDemand,    // Pazar talebi
  costReduction,   // Maliyet düşürme
}

/// Teknoloji ağacındaki tek bir araştırma düğümü
@freezed
class ResearchNode with _$ResearchNode {
  const factory ResearchNode({
    required String id,
    required String name,
    required String description,
    required int researchPointsCost, // Araştırma maliyeti (örn: puan)
    required int durationSeconds,    // Araştırma süresi (saniye)
    required List<String> dependencies, // Bu araştırmayı açmak için gereken diğer node'ların ID'leri
    required ResearchBonusType bonusType,
    required double bonusValue,
  }) = _ResearchNode;

  factory ResearchNode.fromJson(Map<String, dynamic> json) => _$ResearchNodeFromJson(json);
}

/// Oyuncunun aktif araştırma projesi
@freezed
class ActiveResearch with _$ActiveResearch {
  const factory ActiveResearch({
    required String nodeId,
    required DateTime startTime,
    required DateTime endTime,
  }) = _ActiveResearch;

  factory ActiveResearch.fromJson(Map<String, dynamic> json) => _$ActiveResearchFromJson(json);
}