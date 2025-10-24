// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockImpl _$$StockImplFromJson(Map<String, dynamic> json) => _$StockImpl(
  id: json['id'] as String,
  symbol: json['symbol'] as String,
  companyName: json['companyName'] as String,
  currentPrice: (json['currentPrice'] as num).toDouble(),
  priceHistory: (json['priceHistory'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$$StockImplToJson(_$StockImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'currentPrice': instance.currentPrice,
      'priceHistory': instance.priceHistory,
    };
