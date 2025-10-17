import 'package:freezed_annotation/freezed_annotation.dart';

part 'research_development.freezed.dart';
part 'research_development.g.dart';

/// Ar-Ge projesi türleri
enum RdProjectType {
  productDevelopment('Ürün Geliştirme'),
  processImprovement('Süreç İyileştirme'),
  technologyUpgrade('Teknoloji Yükseltimi'),
  marketInnovation('Pazar İnovasyonu'),
  qualityEnhancement('Kalite Artırımı'),
  efficiencyOptimization('Verimlilik Optimizasyonu'),
  patentDevelopment('Patent Geliştirme'),
  rAndDCenter('Ar-Ge Merkezi');

  const RdProjectType(this.displayName);
  final String displayName;
}

/// Ar-Ge projesi seviyeleri
enum RdProjectLevel {
  basic('Temel'),
  advanced('Gelişmiş'),
  expert('Uzman'),
  innovative('İnovatif'),
  revolutionary('Devrimci');

  const RdProjectLevel(this.displayName);
  final String displayName;
}

/// Ar-Ge projesi durumları
enum RdProjectStatus {
  planning('Planlama'),
  inProgress('Devam Ediyor'),
  paused('Duraklatıldı'),
  completed('Tamamlandı'),
  failed('Başarısız'),
  abandoned('İptal Edildi');

  const RdProjectStatus(this.displayName);
  final String displayName;
}

/// Ar-Ge projesi
@freezed
class RdProject with _$RdProject {
  const RdProject._();

  const factory RdProject({
    required String id,
    required String playerId,
    required RdProjectType type,
    required RdProjectLevel level,
    required RdProjectStatus status,
    required String name,
    required String description,
    required DateTime startDate,
    @Default(null) DateTime? endDate,
    required int durationInDays,
    required double budget,
    @Default(0.0) double costIncurred,
    @Default(0.0) double progress, // 0.0 - 1.0 arası
    @Default(0.0) double successProbability,
    @Default(0.0) double potentialValue,
    @Default(0.0) double efficiencyIncrease,
    @Default(0.0) double qualityImprovement,
    @Default(0.0) double marketAdvantage,
    @Default([]) List<RdMilestone> milestones,
    @Default([]) List<RdResource> requiredResources,
    @Default([]) List<RdTeamMember> teamMembers,
    @Default([]) List<String> achievements,
  }) = _RdProject;

  factory RdProject.fromJson(Map<String, dynamic> json) => _$RdProjectFromJson(json);

  /// Kalan gün sayısını hesapla
  int get daysRemaining {
    if (status == RdProjectStatus.completed || status == RdProjectStatus.failed) {
      return 0;
    }
    final now = DateTime.now();
    final projectEnd = startDate.add(Duration(days: durationInDays));
    return projectEnd.difference(now).inDays;
  }

  /// Proje tamamlanma yüzdesi
  double get completionPercentage => progress * 100;

  /// Toplam harcanan bütçe yüzdesi
  double get budgetUtilization => budget > 0 ? (costIncurred / budget) * 100 : 0;
}

/// Ar-Ge kilometre taşı
@freezed
class RdMilestone with _$RdMilestone {
  const factory RdMilestone({
    required int id,
    required String name,
    required String description,
    required double progressRequirement, // 0.0 - 1.0 arası
    required DateTime targetDate,
    @Default(null) DateTime? completionDate,
    @Default(false) bool completed,
    @Default(0.0) double bonusValue,
  }) = _RdMilestone;

  factory RdMilestone.fromJson(Map<String, dynamic> json) => _$RdMilestoneFromJson(json);
}

/// Ar-Ge kaynak türü
enum RdResourceType {
  equipment('Ekipman'),
  material('Malzeme'),
  software('Yazılım'),
  facility('Tesis'),
  externalService('Dış Hizmet');

  const RdResourceType(this.displayName);
  final String displayName;
}

/// Ar-Ge gerekli kaynak
@freezed
class RdResource with _$RdResource {
  const RdResource._();

  const factory RdResource({
    required RdResourceType type,
    required String name,
    required int quantity,
    required double unitCost,
    @Default(false) bool acquired,
  }) = _RdResource;

  factory RdResource.fromJson(Map<String, dynamic> json) => _$RdResourceFromJson(json);

  /// Toplam maliyet
  double get totalCost => quantity * unitCost;
}

/// Ar-Ge personel pozisyonu
enum RdTeamPosition {
  leadResearcher('Lider Araştırmacı'),
  seniorResearcher('Kıdemli Araştırmacı'),
  researcher('Araştırmacı'),
  assistant('Araştırma Görevlisi'),
  consultant('Danışman');

  const RdTeamPosition(this.displayName);
  final String displayName;
}

/// Ar-Ge ekibi üyesi
@freezed
class RdTeamMember with _$RdTeamMember {
  const factory RdTeamMember({
    required String id,
    required String name,
    required RdTeamPosition position,
    required int skillLevel, // 1-10 arası
    required double dailyCost,
    @Default(0.0) double performanceRating,
    @Default(0.0) double contribution,
  }) = _RdTeamMember;

  factory RdTeamMember.fromJson(Map<String, dynamic> json) => _$RdTeamMemberFromJson(json);
}

/// Ar-Ge laboratuvarı
@freezed
class RdLab with _$RdLab {
  const factory RdLab({
    required String id,
    required String playerId,
    @Default(0.0) double totalInvestment,
    @Default(0.0) double currentBudget,
    @Default(0.0) double efficiencyBonus,
    @Default(0.0) double safetyFactor,
    @Default(0.0) double innovationRate,
    @Default(0) int maxProjects,
    @Default(0) int currentProjects,
    @Default([]) List<RdProject> activeProjects,
    @Default([]) List<RdTeamMember> staff,
  }) = _RdLab;

  factory RdLab.fromJson(Map<String, dynamic> json) => _$RdLabFromJson(json);
}

/// Ar-Ge isteği
@freezed
class RdRequest with _$RdRequest {
  const factory RdRequest({
    required String playerId,
    required RdProjectType type,
    required RdProjectLevel level,
    required String projectName,
    required String projectDescription,
    @Default(false) bool usePremiumResources,
    @Default(false) bool hireExternalExperts,
  }) = _RdRequest;

  factory RdRequest.fromJson(Map<String, dynamic> json) => _$RdRequestFromJson(json);
}