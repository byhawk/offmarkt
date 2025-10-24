import 'package:freezed_annotation/freezed_annotation.dart';

part 'auction.freezed.dart';
part 'auction.g.dart';

@freezed
class Auction with _$Auction {
  const factory Auction({
    required String id,
    required String itemId,
    required String itemName,
    required double highestBid,
    required String highestBidderId,
    required DateTime endTime,
  }) = _Auction;

  factory Auction.fromJson(Map<String, dynamic> json) => _$AuctionFromJson(json);
}