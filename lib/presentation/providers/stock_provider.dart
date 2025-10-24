import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/stock.dart';

part 'stock_provider.g.dart';

@riverpod
class StockNotifier extends _$StockNotifier {
  @override
  List<Stock> build() {
    // Piyasadaki hisse senetleri burada yüklenecek
    return [];
  }

  // TODO: Hisse senedi alım/satım ve takip fonksiyonları eklenecek
}