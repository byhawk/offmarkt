// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_research.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MarketResearch _$MarketResearchFromJson(Map<String, dynamic> json) {
  return _MarketResearch.fromJson(json);
}

/// @nodoc
mixin _$MarketResearch {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  ResearchType get type => throw _privateConstructorUsedError;
  String get targetProduct => throw _privateConstructorUsedError;
  ResearchQuality get quality => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  int get durationInHours => throw _privateConstructorUsedError;
  double get accuracy =>
      throw _privateConstructorUsedError; // 0.0 - 1.0 arası doğruluk
  String get insights => throw _privateConstructorUsedError;
  double get pricePrediction => throw _privateConstructorUsedError;
  double get demandPrediction => throw _privateConstructorUsedError;
  double get riskAssessment => throw _privateConstructorUsedError;
  List<MarketForecast> get forecasts => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalData => throw _privateConstructorUsedError;

  /// Serializes this MarketResearch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarketResearch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketResearchCopyWith<MarketResearch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketResearchCopyWith<$Res> {
  factory $MarketResearchCopyWith(
    MarketResearch value,
    $Res Function(MarketResearch) then,
  ) = _$MarketResearchCopyWithImpl<$Res, MarketResearch>;
  @useResult
  $Res call({
    String id,
    String playerId,
    ResearchType type,
    String targetProduct,
    ResearchQuality quality,
    DateTime date,
    double cost,
    int durationInHours,
    double accuracy,
    String insights,
    double pricePrediction,
    double demandPrediction,
    double riskAssessment,
    List<MarketForecast> forecasts,
    Map<String, dynamic> additionalData,
  });
}

/// @nodoc
class _$MarketResearchCopyWithImpl<$Res, $Val extends MarketResearch>
    implements $MarketResearchCopyWith<$Res> {
  _$MarketResearchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketResearch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? type = null,
    Object? targetProduct = null,
    Object? quality = null,
    Object? date = null,
    Object? cost = null,
    Object? durationInHours = null,
    Object? accuracy = null,
    Object? insights = null,
    Object? pricePrediction = null,
    Object? demandPrediction = null,
    Object? riskAssessment = null,
    Object? forecasts = null,
    Object? additionalData = null,
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
                      as ResearchType,
            targetProduct: null == targetProduct
                ? _value.targetProduct
                : targetProduct // ignore: cast_nullable_to_non_nullable
                      as String,
            quality: null == quality
                ? _value.quality
                : quality // ignore: cast_nullable_to_non_nullable
                      as ResearchQuality,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double,
            durationInHours: null == durationInHours
                ? _value.durationInHours
                : durationInHours // ignore: cast_nullable_to_non_nullable
                      as int,
            accuracy: null == accuracy
                ? _value.accuracy
                : accuracy // ignore: cast_nullable_to_non_nullable
                      as double,
            insights: null == insights
                ? _value.insights
                : insights // ignore: cast_nullable_to_non_nullable
                      as String,
            pricePrediction: null == pricePrediction
                ? _value.pricePrediction
                : pricePrediction // ignore: cast_nullable_to_non_nullable
                      as double,
            demandPrediction: null == demandPrediction
                ? _value.demandPrediction
                : demandPrediction // ignore: cast_nullable_to_non_nullable
                      as double,
            riskAssessment: null == riskAssessment
                ? _value.riskAssessment
                : riskAssessment // ignore: cast_nullable_to_non_nullable
                      as double,
            forecasts: null == forecasts
                ? _value.forecasts
                : forecasts // ignore: cast_nullable_to_non_nullable
                      as List<MarketForecast>,
            additionalData: null == additionalData
                ? _value.additionalData
                : additionalData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarketResearchImplCopyWith<$Res>
    implements $MarketResearchCopyWith<$Res> {
  factory _$$MarketResearchImplCopyWith(
    _$MarketResearchImpl value,
    $Res Function(_$MarketResearchImpl) then,
  ) = __$$MarketResearchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    ResearchType type,
    String targetProduct,
    ResearchQuality quality,
    DateTime date,
    double cost,
    int durationInHours,
    double accuracy,
    String insights,
    double pricePrediction,
    double demandPrediction,
    double riskAssessment,
    List<MarketForecast> forecasts,
    Map<String, dynamic> additionalData,
  });
}

