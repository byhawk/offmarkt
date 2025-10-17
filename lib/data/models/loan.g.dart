// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoanImpl _$$LoanImplFromJson(Map<String, dynamic> json) => _$LoanImpl(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  type: $enumDecode(_$LoanTypeEnumMap, json['type']),
  status: $enumDecode(_$LoanStatusEnumMap, json['status']),
  principal: (json['principal'] as num).toDouble(),
  interestRate: (json['interestRate'] as num).toDouble(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  termInDays: (json['termInDays'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  dueDate: DateTime.parse(json['dueDate'] as String),
  amountPaid: (json['amountPaid'] as num?)?.toDouble() ?? 0.0,
  collateralValue: (json['collateralValue'] as num?)?.toDouble() ?? 0.0,
  collateralDescription: json['collateralDescription'] as String? ?? '',
  penaltyRate: (json['penaltyRate'] as num?)?.toDouble() ?? 0.0,
  isSecured: json['isSecured'] as bool? ?? false,
  purpose: json['purpose'] as String? ?? '',
  riskScore: (json['riskScore'] as num?)?.toInt() ?? 0,
  paymentSchedules:
      (json['paymentSchedules'] as List<dynamic>?)
          ?.map((e) => PaymentSchedule.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$LoanImplToJson(_$LoanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'type': _$LoanTypeEnumMap[instance.type]!,
      'status': _$LoanStatusEnumMap[instance.status]!,
      'principal': instance.principal,
      'interestRate': instance.interestRate,
      'totalAmount': instance.totalAmount,
      'termInDays': instance.termInDays,
      'startDate': instance.startDate.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
      'amountPaid': instance.amountPaid,
      'collateralValue': instance.collateralValue,
      'collateralDescription': instance.collateralDescription,
      'penaltyRate': instance.penaltyRate,
      'isSecured': instance.isSecured,
      'purpose': instance.purpose,
      'riskScore': instance.riskScore,
      'paymentSchedules': instance.paymentSchedules,
    };

const _$LoanTypeEnumMap = {
  LoanType.personal: 'personal',
  LoanType.business: 'business',
  LoanType.mortgage: 'mortgage',
  LoanType.investment: 'investment',
  LoanType.emergency: 'emergency',
};

const _$LoanStatusEnumMap = {
  LoanStatus.pending: 'pending',
  LoanStatus.approved: 'approved',
  LoanStatus.active: 'active',
  LoanStatus.overdue: 'overdue',
  LoanStatus.paid: 'paid',
  LoanStatus.rejected: 'rejected',
  LoanStatus.defaulted: 'defaulted',
};

_$PaymentScheduleImpl _$$PaymentScheduleImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentScheduleImpl(
  installmentNumber: (json['installmentNumber'] as num).toInt(),
  dueDate: DateTime.parse(json['dueDate'] as String),
  amount: (json['amount'] as num).toDouble(),
  isPaid: json['isPaid'] as bool? ?? false,
  paidDate: json['paidDate'] == null
      ? null
      : DateTime.parse(json['paidDate'] as String),
);

Map<String, dynamic> _$$PaymentScheduleImplToJson(
  _$PaymentScheduleImpl instance,
) => <String, dynamic>{
  'installmentNumber': instance.installmentNumber,
  'dueDate': instance.dueDate.toIso8601String(),
  'amount': instance.amount,
  'isPaid': instance.isPaid,
  'paidDate': instance.paidDate?.toIso8601String(),
};

_$LoanApplicationImpl _$$LoanApplicationImplFromJson(
  Map<String, dynamic> json,
) => _$LoanApplicationImpl(
  playerId: json['playerId'] as String,
  type: $enumDecode(_$LoanTypeEnumMap, json['type']),
  requestedAmount: (json['requestedAmount'] as num).toDouble(),
  termInDays: (json['termInDays'] as num).toInt(),
  purpose: json['purpose'] as String? ?? '',
  collateralValue: (json['collateralValue'] as num?)?.toDouble() ?? 0.0,
  collateralDescription: json['collateralDescription'] as String? ?? '',
);

Map<String, dynamic> _$$LoanApplicationImplToJson(
  _$LoanApplicationImpl instance,
) => <String, dynamic>{
  'playerId': instance.playerId,
  'type': _$LoanTypeEnumMap[instance.type]!,
  'requestedAmount': instance.requestedAmount,
  'termInDays': instance.termInDays,
  'purpose': instance.purpose,
  'collateralValue': instance.collateralValue,
  'collateralDescription': instance.collateralDescription,
};

_$CreditScoreImpl _$$CreditScoreImplFromJson(Map<String, dynamic> json) =>
    _$CreditScoreImpl(
      playerId: json['playerId'] as String,
      score: (json['score'] as num?)?.toInt() ?? 0,
      legalReputationImpact:
          (json['legalReputationImpact'] as num?)?.toInt() ?? 0,
      streetReputationImpact:
          (json['streetReputationImpact'] as num?)?.toInt() ?? 0,
      riskMultiplier: (json['riskMultiplier'] as num?)?.toDouble() ?? 0.0,
      totalLoans: (json['totalLoans'] as num?)?.toInt() ?? 0,
      paidLoans: (json['paidLoans'] as num?)?.toInt() ?? 0,
      defaultedLoans: (json['defaultedLoans'] as num?)?.toInt() ?? 0,
      currentDebtRatio: (json['currentDebtRatio'] as num?)?.toDouble() ?? 0.0,
      creditHistory:
          (json['creditHistory'] as List<dynamic>?)
              ?.map((e) => CreditHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CreditScoreImplToJson(_$CreditScoreImpl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'score': instance.score,
      'legalReputationImpact': instance.legalReputationImpact,
      'streetReputationImpact': instance.streetReputationImpact,
      'riskMultiplier': instance.riskMultiplier,
      'totalLoans': instance.totalLoans,
      'paidLoans': instance.paidLoans,
      'defaultedLoans': instance.defaultedLoans,
      'currentDebtRatio': instance.currentDebtRatio,
      'creditHistory': instance.creditHistory,
    };

_$CreditHistoryImpl _$$CreditHistoryImplFromJson(Map<String, dynamic> json) =>
    _$CreditHistoryImpl(
      loanId: json['loanId'] as String,
      date: DateTime.parse(json['date'] as String),
      action: json['action'] as String,
      description: json['description'] as String,
      scoreChange: (json['scoreChange'] as num).toInt(),
    );

Map<String, dynamic> _$$CreditHistoryImplToJson(_$CreditHistoryImpl instance) =>
    <String, dynamic>{
      'loanId': instance.loanId,
      'date': instance.date.toIso8601String(),
      'action': instance.action,
      'description': instance.description,
      'scoreChange': instance.scoreChange,
    };
