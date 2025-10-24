// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameEventImpl _$$GameEventImplFromJson(Map<String, dynamic> json) =>
    _$GameEventImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      sector: json['sector'] as String,
      effectType: $enumDecode(_$EventEffectTypeEnumMap, json['effectType']),
      effectMagnitude: (json['effectMagnitude'] as num).toDouble(),
      expiry: DateTime.parse(json['expiry'] as String),
    );

Map<String, dynamic> _$$GameEventImplToJson(_$GameEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'sector': instance.sector,
      'effectType': _$EventEffectTypeEnumMap[instance.effectType]!,
      'effectMagnitude': instance.effectMagnitude,
      'expiry': instance.expiry.toIso8601String(),
    };

const _$EventEffectTypeEnumMap = {
  EventEffectType.demand: 'demand',
  EventEffectType.supply: 'supply',
  EventEffectType.price: 'price',
};