/// @nodoc
class __$$MarketResearchImplCopyWithImpl<$Res>
    extends _$MarketResearchCopyWithImpl<$Res, _$MarketResearchImpl>
    implements _$$MarketResearchImplCopyWith<$Res> {
  __$$MarketResearchImplCopyWithImpl(
    _$MarketResearchImpl _value,
    $Res Function(_$MarketResearchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketResearch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? type = null,
    Object? targetProduct = null,
    Object? quality = null,
    Object? date = null,
    Object? cost = null,
    Object? durationInHours = null,
    Object? accuracy = null,
    Object? insights = null,
    Object? pricePrediction = null,
    Object? demandPrediction = null,
    Object? riskAssessment = null,
    Object? forecasts = null,
    Object? additionalData = null,
  }) {
    return _then(
      _$MarketResearchImpl(
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
                  as ResearchType,
        targetProduct: null == targetProduct
            ? _value.targetProduct
            : targetProduct // ignore: cast_nullable_to_non_nullable
                  as String,
        quality: null == quality
            ? _value.quality
            : quality // ignore: cast_nullable_to_non_nullable
                  as ResearchQuality,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double,
        durationInHours: null == durationInHours
            ? _value.durationInHours
            : durationInHours // ignore: cast_nullable_to_non_nullable
                  as int,
        accuracy: null == accuracy
            ? _value.accuracy
            : accuracy // ignore: cast_nullable_to_non_nullable
                  as double,
        insights: null == insights
            ? _value.insights
            : insights // ignore: cast_nullable_to_non_nullable
                  as String,
        pricePrediction: null == pricePrediction
            ? _value.pricePrediction
            : pricePrediction // ignore: cast_nullable_to_non_nullable
                  as double,
        demandPrediction: null == demandPrediction
            ? _value.demandPrediction
            : demandPrediction // ignore: cast_nullable_to_non_nullable
                  as double,
        riskAssessment: null == riskAssessment
            ? _value.riskAssessment
            : riskAssessment // ignore: cast_nullable_to_non_nullable
                  as double,
        forecasts: null == forecasts
            ? _value._forecasts
            : forecasts // ignore: cast_nullable_to_non_nullable
                  as List<MarketForecast>,
        additionalData: null == additionalData
            ? _value._additionalData
            : additionalData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketResearchImpl extends _MarketResearch {
  const _$MarketResearchImpl({
    required this.id,
    required this.playerId,
    required this.type,
    required this.targetProduct,
    required this.quality,
    required this.date,
    required this.cost,
    required this.durationInHours,
    this.accuracy = 0.0,
    this.insights = '',
    this.pricePrediction = 0.0,
    this.demandPrediction = 0.0,
    this.riskAssessment = 0.0,
    final List<MarketForecast> forecasts = const [],
    final Map<String, dynamic> additionalData = const {},
  }) : _forecasts = forecasts,
       _additionalData = additionalData,
       super._();

  factory _$MarketResearchImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketResearchImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final ResearchType type;
  @override
  final String targetProduct;
  @override
  final ResearchQuality quality;
  @override
  final DateTime date;
  @override
  final double cost;
  @override
  final int durationInHours;
  @override
  @JsonKey()
  final double accuracy;
  // 0.0 - 1.0 arası doğruluk
  @override
  @JsonKey()
  final String insights;
  @override
  @JsonKey()
  final double pricePrediction;
  @override
  @JsonKey()
  final double demandPrediction;
  @override
  @JsonKey()
  final double riskAssessment;
  final List<MarketForecast> _forecasts;
  @override
  @JsonKey()
  List<MarketForecast> get forecasts {
    if (_forecasts is EqualUnmodifiableListView) return _forecasts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_forecasts);
  }

  final Map<String, dynamic> _additionalData;
  @override
  @JsonKey()
  Map<String, dynamic> get additionalData {
    if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalData);
  }

  @override
  String toString() {
    return 'MarketResearch(id: $id, playerId: $playerId, type: $type, targetProduct: $targetProduct, quality: $quality, date: $date, cost: $cost, durationInHours: $durationInHours, accuracy: $accuracy, insights: $insights, pricePrediction: $pricePrediction, demandPrediction: $demandPrediction, riskAssessment: $riskAssessment, forecasts: $forecasts, additionalData: $additionalData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketResearchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetProduct, targetProduct) ||
                other.targetProduct == targetProduct) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.durationInHours, durationInHours) ||
                other.durationInHours == durationInHours) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.insights, insights) ||
                other.insights == insights) &&
            (identical(other.pricePrediction, pricePrediction) ||
                other.pricePrediction == pricePrediction) &&
            (identical(other.demandPrediction, demandPrediction) ||
                other.demandPrediction == demandPrediction) &&
            (identical(other.riskAssessment, riskAssessment) ||
                other.riskAssessment == riskAssessment) &&
            const DeepCollectionEquality().equals(
              other._forecasts,
              _forecasts,
            ) &&
            const DeepCollectionEquality().equals(
              other._additionalData,
              _additionalData,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    playerId,
    type,
    targetProduct,
    quality,
    date,
    cost,
    durationInHours,
    accuracy,
    insights,
    pricePrediction,
    demandPrediction,
    riskAssessment,
    const DeepCollectionEquality().hash(_forecasts),
    const DeepCollectionEquality().hash(_additionalData),
  );

  /// Create a copy of MarketResearch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketResearchImplCopyWith<_$MarketResearchImpl> get copyWith =>
      __$$MarketResearchImplCopyWithImpl<_$MarketResearchImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketResearchImplToJson(this);
  }
}

abstract class _MarketResearch extends MarketResearch {
  const factory _MarketResearch({
    required final String id,
    required final String playerId,
    required final ResearchType type,
    required final String targetProduct,
    required final ResearchQuality quality,
    required final DateTime date,
    required final double cost,
    required final int durationInHours,
    final double accuracy,
    final String insights,
    final double pricePrediction,
    final double demandPrediction,
    final double riskAssessment,
    final List<MarketForecast> forecasts,
    final Map<String, dynamic> additionalData,
  }) = _$MarketResearchImpl;
  const _MarketResearch._() : super._();

