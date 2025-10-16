import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/player.dart';

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

  /// İtibar güncelle
  void updateReputation({int? legal, int? street}) {
    state = state.copyWith(
      legalReputation: legal ?? state.legalReputation,
      streetReputation: street ?? state.streetReputation,
    );
  }

  /// Risk seviyesi güncelle
  void updateRisk(int risk) {
    state = state.copyWith(riskLevel: risk.clamp(0, 100));
  }

  /// Gün ilerlet
  void advanceDay() {
    state = state.copyWith(currentDay: state.currentDay + 1);
  }

  /// İşlem ekle
  void addTransaction(double profit) {
    state = state.copyWith(
      totalTransactions: state.totalTransactions + 1,
      totalProfit: state.totalProfit + profit,
    );
  }

  /// Seviye atla
  void levelUp() {
    state = state.copyWith(
      level: state.level + 1,
      experience: 0,
    );
  }

  /// Deneyim ekle
  void addExperience(int exp) {
    final newExp = state.experience + exp;
    // Her 1000 exp'de seviye atla
    if (newExp >= 1000) {
      levelUp();
    } else {
      state = state.copyWith(experience: newExp);
    }
  }
}
