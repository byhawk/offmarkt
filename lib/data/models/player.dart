import 'package:freezed_annotation/freezed_annotation.dart';

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
    @Default(50) int legalReputation,
    @Default(50) int streetReputation,
    @Default(0) int riskLevel,
    @Default(0) int suspicionLevel,
    @Default(1) int currentDay,
    @Default(0) int totalTransactions,
    @Default(0.0) double totalProfit,
    @Default(0.0) double portfolioValue,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
