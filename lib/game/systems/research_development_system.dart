import '../../data/models/player.dart';
import '../../data/models/research_development.dart';

/// Araştırma ve Geliştirme (Ar-Ge) sistemi
class ResearchDevelopmentSystem {
  /// Ar-Ge projesi maliyeti hesaplama
  static double calculateProjectCost({
    required RdProjectType type,
    required RdProjectLevel level,
    required bool usePremiumResources,
    required bool hireExternalExperts,
    required int playerLevel,
  }) {
    // Temel maliyet türüne göre
    double baseCost = 0;
    switch (type) {
      case RdProjectType.productDevelopment:
        baseCost = 5000;
      case RdProjectType.processImprovement:
        baseCost = 3000;
      case RdProjectType.technologyUpgrade:
        baseCost = 8000;
      case RdProjectType.marketInnovation:
        baseCost = 6000;
      case RdProjectType.qualityEnhancement:
        baseCost = 4000;
      case RdProjectType.efficiencyOptimization:
        baseCost = 3500;
      case RdProjectType.patentDevelopment:
        baseCost = 10000;
      case RdProjectType.rAndDCenter:
        baseCost = 15000;
    }

    // Seviyeye göre maliyet çarpanı
    double levelMultiplier = 1.0;
    switch (level) {
      case RdProjectLevel.basic:
        levelMultiplier = 1.0;
      case RdProjectLevel.advanced:
        levelMultiplier = 2.0;
      case RdProjectLevel.expert:
        levelMultiplier = 4.0;
      case RdProjectLevel.innovative:
        levelMultiplier = 8.0;
      case RdProjectLevel.revolutionary:
        levelMultiplier = 15.0;
    }

    // Premium kaynaklar
    double premiumMultiplier = usePremiumResources ? 2.0 : 1.0;

    // Dış uzman istihdamı
    double externalExpertCost = hireExternalExperts ? baseCost * 0.5 : 0;

    // Seviyeye göre indirim
    double levelDiscount = playerLevel * 50; // Her seviyede 50₺ indirim

    double totalCost =
        (baseCost * levelMultiplier * premiumMultiplier) +
        externalExpertCost -
        levelDiscount;

    return totalCost.clamp(1000, double.infinity); // Minimum 1000₺
  }

  /// Ar-Ge projesi süresi hesaplama
  static int calculateProjectDuration({
    required RdProjectType type,
    required RdProjectLevel level,
    required bool usePremiumResources,
    required bool hireExternalExperts,
    required int playerLevel,
  }) {
    // Temel süre (gün cinsinden)
    int baseDuration = 0;
    switch (type) {
      case RdProjectType.productDevelopment:
        baseDuration = 30;
      case RdProjectType.processImprovement:
        baseDuration = 20;
      case RdProjectType.technologyUpgrade:
        baseDuration = 45;
      case RdProjectType.marketInnovation:
        baseDuration = 35;
      case RdProjectType.qualityEnhancement:
        baseDuration = 25;
      case RdProjectType.efficiencyOptimization:
        baseDuration = 22;
      case RdProjectType.patentDevelopment:
        baseDuration = 60;
      case RdProjectType.rAndDCenter:
        baseDuration = 90;
    }

    // Seviyeye göre süre çarpanı
    double levelMultiplier = 1.0;
    switch (level) {
      case RdProjectLevel.basic:
        levelMultiplier = 1.0;
      case RdProjectLevel.advanced:
        levelMultiplier = 1.5;
      case RdProjectLevel.expert:
        levelMultiplier = 2.0;
      case RdProjectLevel.innovative:
        levelMultiplier = 3.0;
      case RdProjectLevel.revolutionary:
        levelMultiplier = 5.0;
    }

    // Premium kaynaklar süreyi azaltır
    double premiumReduction = usePremiumResources ? 0.3 : 0;

    // Dış uzmanlar süreyi azaltır
    double expertReduction = hireExternalExperts ? 0.4 : 0;

    // Seviyeye göre zaman azalması
    double levelReduction = playerLevel * 0.005; // Her seviyede %0.5 azalma

    double totalDuration = baseDuration * levelMultiplier;
    totalDuration *= (1 - premiumReduction);
    totalDuration *= (1 - expertReduction);
    totalDuration *= (1 - levelReduction);

    return totalDuration.round().clamp(5, 365); // 5 gün - 1 yıl arası
  }