  factory _MarketResearch.fromJson(Map<String, dynamic> json) =
      _$MarketResearchImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  ResearchType get type;
  @override
  String get targetProduct;
  @override
  ResearchQuality get quality;
  @override
  DateTime get date;
  @override
  double get cost;
  @override
  int get durationInHours;
  @override
  double get accuracy; // 0.0 - 1.0 arası doğruluk
  @override
  String get insights;
  @override
  double get pricePrediction;
  @override
  double get demandPrediction;
  @override
  double get riskAssessment;
  @override
  List<MarketForecast> get forecasts;
  @override
  Map<String, dynamic> get additionalData;

  /// Create a copy of MarketResearch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketResearchImplCopyWith<_$MarketResearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarketForecast _$MarketForecastFromJson(Map<String, dynamic> json) {
  return _MarketForecast.fromJson(json);
}

/// @nodoc
mixin _$MarketForecast {
  int get dayOffset =>
      throw _privateConstructorUsedError; // Gelecekteki gün sayısı
  double get predictedPrice => throw _privateConstructorUsedError;
  double get predictedDemand => throw _privateConstructorUsedError;
  double get confidence =>
      throw _privateConstructorUsedError; // 0.0 - 1.0 arası güven
  double get volatility =>
      throw _privateConstructorUsedError; // Fiyat volatilitesi
  double get trendStrength => throw _privateConstructorUsedError;

  /// Serializes this MarketForecast to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarketForecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketForecastCopyWith<MarketForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketForecastCopyWith<$Res> {
  factory $MarketForecastCopyWith(
    MarketForecast value,
    $Res Function(MarketForecast) then,
  ) = _$MarketForecastCopyWithImpl<$Res, MarketForecast>;
  @useResult
  $Res call({
    int dayOffset,
    double predictedPrice,
    double predictedDemand,
    double confidence,
    double volatility,
    double trendStrength,
  });
}

/// @nodoc
class _$MarketForecastCopyWithImpl<$Res, $Val extends MarketForecast>
    implements $MarketForecastCopyWith<$Res> {
  _$MarketForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketForecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayOffset = null,
    Object? predictedPrice = null,
    Object? predictedDemand = null,
    Object? confidence = null,
    Object? volatility = null,
    Object? trendStrength = null,
  }) {
    return _then(
      _value.copyWith(
            dayOffset: null == dayOffset
                ? _value.dayOffset
                : dayOffset // ignore: cast_nullable_to_non_nullable
                      as int,
            predictedPrice: null == predictedPrice
                ? _value.predictedPrice
                : predictedPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            predictedDemand: null == predictedDemand
                ? _value.predictedDemand
                : predictedDemand // ignore: cast_nullable_to_non_nullable
                      as double,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            volatility: null == volatility
                ? _value.volatility
                : volatility // ignore: cast_nullable_to_non_nullable
                      as double,
            trendStrength: null == trendStrength
                ? _value.trendStrength
                : trendStrength // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarketForecastImplCopyWith<$Res>
    implements $MarketForecastCopyWith<$Res> {
  factory _$$MarketForecastImplCopyWith(
    _$MarketForecastImpl value,
    $Res Function(_$MarketForecastImpl) then,
  ) = __$$MarketForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int dayOffset,
    double predictedPrice,
    double predictedDemand,
    double confidence,
    double volatility,
    double trendStrength,
  });
}

/// @nodoc
class __$$MarketForecastImplCopyWithImpl<$Res>
    extends _$MarketForecastCopyWithImpl<$Res, _$MarketForecastImpl>
    implements _$$MarketForecastImplCopyWith<$Res> {
  __$$MarketForecastImplCopyWithImpl(
    _$MarketForecastImpl _value,
    $Res Function(_$MarketForecastImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketForecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayOffset = null,
    Object? predictedPrice = null,
    Object? predictedDemand = null,
    Object? confidence = null,
    Object? volatility = null,
    Object? trendStrength = null,
  }) {
    return _then(
      _$MarketForecastImpl(
        dayOffset: null == dayOffset
            ? _value.dayOffset
            : dayOffset // ignore: cast_nullable_to_non_nullable
                  as int,
        predictedPrice: null == predictedPrice
            ? _value.predictedPrice
            : predictedPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        predictedDemand: null == predictedDemand
            ? _value.predictedDemand
            : predictedDemand // ignore: cast_nullable_to_non_nullable
                  as double,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        volatility: null == volatility
            ? _value.volatility
            : volatility // ignore: cast_nullable_to_non_nullable
                  as double,
        trendStrength: null == trendStrength
            ? _value.trendStrength
            : trendStrength // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketForecastImpl implements _MarketForecast {
  const _$MarketForecastImpl({
    required this.dayOffset,
    required this.predictedPrice,
    required this.predictedDemand,
    required this.confidence,
    this.volatility = 0.0,
    this.trendStrength = 0.0,
  });

  factory _$MarketForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketForecastImplFromJson(json);

  @override
  final int dayOffset;
  // Gelecekteki gün sayısı
  @override
  final double predictedPrice;
  @override
  final double predictedDemand;
  @override
  final double confidence;
  // 0.0 - 1.0 arası güven
  @override
  @JsonKey()
  final double volatility;
  // Fiyat volatilitesi
  @override
  @JsonKey()
  final double trendStrength;

  @override
  String toString() {
    return 'MarketForecast(dayOffset: $dayOffset, predictedPrice: $predictedPrice, predictedDemand: $predictedDemand, confidence: $confidence, volatility: $volatility, trendStrength: $trendStrength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketForecastImpl &&
            (identical(other.dayOffset, dayOffset) ||
                other.dayOffset == dayOffset) &&
            (identical(other.predictedPrice, predictedPrice) ||
                other.predictedPrice == predictedPrice) &&
            (identical(other.predictedDemand, predictedDemand) ||
                other.predictedDemand == predictedDemand) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.volatility, volatility) ||
                other.volatility == volatility) &&
            (identical(other.trendStrength, trendStrength) ||
                other.trendStrength == trendStrength));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dayOffset,
    predictedPrice,
    predictedDemand,
    confidence,
    volatility,
    trendStrength,
  );

  /// Create a copy of MarketForecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketForecastImplCopyWith<_$MarketForecastImpl> get copyWith =>
      __$$MarketForecastImplCopyWithImpl<_$MarketForecastImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketForecastImplToJson(this);
  }
}

