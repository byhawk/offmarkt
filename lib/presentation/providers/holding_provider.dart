import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/holding.dart';
import 'package:deal_baron/core/utils/formatters.dart';
import 'player_provider.dart';

part 'holding_provider.g.dart';

@Riverpod(keepAlive: true)
class HoldingNotifier extends _$HoldingNotifier {
  @override
  Holding? build() {
    // Oyuncunun bir holdingi olup olmadığını kontrol et
    final player = ref.watch(playerNotifierProvider);
    if (player.holdingId == null) {
      return null;
    }
    // Başlangıç için sahte (mock) veri
    return Holding(
      id: 'deal-barons-tr',
      name: 'Deal Barons TR',
      tag: 'DBTR',
      treasury: 1250000,
      level: 5,
      members: [
        HoldingMember(playerId: 'player1', playerName: 'Ahmet CEO', rank: HoldingRank.ceo, totalContribution: 800000),
        HoldingMember(playerId: 'player2', playerName: 'Ayşe Yönetici', rank: HoldingRank.executive, totalContribution: 450000),
        HoldingMember(playerId: 'player3', playerName: 'Mehmet Üye', rank: HoldingRank.member, totalContribution: 120000),
      ],
    );
  }

  /// Holding hazinesine para yatırır
  (bool, String?) depositToTreasury(double amount) {
    final playerNotifier = ref.read(playerNotifierProvider.notifier);
    final currentPlayer = ref.read(playerNotifierProvider);

    if (currentPlayer.cash < amount) {
      return (false, 'Yetersiz nakit!');
    }

    playerNotifier.removeCash(amount);

    if (state != null) {
      state = state!.copyWith(treasury: state!.treasury + amount);
    }

    return (true, '${Formatters.formatCurrency(amount)} hazineye eklendi.');
  }

  /// Yeni bir holding kurar
  (bool, String?) createHolding(String name, String tag) {
    final playerNotifier = ref.read(playerNotifierProvider.notifier);
    final currentPlayer = ref.read(playerNotifierProvider);
    const creationCost = 100000; // Örnek kurma maliyeti

    if (currentPlayer.cash < creationCost) {
      return (false, 'Holding kurmak için yetersiz bakiye!');
    }

    playerNotifier.removeCash(creationCost);

    final newHolding = Holding(
      id: tag.toLowerCase(),
      name: name,
      tag: tag,
      treasury: 0,
      level: 1,
      members: [
        HoldingMember(playerId: 'player1', playerName: currentPlayer.name, rank: HoldingRank.ceo, totalContribution: 0),
      ],
    );

    state = newHolding;
    playerNotifier.setHoldingId(newHolding.id);

    return (true, 'Holding başarıyla kuruldu!');
  }
}