  /// Ar-Ge projesi başarı olasılığı hesaplama
  static double calculateSuccessProbability({
    required RdProjectLevel level,
    required bool usePremiumResources,
    required bool hireExternalExperts,
    required int playerLevel,
    required int researchReputation,
  }) {
    // Taban başarı olasılığı
    double baseProbability = 0;
    switch (level) {
      case RdProjectLevel.basic:
        baseProbability = 0.9;
      case RdProjectLevel.advanced:
        baseProbability = 0.75;
      case RdProjectLevel.expert:
        baseProbability = 0.6;
      case RdProjectLevel.innovative:
        baseProbability = 0.4;
      case RdProjectLevel.revolutionary:
        baseProbability = 0.2;
    }

    // Premium kaynak artışı
    double premiumBonus = usePremiumResources ? 0.15 : 0;

    // Dış uzman bonusu
    double expertBonus = hireExternalExperts ? 0.2 : 0;

    // Seviye bonusu
    double levelBonus = (playerLevel / 200).clamp(0, 0.25); // Maksimum %25

    // Ar-Ge itibarı bonusu
    double reputationBonus = (researchReputation / 1000).clamp(
      0,
      0.15,
    ); // Maksimum %15

    double totalProbability =
        baseProbability +
        premiumBonus +
        expertBonus +
        levelBonus +
        reputationBonus;

    return totalProbability.clamp(
      0.1,
      0.95,
    ); // Minimum %10, maksimum %95 başarı
  }

  /// Ar-Ge projesi başlat
  static (bool, String?, RdProject?) initiateProject({
    required RdRequest request,
    required Player player,
  }) {
    // Maliyet hesapla
    double cost = calculateProjectCost(
      type: request.type,
      level: request.level,
      usePremiumResources: request.usePremiumResources,
      hireExternalExperts: request.hireExternalExperts,
      playerLevel: player.level,
    );

    if (player.cash < cost) {
      return (
        false,
        'Yetersiz bakiye! Gerekli: ₺${cost.toStringAsFixed(2)}',
        null,
      );
    }

    // Proje süresi
    int duration = calculateProjectDuration(
      type: request.type,
      level: request.level,
      usePremiumResources: request.usePremiumResources,
      hireExternalExperts: request.hireExternalExperts,
      playerLevel: player.level,
    );

    // Başarı olasılığı
    double successProbability = calculateSuccessProbability(
      level: request.level,
      usePremiumResources: request.usePremiumResources,
      hireExternalExperts: request.hireExternalExperts,
      playerLevel: player.level,
      researchReputation: player.level * 5, // Örnek: seviye * 5 ar-ge itibarı
    );

    // Potansiyel değer
    double potentialValue =
        cost * (1 + (successProbability * 2)); // Başarıya göre artan değer

    // Etki hesaplamaları
    double efficiencyIncrease =
        (request.level.index + 1) *
        (request.usePremiumResources ? 1.5 : 1.0) *
        0.05;
    double qualityImprovement =
        (request.level.index + 1) *
        (request.usePremiumResources ? 1.3 : 1.0) *
        0.03;
    double marketAdvantage =
        (request.level.index + 1) *
        (request.hireExternalExperts ? 1.4 : 1.0) *
        0.02;

    // Kilometre taşları oluştur
    List<RdMilestone> milestones = _generateMilestones(duration, request.level);

    // Gerekli kaynaklar
    List<RdResource> requiredResources = _generateRequiredResources(request);

    // Ar-Ge projesi oluştur
    final project = RdProject(
      id: 'rd_${DateTime.now().millisecondsSinceEpoch}',
      playerId: request.playerId,
      type: request.type,
      level: request.level,
      status: RdProjectStatus.inProgress,
      name: request.projectName,
      description: request.projectDescription,
      startDate: DateTime.now(),
      durationInDays: duration,
      budget: cost,
      progress: 0.0,
      successProbability: successProbability,
      potentialValue: potentialValue,
      efficiencyIncrease: efficiencyIncrease,
      qualityImprovement: qualityImprovement,
      marketAdvantage: marketAdvantage,
      milestones: milestones,
      requiredResources: requiredResources,
    );

    return (true, null, project);
  }

