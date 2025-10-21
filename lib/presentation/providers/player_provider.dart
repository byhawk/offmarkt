import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/player.dart';
import '../../game/systems/level_system.dart';
import '../../game/systems/reputation_system.dart';
import '../../game/systems/event_system.dart';
import '../../services/api_service.dart';

part 'player_provider.g.dart';

@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  @override
  Player build() {
    // Başlangıç player state'i
    return const Player(
      name: 'Oyuncu',
      level: 1,
      experience: 0,
      cash: 5000.0,
      bankAccount: 0.0,
      debt: 0.0,
      legalReputation: 50,
      streetReputation: 50,
      riskLevel: 0,
      suspicionLevel: 0,
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
        legalReputation: playerData['legalReputation'] ?? 50,
        streetReputation: playerData['streetReputation'] ?? 50,
        riskLevel: playerData['riskLevel'] ?? 0,
        suspicionLevel: playerData['suspicionLevel'] ?? 0,
        currentDay: playerData['currentDay'] ?? 1,
        totalTransactions: playerData['totalTransactions'] ?? 0,
        totalProfit: (playerData['totalProfit'] ?? 0.0).toDouble(),
        portfolioValue: (playerData['portfolioValue'] ?? 0.0).toDouble(),
      );
    } catch (e) {
      print('Error loading player data: $e');
    }
  }

  /// Backend'den güncel player verisini fetch et
  Future<void> refreshPlayerData() async {
    try {
      final apiService = ApiService();
      final response = await apiService.get('/auth/me');

      if (response.data['success'] == true) {
        final playerData = response.data['data']['player'];
        print('🔄 Refreshing player data: cash=${playerData['cash']}');
        await loadPlayerFromBackend(playerData);
        print('✅ Player refreshed: cash=${state.cash}');
      }
    } catch (e) {
      print('❌ Error refreshing player data: $e');
    }
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

  /// İtibar güncelle (ReputationSystem ile)
  void updateReputation({int? legal, int? street}) {
    state = state.copyWith(
      legalReputation: legal ?? state.legalReputation,
      streetReputation: street ?? state.streetReputation,
    );
  }

  /// İtibar aksiyonu uygula
  void applyReputationAction(ReputationAction action, int amount) {
    final (newLegal, newStreet) = ReputationSystem.updateReputation(
      player: state,
      action: action,
      amount: amount,
    );

    state = state.copyWith(
      legalReputation: newLegal,
      streetReputation: newStreet,
    );
  }

  /// Risk seviyesi güncelle
  void updateRisk(int risk) {
    state = state.copyWith(riskLevel: risk.clamp(0, 100));
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
        case EffectType.reputationChange:
          if (effect.target == 'legal') {
            state = state.copyWith(
              legalReputation: (state.legalReputation + effect.value.toInt())
                  .clamp(0, 100),
            );
          } else if (effect.target == 'street') {
            state = state.copyWith(
              streetReputation: (state.streetReputation + effect.value.toInt())
                  .clamp(0, 100),
            );
          } else if (effect.target == 'both') {
            state = state.copyWith(
              legalReputation: (state.legalReputation + effect.value.toInt())
                  .clamp(0, 100),
              streetReputation: (state.streetReputation + effect.value.toInt())
                  .clamp(0, 100),
            );
          }
        case EffectType.riskIncrease:
          state = state.copyWith(
            riskLevel: (state.riskLevel + effect.value.toInt()).clamp(0, 100),
          );
        case EffectType.riskDecrease:
          state = state.copyWith(
            riskLevel: (state.riskLevel - effect.value.toInt()).clamp(0, 100),
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

    // İtibar bonusu ekle
    final (newLegal, newStreet) = (
      (state.legalReputation + rewards.reputationBonus).clamp(0, 100),
      (state.streetReputation + (rewards.reputationBonus ~/ 2)).clamp(0, 100),
    );

    state = state.copyWith(
      legalReputation: newLegal,
      streetReputation: newStreet,
    );
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
}
