// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Loan _$LoanFromJson(Map<String, dynamic> json) {
  return _Loan.fromJson(json);
}

/// @nodoc
mixin _$Loan {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  LoanType get type => throw _privateConstructorUsedError;
  LoanStatus get status => throw _privateConstructorUsedError;
  double get principal => throw _privateConstructorUsedError; // Ana para
  double get interestRate => throw _privateConstructorUsedError; // Faiz oranı
  double get totalAmount =>
      throw _privateConstructorUsedError; // Toplam ödeme (ana para + faiz)
  int get termInDays =>
      throw _privateConstructorUsedError; // Vade (gün cinsinden)
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  double get amountPaid => throw _privateConstructorUsedError; // Ödenen miktar
  double get collateralValue =>
      throw _privateConstructorUsedError; // Teminat değeri
  String get collateralDescription =>
      throw _privateConstructorUsedError; // Teminat açıklaması
  double get penaltyRate =>
      throw _privateConstructorUsedError; // Cezai faiz oranı
  bool get isSecured => throw _privateConstructorUsedError; // Güvenli kredi mi?
  String get purpose => throw _privateConstructorUsedError; // Kredi amacı
  int get riskScore => throw _privateConstructorUsedError; // Risk puanı (0-100)
  List<PaymentSchedule> get paymentSchedules =>
      throw _privateConstructorUsedError;

  /// Serializes this Loan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Loan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoanCopyWith<Loan> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoanCopyWith<$Res> {
  factory $LoanCopyWith(Loan value, $Res Function(Loan) then) =
      _$LoanCopyWithImpl<$Res, Loan>;
  @useResult
  $Res call({
    String id,
    String playerId,
    LoanType type,
    LoanStatus status,
    double principal,
    double interestRate,
    double totalAmount,
    int termInDays,
    DateTime startDate,
    DateTime dueDate,
    double amountPaid,
    double collateralValue,
    String collateralDescription,
    double penaltyRate,
    bool isSecured,
    String purpose,
    int riskScore,
    List<PaymentSchedule> paymentSchedules,
  });
}

/// @nodoc
class _$LoanCopyWithImpl<$Res, $Val extends Loan>
    implements $LoanCopyWith<$Res> {
  _$LoanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Loan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? type = null,
    Object? status = null,
    Object? principal = null,
    Object? interestRate = null,
    Object? totalAmount = null,
    Object? termInDays = null,
    Object? startDate = null,
    Object? dueDate = null,
    Object? amountPaid = null,
    Object? collateralValue = null,
    Object? collateralDescription = null,
    Object? penaltyRate = null,
    Object? isSecured = null,
    Object? purpose = null,
    Object? riskScore = null,
    Object? paymentSchedules = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as LoanType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as LoanStatus,
            principal: null == principal
                ? _value.principal
                : principal // ignore: cast_nullable_to_non_nullable
                      as double,
            interestRate: null == interestRate
                ? _value.interestRate
                : interestRate // ignore: cast_nullable_to_non_nullable
                      as double,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            termInDays: null == termInDays
                ? _value.termInDays
                : termInDays // ignore: cast_nullable_to_non_nullable
                      as int,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dueDate: null == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            amountPaid: null == amountPaid
                ? _value.amountPaid
                : amountPaid // ignore: cast_nullable_to_non_nullable
                      as double,
            collateralValue: null == collateralValue
                ? _value.collateralValue
                : collateralValue // ignore: cast_nullable_to_non_nullable
                      as double,
            collateralDescription: null == collateralDescription
                ? _value.collateralDescription
                : collateralDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            penaltyRate: null == penaltyRate
                ? _value.penaltyRate
                : penaltyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            isSecured: null == isSecured
                ? _value.isSecured
                : isSecured // ignore: cast_nullable_to_non_nullable
                      as bool,
            purpose: null == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                      as String,
            riskScore: null == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as int,
            paymentSchedules: null == paymentSchedules
                ? _value.paymentSchedules
                : paymentSchedules // ignore: cast_nullable_to_non_nullable
                      as List<PaymentSchedule>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoanImplCopyWith<$Res> implements $LoanCopyWith<$Res> {
  factory _$$LoanImplCopyWith(
    _$LoanImpl value,
    $Res Function(_$LoanImpl) then,
  ) = __$$LoanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    LoanType type,
    LoanStatus status,
    double principal,
    double interestRate,
    double totalAmount,
    int termInDays,
    DateTime startDate,
    DateTime dueDate,
    double amountPaid,
    double collateralValue,
    String collateralDescription,
    double penaltyRate,
    bool isSecured,
    String purpose,
    int riskScore,
    List<PaymentSchedule> paymentSchedules,
  });
}