  /// Kilometre taşları oluştur
  static List<RdMilestone> _generateMilestones(
    int duration,
    RdProjectLevel level,
  ) {
    final milestones = <RdMilestone>[];

    // Proje süresine göre kilometre taşı sayısı
    int milestoneCount = (duration / 10).ceil(); // Her 10 gün için bir taşı
    milestoneCount = milestoneCount.clamp(3, 10); // Minimum 3, maksimum 10 taşı

    for (int i = 1; i <= milestoneCount; i++) {
      double progressRequirement =
          i / milestoneCount; // Eşit aralıklarla ilerleme

      milestones.add(
        RdMilestone(
          id: i,
          name: '$i. Kilometre Taşı',
          description:
              '${(progressRequirement * 100).toStringAsFixed(0)}% ilerleme',
          progressRequirement: progressRequirement,
          targetDate: DateTime.now().add(
            Duration(days: (duration * progressRequirement).round()),
          ),
          bonusValue: (i * 100).toDouble(), // Her taşı için bonus
        ),
      );
    }

    return milestones;
  }

  /// Gerekli kaynakları oluştur
  static List<RdResource> _generateRequiredResources(RdRequest request) {
    final resources = <RdResource>[];

    // Proje seviyesine göre gerekli kaynaklar
    int equipmentCount =
        (request.level.index + 1) * (request.usePremiumResources ? 2 : 1);
    int materialCount =
        ((request.level.index + 1) *
                5 *
                (request.usePremiumResources ? 1.5 : 1.0))
            .round();
    int softwareCount =
        (request.level.index + 1) * (request.usePremiumResources ? 1 : 1);

    if (equipmentCount > 0) {
      resources.add(
        RdResource(
          type: RdResourceType.equipment,
          name: request.usePremiumResources
              ? 'Premium Araç-Gereç'
              : 'Standart Araç-Gereç',
          quantity: equipmentCount,
          unitCost: request.usePremiumResources ? 500.0 : 200.0,
        ),
      );
    }

    if (materialCount > 0) {
      resources.add(
        RdResource(
          type: RdResourceType.material,
          name: request.usePremiumResources
              ? 'Premium Malzeme'
              : 'Standart Malzeme',
          quantity: materialCount,
          unitCost: request.usePremiumResources ? 50.0 : 25.0,
        ),
      );
    }

    if (softwareCount > 0) {
      resources.add(
        RdResource(
          type: RdResourceType.software,
          name: request.usePremiumResources
              ? 'İleri Düzey Yazılım'
              : 'Standart Yazılım',
          quantity: softwareCount,
          unitCost: request.usePremiumResources ? 1000.0 : 500.0,
        ),
      );
    }

    return resources;
  }

  /// Günlük Ar-Ge ilerleme güncellemesi
  static RdProject updateProjectDaily({required RdProject project}) {
    if (project.status != RdProjectStatus.inProgress) {
      return project;
    }

    // Günlük ilerleme (proje süresine göre)
    double dailyProgress = 1.0 / project.durationInDays;

    // Mevcut ilerlemeye günlük payı ekle
    double newProgress = (project.progress + dailyProgress).clamp(0.0, 1.0);

    // Kilometre taşları kontrol et
    List<RdMilestone> updatedMilestones = _updateMilestones(
      milestones: project.milestones,
      newProgress: newProgress,
    );

    // Gerekli kaynaklar kontrol et
    List<RdResource> updatedResources = _updateResources(
      resources: project.requiredResources,
      progress: newProgress,
    );

    // Proje tamamlandı mı kontrolü
    RdProjectStatus newStatus = project.status;
    DateTime? endDate = project.endDate;

    if (newProgress >= 1.0) {
      // Başarı kontrolü
      bool projectSuccess = _checkProjectSuccess(
        successProbability: project.successProbability,
        level: project.level,
      );

      newStatus = projectSuccess
          ? RdProjectStatus.completed
          : RdProjectStatus.failed;
      endDate = DateTime.now();
    }

    return project.copyWith(
      progress: newProgress,
      status: newStatus,
      endDate: endDate,
      milestones: updatedMilestones,
      requiredResources: updatedResources,
    );
  }

  /// Kilometre taşlarını güncelle
  static List<RdMilestone> _updateMilestones({
    required List<RdMilestone> milestones,
    required double newProgress,
  }) {
    return milestones.map((milestone) {
      if (!milestone.completed &&
          newProgress >= milestone.progressRequirement) {
        return milestone.copyWith(
          completed: true,
          completionDate: DateTime.now(),
        );
      }
      return milestone;
    }).toList();
  }

  /// Kaynakları güncelle
  static List<RdResource> _updateResources({
    required List<RdResource> resources,
    required double progress,
  }) {
    return resources.map((resource) {
      // İlerleme yüzdesine göre kaynak kullanımı
      bool acquired =
          resource.acquired ||
          (progress >= 0.2); // %20'de kaynak kullanılmaya başlanır
      return resource.copyWith(acquired: acquired);
    }).toList();
  }

