import 'package:freezed_annotation/freezed_annotation.dart';
import 'research_development.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
class Player with _$Player {
  const factory Player({
    @Default('Oyuncu') String name,
    @Default(1) int level,
    @Default(0) int experience,
    @Default(5000.0) double cash,
    @Default(0.0) double bankAccount,
    @Default(0.0) double debt,
    @Default(1) int currentDay,
    @Default(0) int totalTransactions,
    @Default(0.0) double totalProfit,
    @Default(0.0) double portfolioValue,
    @Default(0) int legalReputation,
    @Default(0) int streetReputation,
    ActiveResearch? activeResearch,
    @Default([]) List<String> completedResearchIds,
    @Default(10) int researchPoints,
    String? holdingId,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
