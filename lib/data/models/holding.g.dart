// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HoldingImpl _$$HoldingImplFromJson(Map<String, dynamic> json) =>
    _$HoldingImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      memberIds: (json['memberIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      treasury: (json['treasury'] as num).toDouble(),
      level: (json['level'] as num).toInt(),
    );

Map<String, dynamic> _$$HoldingImplToJson(_$HoldingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'memberIds': instance.memberIds,
      'treasury': instance.treasury,
      'level': instance.level,
    };
