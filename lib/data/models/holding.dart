import 'package:freezed_annotation/freezed_annotation.dart';

part 'holding.freezed.dart';
part 'holding.g.dart';

enum HoldingRank {
  ceo('CEO'),
  executive('Yönetici'),
  member('Üye');

  const HoldingRank(this.displayName);
  final String displayName;
}

@freezed
class Holding with _$Holding {
  const factory Holding({
    required String id,
    required String name,
    required String tag, // Holding tag'i (örn: [DEAL])
    required double treasury,
    required int level,
    required List<HoldingMember> members,
  }) = _Holding;

  factory Holding.fromJson(Map<String, dynamic> json) => _$HoldingFromJson(json);
}

@freezed
class HoldingMember with _$HoldingMember {
  const factory HoldingMember({
    required String playerId,
    required String playerName,
    required HoldingRank rank,
    required double totalContribution,
  }) = _HoldingMember;

  factory HoldingMember.fromJson(Map<String, dynamic> json) => _$HoldingMemberFromJson(json);
}