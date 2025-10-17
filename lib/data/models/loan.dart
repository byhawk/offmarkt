import 'package:freezed_annotation/freezed_annotation.dart';

part 'loan.freezed.dart';
part 'loan.g.dart';

/// Kredi türleri
enum LoanType {
  personal('Bireysel Kredi'),
  business('İşletme Kredisi'),
  mortgage('Konut Kredisi'),
  investment('Yatırım Kredisi'),
  emergency('Acil Durum Kredisi');

  const LoanType(this.displayName);
  final String displayName;
}

/// Kredi durumları
enum LoanStatus {
  pending('Beklemede'),
  approved('Onaylandı'),
  active('Aktif'),
  overdue('Gecikmiş'),
  paid('Tamamlandı'),
  rejected('Reddedildi'),
  defaulted('İflas');

  const LoanStatus(this.displayName);
  final String displayName;
}

@freezed
class Loan with _$Loan {
  const Loan._();

  const factory Loan({
    required String id,
    required String playerId,
    required LoanType type,
    required LoanStatus status,
    required double principal, // Ana para
    required double interestRate, // Faiz oranı
    required double totalAmount, // Toplam ödeme (ana para + faiz)
    required int termInDays, // Vade (gün cinsinden)
    required DateTime startDate,
    required DateTime dueDate,
    @Default(0.0) double amountPaid, // Ödenen miktar
    @Default(0.0) double collateralValue, // Teminat değeri
    @Default('') String collateralDescription, // Teminat açıklaması
    @Default(0.0) double penaltyRate, // Cezai faiz oranı
    @Default(false) bool isSecured, // Güvenli kredi mi?
    @Default('') String purpose, // Kredi amacı
    @Default(0) int riskScore, // Risk puanı (0-100)
    @Default([]) List<PaymentSchedule> paymentSchedules, // Ödeme planı
  }) = _Loan;

  factory Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);

  /// Kalan ödeme miktarını hesapla
  double get remainingAmount => totalAmount - amountPaid;

  /// Gecikmiş mi kontrolü
  bool get isOverdue => status == LoanStatus.overdue || (status == LoanStatus.active && DateTime.now().isAfter(dueDate));

  /// Ödeme yüzdesini hesapla
  double get paymentPercentage => totalAmount > 0 ? (amountPaid / totalAmount) * 100 : 0;

  /// Vade tamamlandı mı
  bool get isTermComplete => DateTime.now().isAfter(dueDate) && status != LoanStatus.paid;
}

@freezed
class PaymentSchedule with _$PaymentSchedule {
  const factory PaymentSchedule({
    required int installmentNumber,
    required DateTime dueDate,
    required double amount,
    @Default(false) bool isPaid,
    @Default(null) DateTime? paidDate,
  }) = _PaymentSchedule;

  factory PaymentSchedule.fromJson(Map<String, dynamic> json) => _$PaymentScheduleFromJson(json);
}

@freezed
class LoanApplication with _$LoanApplication {
  const factory LoanApplication({
    required String playerId,
    required LoanType type,
    required double requestedAmount,
    required int termInDays,
    @Default('') String purpose,
    @Default(0.0) double collateralValue,
    @Default('') String collateralDescription,
  }) = _LoanApplication;

  factory LoanApplication.fromJson(Map<String, dynamic> json) => _$LoanApplicationFromJson(json);
}

@freezed
class CreditScore with _$CreditScore {
  const CreditScore._();

  const factory CreditScore({
    required String playerId,
    @Default(0) int score, // 0-1000 arası kredi notu
    @Default(0) int legalReputationImpact, // Yasal itibar etkisi
    @Default(0) int streetReputationImpact, // Sokak itibarı etkisi
    @Default(0.0) double riskMultiplier, // Risk çarpanı
    @Default(0) int totalLoans, // Toplam kredi sayısı
    @Default(0) int paidLoans, // Ödenmiş kredi sayısı
    @Default(0) int defaultedLoans, // İflas edilmiş kredi sayısı
    @Default(0.0) double currentDebtRatio, // Mevcut borç oranı
    @Default([]) List<CreditHistory> creditHistory, // Kredi geçmişi
  }) = _CreditScore;

  factory CreditScore.fromJson(Map<String, dynamic> json) => _$CreditScoreFromJson(json);

  /// Kredi notu seviyesi
  String get scoreLevel {
    if (score >= 750) return 'Mükemmel';
    if (score >= 650) return 'İyi';
    if (score >= 550) return 'Orta';
    if (score >= 450) return 'Zayıf';
    return 'Kötü';
  }

  /// Faiz oranına etki
  double get interestRateModifier {
    if (score >= 750) return 0.8; // %20 indirim
    if (score >= 650) return 0.9; // %10 indirim
    if (score >= 550) return 1.0; // Normal oran
    if (score >= 450) return 1.2; // %20 artış
    return 1.5; // %50 artış
  }
}

@freezed
class CreditHistory with _$CreditHistory {
  const factory CreditHistory({
    required String loanId,
    required DateTime date,
    required String action, // 'application', 'approval', 'payment', 'default', 'closure'
    required String description,
    required int scoreChange, // Kredi notundaki değişim
  }) = _CreditHistory;

  factory CreditHistory.fromJson(Map<String, dynamic> json) => _$CreditHistoryFromJson(json);
}