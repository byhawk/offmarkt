import 'package:freezed_annotation/freezed_annotation.dart';

part 'holding.freezed.dart';
part 'holding.g.dart';

@freezed
class Holding with _$Holding {
  const factory Holding({
    required String id,
    required String name,
    required List<String> memberIds,
    required double treasury,
    required int level,
  }) = _Holding;

  factory Holding.fromJson(Map<String, dynamic> json) => _$HoldingFromJson(json);
}