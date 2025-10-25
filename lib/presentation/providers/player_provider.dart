import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/player.dart';
import '../../data/models/research_development.dart' as rd;
import '../../game/systems/level_system.dart';
import '../../game/systems/event_system.dart';
import '../../services/api_service.dart';

part 'player_provider.g.dart';

@Riverpod(keepAlive: true)
class PlayerNotifier extends _$PlayerNotifier {
  @override
  Player build() {
    // Build sadece ilk kez çalışır (keepAlive: true sayesinde)
    return const Player(
      name: 'Yükleniyor...',
      level: 1,
      experience: 0,
      cash: 0.0,
      bankAccount: 0.0,
      debt: 0.0,
      currentDay: 1,
      totalTransactions: 0,
      totalProfit: 0.0,
    );
  }

  /// Backend'den player verisini yükle
  Future<void> loadPlayerFromBackend(Map<String, dynamic> playerData) async {
    try {
      state = Player(
        name: playerData['name'] ?? 'Oyuncu',
        level: playerData['level'] ?? 1,
        experience: playerData['experience'] ?? 0,
        cash: (playerData['cash'] ?? 5000.0).toDouble(),
        bankAccount: (playerData['bankAccount'] ?? 0.0).toDouble(),
        debt: (playerData['debt'] ?? 0.0).toDouble(),
        currentDay: playerData['currentDay'] ?? 1,
        totalTransactions: playerData['totalTransactions'] ?? 0,
        totalProfit: (playerData['totalProfit'] ?? 0.0).toDouble(),
        portfolioValue: (playerData['portfolioValue'] ?? 0.0).toDouble(),
      );
    } catch (e) {
      // Player data loading failed - maintain default state
    }
  }

  /// Backend'den güncel player verisini fetch et
  Future<void> refreshPlayerData() async {
    try {
      final apiService = ApiService();
      final response = await apiService.get('/auth/me');

      if (response.data['success'] == true) {
        final playerData = response.data['data']['player'];
        await loadPlayerFromBackend(playerData);
      }
    } catch (e) {
      // Silently fail on refresh - maintain current state if backend unavailable
    }
  }

  /// Player state'ini resetle (logout için)
  void reset() {
    state = const Player(
      name: 'Oyuncu',
      level: 1,
      experience: 0,
      cash: 0.0,
      bankAccount: 0.0,
      debt: 0.0,
      currentDay: 1,
      totalTransactions: 0,
      totalProfit: 0.0,
    );
  }

  /// Nakit güncelle
  void updateCash(double amount) {
    state = state.copyWith(cash: amount);
  }

  /// Nakit ekle
  void addCash(double amount) {
    state = state.copyWith(cash: state.cash + amount);
  }

  /// Nakit çıkar
  void removeCash(double amount) {
    state = state.copyWith(cash: state.cash - amount);
  }

  /// Banka hesabına para ekle
  void depositToBank(double amount) {
    if (state.cash >= amount) {
      state = state.copyWith(
        cash: state.cash - amount,
        bankAccount: state.bankAccount + amount,
      );
    }
  }

  /// Bankadan para çek
  void withdrawFromBank(double amount) {
    if (state.bankAccount >= amount) {
      state = state.copyWith(
        cash: state.cash + amount,
        bankAccount: state.bankAccount - amount,
      );
    }
  }

  /// Gün ilerlet (EventSystem ile rastgele olaylar)
  void advanceDay() {
    final newDay = state.currentDay + 1;
    state = state.copyWith(currentDay: newDay);

    // Günlük özel olayları kontrol et
    final specialEvent = EventSystem.getDailySpecialEvent(newDay);
    if (specialEvent != null) {
      // Özel olay varsa (7. gün, 30. gün bonusları)
      _applyEventEffects(specialEvent);
    }

    // Rastgele olay tetikleme şansı
    final randomEvent = EventSystem.triggerRandomEvent(
      player: state,
      currentDay: newDay,
    );
    if (randomEvent != null) {
      // Rastgele olay tetiklendi
      _applyEventEffects(randomEvent);
    }
  }

  /// Olay etkilerini uygula
  void _applyEventEffects(GameEvent event) {
    for (final effect in event.effects) {
      switch (effect.type) {
        case EffectType.cashGain:
          state = state.copyWith(
            cash: (state.cash + effect.value).clamp(0, double.infinity),
          );
        case EffectType.cashLoss:
          state = state.copyWith(
            cash: (state.cash - effect.value).clamp(0, double.infinity),
          );
        case EffectType.expGain:
          addExperience(effect.value.toInt());
        default:
          break;
      }
    }
  }

  /// İşlem ekle
  void addTransaction(double profit) {
    state = state.copyWith(
      totalTransactions: state.totalTransactions + 1,
      totalProfit: state.totalProfit + profit,
    );
  }

  /// Deneyim ekle (LevelSystem ile)
  void addExperience(int exp) {
    final (newLevel, newExp, leveledUp) = LevelSystem.addExperience(
      player: state,
      expGained: exp,
    );

    state = state.copyWith(level: newLevel, experience: newExp);

    // Seviye atladıysa ödüller ver
    if (leveledUp) {
      _applyLevelRewards(newLevel);
    }
  }

  /// Seviye ödülleri uygula
  void _applyLevelRewards(int level) {
    final rewards = LevelSystem.getLevelRewards(level);

    // Nakit bonusu ekle
    state = state.copyWith(cash: state.cash + rewards.cashBonus);
  }

  /// Portföy değerini güncelle
  void updatePortfolioValue(double value) {
    state = state.copyWith(portfolioValue: value);
  }

  /// Seviye atla (manuel - eski metod)
  void levelUp() {
    state = state.copyWith(level: state.level + 1, experience: 0);
    _applyLevelRewards(state.level);
  }

  // --- Araştırma (R&D) Metodları ---

  /// Araştırma puanlarını güncelle
  void updateResearchPoints(int amount) {
    state = state.copyWith(researchPoints: state.researchPoints + amount);
  }

  /// Aktif araştırmayı ayarla
  void setActiveResearch(rd.ActiveResearch? research) {
    state = state.copyWith(activeResearch: research);
  }

  /// Bir araştırmayı tamamla
  void completeResearch(String nodeId) {
    final newCompletedIds = [...state.completedResearchIds, nodeId];
    state = state.copyWith(
      completedResearchIds: newCompletedIds,
      activeResearch: null, // Aktif araştırmayı temizle
    );

    // Araştırma bonuslarını oyuncuya uygula
    _applyResearchBonus(nodeId);
  }

  /// Araştırma bonuslarını oyuncuya uygula
  void _applyResearchBonus(String nodeId) {
    // Basit bonus sistemi - her araştırma tamamlandığında
    // oyuncuya araştırma puanı ve deneyim bonusu ver
    const bonusPoints = 10;
    const bonusExp = 50;

    updateResearchPoints(bonusPoints);
    addExperience(bonusExp);
  }

  // --- Holding Metodları ---

  /// Oyuncunun holding ID'sini ayarla
  void setHoldingId(String? holdingId) {
    state = state.copyWith(holdingId: holdingId);
  }
}
