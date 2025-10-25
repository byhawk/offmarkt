import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/auction.dart';
import '../../data/models/player.dart';
import 'player_provider.dart';

part 'auction_provider.g.dart';

@riverpod
class AuctionNotifier extends _$AuctionNotifier {
  Timer? _timer;

  @override
  List<Auction> build() {
    // Zamanlayıcıyı başlat
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkAuctions();
    });

    // Ref'in dispose olmasını dinle ve zamanlayıcıyı iptal et
    ref.onDispose(() {
      _timer?.cancel();
    });

    // Başlangıç için sahte (mock) veri
    return [
      Auction(
        id: 'rare-land-deed',
        itemName: 'Nadir Arsa Tapusu',
        itemDescription: 'Şehir merkezinde stratejik bir konumda bulunan değerli bir arsa.',
        startingPrice: 100000,
        currentPrice: 150000,
        highestBidderId: 'player2',
        highestBidderName: 'Ayşe',
        endTime: DateTime.now().add(const Duration(minutes: 15)),
      ),
      Auction(
        id: 'gold-watch',
        itemName: 'Altın CEO Saati',
        itemDescription: 'Sahibine prestij ve karizma katan özel bir saat.',
        startingPrice: 25000,
        currentPrice: 25000,
        highestBidderId: null,
        highestBidderName: null,
        endTime: DateTime.now().add(const Duration(hours: 2)),
      ),
    ];
  }

  void _checkAuctions() {
    // Bu metod, ihalelerin bitip bitmediğini kontrol eder
    // ve durumu günceller. Gerçek bir uygulamada bu,
    // backend tarafından yönetilmelidir.
  }

  (bool, String?) placeBid(String auctionId, double bidAmount) {
    final playerNotifier = ref.read(playerNotifierProvider.notifier);
    final player = ref.read(playerNotifierProvider);

    final auctionIndex = state.indexWhere((a) => a.id == auctionId);
    if (auctionIndex == -1) {
      return (false, 'İhale bulunamadı.');
    }

    final auction = state[auctionIndex];

    if (bidAmount <= auction.currentPrice) {
      return (false, 'Teklif, mevcut fiyattan yüksek olmalı.');
    }

    // Oyuncunun bloke edilmiş parası + yeni teklifi, toplam nakdinden fazla olamaz
    if ((player.cash - player.blockedCash) < bidAmount) {
      return (false, 'Yetersiz bakiye.');
    }

    // Yeni bir liste oluşturarak state'i güncelle
    final newState = List<Auction>.from(state);
    newState[auctionIndex] = auction.copyWith(
      currentPrice: bidAmount,
      highestBidderId: 'player1', // Mock olarak mevcut oyuncu
      highestBidderName: player.name,
    );
    state = newState;

    // Oyuncunun bloke edilmiş parasını güncelle
    // TODO: Önceki teklifi varsa iade etme mantığı eklenmeli
    playerNotifier.updateBlockedCash(bidAmount);

    return (true, 'Teklif başarıyla yapıldı!');
  }
}