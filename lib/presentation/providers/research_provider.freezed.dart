// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'research_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ResearchState {
  List<ResearchNode> get researchTree => throw _privateConstructorUsedError;
  Player get player => throw _privateConstructorUsedError;

  /// Create a copy of ResearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResearchStateCopyWith<ResearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchStateCopyWith<$Res> {
  factory $ResearchStateCopyWith(
    ResearchState value,
    $Res Function(ResearchState) then,
  ) = _$ResearchStateCopyWithImpl<$Res, ResearchState>;
  @useResult
  $Res call({List<ResearchNode> researchTree, Player player});

  $PlayerCopyWith<$Res> get player;
}

/// @nodoc
class _$ResearchStateCopyWithImpl<$Res, $Val extends ResearchState>
    implements $ResearchStateCopyWith<$Res> {
  _$ResearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? researchTree = null, Object? player = null}) {
    return _then(
      _value.copyWith(
            researchTree: null == researchTree
                ? _value.researchTree
                : researchTree // ignore: cast_nullable_to_non_nullable
                      as List<ResearchNode>,
            player: null == player
                ? _value.player
                : player // ignore: cast_nullable_to_non_nullable
                      as Player,
          )
          as $Val,
    );
  }

  /// Create a copy of ResearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get player {
    return $PlayerCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResearchStateImplCopyWith<$Res>
    implements $ResearchStateCopyWith<$Res> {
  factory _$$ResearchStateImplCopyWith(
    _$ResearchStateImpl value,
    $Res Function(_$ResearchStateImpl) then,
  ) = __$$ResearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ResearchNode> researchTree, Player player});

  @override
  $PlayerCopyWith<$Res> get player;
}

/// @nodoc
class __$$ResearchStateImplCopyWithImpl<$Res>
    extends _$ResearchStateCopyWithImpl<$Res, _$ResearchStateImpl>
    implements _$$ResearchStateImplCopyWith<$Res> {
  __$$ResearchStateImplCopyWithImpl(
    _$ResearchStateImpl _value,
    $Res Function(_$ResearchStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? researchTree = null, Object? player = null}) {
    return _then(
      _$ResearchStateImpl(
        researchTree: null == researchTree
            ? _value._researchTree
            : researchTree // ignore: cast_nullable_to_non_nullable
                  as List<ResearchNode>,
        player: null == player
            ? _value.player
            : player // ignore: cast_nullable_to_non_nullable
                  as Player,
      ),
    );
  }
}

/// @nodoc

class _$ResearchStateImpl extends _ResearchState {
  const _$ResearchStateImpl({
    required final List<ResearchNode> researchTree,
    required this.player,
  }) : _researchTree = researchTree,
       super._();

  final List<ResearchNode> _researchTree;
  @override
  List<ResearchNode> get researchTree {
    if (_researchTree is EqualUnmodifiableListView) return _researchTree;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_researchTree);
  }

  @override
  final Player player;

  @override
  String toString() {
    return 'ResearchState(researchTree: $researchTree, player: $player)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchStateImpl &&
            const DeepCollectionEquality().equals(
              other._researchTree,
              _researchTree,
            ) &&
            (identical(other.player, player) || other.player == player));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_researchTree),
    player,
  );

  /// Create a copy of ResearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchStateImplCopyWith<_$ResearchStateImpl> get copyWith =>
      __$$ResearchStateImplCopyWithImpl<_$ResearchStateImpl>(this, _$identity);
}

abstract class _ResearchState extends ResearchState {
  const factory _ResearchState({
    required final List<ResearchNode> researchTree,
    required final Player player,
  }) = _$ResearchStateImpl;
  const _ResearchState._() : super._();

  @override
  List<ResearchNode> get researchTree;
  @override
  Player get player;

  /// Create a copy of ResearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResearchStateImplCopyWith<_$ResearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