/// @nodoc
class __$$LoanImplCopyWithImpl<$Res>
    extends _$LoanCopyWithImpl<$Res, _$LoanImpl>
    implements _$$LoanImplCopyWith<$Res> {
  __$$LoanImplCopyWithImpl(_$LoanImpl _value, $Res Function(_$LoanImpl) _then)
    : super(_value, _then);

  /// Create a copy of Loan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? type = null,
    Object? status = null,
    Object? principal = null,
    Object? interestRate = null,
    Object? totalAmount = null,
    Object? termInDays = null,
    Object? startDate = null,
    Object? dueDate = null,
    Object? amountPaid = null,
    Object? collateralValue = null,
    Object? collateralDescription = null,
    Object? penaltyRate = null,
    Object? isSecured = null,
    Object? purpose = null,
    Object? riskScore = null,
    Object? paymentSchedules = null,
  }) {
    return _then(
      _$LoanImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as LoanType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as LoanStatus,
        principal: null == principal
            ? _value.principal
            : principal // ignore: cast_nullable_to_non_nullable
                  as double,
        interestRate: null == interestRate
            ? _value.interestRate
            : interestRate // ignore: cast_nullable_to_non_nullable
                  as double,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        termInDays: null == termInDays
            ? _value.termInDays
            : termInDays // ignore: cast_nullable_to_non_nullable
                  as int,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dueDate: null == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        amountPaid: null == amountPaid
            ? _value.amountPaid
            : amountPaid // ignore: cast_nullable_to_non_nullable
                  as double,
        collateralValue: null == collateralValue
            ? _value.collateralValue
            : collateralValue // ignore: cast_nullable_to_non_nullable
                  as double,
        collateralDescription: null == collateralDescription
            ? _value.collateralDescription
            : collateralDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        penaltyRate: null == penaltyRate
            ? _value.penaltyRate
            : penaltyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        isSecured: null == isSecured
            ? _value.isSecured
            : isSecured // ignore: cast_nullable_to_non_nullable
                  as bool,
        purpose: null == purpose
            ? _value.purpose
            : purpose // ignore: cast_nullable_to_non_nullable
                  as String,
        riskScore: null == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentSchedules: null == paymentSchedules
            ? _value._paymentSchedules
            : paymentSchedules // ignore: cast_nullable_to_non_nullable
                  as List<PaymentSchedule>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoanImpl extends _Loan {
  const _$LoanImpl({
    required this.id,
    required this.playerId,
    required this.type,
    required this.status,
    required this.principal,
    required this.interestRate,
    required this.totalAmount,
    required this.termInDays,
    required this.startDate,
    required this.dueDate,
    this.amountPaid = 0.0,
    this.collateralValue = 0.0,
    this.collateralDescription = '',
    this.penaltyRate = 0.0,
    this.isSecured = false,
    this.purpose = '',
    this.riskScore = 0,
    final List<PaymentSchedule> paymentSchedules = const [],
  }) : _paymentSchedules = paymentSchedules,
       super._();

  factory _$LoanImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoanImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final LoanType type;
  @override
  final LoanStatus status;
  @override
  final double principal;
  // Ana para
  @override
  final double interestRate;
  // Faiz oranı
  @override
  final double totalAmount;
  // Toplam ödeme (ana para + faiz)
  @override
  final int termInDays;
  // Vade (gün cinsinden)
  @override
  final DateTime startDate;
  @override
  final DateTime dueDate;
  @override
  @JsonKey()
  final double amountPaid;
  // Ödenen miktar
  @override
  @JsonKey()
  final double collateralValue;
  // Teminat değeri
  @override
  @JsonKey()
  final String collateralDescription;
  // Teminat açıklaması
  @override
  @JsonKey()
  final double penaltyRate;
  // Cezai faiz oranı
  @override
  @JsonKey()
  final bool isSecured;
  // Güvenli kredi mi?
  @override
  @JsonKey()
  final String purpose;
  // Kredi amacı
  @override
  @JsonKey()
  final int riskScore;
  // Risk puanı (0-100)
  final List<PaymentSchedule> _paymentSchedules;
  // Risk puanı (0-100)
  @override
  @JsonKey()
  List<PaymentSchedule> get paymentSchedules {
    if (_paymentSchedules is EqualUnmodifiableListView)
      return _paymentSchedules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentSchedules);
  }

  @override
  String toString() {
    return 'Loan(id: $id, playerId: $playerId, type: $type, status: $status, principal: $principal, interestRate: $interestRate, totalAmount: $totalAmount, termInDays: $termInDays, startDate: $startDate, dueDate: $dueDate, amountPaid: $amountPaid, collateralValue: $collateralValue, collateralDescription: $collateralDescription, penaltyRate: $penaltyRate, isSecured: $isSecured, purpose: $purpose, riskScore: $riskScore, paymentSchedules: $paymentSchedules)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.principal, principal) ||
                other.principal == principal) &&
            (identical(other.interestRate, interestRate) ||
                other.interestRate == interestRate) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.termInDays, termInDays) ||
                other.termInDays == termInDays) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.amountPaid, amountPaid) ||
                other.amountPaid == amountPaid) &&
            (identical(other.collateralValue, collateralValue) ||
                other.collateralValue == collateralValue) &&
            (identical(other.collateralDescription, collateralDescription) ||
                other.collateralDescription == collateralDescription) &&
            (identical(other.penaltyRate, penaltyRate) ||
                other.penaltyRate == penaltyRate) &&
            (identical(other.isSecured, isSecured) ||
                other.isSecured == isSecured) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            const DeepCollectionEquality().equals(
              other._paymentSchedules,
              _paymentSchedules,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    playerId,
    type,
    status,
    principal,
    interestRate,
    totalAmount,
    termInDays,
    startDate,
    dueDate,
    amountPaid,
    collateralValue,
    collateralDescription,
    penaltyRate,
    isSecured,
    purpose,
    riskScore,
    const DeepCollectionEquality().hash(_paymentSchedules),
  );

  /// Create a copy of Loan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoanImplCopyWith<_$LoanImpl> get copyWith =>
      __$$LoanImplCopyWithImpl<_$LoanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoanImplToJson(this);
  }
}

