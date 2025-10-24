import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/auction.dart';

part 'auction_provider.g.dart';

@riverpod
class AuctionNotifier extends _$AuctionNotifier {
  @override
  List<Auction> build() {
    // Gelecekte aktif ihaleler burada yüklenecek (muhtemelen bir stream ile)
    return [];
  }

  // TODO: Teklif verme ve ihale takibi fonksiyonları eklenecek
}