abstract class _MarketForecast implements MarketForecast {
  const factory _MarketForecast({
    required final int dayOffset,
    required final double predictedPrice,
    required final double predictedDemand,
    required final double confidence,
    final double volatility,
    final double trendStrength,
  }) = _$MarketForecastImpl;

  factory _MarketForecast.fromJson(Map<String, dynamic> json) =
      _$MarketForecastImpl.fromJson;

  @override
  int get dayOffset; // Gelecekteki gün sayısı
  @override
  double get predictedPrice;
  @override
  double get predictedDemand;
  @override
  double get confidence; // 0.0 - 1.0 arası güven
  @override
  double get volatility; // Fiyat volatilitesi
  @override
  double get trendStrength;

  /// Create a copy of MarketForecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketForecastImplCopyWith<_$MarketForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarketIntelligence _$MarketIntelligenceFromJson(Map<String, dynamic> json) {
  return _MarketIntelligence.fromJson(json);
}

/// @nodoc
mixin _$MarketIntelligence {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get targetProduct => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get competitorPrice => throw _privateConstructorUsedError;
  double get competitorDemand => throw _privateConstructorUsedError;
  double get marketShare => throw _privateConstructorUsedError;
  double get supplyLevel => throw _privateConstructorUsedError;
  String get marketConditions => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalData => throw _privateConstructorUsedError;

  /// Serializes this MarketIntelligence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarketIntelligence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketIntelligenceCopyWith<MarketIntelligence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketIntelligenceCopyWith<$Res> {
  factory $MarketIntelligenceCopyWith(
    MarketIntelligence value,
    $Res Function(MarketIntelligence) then,
  ) = _$MarketIntelligenceCopyWithImpl<$Res, MarketIntelligence>;
  @useResult
  $Res call({
    String id,
    String playerId,
    String targetProduct,
    DateTime date,
    double competitorPrice,
    double competitorDemand,
    double marketShare,
    double supplyLevel,
    String marketConditions,
    Map<String, dynamic> additionalData,
  });
}

/// @nodoc
class _$MarketIntelligenceCopyWithImpl<$Res, $Val extends MarketIntelligence>
    implements $MarketIntelligenceCopyWith<$Res> {
  _$MarketIntelligenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketIntelligence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? targetProduct = null,
    Object? date = null,
    Object? competitorPrice = null,
    Object? competitorDemand = null,
    Object? marketShare = null,
    Object? supplyLevel = null,
    Object? marketConditions = null,
    Object? additionalData = null,
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
            targetProduct: null == targetProduct
                ? _value.targetProduct
                : targetProduct // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            competitorPrice: null == competitorPrice
                ? _value.competitorPrice
                : competitorPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            competitorDemand: null == competitorDemand
                ? _value.competitorDemand
                : competitorDemand // ignore: cast_nullable_to_non_nullable
                      as double,
            marketShare: null == marketShare
                ? _value.marketShare
                : marketShare // ignore: cast_nullable_to_non_nullable
                      as double,
            supplyLevel: null == supplyLevel
                ? _value.supplyLevel
                : supplyLevel // ignore: cast_nullable_to_non_nullable
                      as double,
            marketConditions: null == marketConditions
                ? _value.marketConditions
                : marketConditions // ignore: cast_nullable_to_non_nullable
                      as String,
            additionalData: null == additionalData
                ? _value.additionalData
                : additionalData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarketIntelligenceImplCopyWith<$Res>
    implements $MarketIntelligenceCopyWith<$Res> {
  factory _$$MarketIntelligenceImplCopyWith(
    _$MarketIntelligenceImpl value,
    $Res Function(_$MarketIntelligenceImpl) then,
  ) = __$$MarketIntelligenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    String targetProduct,
    DateTime date,
    double competitorPrice,
    double competitorDemand,
    double marketShare,
    double supplyLevel,
    String marketConditions,
    Map<String, dynamic> additionalData,
  });
}