abstract class _Loan extends Loan {
  const factory _Loan({
    required final String id,
    required final String playerId,
    required final LoanType type,
    required final LoanStatus status,
    required final double principal,
    required final double interestRate,
    required final double totalAmount,
    required final int termInDays,
    required final DateTime startDate,
    required final DateTime dueDate,
    final double amountPaid,
    final double collateralValue,
    final String collateralDescription,
    final double penaltyRate,
    final bool isSecured,
    final String purpose,
    final int riskScore,
    final List<PaymentSchedule> paymentSchedules,
  }) = _$LoanImpl;
  const _Loan._() : super._();

  factory _Loan.fromJson(Map<String, dynamic> json) = _$LoanImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  LoanType get type;
  @override
  LoanStatus get status;
  @override
  double get principal; // Ana para
  @override
  double get interestRate; // Faiz oranı
  @override
  double get totalAmount; // Toplam ödeme (ana para + faiz)
  @override
  int get termInDays; // Vade (gün cinsinden)
  @override
  DateTime get startDate;
  @override
  DateTime get dueDate;
  @override
  double get amountPaid; // Ödenen miktar
  @override
  double get collateralValue; // Teminat değeri
  @override
  String get collateralDescription; // Teminat açıklaması
  @override
  double get penaltyRate; // Cezai faiz oranı
  @override
  bool get isSecured; // Güvenli kredi mi?
  @override
  String get purpose; // Kredi amacı
  @override
  int get riskScore; // Risk puanı (0-100)
  @override
  List<PaymentSchedule> get paymentSchedules;

  /// Create a copy of Loan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoanImplCopyWith<_$LoanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentSchedule _$PaymentScheduleFromJson(Map<String, dynamic> json) {
  return _PaymentSchedule.fromJson(json);
}

/// @nodoc
mixin _$PaymentSchedule {
  int get installmentNumber => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  bool get isPaid => throw _privateConstructorUsedError;
  DateTime? get paidDate => throw _privateConstructorUsedError;

  /// Serializes this PaymentSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentScheduleCopyWith<PaymentSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentScheduleCopyWith<$Res> {
  factory $PaymentScheduleCopyWith(
    PaymentSchedule value,
    $Res Function(PaymentSchedule) then,
  ) = _$PaymentScheduleCopyWithImpl<$Res, PaymentSchedule>;
  @useResult
  $Res call({
    int installmentNumber,
    DateTime dueDate,
    double amount,
    bool isPaid,
    DateTime? paidDate,
  });
}

/// @nodoc
class _$PaymentScheduleCopyWithImpl<$Res, $Val extends PaymentSchedule>
    implements $PaymentScheduleCopyWith<$Res> {
  _$PaymentScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? installmentNumber = null,
    Object? dueDate = null,
    Object? amount = null,
    Object? isPaid = null,
    Object? paidDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            installmentNumber: null == installmentNumber
                ? _value.installmentNumber
                : installmentNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            dueDate: null == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            isPaid: null == isPaid
                ? _value.isPaid
                : isPaid // ignore: cast_nullable_to_non_nullable
                      as bool,
            paidDate: freezed == paidDate
                ? _value.paidDate
                : paidDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentScheduleImplCopyWith<$Res>
    implements $PaymentScheduleCopyWith<$Res> {
  factory _$$PaymentScheduleImplCopyWith(
    _$PaymentScheduleImpl value,
    $Res Function(_$PaymentScheduleImpl) then,
  ) = __$$PaymentScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int installmentNumber,
    DateTime dueDate,
    double amount,
    bool isPaid,
    DateTime? paidDate,
  });
}

