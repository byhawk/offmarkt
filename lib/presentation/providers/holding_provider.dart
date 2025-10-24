import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/holding.dart';

part 'holding_provider.g.dart';

@riverpod
class HoldingNotifier extends _$HoldingNotifier {
  @override
  Holding? build() {
    // Gelecekte oyuncunun holding bilgisi burada yüklenecek
    return null;
  }

  // TODO: Holding oluşturma, katılma, yönetme fonksiyonları eklenecek
}