/// @nodoc
class __$$MarketIntelligenceImplCopyWithImpl<$Res>
    extends _$MarketIntelligenceCopyWithImpl<$Res, _$MarketIntelligenceImpl>
    implements _$$MarketIntelligenceImplCopyWith<$Res> {
  __$$MarketIntelligenceImplCopyWithImpl(
    _$MarketIntelligenceImpl _value,
    $Res Function(_$MarketIntelligenceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketIntelligence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? targetProduct = null,
    Object? date = null,
    Object? competitorPrice = null,
    Object? competitorDemand = null,
    Object? marketShare = null,
    Object? supplyLevel = null,
    Object? marketConditions = null,
    Object? additionalData = null,
  }) {
    return _then(
      _$MarketIntelligenceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetProduct: null == targetProduct
            ? _value.targetProduct
            : targetProduct // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        competitorPrice: null == competitorPrice
            ? _value.competitorPrice
            : competitorPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        competitorDemand: null == competitorDemand
            ? _value.competitorDemand
            : competitorDemand // ignore: cast_nullable_to_non_nullable
                  as double,
        marketShare: null == marketShare
            ? _value.marketShare
            : marketShare // ignore: cast_nullable_to_non_nullable
                  as double,
        supplyLevel: null == supplyLevel
            ? _value.supplyLevel
            : supplyLevel // ignore: cast_nullable_to_non_nullable
                  as double,
        marketConditions: null == marketConditions
            ? _value.marketConditions
            : marketConditions // ignore: cast_nullable_to_non_nullable
                  as String,
        additionalData: null == additionalData
            ? _value._additionalData
            : additionalData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketIntelligenceImpl implements _MarketIntelligence {
  const _$MarketIntelligenceImpl({
    required this.id,
    required this.playerId,
    required this.targetProduct,
    required this.date,
    this.competitorPrice = 0.0,
    this.competitorDemand = 0.0,
    this.marketShare = 0.0,
    this.supplyLevel = 0.0,
    this.marketConditions = '',
    final Map<String, dynamic> additionalData = const {},
  }) : _additionalData = additionalData;

  factory _$MarketIntelligenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketIntelligenceImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final String targetProduct;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final double competitorPrice;
  @override
  @JsonKey()
  final double competitorDemand;
  @override
  @JsonKey()
  final double marketShare;
  @override
  @JsonKey()
  final double supplyLevel;
  @override
  @JsonKey()
  final String marketConditions;
  final Map<String, dynamic> _additionalData;
  @override
  @JsonKey()
  Map<String, dynamic> get additionalData {
    if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalData);
  }

  @override
  String toString() {
    return 'MarketIntelligence(id: $id, playerId: $playerId, targetProduct: $targetProduct, date: $date, competitorPrice: $competitorPrice, competitorDemand: $competitorDemand, marketShare: $marketShare, supplyLevel: $supplyLevel, marketConditions: $marketConditions, additionalData: $additionalData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketIntelligenceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.targetProduct, targetProduct) ||
                other.targetProduct == targetProduct) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.competitorPrice, competitorPrice) ||
                other.competitorPrice == competitorPrice) &&
            (identical(other.competitorDemand, competitorDemand) ||
                other.competitorDemand == competitorDemand) &&
            (identical(other.marketShare, marketShare) ||
                other.marketShare == marketShare) &&
            (identical(other.supplyLevel, supplyLevel) ||
                other.supplyLevel == supplyLevel) &&
            (identical(other.marketConditions, marketConditions) ||
                other.marketConditions == marketConditions) &&
            const DeepCollectionEquality().equals(
              other._additionalData,
              _additionalData,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    playerId,
    targetProduct,
    date,
    competitorPrice,
    competitorDemand,
    marketShare,
    supplyLevel,
    marketConditions,
    const DeepCollectionEquality().hash(_additionalData),
  );

  /// Create a copy of MarketIntelligence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketIntelligenceImplCopyWith<_$MarketIntelligenceImpl> get copyWith =>
      __$$MarketIntelligenceImplCopyWithImpl<_$MarketIntelligenceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketIntelligenceImplToJson(this);
  }
}

abstract class _MarketIntelligence implements MarketIntelligence {
  const factory _MarketIntelligence({
    required final String id,
    required final String playerId,
    required final String targetProduct,
    required final DateTime date,
    final double competitorPrice,
    final double competitorDemand,
    final double marketShare,
    final double supplyLevel,
    final String marketConditions,
    final Map<String, dynamic> additionalData,
  }) = _$MarketIntelligenceImpl;

  factory _MarketIntelligence.fromJson(Map<String, dynamic> json) =
      _$MarketIntelligenceImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  String get targetProduct;
  @override
  DateTime get date;
  @override
  double get competitorPrice;
  @override
  double get competitorDemand;
  @override
  double get marketShare;
  @override
  double get supplyLevel;
  @override
  String get marketConditions;
  @override
  Map<String, dynamic> get additionalData;

  /// Create a copy of MarketIntelligence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketIntelligenceImplCopyWith<_$MarketIntelligenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConsumerBehaviorAnalysis _$ConsumerBehaviorAnalysisFromJson(
  Map<String, dynamic> json,
) {
  return _ConsumerBehaviorAnalysis.fromJson(json);
}

