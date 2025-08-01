// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recording_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecordingState _$RecordingStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'idle':
      return _Idle.fromJson(json);
    case 'recording':
      return _Recording.fromJson(json);
    case 'playing':
      return _Playing.fromJson(json);
    case 'paused':
      return _Paused.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'RecordingState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$RecordingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() playing,
    required TResult Function() paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? playing,
    TResult? Function()? paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? playing,
    TResult Function()? paused,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Recording value) recording,
    required TResult Function(_Playing value) playing,
    required TResult Function(_Paused value) paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Recording value)? recording,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_Paused value)? paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Recording value)? recording,
    TResult Function(_Playing value)? playing,
    TResult Function(_Paused value)? paused,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this RecordingState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingStateCopyWith<$Res> {
  factory $RecordingStateCopyWith(
          RecordingState value, $Res Function(RecordingState) then) =
      _$RecordingStateCopyWithImpl<$Res, RecordingState>;
}

/// @nodoc
class _$RecordingStateCopyWithImpl<$Res, $Val extends RecordingState>
    implements $RecordingStateCopyWith<$Res> {
  _$RecordingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl value, $Res Function(_$IdleImpl) then) =
      __$$IdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$RecordingStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$IdleImpl implements _Idle {
  const _$IdleImpl({final String? $type}) : $type = $type ?? 'idle';

  factory _$IdleImpl.fromJson(Map<String, dynamic> json) =>
      _$$IdleImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RecordingState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() playing,
    required TResult Function() paused,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? playing,
    TResult? Function()? paused,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? playing,
    TResult Function()? paused,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Recording value) recording,
    required TResult Function(_Playing value) playing,
    required TResult Function(_Paused value) paused,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Recording value)? recording,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_Paused value)? paused,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Recording value)? recording,
    TResult Function(_Playing value)? playing,
    TResult Function(_Paused value)? paused,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$IdleImplToJson(
      this,
    );
  }
}

abstract class _Idle implements RecordingState {
  const factory _Idle() = _$IdleImpl;

  factory _Idle.fromJson(Map<String, dynamic> json) = _$IdleImpl.fromJson;
}

/// @nodoc
abstract class _$$RecordingImplCopyWith<$Res> {
  factory _$$RecordingImplCopyWith(
          _$RecordingImpl value, $Res Function(_$RecordingImpl) then) =
      __$$RecordingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RecordingImplCopyWithImpl<$Res>
    extends _$RecordingStateCopyWithImpl<$Res, _$RecordingImpl>
    implements _$$RecordingImplCopyWith<$Res> {
  __$$RecordingImplCopyWithImpl(
      _$RecordingImpl _value, $Res Function(_$RecordingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$RecordingImpl implements _Recording {
  const _$RecordingImpl({final String? $type}) : $type = $type ?? 'recording';

  factory _$RecordingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordingImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RecordingState.recording()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RecordingImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() playing,
    required TResult Function() paused,
  }) {
    return recording();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? playing,
    TResult? Function()? paused,
  }) {
    return recording?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? playing,
    TResult Function()? paused,
    required TResult orElse(),
  }) {
    if (recording != null) {
      return recording();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Recording value) recording,
    required TResult Function(_Playing value) playing,
    required TResult Function(_Paused value) paused,
  }) {
    return recording(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Recording value)? recording,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_Paused value)? paused,
  }) {
    return recording?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Recording value)? recording,
    TResult Function(_Playing value)? playing,
    TResult Function(_Paused value)? paused,
    required TResult orElse(),
  }) {
    if (recording != null) {
      return recording(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordingImplToJson(
      this,
    );
  }
}

abstract class _Recording implements RecordingState {
  const factory _Recording() = _$RecordingImpl;

  factory _Recording.fromJson(Map<String, dynamic> json) =
      _$RecordingImpl.fromJson;
}

/// @nodoc
abstract class _$$PlayingImplCopyWith<$Res> {
  factory _$$PlayingImplCopyWith(
          _$PlayingImpl value, $Res Function(_$PlayingImpl) then) =
      __$$PlayingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayingImplCopyWithImpl<$Res>
    extends _$RecordingStateCopyWithImpl<$Res, _$PlayingImpl>
    implements _$$PlayingImplCopyWith<$Res> {
  __$$PlayingImplCopyWithImpl(
      _$PlayingImpl _value, $Res Function(_$PlayingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$PlayingImpl implements _Playing {
  const _$PlayingImpl({final String? $type}) : $type = $type ?? 'playing';

  factory _$PlayingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayingImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RecordingState.playing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PlayingImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() playing,
    required TResult Function() paused,
  }) {
    return playing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? playing,
    TResult? Function()? paused,
  }) {
    return playing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? playing,
    TResult Function()? paused,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Recording value) recording,
    required TResult Function(_Playing value) playing,
    required TResult Function(_Paused value) paused,
  }) {
    return playing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Recording value)? recording,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_Paused value)? paused,
  }) {
    return playing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Recording value)? recording,
    TResult Function(_Playing value)? playing,
    TResult Function(_Paused value)? paused,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayingImplToJson(
      this,
    );
  }
}

abstract class _Playing implements RecordingState {
  const factory _Playing() = _$PlayingImpl;

  factory _Playing.fromJson(Map<String, dynamic> json) = _$PlayingImpl.fromJson;
}

/// @nodoc
abstract class _$$PausedImplCopyWith<$Res> {
  factory _$$PausedImplCopyWith(
          _$PausedImpl value, $Res Function(_$PausedImpl) then) =
      __$$PausedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PausedImplCopyWithImpl<$Res>
    extends _$RecordingStateCopyWithImpl<$Res, _$PausedImpl>
    implements _$$PausedImplCopyWith<$Res> {
  __$$PausedImplCopyWithImpl(
      _$PausedImpl _value, $Res Function(_$PausedImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$PausedImpl implements _Paused {
  const _$PausedImpl({final String? $type}) : $type = $type ?? 'paused';

  factory _$PausedImpl.fromJson(Map<String, dynamic> json) =>
      _$$PausedImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RecordingState.paused()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PausedImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() playing,
    required TResult Function() paused,
  }) {
    return paused();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? playing,
    TResult? Function()? paused,
  }) {
    return paused?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? playing,
    TResult Function()? paused,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Recording value) recording,
    required TResult Function(_Playing value) playing,
    required TResult Function(_Paused value) paused,
  }) {
    return paused(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Recording value)? recording,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_Paused value)? paused,
  }) {
    return paused?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Recording value)? recording,
    TResult Function(_Playing value)? playing,
    TResult Function(_Paused value)? paused,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PausedImplToJson(
      this,
    );
  }
}

abstract class _Paused implements RecordingState {
  const factory _Paused() = _$PausedImpl;

  factory _Paused.fromJson(Map<String, dynamic> json) = _$PausedImpl.fromJson;
}
