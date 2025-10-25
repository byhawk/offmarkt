import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/player.dart';
import '../../data/models/research_development.dart';
import 'player_provider.dart';

part 'research_provider.freezed.dart';
part 'research_provider.g.dart';

// Statik teknoloji ağacı verisi
final List<ResearchNode> _staticResearchTree = [
  ResearchNode(
    id: 'basic_logistics',
    name: 'Temel Lojistik',
    description: 'Ticaret rotalarınızı daha verimli hale getirir.',
    researchPointsCost: 5,
    durationSeconds: 60,
    dependencies: [],
    bonusType: ResearchBonusType.costReduction,
    bonusValue: 2.0,
  ),
  ResearchNode(
    id: 'advanced_logistics',
    name: 'Gelişmiş Lojistik',
    description: 'Tedarik zinciri maliyetlerini önemli ölçüde düşürür.',
    researchPointsCost: 15,
    durationSeconds: 300,
    dependencies: ['basic_logistics'],
    bonusType: ResearchBonusType.costReduction,
    bonusValue: 5.0,
  ),
  ResearchNode(
    id: 'basic_marketing',
    name: 'Temel Pazarlama',
    description: 'Ürünlerinize olan talebi artırır.',
    researchPointsCost: 5,
    durationSeconds: 60,
    dependencies: [],
    bonusType: ResearchBonusType.marketDemand,
    bonusValue: 3.0,
  ),
];

@freezed
class ResearchState with _$ResearchState {
  const factory ResearchState({
    required List<ResearchNode> researchTree,
    required Player player,
  }) = _ResearchState;

  const ResearchState._();

  ResearchStatus getNodeStatus(String nodeId) {
    if (player.completedResearchIds.contains(nodeId)) {
      return ResearchStatus.completed;
    }
    if (player.activeResearch?.nodeId == nodeId) {
      return ResearchStatus.inProgress;
    }

    final node = researchTree.firstWhere((n) => n.id == nodeId);
    final dependenciesMet = node.dependencies.every((depId) => player.completedResearchIds.contains(depId));

    if (dependenciesMet) {
      return ResearchStatus.available;
    }

    return ResearchStatus.locked;
  }
}

@riverpod
class ResearchNotifier extends _$ResearchNotifier {
  @override
  ResearchState build() {
    final player = ref.watch(playerNotifierProvider);
    return ResearchState(
      researchTree: _staticResearchTree,
      player: player,
    );
  }

  (bool, String?) startResearch(String nodeId) {
    final player = ref.read(playerNotifierProvider);
    final playerNotifier = ref.read(playerNotifierProvider.notifier);
    final node = state.researchTree.firstWhere((n) => n.id == nodeId);

    if (player.activeResearch != null) {
      return (false, 'Zaten bir araştırma devam ediyor.');
    }

    if (player.researchPoints < node.researchPointsCost) {
      return (false, 'Yetersiz araştırma puanı.');
    }

    final status = state.getNodeStatus(nodeId);
    if (status != ResearchStatus.available) {
      return (false, 'Bu araştırma henüz yapılamaz.');
    }

    playerNotifier.updateResearchPoints(-node.researchPointsCost);

    final now = DateTime.now();
    final endTime = now.add(Duration(seconds: node.durationSeconds));
    final activeResearch = ActiveResearch(nodeId: nodeId, startTime: now, endTime: endTime);

    playerNotifier.setActiveResearch(activeResearch);

    return (true, '${node.name} araştırması başlatıldı.');
  }

  // TODO: Araştırma tamamlama mantığı için bir zamanlayıcı veya periyodik kontrol eklenecek.
}