/// @nodoc
mixin _$ConsumerBehaviorAnalysis {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get targetProduct => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get priceSensitivity => throw _privateConstructorUsedError;
  double get brandLoyalty => throw _privateConstructorUsedError;
  double get seasonalPreference => throw _privateConstructorUsedError;
  double get trendInfluence => throw _privateConstructorUsedError;
  double get riskAversion => throw _privateConstructorUsedError;
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;

  /// Serializes this ConsumerBehaviorAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsumerBehaviorAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsumerBehaviorAnalysisCopyWith<ConsumerBehaviorAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumerBehaviorAnalysisCopyWith<$Res> {
  factory $ConsumerBehaviorAnalysisCopyWith(
    ConsumerBehaviorAnalysis value,
    $Res Function(ConsumerBehaviorAnalysis) then,
  ) = _$ConsumerBehaviorAnalysisCopyWithImpl<$Res, ConsumerBehaviorAnalysis>;
  @useResult
  $Res call({
    String id,
    String playerId,
    String targetProduct,
    DateTime date,
    double priceSensitivity,
    double brandLoyalty,
    double seasonalPreference,
    double trendInfluence,
    double riskAversion,
    Map<String, dynamic> preferences,
  });
}

/// @nodoc
class _$ConsumerBehaviorAnalysisCopyWithImpl<
  $Res,
  $Val extends ConsumerBehaviorAnalysis
>
    implements $ConsumerBehaviorAnalysisCopyWith<$Res> {
  _$ConsumerBehaviorAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsumerBehaviorAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? targetProduct = null,
    Object? date = null,
    Object? priceSensitivity = null,
    Object? brandLoyalty = null,
    Object? seasonalPreference = null,
    Object? trendInfluence = null,
    Object? riskAversion = null,
    Object? preferences = null,
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
            targetProduct: null == targetProduct
                ? _value.targetProduct
                : targetProduct // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            priceSensitivity: null == priceSensitivity
                ? _value.priceSensitivity
                : priceSensitivity // ignore: cast_nullable_to_non_nullable
                      as double,
            brandLoyalty: null == brandLoyalty
                ? _value.brandLoyalty
                : brandLoyalty // ignore: cast_nullable_to_non_nullable
                      as double,
            seasonalPreference: null == seasonalPreference
                ? _value.seasonalPreference
                : seasonalPreference // ignore: cast_nullable_to_non_nullable
                      as double,
            trendInfluence: null == trendInfluence
                ? _value.trendInfluence
                : trendInfluence // ignore: cast_nullable_to_non_nullable
                      as double,
            riskAversion: null == riskAversion
                ? _value.riskAversion
                : riskAversion // ignore: cast_nullable_to_non_nullable
                      as double,
            preferences: null == preferences
                ? _value.preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConsumerBehaviorAnalysisImplCopyWith<$Res>
    implements $ConsumerBehaviorAnalysisCopyWith<$Res> {
  factory _$$ConsumerBehaviorAnalysisImplCopyWith(
    _$ConsumerBehaviorAnalysisImpl value,
    $Res Function(_$ConsumerBehaviorAnalysisImpl) then,
  ) = __$$ConsumerBehaviorAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    String targetProduct,
    DateTime date,
    double priceSensitivity,
    double brandLoyalty,
    double seasonalPreference,
    double trendInfluence,
    double riskAversion,
    Map<String, dynamic> preferences,
  });
}