  /// Proje başarısı kontrolü
  static bool _checkProjectSuccess({
    required double successProbability,
    required RdProjectLevel level,
  }) {
    // Rastgele sayı üret (0-1 arası)
    double randomValue =
        DateTime.now().millisecond / 1000; // Basit rastgelelik için

    // Başarı olasılığına göre kontrol et
    return randomValue <= successProbability;
  }

  /// Ar-Ge laboratuvarı oluştur
  static RdLab createLab({required String playerId}) {
    return RdLab(
      id: 'lab_${playerId}_${DateTime.now().millisecondsSinceEpoch}',
      playerId: playerId,
      totalInvestment: 0.0,
      currentBudget: 0.0,
      efficiencyBonus: 0.0,
      safetyFactor: 0.5, // Başlangıçta ortalama güvenlik
      innovationRate: 0.1, // Başlangıçta düşük inovasyon oranı
      maxProjects: 1, // Başlangıçta sadece 1 proje
    );
  }

  /// Ar-Ge laboratuvarı yükselt
  static RdLab upgradeLab({
    required RdLab lab,
    required double upgradeCost,
    required Player player,
  }) {
    if (player.cash < upgradeCost) {
      throw Exception('Yetersiz bakiye!');
    }

    // Laboratuvar özelliklerini geliştir
    return lab.copyWith(
      totalInvestment: lab.totalInvestment + upgradeCost,
      currentBudget:
          lab.currentBudget +
          (upgradeCost * 0.2), // Yatırımla birlikte bütçe artar
      efficiencyBonus: (lab.efficiencyBonus + 0.05).clamp(
        0.0,
        0.5,
      ), // Maksimum %50 verimlilik artışı
      safetyFactor: (lab.safetyFactor + 0.05).clamp(0.0, 1.0), // Güvenlik artar
      innovationRate: (lab.innovationRate + 0.02).clamp(
        0.0,
        0.3,
      ), // İnovasyon oranı artar
      maxProjects: lab.maxProjects + 1, // Daha fazla proje yapılabilir
    );
  }

  /// Ar-Ge itibarı puanı hesaplama
  static int calculateResearchReputation({
    required List<RdProject> completedProjects,
    required List<RdProject> failedProjects,
  }) {
    int reputation = 0;

    // Tamamlanan projeler
    for (var project in completedProjects) {
      if (project.level == RdProjectLevel.revolutionary) {
        reputation += 50;
      } else if (project.level == RdProjectLevel.innovative) {
        reputation += 30;
      } else if (project.level == RdProjectLevel.expert) {
        reputation += 20;
      } else if (project.level == RdProjectLevel.advanced) {
        reputation += 10;
      } else {
        reputation += 5;
      }
    }

    // Başarısız projeler
    for (var project in failedProjects) {
      if (project.level == RdProjectLevel.revolutionary) {
        reputation -= 20;
      } else if (project.level == RdProjectLevel.innovative) {
        reputation -= 15;
      } else if (project.level == RdProjectLevel.expert) {
        reputation -= 10;
      } else if (project.level == RdProjectLevel.advanced) {
        reputation -= 5;
      } else {
        reputation -= 2;
      }
    }

    return reputation.clamp(0, 500); // 0-500 arası
  }

  /// Ar-Ge performans indeksi
  static double calculatePerformanceIndex({required List<RdProject> projects}) {
    if (projects.isEmpty) return 0.0;

    double totalSuccessRatio = 0;
    int validProjects = 0;

    for (var project in projects) {
      if (project.status == RdProjectStatus.completed) {
        totalSuccessRatio += 1.0;
        validProjects++;
      } else if (project.status == RdProjectStatus.failed) {
        totalSuccessRatio += 0.0;
        validProjects++;
      }
    }

    if (validProjects == 0) return 0.0;

    double successRatio = totalSuccessRatio / validProjects;
    double avgEfficiency =
        projects
            .where((p) => p.status == RdProjectStatus.completed)
            .map((p) => p.efficiencyIncrease)
            .fold(0.0, (a, b) => a + b) /
        (projects.where((p) => p.status == RdProjectStatus.completed).length +
            1);

    return (successRatio * 0.7 + (avgEfficiency * 10) * 0.3).clamp(0.0, 10.0);
  }
}
