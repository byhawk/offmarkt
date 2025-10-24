import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/game_event.dart';

part 'game_event_provider.g.dart';

@riverpod
class GameEventNotifier extends _$GameEventNotifier {
  @override
  List<GameEvent> build() {
    // Aktif global olaylar burada yüklenecek
    return [];
  }

  // TODO: Olayları dinleme ve yönetme fonksiyonları eklenecek
}