/// @nodoc
class __$$ConsumerBehaviorAnalysisImplCopyWithImpl<$Res>
    extends
        _$ConsumerBehaviorAnalysisCopyWithImpl<
          $Res,
          _$ConsumerBehaviorAnalysisImpl
        >
    implements _$$ConsumerBehaviorAnalysisImplCopyWith<$Res> {
  __$$ConsumerBehaviorAnalysisImplCopyWithImpl(
    _$ConsumerBehaviorAnalysisImpl _value,
    $Res Function(_$ConsumerBehaviorAnalysisImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConsumerBehaviorAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? targetProduct = null,
    Object? date = null,
    Object? priceSensitivity = null,
    Object? brandLoyalty = null,
    Object? seasonalPreference = null,
    Object? trendInfluence = null,
    Object? riskAversion = null,
    Object? preferences = null,
  }) {
    return _then(
      _$ConsumerBehaviorAnalysisImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetProduct: null == targetProduct
            ? _value.targetProduct
            : targetProduct // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        priceSensitivity: null == priceSensitivity
            ? _value.priceSensitivity
            : priceSensitivity // ignore: cast_nullable_to_non_nullable
                  as double,
        brandLoyalty: null == brandLoyalty
            ? _value.brandLoyalty
            : brandLoyalty // ignore: cast_nullable_to_non_nullable
                  as double,
        seasonalPreference: null == seasonalPreference
            ? _value.seasonalPreference
            : seasonalPreference // ignore: cast_nullable_to_non_nullable
                  as double,
        trendInfluence: null == trendInfluence
            ? _value.trendInfluence
            : trendInfluence // ignore: cast_nullable_to_non_nullable
                  as double,
        riskAversion: null == riskAversion
            ? _value.riskAversion
            : riskAversion // ignore: cast_nullable_to_non_nullable
                  as double,
        preferences: null == preferences
            ? _value._preferences
            : preferences // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumerBehaviorAnalysisImpl implements _ConsumerBehaviorAnalysis {
  const _$ConsumerBehaviorAnalysisImpl({
    required this.id,
    required this.playerId,
    required this.targetProduct,
    required this.date,
    this.priceSensitivity = 0.0,
    this.brandLoyalty = 0.0,
    this.seasonalPreference = 0.0,
    this.trendInfluence = 0.0,
    this.riskAversion = 0.0,
    final Map<String, dynamic> preferences = const {},
  }) : _preferences = preferences;

  factory _$ConsumerBehaviorAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumerBehaviorAnalysisImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final String targetProduct;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final double priceSensitivity;
  @override
  @JsonKey()
  final double brandLoyalty;
  @override
  @JsonKey()
  final double seasonalPreference;
  @override
  @JsonKey()
  final double trendInfluence;
  @override
  @JsonKey()
  final double riskAversion;
  final Map<String, dynamic> _preferences;
  @override
  @JsonKey()
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  @override
  String toString() {
    return 'ConsumerBehaviorAnalysis(id: $id, playerId: $playerId, targetProduct: $targetProduct, date: $date, priceSensitivity: $priceSensitivity, brandLoyalty: $brandLoyalty, seasonalPreference: $seasonalPreference, trendInfluence: $trendInfluence, riskAversion: $riskAversion, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumerBehaviorAnalysisImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.targetProduct, targetProduct) ||
                other.targetProduct == targetProduct) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.priceSensitivity, priceSensitivity) ||
                other.priceSensitivity == priceSensitivity) &&
            (identical(other.brandLoyalty, brandLoyalty) ||
                other.brandLoyalty == brandLoyalty) &&
            (identical(other.seasonalPreference, seasonalPreference) ||
                other.seasonalPreference == seasonalPreference) &&
            (identical(other.trendInfluence, trendInfluence) ||
                other.trendInfluence == trendInfluence) &&
            (identical(other.riskAversion, riskAversion) ||
                other.riskAversion == riskAversion) &&
            const DeepCollectionEquality().equals(
              other._preferences,
              _preferences,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    playerId,
    targetProduct,
    date,
    priceSensitivity,
    brandLoyalty,
    seasonalPreference,
    trendInfluence,
    riskAversion,
    const DeepCollectionEquality().hash(_preferences),
  );

  /// Create a copy of ConsumerBehaviorAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumerBehaviorAnalysisImplCopyWith<_$ConsumerBehaviorAnalysisImpl>
  get copyWith =>
      __$$ConsumerBehaviorAnalysisImplCopyWithImpl<
        _$ConsumerBehaviorAnalysisImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumerBehaviorAnalysisImplToJson(this);
  }
}

abstract class _ConsumerBehaviorAnalysis implements ConsumerBehaviorAnalysis {
  const factory _ConsumerBehaviorAnalysis({
    required final String id,
    required final String playerId,
    required final String targetProduct,
    required final DateTime date,
    final double priceSensitivity,
    final double brandLoyalty,
    final double seasonalPreference,
    final double trendInfluence,
    final double riskAversion,
    final Map<String, dynamic> preferences,
  }) = _$ConsumerBehaviorAnalysisImpl;

  factory _ConsumerBehaviorAnalysis.fromJson(Map<String, dynamic> json) =
      _$ConsumerBehaviorAnalysisImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  String get targetProduct;
  @override
  DateTime get date;
  @override
  double get priceSensitivity;
  @override
  double get brandLoyalty;
  @override
  double get seasonalPreference;
  @override
  double get trendInfluence;
  @override
  double get riskAversion;
  @override
  Map<String, dynamic> get preferences;

  /// Create a copy of ConsumerBehaviorAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsumerBehaviorAnalysisImplCopyWith<_$ConsumerBehaviorAnalysisImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ResearchRequest _$ResearchRequestFromJson(Map<String, dynamic> json) {
  return _ResearchRequest.fromJson(json);
}

/// @nodoc
mixin _$ResearchRequest {
  String get playerId => throw _privateConstructorUsedError;
  ResearchType get type => throw _privateConstructorUsedError;
  String get targetProduct => throw _privateConstructorUsedError;
  ResearchQuality get desiredQuality => throw _privateConstructorUsedError;
  bool get useAdvancedTools => throw _privateConstructorUsedError;
  bool get payForExpedited => throw _privateConstructorUsedError;

  /// Serializes this ResearchRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResearchRequestCopyWith<ResearchRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchRequestCopyWith<$Res> {
  factory $ResearchRequestCopyWith(
    ResearchRequest value,
    $Res Function(ResearchRequest) then,
  ) = _$ResearchRequestCopyWithImpl<$Res, ResearchRequest>;
  @useResult
  $Res call({
    String playerId,
    ResearchType type,
    String targetProduct,
    ResearchQuality desiredQuality,
    bool useAdvancedTools,
    bool payForExpedited,
  });
}

