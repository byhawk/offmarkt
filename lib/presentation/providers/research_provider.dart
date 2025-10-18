import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offmarket_flutter/data/models/research_development.dart';

class ResearchNotifier extends StateNotifier<Map<String, dynamic>> {
  ResearchNotifier()
    : super({
        'lab': null,
        'projects': <RdProject>[],
        'completedProjects': <RdProject>[],
        'availableProjects': <RdProjectType>[],
        'loading': false,
        'error': null,
      });

  Future<void> loadResearchLab(String playerId) async {
    state = {...state, 'loading': true, 'error': null};

    try {
      final RdLab mockLab = RdLab(
        id: 'lab_$playerId',
        playerId: playerId,
        totalInvestment: 150000.0,
        currentBudget: 50000.0,
        efficiencyBonus: 15.0,
        safetyFactor: 85.0,
        innovationRate: 20.0,
        maxProjects: 3,
        currentProjects: 0,
        activeProjects: [],
        staff: [],
      );

      state = {...state, 'lab': mockLab, 'loading': false};
    } catch (error) {
      state = {...state, 'error': error.toString(), 'loading': false};
    }
  }

  Future<void> loadActiveProjects(String playerId) async {
    state = {...state, 'loading': true, 'error': null};

    try {
      final List<RdProject> mockProjects = [
        RdProject(
          id: 'project_1',
          playerId: playerId,
          type: RdProjectType.productDevelopment,
          level: RdProjectLevel.advanced,
          status: RdProjectStatus.inProgress,
          name: 'Yeni Ürün Geliştirme',
          description: 'Pazar talebine uygun yeni ürün geliştirmesi',
          startDate: DateTime.now().subtract(const Duration(days: 15)),
          durationInDays: 45,
          budget: 25000.0,
          costIncurred: 12500.0,
          progress: 0.55,
          successProbability: 75.0,
          potentialValue: 150000.0,
          efficiencyIncrease: 20.0,
          qualityImprovement: 15.0,
          marketAdvantage: 25.0,
          milestones: [],
          requiredResources: [],
          teamMembers: [],
          achievements: ['Hızlı Prototyping'],
        ),
      ];

      state = {...state, 'projects': mockProjects, 'loading': false};
    } catch (error) {
      state = {...state, 'error': error.toString(), 'loading': false};
    }
  }

  Future<void> startNewProject(RdRequest request) async {
    state = {...state, 'loading': true, 'error': null};

    try {
      final newProject = RdProject(
        id: 'project_${DateTime.now().millisecondsSinceEpoch}',
        playerId: request.playerId,
        type: request.type,
        level: request.level,
        status: RdProjectStatus.inProgress,
        name: '${request.level.displayName} ${request.type.displayName}',
        description: request.projectDescription,
        startDate: DateTime.now(),
        durationInDays: _calculateDuration(request.level),
        budget: _calculateBudget(request),
        progress: 0.0,
        successProbability: 70.0,
        potentialValue: _calculatePotentialValue(request),
      );

      final currentProjects = List<RdProject>.from(state['projects'] ?? []);
      currentProjects.add(newProject);

      state = {...state, 'projects': currentProjects, 'loading': false};
    } catch (error) {
      state = {...state, 'error': error.toString(), 'loading': false};
    }
  }

  RdLab? get currentLab => state['lab'] as RdLab?;
  List<RdProject> get activeProjects =>
      List<RdProject>.from(state['projects'] ?? []);
  bool get isLoading => state['loading'] == true;
  String? get error => state['error'] as String?;

  void updateProjectProgress(String projectId, double newProgress) {
    final currentProjects = List<RdProject>.from(state['projects'] ?? []);
    final updatedProjects = currentProjects.map((project) {
      if (project.id == projectId) {
        return project.copyWith(progress: newProgress);
      }
      return project;
    }).toList();

    state = {...state, 'projects': updatedProjects};
  }

  void toggleProjectStatus(String projectId) {
    final currentProjects = List<RdProject>.from(state['projects'] ?? []);
    final updatedProjects = currentProjects.map((project) {
      if (project.id == projectId) {
        final newStatus = project.status == RdProjectStatus.paused
            ? RdProjectStatus.inProgress
            : RdProjectStatus.paused;
        return project.copyWith(status: newStatus);
      }
      return project;
    }).toList();

    state = {...state, 'projects': updatedProjects};
  }

  int _calculateDuration(RdProjectLevel level) {
    switch (level) {
      case RdProjectLevel.basic:
        return 20;
      case RdProjectLevel.advanced:
        return 35;
      case RdProjectLevel.expert:
        return 50;
      case RdProjectLevel.innovative:
        return 65;
      case RdProjectLevel.revolutionary:
        return 80;
    }
  }

  double _calculateBudget(RdRequest request) {
    double baseBudget = 0;
    switch (request.level) {
      case RdProjectLevel.basic:
        baseBudget = 10000;
        break;
      case RdProjectLevel.advanced:
        baseBudget = 25000;
        break;
      case RdProjectLevel.expert:
        baseBudget = 50000;
        break;
      case RdProjectLevel.innovative:
        baseBudget = 100000;
        break;
      case RdProjectLevel.revolutionary:
        baseBudget = 200000;
        break;
    }

    if (request.usePremiumResources) baseBudget *= 1.5;
    if (request.hireExternalExperts) baseBudget *= 1.3;
    return baseBudget;
  }

  double _calculatePotentialValue(RdRequest request) {
    switch (request.level) {
      case RdProjectLevel.basic:
        return 50000;
      case RdProjectLevel.advanced:
        return 150000;
      case RdProjectLevel.expert:
        return 300000;
      case RdProjectLevel.innovative:
        return 600000;
      case RdProjectLevel.revolutionary:
        return 1500000;
    }
  }
}

final researchNotifierProvider =
    StateNotifierProvider<ResearchNotifier, Map<String, dynamic>>(
      (ref) => ResearchNotifier(),
    );
