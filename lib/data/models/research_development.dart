import 'package:freezed_annotation/freezed_annotation.dart';

part 'research_development.freezed.dart';
part 'research_development.g.dart';

/// Ar-Ge proje türü
enum RdProjectType {
  productDevelopment, // Ürün geliştirme
  processImprovement, // Süreç iyileştirme
  technologyUpgrade, // Teknoloji yükseltme
  marketInnovation, // Pazar yeniliği
  qualityEnhancement, // Kalite geliştirme
  efficiencyOptimization, // Verimlilik optimizasyonu
  patentDevelopment, // Patent geliştirme
  rAndDCenter, // Ar-Ge merkezi
}

/// Ar-Ge proje seviyesi
enum RdProjectLevel {
  basic, // Temel
  advanced, // Gelişmiş
  expert, // Uzman
  innovative, // Yenilikçi
  revolutionary, // Devrimci
}

/// Ar-Ge proje durumu
enum RdProjectStatus {
  inProgress, // Devam ediyor
  completed, // Tamamlandı
  failed, // Başarısız
  cancelled, // İptal edildi
}

/// Ar-Ge kaynak türü
enum RdResourceType {
  equipment, // Ekipman
  material, // Malzeme
  software, // Yazılım
  personnel, // Personel
}

/// Araştırmanın getireceği bonus türü
enum ResearchBonusType {
  productionSpeed, // Üretim hızı
  marketDemand, // Pazar talebi
  costReduction, // Maliyet düşürme
}

/// Araştırma durumu (eski sistem için geriye uyumluluk)
enum ResearchStatus {
  locked, // Henüz erişilemez
  available, // Araştırılabilir
  inProgress, // Araştırma devam ediyor
  completed, // Araştırma tamamlandı
}

/// Teknoloji ağacındaki tek bir araştırma düğümü
@freezed
class ResearchNode with _$ResearchNode {
  const factory ResearchNode({
    required String id,
    required String name,
    required String description,
    required int researchPointsCost, // Araştırma maliyeti (örn: puan)
    required int durationSeconds, // Araştırma süresi (saniye)
    required List<String>
    dependencies, // Bu araştırmayı açmak için gereken diğer node'ların ID'leri
    required ResearchBonusType bonusType,
    required double bonusValue,
  }) = _ResearchNode;

  factory ResearchNode.fromJson(Map<String, dynamic> json) =>
      _$ResearchNodeFromJson(json);
}

/// Oyuncunun aktif araştırma projesi
@freezed
class ActiveResearch with _$ActiveResearch {
  const factory ActiveResearch({
    required String nodeId,
    required DateTime startTime,
    required DateTime endTime,
  }) = _ActiveResearch;

  factory ActiveResearch.fromJson(Map<String, dynamic> json) =>
      _$ActiveResearchFromJson(json);
}

/// Ar-Ge proje isteği
@freezed
class RdRequest with _$RdRequest {
  const factory RdRequest({
    required String projectName,
    String? projectDescription,
    required RdProjectType type,
    required RdProjectLevel level,
    required bool usePremiumResources,
    @Default(false) bool hireExternalExperts,
    String? playerId,
    int? durationInDays,
    double? budget,
    double? successProbability,
    double? potentialValue,
    double? qualityImprovement,
    double? marketAdvantage,
  }) = _RdRequest;

  factory RdRequest.fromJson(Map<String, dynamic> json) =>
      _$RdRequestFromJson(json);
}

/// Ar-Ge proje kilometre taşı
@freezed
class RdMilestone with _$RdMilestone {
  const factory RdMilestone({
    required int id,
    required String name,
    required String description,
    @Default(false) bool completed,
    @Default(0.0) double progressRequirement,
    DateTime? targetDate,
    DateTime? completionDate,
    @Default(0.0) double bonusValue,
  }) = _RdMilestone;

  factory RdMilestone.fromJson(Map<String, dynamic> json) =>
      _$RdMilestoneFromJson(json);
}

/// Ar-Ge kaynağı
@freezed
class RdResource with _$RdResource {
  const factory RdResource({
    required String id,
    required RdResourceType type,
    required String name,
    required String description,
    @Default(false) bool acquired,
    @Default(0.0) double cost,
    @Default(0) int quantity,
    @Default(0.0) double unitCost,
  }) = _RdResource;

  factory RdResource.fromJson(Map<String, dynamic> json) =>
      _$RdResourceFromJson(json);
}

/// Ar-Ge projesi
@freezed
class RdProject with _$RdProject {
  const factory RdProject({
    required String id,
    required String name,
    required RdProjectLevel level,
    required RdProjectStatus status,
    required DateTime startDate,
    DateTime? endDate,
    @Default(0.0) double progress,
    @Default(0.0) double efficiencyIncrease,
    @Default([]) List<RdMilestone> milestones,
    @Default([]) List<RdResource> requiredResources,
    @Default(30) int durationInDays,
    @Default(0.5) double successProbability,
    DateTime? completionDate,
  }) = _RdProject;

  factory RdProject.fromJson(Map<String, dynamic> json) =>
      _$RdProjectFromJson(json);
}

/// Ar-Ge laboratuvarı
@freezed
class RdLab with _$RdLab {
  const factory RdLab({
    required String id,
    required String playerId,
    @Default(1) int level,
    @Default(100) int maxProjects,
    @Default(50) int researchPointsPerDay,
    @Default([]) List<RdProject> activeProjects,
    @Default([]) List<RdProject> completedProjects,
    @Default(0.0) double totalInvestment,
    @Default(0.0) double currentBudget,
    @Default(0.0) double efficiencyBonus,
    @Default(0.5) double safetyFactor,
    @Default(0.1) double innovationRate,
  }) = _RdLab;

  factory RdLab.fromJson(Map<String, dynamic> json) => _$RdLabFromJson(json);
}
