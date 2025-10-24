// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuctionImpl _$$AuctionImplFromJson(Map<String, dynamic> json) =>
    _$AuctionImpl(
      id: json['id'] as String,
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      highestBid: (json['highestBid'] as num).toDouble(),
      highestBidderId: json['highestBidderId'] as String,
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$$AuctionImplToJson(_$AuctionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'highestBid': instance.highestBid,
      'highestBidderId': instance.highestBidderId,
      'endTime': instance.endTime.toIso8601String(),
    };
