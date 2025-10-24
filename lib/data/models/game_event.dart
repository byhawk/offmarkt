import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_event.freezed.dart';
part 'game_event.g.dart';

enum EventEffectType {
  demand,
  supply,
  price,
}

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent({
    required String id,
    required String name,
    required String description,
    required String sector,
    required EventEffectType effectType,
    required double effectMagnitude,
    required DateTime expiry,
  }) = _GameEvent;

  factory GameEvent.fromJson(Map<String, dynamic> json) => _$GameEventFromJson(json);
}