import 'package:freezed_annotation/freezed_annotation.dart';

part 'auction.freezed.dart';
part 'auction.g.dart';

enum AuctionStatus {
  active,
  endingSoon,
  sold,
  expired,
}

@freezed
class Auction with _$Auction {
  const factory Auction({
    required String id,
    required String itemName,
    required String itemDescription,
    required double startingPrice,
    required double currentPrice,
    String? highestBidderId,
    String? highestBidderName,
    required DateTime endTime,
  }) = _Auction;

  factory Auction.fromJson(Map<String, dynamic> json) => _$AuctionFromJson(json);
}