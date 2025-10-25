// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HoldingImpl _$$HoldingImplFromJson(Map<String, dynamic> json) =>
    _$HoldingImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      tag: json['tag'] as String,
      treasury: (json['treasury'] as num).toDouble(),
      level: (json['level'] as num).toInt(),
      members: (json['members'] as List<dynamic>)
          .map((e) => HoldingMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HoldingImplToJson(_$HoldingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tag': instance.tag,
      'treasury': instance.treasury,
      'level': instance.level,
      'members': instance.members,
    };

_$HoldingMemberImpl _$$HoldingMemberImplFromJson(Map<String, dynamic> json) =>
    _$HoldingMemberImpl(
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      rank: $enumDecode(_$HoldingRankEnumMap, json['rank']),
      totalContribution: (json['totalContribution'] as num).toDouble(),
    );

Map<String, dynamic> _$$HoldingMemberImplToJson(_$HoldingMemberImpl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'rank': _$HoldingRankEnumMap[instance.rank]!,
      'totalContribution': instance.totalContribution,
    };

const _$HoldingRankEnumMap = {
  HoldingRank.ceo: 'ceo',
  HoldingRank.executive: 'executive',
  HoldingRank.member: 'member',
};