/// @nodoc
class __$$PaymentScheduleImplCopyWithImpl<$Res>
    extends _$PaymentScheduleCopyWithImpl<$Res, _$PaymentScheduleImpl>
    implements _$$PaymentScheduleImplCopyWith<$Res> {
  __$$PaymentScheduleImplCopyWithImpl(
    _$PaymentScheduleImpl _value,
    $Res Function(_$PaymentScheduleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? installmentNumber = null,
    Object? dueDate = null,
    Object? amount = null,
    Object? isPaid = null,
    Object? paidDate = freezed,
  }) {
    return _then(
      _$PaymentScheduleImpl(
        installmentNumber: null == installmentNumber
            ? _value.installmentNumber
            : installmentNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        dueDate: null == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        isPaid: null == isPaid
            ? _value.isPaid
            : isPaid // ignore: cast_nullable_to_non_nullable
                  as bool,
        paidDate: freezed == paidDate
            ? _value.paidDate
            : paidDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentScheduleImpl implements _PaymentSchedule {
  const _$PaymentScheduleImpl({
    required this.installmentNumber,
    required this.dueDate,
    required this.amount,
    this.isPaid = false,
    this.paidDate = null,
  });

  factory _$PaymentScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentScheduleImplFromJson(json);

  @override
  final int installmentNumber;
  @override
  final DateTime dueDate;
  @override
  final double amount;
  @override
  @JsonKey()
  final bool isPaid;
  @override
  @JsonKey()
  final DateTime? paidDate;

  @override
  String toString() {
    return 'PaymentSchedule(installmentNumber: $installmentNumber, dueDate: $dueDate, amount: $amount, isPaid: $isPaid, paidDate: $paidDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentScheduleImpl &&
            (identical(other.installmentNumber, installmentNumber) ||
                other.installmentNumber == installmentNumber) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.paidDate, paidDate) ||
                other.paidDate == paidDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    installmentNumber,
    dueDate,
    amount,
    isPaid,
    paidDate,
  );

  /// Create a copy of PaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentScheduleImplCopyWith<_$PaymentScheduleImpl> get copyWith =>
      __$$PaymentScheduleImplCopyWithImpl<_$PaymentScheduleImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentScheduleImplToJson(this);
  }
}

abstract class _PaymentSchedule implements PaymentSchedule {
  const factory _PaymentSchedule({
    required final int installmentNumber,
    required final DateTime dueDate,
    required final double amount,
    final bool isPaid,
    final DateTime? paidDate,
  }) = _$PaymentScheduleImpl;

  factory _PaymentSchedule.fromJson(Map<String, dynamic> json) =
      _$PaymentScheduleImpl.fromJson;

  @override
  int get installmentNumber;
  @override
  DateTime get dueDate;
  @override
  double get amount;
  @override
  bool get isPaid;
  @override
  DateTime? get paidDate;

  /// Create a copy of PaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentScheduleImplCopyWith<_$PaymentScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoanApplication _$LoanApplicationFromJson(Map<String, dynamic> json) {
  return _LoanApplication.fromJson(json);
}

/// @nodoc
mixin _$LoanApplication {
  String get playerId => throw _privateConstructorUsedError;
  LoanType get type => throw _privateConstructorUsedError;
  double get requestedAmount => throw _privateConstructorUsedError;
  int get termInDays => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  double get collateralValue => throw _privateConstructorUsedError;
  String get collateralDescription => throw _privateConstructorUsedError;

  /// Serializes this LoanApplication to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoanApplication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoanApplicationCopyWith<LoanApplication> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoanApplicationCopyWith<$Res> {
  factory $LoanApplicationCopyWith(
    LoanApplication value,
    $Res Function(LoanApplication) then,
  ) = _$LoanApplicationCopyWithImpl<$Res, LoanApplication>;
  @useResult
  $Res call({
    String playerId,
    LoanType type,
    double requestedAmount,
    int termInDays,
    String purpose,
    double collateralValue,
    String collateralDescription,
  });
}

/// @nodoc
class _$LoanApplicationCopyWithImpl<$Res, $Val extends LoanApplication>
    implements $LoanApplicationCopyWith<$Res> {
  _$LoanApplicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoanApplication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? type = null,
    Object? requestedAmount = null,
    Object? termInDays = null,
    Object? purpose = null,
    Object? collateralValue = null,
    Object? collateralDescription = null,
  }) {
    return _then(
      _value.copyWith(
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as LoanType,
            requestedAmount: null == requestedAmount
                ? _value.requestedAmount
                : requestedAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            termInDays: null == termInDays
                ? _value.termInDays
                : termInDays // ignore: cast_nullable_to_non_nullable
                      as int,
            purpose: null == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                      as String,
            collateralValue: null == collateralValue
                ? _value.collateralValue
                : collateralValue // ignore: cast_nullable_to_non_nullable
                      as double,
            collateralDescription: null == collateralDescription
                ? _value.collateralDescription
                : collateralDescription // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoanApplicationImplCopyWith<$Res>
    implements $LoanApplicationCopyWith<$Res> {
  factory _$$LoanApplicationImplCopyWith(
    _$LoanApplicationImpl value,
    $Res Function(_$LoanApplicationImpl) then,
  ) = __$$LoanApplicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String playerId,
    LoanType type,
    double requestedAmount,
    int termInDays,
    String purpose,
    double collateralValue,
    String collateralDescription,
  });
}

/// @nodoc
class __$$LoanApplicationImplCopyWithImpl<$Res>
    extends _$LoanApplicationCopyWithImpl<$Res, _$LoanApplicationImpl>
    implements _$$LoanApplicationImplCopyWith<$Res> {
  __$$LoanApplicationImplCopyWithImpl(
    _$LoanApplicationImpl _value,
    $Res Function(_$LoanApplicationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoanApplication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? type = null,
    Object? requestedAmount = null,
    Object? termInDays = null,
    Object? purpose = null,
    Object? collateralValue = null,
    Object? collateralDescription = null,
  }) {
    return _then(
      _$LoanApplicationImpl(
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as LoanType,
        requestedAmount: null == requestedAmount
            ? _value.requestedAmount
            : requestedAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        termInDays: null == termInDays
            ? _value.termInDays
            : termInDays // ignore: cast_nullable_to_non_nullable
                  as int,
        purpose: null == purpose
            ? _value.purpose
            : purpose // ignore: cast_nullable_to_non_nullable
                  as String,
        collateralValue: null == collateralValue
            ? _value.collateralValue
            : collateralValue // ignore: cast_nullable_to_non_nullable
                  as double,
        collateralDescription: null == collateralDescription
            ? _value.collateralDescription
            : collateralDescription // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoanApplicationImpl implements _LoanApplication {
  const _$LoanApplicationImpl({
    required this.playerId,
    required this.type,
    required this.requestedAmount,
    required this.termInDays,
    this.purpose = '',
    this.collateralValue = 0.0,
    this.collateralDescription = '',
  });

  factory _$LoanApplicationImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoanApplicationImplFromJson(json);

  @override
  final String playerId;
  @override
  final LoanType type;
  @override
  final double requestedAmount;
  @override
  final int termInDays;
  @override
  @JsonKey()
  final String purpose;
  @override
  @JsonKey()
  final double collateralValue;
  @override
  @JsonKey()
  final String collateralDescription;

  @override
  String toString() {
    return 'LoanApplication(playerId: $playerId, type: $type, requestedAmount: $requestedAmount, termInDays: $termInDays, purpose: $purpose, collateralValue: $collateralValue, collateralDescription: $collateralDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoanApplicationImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.requestedAmount, requestedAmount) ||
                other.requestedAmount == requestedAmount) &&
            (identical(other.termInDays, termInDays) ||
                other.termInDays == termInDays) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.collateralValue, collateralValue) ||
                other.collateralValue == collateralValue) &&
            (identical(other.collateralDescription, collateralDescription) ||
                other.collateralDescription == collateralDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    playerId,
    type,
    requestedAmount,
    termInDays,
    purpose,
    collateralValue,
    collateralDescription,
  );

  /// Create a copy of LoanApplication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoanApplicationImplCopyWith<_$LoanApplicationImpl> get copyWith =>
      __$$LoanApplicationImplCopyWithImpl<_$LoanApplicationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoanApplicationImplToJson(this);
  }
}

abstract class _LoanApplication implements LoanApplication {
  const factory _LoanApplication({
    required final String playerId,
    required final LoanType type,
    required final double requestedAmount,
    required final int termInDays,
    final String purpose,
    final double collateralValue,
    final String collateralDescription,
  }) = _$LoanApplicationImpl;

  factory _LoanApplication.fromJson(Map<String, dynamic> json) =
      _$LoanApplicationImpl.fromJson;

  @override
  String get playerId;
  @override
  LoanType get type;
  @override
  double get requestedAmount;
  @override
  int get termInDays;
  @override
  String get purpose;
  @override
  double get collateralValue;
  @override
  String get collateralDescription;

  /// Create a copy of LoanApplication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoanApplicationImplCopyWith<_$LoanApplicationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreditScore _$CreditScoreFromJson(Map<String, dynamic> json) {
  return _CreditScore.fromJson(json);
}

/// @nodoc
mixin _$CreditScore {
  String get playerId => throw _privateConstructorUsedError;
  int get score =>
      throw _privateConstructorUsedError; // 0-1000 arası kredi notu
  int get legalReputationImpact =>
      throw _privateConstructorUsedError; // Yasal itibar etkisi
  int get streetReputationImpact =>
      throw _privateConstructorUsedError; // Sokak itibarı etkisi
  double get riskMultiplier =>
      throw _privateConstructorUsedError; // Risk çarpanı
  int get totalLoans =>
      throw _privateConstructorUsedError; // Toplam kredi sayısı
  int get paidLoans =>
      throw _privateConstructorUsedError; // Ödenmiş kredi sayısı
  int get defaultedLoans =>
      throw _privateConstructorUsedError; // İflas edilmiş kredi sayısı
  double get currentDebtRatio =>
      throw _privateConstructorUsedError; // Mevcut borç oranı
  List<CreditHistory> get creditHistory => throw _privateConstructorUsedError;

  /// Serializes this CreditScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreditScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreditScoreCopyWith<CreditScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditScoreCopyWith<$Res> {
  factory $CreditScoreCopyWith(
    CreditScore value,
    $Res Function(CreditScore) then,
  ) = _$CreditScoreCopyWithImpl<$Res, CreditScore>;
  @useResult
  $Res call({
    String playerId,
    int score,
    int legalReputationImpact,
    int streetReputationImpact,
    double riskMultiplier,
    int totalLoans,
    int paidLoans,
    int defaultedLoans,
    double currentDebtRatio,
    List<CreditHistory> creditHistory,
  });
}

/// @nodoc
class _$CreditScoreCopyWithImpl<$Res, $Val extends CreditScore>
    implements $CreditScoreCopyWith<$Res> {
  _$CreditScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? score = null,
    Object? legalReputationImpact = null,
    Object? streetReputationImpact = null,
    Object? riskMultiplier = null,
    Object? totalLoans = null,
    Object? paidLoans = null,
    Object? defaultedLoans = null,
    Object? currentDebtRatio = null,
    Object? creditHistory = null,
  }) {
    return _then(
      _value.copyWith(
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            legalReputationImpact: null == legalReputationImpact
                ? _value.legalReputationImpact
                : legalReputationImpact // ignore: cast_nullable_to_non_nullable
                      as int,
            streetReputationImpact: null == streetReputationImpact
                ? _value.streetReputationImpact
                : streetReputationImpact // ignore: cast_nullable_to_non_nullable
                      as int,
            riskMultiplier: null == riskMultiplier
                ? _value.riskMultiplier
                : riskMultiplier // ignore: cast_nullable_to_non_nullable
                      as double,
            totalLoans: null == totalLoans
                ? _value.totalLoans
                : totalLoans // ignore: cast_nullable_to_non_nullable
                      as int,
            paidLoans: null == paidLoans
                ? _value.paidLoans
                : paidLoans // ignore: cast_nullable_to_non_nullable
                      as int,
            defaultedLoans: null == defaultedLoans
                ? _value.defaultedLoans
                : defaultedLoans // ignore: cast_nullable_to_non_nullable
                      as int,
            currentDebtRatio: null == currentDebtRatio
                ? _value.currentDebtRatio
                : currentDebtRatio // ignore: cast_nullable_to_non_nullable
                      as double,
            creditHistory: null == creditHistory
                ? _value.creditHistory
                : creditHistory // ignore: cast_nullable_to_non_nullable
                      as List<CreditHistory>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreditScoreImplCopyWith<$Res>
    implements $CreditScoreCopyWith<$Res> {
  factory _$$CreditScoreImplCopyWith(
    _$CreditScoreImpl value,
    $Res Function(_$CreditScoreImpl) then,
  ) = __$$CreditScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String playerId,
    int score,
    int legalReputationImpact,
    int streetReputationImpact,
    double riskMultiplier,
    int totalLoans,
    int paidLoans,
    int defaultedLoans,
    double currentDebtRatio,
    List<CreditHistory> creditHistory,
  });
}

/// @nodoc
class __$$CreditScoreImplCopyWithImpl<$Res>
    extends _$CreditScoreCopyWithImpl<$Res, _$CreditScoreImpl>
    implements _$$CreditScoreImplCopyWith<$Res> {
  __$$CreditScoreImplCopyWithImpl(
    _$CreditScoreImpl _value,
    $Res Function(_$CreditScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? score = null,
    Object? legalReputationImpact = null,
    Object? streetReputationImpact = null,
    Object? riskMultiplier = null,
    Object? totalLoans = null,
    Object? paidLoans = null,
    Object? defaultedLoans = null,
    Object? currentDebtRatio = null,
    Object? creditHistory = null,
  }) {
    return _then(
      _$CreditScoreImpl(
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        legalReputationImpact: null == legalReputationImpact
            ? _value.legalReputationImpact
            : legalReputationImpact // ignore: cast_nullable_to_non_nullable
                  as int,
        streetReputationImpact: null == streetReputationImpact
            ? _value.streetReputationImpact
            : streetReputationImpact // ignore: cast_nullable_to_non_nullable
                  as int,
        riskMultiplier: null == riskMultiplier
            ? _value.riskMultiplier
            : riskMultiplier // ignore: cast_nullable_to_non_nullable
                  as double,
        totalLoans: null == totalLoans
            ? _value.totalLoans
            : totalLoans // ignore: cast_nullable_to_non_nullable
                  as int,
        paidLoans: null == paidLoans
            ? _value.paidLoans
            : paidLoans // ignore: cast_nullable_to_non_nullable
                  as int,
        defaultedLoans: null == defaultedLoans
            ? _value.defaultedLoans
            : defaultedLoans // ignore: cast_nullable_to_non_nullable
                  as int,
        currentDebtRatio: null == currentDebtRatio
            ? _value.currentDebtRatio
            : currentDebtRatio // ignore: cast_nullable_to_non_nullable
                  as double,
        creditHistory: null == creditHistory
            ? _value._creditHistory
            : creditHistory // ignore: cast_nullable_to_non_nullable
                  as List<CreditHistory>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditScoreImpl extends _CreditScore {
  const _$CreditScoreImpl({
    required this.playerId,
    this.score = 0,
    this.legalReputationImpact = 0,
    this.streetReputationImpact = 0,
    this.riskMultiplier = 0.0,
    this.totalLoans = 0,
    this.paidLoans = 0,
    this.defaultedLoans = 0,
    this.currentDebtRatio = 0.0,
    final List<CreditHistory> creditHistory = const [],
  }) : _creditHistory = creditHistory,
       super._();

  factory _$CreditScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditScoreImplFromJson(json);

  @override
  final String playerId;
  @override
  @JsonKey()
  final int score;
  // 0-1000 arası kredi notu
  @override
  @JsonKey()
  final int legalReputationImpact;
  // Yasal itibar etkisi
  @override
  @JsonKey()
  final int streetReputationImpact;
  // Sokak itibarı etkisi
  @override
  @JsonKey()
  final double riskMultiplier;
  // Risk çarpanı
  @override
  @JsonKey()
  final int totalLoans;
  // Toplam kredi sayısı
  @override
  @JsonKey()
  final int paidLoans;
  // Ödenmiş kredi sayısı
  @override
  @JsonKey()
  final int defaultedLoans;
  // İflas edilmiş kredi sayısı
  @override
  @JsonKey()
  final double currentDebtRatio;
  // Mevcut borç oranı
  final List<CreditHistory> _creditHistory;
  // Mevcut borç oranı
  @override
  @JsonKey()
  List<CreditHistory> get creditHistory {
    if (_creditHistory is EqualUnmodifiableListView) return _creditHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_creditHistory);
  }

  @override
  String toString() {
    return 'CreditScore(playerId: $playerId, score: $score, legalReputationImpact: $legalReputationImpact, streetReputationImpact: $streetReputationImpact, riskMultiplier: $riskMultiplier, totalLoans: $totalLoans, paidLoans: $paidLoans, defaultedLoans: $defaultedLoans, currentDebtRatio: $currentDebtRatio, creditHistory: $creditHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditScoreImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.legalReputationImpact, legalReputationImpact) ||
                other.legalReputationImpact == legalReputationImpact) &&
            (identical(other.streetReputationImpact, streetReputationImpact) ||
                other.streetReputationImpact == streetReputationImpact) &&
            (identical(other.riskMultiplier, riskMultiplier) ||
                other.riskMultiplier == riskMultiplier) &&
            (identical(other.totalLoans, totalLoans) ||
                other.totalLoans == totalLoans) &&
            (identical(other.paidLoans, paidLoans) ||
                other.paidLoans == paidLoans) &&
            (identical(other.defaultedLoans, defaultedLoans) ||
                other.defaultedLoans == defaultedLoans) &&
            (identical(other.currentDebtRatio, currentDebtRatio) ||
                other.currentDebtRatio == currentDebtRatio) &&
            const DeepCollectionEquality().equals(
              other._creditHistory,
              _creditHistory,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    playerId,
    score,
    legalReputationImpact,
    streetReputationImpact,
    riskMultiplier,
    totalLoans,
    paidLoans,
    defaultedLoans,
    currentDebtRatio,
    const DeepCollectionEquality().hash(_creditHistory),
  );

  /// Create a copy of CreditScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditScoreImplCopyWith<_$CreditScoreImpl> get copyWith =>
      __$$CreditScoreImplCopyWithImpl<_$CreditScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditScoreImplToJson(this);
  }
}

abstract class _CreditScore extends CreditScore {
  const factory _CreditScore({
    required final String playerId,
    final int score,
    final int legalReputationImpact,
    final int streetReputationImpact,
    final double riskMultiplier,
    final int totalLoans,
    final int paidLoans,
    final int defaultedLoans,
    final double currentDebtRatio,
    final List<CreditHistory> creditHistory,
  }) = _$CreditScoreImpl;
  const _CreditScore._() : super._();

  factory _CreditScore.fromJson(Map<String, dynamic> json) =
      _$CreditScoreImpl.fromJson;

  @override
  String get playerId;
  @override
  int get score; // 0-1000 arası kredi notu
  @override
  int get legalReputationImpact; // Yasal itibar etkisi
  @override
  int get streetReputationImpact; // Sokak itibarı etkisi
  @override
  double get riskMultiplier; // Risk çarpanı
  @override
  int get totalLoans; // Toplam kredi sayısı
  @override
  int get paidLoans; // Ödenmiş kredi sayısı
  @override
  int get defaultedLoans; // İflas edilmiş kredi sayısı
  @override
  double get currentDebtRatio; // Mevcut borç oranı
  @override
  List<CreditHistory> get creditHistory;

  /// Create a copy of CreditScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditScoreImplCopyWith<_$CreditScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreditHistory _$CreditHistoryFromJson(Map<String, dynamic> json) {
  return _CreditHistory.fromJson(json);
}

/// @nodoc
mixin _$CreditHistory {
  String get loanId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get action =>
      throw _privateConstructorUsedError; // 'application', 'approval', 'payment', 'default', 'closure'
  String get description => throw _privateConstructorUsedError;
  int get scoreChange => throw _privateConstructorUsedError;

  /// Serializes this CreditHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreditHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreditHistoryCopyWith<CreditHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditHistoryCopyWith<$Res> {
  factory $CreditHistoryCopyWith(
    CreditHistory value,
    $Res Function(CreditHistory) then,
  ) = _$CreditHistoryCopyWithImpl<$Res, CreditHistory>;
  @useResult
  $Res call({
    String loanId,
    DateTime date,
    String action,
    String description,
    int scoreChange,
  });
}

/// @nodoc
class _$CreditHistoryCopyWithImpl<$Res, $Val extends CreditHistory>
    implements $CreditHistoryCopyWith<$Res> {
  _$CreditHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loanId = null,
    Object? date = null,
    Object? action = null,
    Object? description = null,
    Object? scoreChange = null,
  }) {
    return _then(
      _value.copyWith(
            loanId: null == loanId
                ? _value.loanId
                : loanId // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            scoreChange: null == scoreChange
                ? _value.scoreChange
                : scoreChange // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreditHistoryImplCopyWith<$Res>
    implements $CreditHistoryCopyWith<$Res> {
  factory _$$CreditHistoryImplCopyWith(
    _$CreditHistoryImpl value,
    $Res Function(_$CreditHistoryImpl) then,
  ) = __$$CreditHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String loanId,
    DateTime date,
    String action,
    String description,
    int scoreChange,
  });
}

/// @nodoc
class __$$CreditHistoryImplCopyWithImpl<$Res>
    extends _$CreditHistoryCopyWithImpl<$Res, _$CreditHistoryImpl>
    implements _$$CreditHistoryImplCopyWith<$Res> {
  __$$CreditHistoryImplCopyWithImpl(
    _$CreditHistoryImpl _value,
    $Res Function(_$CreditHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loanId = null,
    Object? date = null,
    Object? action = null,
    Object? description = null,
    Object? scoreChange = null,
  }) {
    return _then(
      _$CreditHistoryImpl(
        loanId: null == loanId
            ? _value.loanId
            : loanId // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        scoreChange: null == scoreChange
            ? _value.scoreChange
            : scoreChange // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditHistoryImpl implements _CreditHistory {
  const _$CreditHistoryImpl({
    required this.loanId,
    required this.date,
    required this.action,
    required this.description,
    required this.scoreChange,
  });

  factory _$CreditHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditHistoryImplFromJson(json);

  @override
  final String loanId;
  @override
  final DateTime date;
  @override
  final String action;
  // 'application', 'approval', 'payment', 'default', 'closure'
  @override
  final String description;
  @override
  final int scoreChange;

  @override
  String toString() {
    return 'CreditHistory(loanId: $loanId, date: $date, action: $action, description: $description, scoreChange: $scoreChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditHistoryImpl &&
            (identical(other.loanId, loanId) || other.loanId == loanId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.scoreChange, scoreChange) ||
                other.scoreChange == scoreChange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, loanId, date, action, description, scoreChange);

  /// Create a copy of CreditHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditHistoryImplCopyWith<_$CreditHistoryImpl> get copyWith =>
      __$$CreditHistoryImplCopyWithImpl<_$CreditHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditHistoryImplToJson(this);
  }
}

abstract class _CreditHistory implements CreditHistory {
  const factory _CreditHistory({
    required final String loanId,
    required final DateTime date,
    required final String action,
    required final String description,
    required final int scoreChange,
  }) = _$CreditHistoryImpl;

  factory _CreditHistory.fromJson(Map<String, dynamic> json) =
      _$CreditHistoryImpl.fromJson;

  @override
  String get loanId;
  @override
  DateTime get date;
  @override
  String get action; // 'application', 'approval', 'payment', 'default', 'closure'
  @override
  String get description;
  @override
  int get scoreChange;

  /// Create a copy of CreditHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditHistoryImplCopyWith<_$CreditHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
