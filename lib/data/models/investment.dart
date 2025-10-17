import 'package:freezed_annotation/freezed_annotation.dart';

part 'investment.freezed.dart';
part 'investment.g.dart';

@freezed
class Investment with _$Investment {
  const factory Investment({
    required String id,
    required String companyId,
    required String companyName,
    required int shares,
    required double purchasePricePerShare,
    required double currentPricePerShare,
    required DateTime purchaseDate,
    @Default(0.0) double dividendsReceived,
  }) = _Investment;

  factory Investment.fromJson(Map<String, dynamic> json) => _$InvestmentFromJson(json);
}