/// @nodoc
class _$ResearchRequestCopyWithImpl<$Res, $Val extends ResearchRequest>
    implements $ResearchRequestCopyWith<$Res> {
  _$ResearchRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? type = null,
    Object? targetProduct = null,
    Object? desiredQuality = null,
    Object? useAdvancedTools = null,
    Object? payForExpedited = null,
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
                      as ResearchType,
            targetProduct: null == targetProduct
                ? _value.targetProduct
                : targetProduct // ignore: cast_nullable_to_non_nullable
                      as String,
            desiredQuality: null == desiredQuality
                ? _value.desiredQuality
                : desiredQuality // ignore: cast_nullable_to_non_nullable
                      as ResearchQuality,
            useAdvancedTools: null == useAdvancedTools
                ? _value.useAdvancedTools
                : useAdvancedTools // ignore: cast_nullable_to_non_nullable
                      as bool,
            payForExpedited: null == payForExpedited
                ? _value.payForExpedited
                : payForExpedited // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResearchRequestImplCopyWith<$Res>
    implements $ResearchRequestCopyWith<$Res> {
  factory _$$ResearchRequestImplCopyWith(
    _$ResearchRequestImpl value,
    $Res Function(_$ResearchRequestImpl) then,
  ) = __$$ResearchRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String playerId,
    ResearchType type,
    String targetProduct,
    ResearchQuality desiredQuality,
    bool useAdvancedTools,
    bool payForExpedited,
  });
}

/// @nodoc
class __$$ResearchRequestImplCopyWithImpl<$Res>
    extends _$ResearchRequestCopyWithImpl<$Res, _$ResearchRequestImpl>
    implements _$$ResearchRequestImplCopyWith<$Res> {
  __$$ResearchRequestImplCopyWithImpl(
    _$ResearchRequestImpl _value,
    $Res Function(_$ResearchRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? type = null,
    Object? targetProduct = null,
    Object? desiredQuality = null,
    Object? useAdvancedTools = null,
    Object? payForExpedited = null,
  }) {
    return _then(
      _$ResearchRequestImpl(
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ResearchType,
        targetProduct: null == targetProduct
            ? _value.targetProduct
            : targetProduct // ignore: cast_nullable_to_non_nullable
                  as String,
        desiredQuality: null == desiredQuality
            ? _value.desiredQuality
            : desiredQuality // ignore: cast_nullable_to_non_nullable
                  as ResearchQuality,
        useAdvancedTools: null == useAdvancedTools
            ? _value.useAdvancedTools
            : useAdvancedTools // ignore: cast_nullable_to_non_nullable
                  as bool,
        payForExpedited: null == payForExpedited
            ? _value.payForExpedited
            : payForExpedited // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchRequestImpl implements _ResearchRequest {
  const _$ResearchRequestImpl({
    required this.playerId,
    required this.type,
    required this.targetProduct,
    this.desiredQuality = ResearchQuality.standard,
    this.useAdvancedTools = false,
    this.payForExpedited = false,
  });

  factory _$ResearchRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchRequestImplFromJson(json);

  @override
  final String playerId;
  @override
  final ResearchType type;
  @override
  final String targetProduct;
  @override
  @JsonKey()
  final ResearchQuality desiredQuality;
  @override
  @JsonKey()
  final bool useAdvancedTools;
  @override
  @JsonKey()
  final bool payForExpedited;

  @override
  String toString() {
    return 'ResearchRequest(playerId: $playerId, type: $type, targetProduct: $targetProduct, desiredQuality: $desiredQuality, useAdvancedTools: $useAdvancedTools, payForExpedited: $payForExpedited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchRequestImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetProduct, targetProduct) ||
                other.targetProduct == targetProduct) &&
            (identical(other.desiredQuality, desiredQuality) ||
                other.desiredQuality == desiredQuality) &&
            (identical(other.useAdvancedTools, useAdvancedTools) ||
                other.useAdvancedTools == useAdvancedTools) &&
            (identical(other.payForExpedited, payForExpedited) ||
                other.payForExpedited == payForExpedited));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    playerId,
    type,
    targetProduct,
    desiredQuality,
    useAdvancedTools,
    payForExpedited,
  );

  /// Create a copy of ResearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchRequestImplCopyWith<_$ResearchRequestImpl> get copyWith =>
      __$$ResearchRequestImplCopyWithImpl<_$ResearchRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ResearchRequestImplToJson(this);
  }
}

abstract class _ResearchRequest implements ResearchRequest {
  const factory _ResearchRequest({
    required final String playerId,
    required final ResearchType type,
    required final String targetProduct,
    final ResearchQuality desiredQuality,
    final bool useAdvancedTools,
    final bool payForExpedited,
  }) = _$ResearchRequestImpl;

  factory _ResearchRequest.fromJson(Map<String, dynamic> json) =
      _$ResearchRequestImpl.fromJson;

  @override
  String get playerId;
  @override
  ResearchType get type;
  @override
  String get targetProduct;
  @override
  ResearchQuality get desiredQuality;
  @override
  bool get useAdvancedTools;
  @override
  bool get payForExpedited;

  /// Create a copy of ResearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResearchRequestImplCopyWith<_$ResearchRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
