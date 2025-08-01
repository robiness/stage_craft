// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StateFrame _$StateFrameFromJson(Map<String, dynamic> json) {
  return _StateFrame.fromJson(json);
}

/// @nodoc
mixin _$StateFrame {
  /// Timestamp relative to recording start.
  ///
  /// This represents when in the recording timeline this state was captured.
  /// Used for precise playback timing - the difference between frame timestamps
  /// determines the delay before applying the next frame.
  ///
  /// Timeline examples:
  /// - Duration.zero: Initial state (captured when recording starts)
  /// - Duration(seconds: 2): State captured 2 seconds into recording
  /// - Duration(milliseconds: 750): State captured 0.75 seconds into recording
  ///
  /// During playback, frames are applied in timestamp order with calculated
  /// delays between them to maintain original interaction timing.
  Duration get timestamp => throw _privateConstructorUsedError;

  /// Map of control labels to their serialized values.
  ///
  /// Keys are the control.label values from ValueControl instances.
  /// Values are the serialized control values, with complex Flutter types
  /// stored as Maps with type information for safe deserialization.
  ///
  /// Serialization examples:
  /// - Primitive types: 'size': 150.0, 'enabled': true, 'name': 'text'
  /// - Color: 'color': {'type': 'Color', 'value': 0xFFFF0000}
  /// - DateTime: 'date': {'type': 'DateTime', 'value': '2024-01-01T10:00:00.000Z'}
  /// - Duration: 'delay': {'type': 'Duration', 'value': 5000000} // microseconds
  /// - Offset: 'position': {'type': 'Offset', 'dx': 10.0, 'dy': 20.0}
  /// - Size: 'bounds': {'type': 'Size', 'width': 100.0, 'height': 200.0}
  ///
  /// This design enables:
  /// 1. Type-safe deserialization during playback
  /// 2. Extension to new control types without breaking existing data
  /// 3. JSON serialization for persistence and sharing
  /// 4. Human-readable debugging of recorded scenarios
  ///
  /// Empty map is valid and represents a scenario with no controls.
  Map<String, dynamic> get controlValues => throw _privateConstructorUsedError;

  /// Canvas state including zoom, pan, and UI configuration.
  ///
  /// Captures the complete visual state of the stage canvas for accurate
  /// playback reproduction. When applied during playback, the canvas view
  /// will be restored to exactly match the recorded state.
  ///
  /// Standard canvas state structure:
  /// ```dart
  /// canvasState: {
  ///   // Visual state
  ///   'zoom': 1.5,              // Zoom level (1.0 = 100%, 2.0 = 200%)
  ///   'panX': 100.0,            // Pan offset X in logical pixels
  ///   'panY': -50.0,            // Pan offset Y in logical pixels
  ///
  ///   // UI toggles
  ///   'showRulers': true,       // Whether rulers are visible
  ///   'showCrosshair': false,   // Whether crosshair overlay is visible
  ///   'showGrid': true,         // Whether background grid is visible
  ///
  ///   // Configuration
  ///   'gridSpacing': 20.0,      // Grid spacing in logical pixels
  ///   'textScaling': 1.2,       // Text scaling factor for accessibility
  ///   'rulerOriginX': 0.0,      // Ruler origin point X (if configurable)
  ///   'rulerOriginY': 0.0,      // Ruler origin point Y (if configurable)
  /// }
  /// ```
  ///
  /// Null when no canvas controller was present during capture.
  /// This occurs in:
  /// - Preview mode without canvas features
  /// - Simplified widget testing scenarios
  /// - Controls-only recordings
  ///
  /// During playback, null canvasState is safely ignored, allowing
  /// the same StateFrame to work in both canvas and non-canvas environments.
  Map<String, dynamic>? get canvasState => throw _privateConstructorUsedError;

  /// Serializes this StateFrame to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StateFrame
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StateFrameCopyWith<StateFrame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StateFrameCopyWith<$Res> {
  factory $StateFrameCopyWith(
          StateFrame value, $Res Function(StateFrame) then) =
      _$StateFrameCopyWithImpl<$Res, StateFrame>;
  @useResult
  $Res call(
      {Duration timestamp,
      Map<String, dynamic> controlValues,
      Map<String, dynamic>? canvasState});
}

/// @nodoc
class _$StateFrameCopyWithImpl<$Res, $Val extends StateFrame>
    implements $StateFrameCopyWith<$Res> {
  _$StateFrameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StateFrame
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? controlValues = null,
    Object? canvasState = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Duration,
      controlValues: null == controlValues
          ? _value.controlValues
          : controlValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      canvasState: freezed == canvasState
          ? _value.canvasState
          : canvasState // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StateFrameImplCopyWith<$Res>
    implements $StateFrameCopyWith<$Res> {
  factory _$$StateFrameImplCopyWith(
          _$StateFrameImpl value, $Res Function(_$StateFrameImpl) then) =
      __$$StateFrameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration timestamp,
      Map<String, dynamic> controlValues,
      Map<String, dynamic>? canvasState});
}

/// @nodoc
class __$$StateFrameImplCopyWithImpl<$Res>
    extends _$StateFrameCopyWithImpl<$Res, _$StateFrameImpl>
    implements _$$StateFrameImplCopyWith<$Res> {
  __$$StateFrameImplCopyWithImpl(
      _$StateFrameImpl _value, $Res Function(_$StateFrameImpl) _then)
      : super(_value, _then);

  /// Create a copy of StateFrame
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? controlValues = null,
    Object? canvasState = freezed,
  }) {
    return _then(_$StateFrameImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Duration,
      controlValues: null == controlValues
          ? _value._controlValues
          : controlValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      canvasState: freezed == canvasState
          ? _value._canvasState
          : canvasState // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StateFrameImpl implements _StateFrame {
  const _$StateFrameImpl(
      {required this.timestamp,
      required final Map<String, dynamic> controlValues,
      final Map<String, dynamic>? canvasState})
      : _controlValues = controlValues,
        _canvasState = canvasState;

  factory _$StateFrameImpl.fromJson(Map<String, dynamic> json) =>
      _$$StateFrameImplFromJson(json);

  /// Timestamp relative to recording start.
  ///
  /// This represents when in the recording timeline this state was captured.
  /// Used for precise playback timing - the difference between frame timestamps
  /// determines the delay before applying the next frame.
  ///
  /// Timeline examples:
  /// - Duration.zero: Initial state (captured when recording starts)
  /// - Duration(seconds: 2): State captured 2 seconds into recording
  /// - Duration(milliseconds: 750): State captured 0.75 seconds into recording
  ///
  /// During playback, frames are applied in timestamp order with calculated
  /// delays between them to maintain original interaction timing.
  @override
  final Duration timestamp;

  /// Map of control labels to their serialized values.
  ///
  /// Keys are the control.label values from ValueControl instances.
  /// Values are the serialized control values, with complex Flutter types
  /// stored as Maps with type information for safe deserialization.
  ///
  /// Serialization examples:
  /// - Primitive types: 'size': 150.0, 'enabled': true, 'name': 'text'
  /// - Color: 'color': {'type': 'Color', 'value': 0xFFFF0000}
  /// - DateTime: 'date': {'type': 'DateTime', 'value': '2024-01-01T10:00:00.000Z'}
  /// - Duration: 'delay': {'type': 'Duration', 'value': 5000000} // microseconds
  /// - Offset: 'position': {'type': 'Offset', 'dx': 10.0, 'dy': 20.0}
  /// - Size: 'bounds': {'type': 'Size', 'width': 100.0, 'height': 200.0}
  ///
  /// This design enables:
  /// 1. Type-safe deserialization during playback
  /// 2. Extension to new control types without breaking existing data
  /// 3. JSON serialization for persistence and sharing
  /// 4. Human-readable debugging of recorded scenarios
  ///
  /// Empty map is valid and represents a scenario with no controls.
  final Map<String, dynamic> _controlValues;

  /// Map of control labels to their serialized values.
  ///
  /// Keys are the control.label values from ValueControl instances.
  /// Values are the serialized control values, with complex Flutter types
  /// stored as Maps with type information for safe deserialization.
  ///
  /// Serialization examples:
  /// - Primitive types: 'size': 150.0, 'enabled': true, 'name': 'text'
  /// - Color: 'color': {'type': 'Color', 'value': 0xFFFF0000}
  /// - DateTime: 'date': {'type': 'DateTime', 'value': '2024-01-01T10:00:00.000Z'}
  /// - Duration: 'delay': {'type': 'Duration', 'value': 5000000} // microseconds
  /// - Offset: 'position': {'type': 'Offset', 'dx': 10.0, 'dy': 20.0}
  /// - Size: 'bounds': {'type': 'Size', 'width': 100.0, 'height': 200.0}
  ///
  /// This design enables:
  /// 1. Type-safe deserialization during playback
  /// 2. Extension to new control types without breaking existing data
  /// 3. JSON serialization for persistence and sharing
  /// 4. Human-readable debugging of recorded scenarios
  ///
  /// Empty map is valid and represents a scenario with no controls.
  @override
  Map<String, dynamic> get controlValues {
    if (_controlValues is EqualUnmodifiableMapView) return _controlValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_controlValues);
  }

  /// Canvas state including zoom, pan, and UI configuration.
  ///
  /// Captures the complete visual state of the stage canvas for accurate
  /// playback reproduction. When applied during playback, the canvas view
  /// will be restored to exactly match the recorded state.
  ///
  /// Standard canvas state structure:
  /// ```dart
  /// canvasState: {
  ///   // Visual state
  ///   'zoom': 1.5,              // Zoom level (1.0 = 100%, 2.0 = 200%)
  ///   'panX': 100.0,            // Pan offset X in logical pixels
  ///   'panY': -50.0,            // Pan offset Y in logical pixels
  ///
  ///   // UI toggles
  ///   'showRulers': true,       // Whether rulers are visible
  ///   'showCrosshair': false,   // Whether crosshair overlay is visible
  ///   'showGrid': true,         // Whether background grid is visible
  ///
  ///   // Configuration
  ///   'gridSpacing': 20.0,      // Grid spacing in logical pixels
  ///   'textScaling': 1.2,       // Text scaling factor for accessibility
  ///   'rulerOriginX': 0.0,      // Ruler origin point X (if configurable)
  ///   'rulerOriginY': 0.0,      // Ruler origin point Y (if configurable)
  /// }
  /// ```
  ///
  /// Null when no canvas controller was present during capture.
  /// This occurs in:
  /// - Preview mode without canvas features
  /// - Simplified widget testing scenarios
  /// - Controls-only recordings
  ///
  /// During playback, null canvasState is safely ignored, allowing
  /// the same StateFrame to work in both canvas and non-canvas environments.
  final Map<String, dynamic>? _canvasState;

  /// Canvas state including zoom, pan, and UI configuration.
  ///
  /// Captures the complete visual state of the stage canvas for accurate
  /// playback reproduction. When applied during playback, the canvas view
  /// will be restored to exactly match the recorded state.
  ///
  /// Standard canvas state structure:
  /// ```dart
  /// canvasState: {
  ///   // Visual state
  ///   'zoom': 1.5,              // Zoom level (1.0 = 100%, 2.0 = 200%)
  ///   'panX': 100.0,            // Pan offset X in logical pixels
  ///   'panY': -50.0,            // Pan offset Y in logical pixels
  ///
  ///   // UI toggles
  ///   'showRulers': true,       // Whether rulers are visible
  ///   'showCrosshair': false,   // Whether crosshair overlay is visible
  ///   'showGrid': true,         // Whether background grid is visible
  ///
  ///   // Configuration
  ///   'gridSpacing': 20.0,      // Grid spacing in logical pixels
  ///   'textScaling': 1.2,       // Text scaling factor for accessibility
  ///   'rulerOriginX': 0.0,      // Ruler origin point X (if configurable)
  ///   'rulerOriginY': 0.0,      // Ruler origin point Y (if configurable)
  /// }
  /// ```
  ///
  /// Null when no canvas controller was present during capture.
  /// This occurs in:
  /// - Preview mode without canvas features
  /// - Simplified widget testing scenarios
  /// - Controls-only recordings
  ///
  /// During playback, null canvasState is safely ignored, allowing
  /// the same StateFrame to work in both canvas and non-canvas environments.
  @override
  Map<String, dynamic>? get canvasState {
    final value = _canvasState;
    if (value == null) return null;
    if (_canvasState is EqualUnmodifiableMapView) return _canvasState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'StateFrame(timestamp: $timestamp, controlValues: $controlValues, canvasState: $canvasState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateFrameImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._controlValues, _controlValues) &&
            const DeepCollectionEquality()
                .equals(other._canvasState, _canvasState));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      timestamp,
      const DeepCollectionEquality().hash(_controlValues),
      const DeepCollectionEquality().hash(_canvasState));

  /// Create a copy of StateFrame
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StateFrameImplCopyWith<_$StateFrameImpl> get copyWith =>
      __$$StateFrameImplCopyWithImpl<_$StateFrameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StateFrameImplToJson(
      this,
    );
  }
}

abstract class _StateFrame implements StateFrame {
  const factory _StateFrame(
      {required final Duration timestamp,
      required final Map<String, dynamic> controlValues,
      final Map<String, dynamic>? canvasState}) = _$StateFrameImpl;

  factory _StateFrame.fromJson(Map<String, dynamic> json) =
      _$StateFrameImpl.fromJson;

  /// Timestamp relative to recording start.
  ///
  /// This represents when in the recording timeline this state was captured.
  /// Used for precise playback timing - the difference between frame timestamps
  /// determines the delay before applying the next frame.
  ///
  /// Timeline examples:
  /// - Duration.zero: Initial state (captured when recording starts)
  /// - Duration(seconds: 2): State captured 2 seconds into recording
  /// - Duration(milliseconds: 750): State captured 0.75 seconds into recording
  ///
  /// During playback, frames are applied in timestamp order with calculated
  /// delays between them to maintain original interaction timing.
  @override
  Duration get timestamp;

  /// Map of control labels to their serialized values.
  ///
  /// Keys are the control.label values from ValueControl instances.
  /// Values are the serialized control values, with complex Flutter types
  /// stored as Maps with type information for safe deserialization.
  ///
  /// Serialization examples:
  /// - Primitive types: 'size': 150.0, 'enabled': true, 'name': 'text'
  /// - Color: 'color': {'type': 'Color', 'value': 0xFFFF0000}
  /// - DateTime: 'date': {'type': 'DateTime', 'value': '2024-01-01T10:00:00.000Z'}
  /// - Duration: 'delay': {'type': 'Duration', 'value': 5000000} // microseconds
  /// - Offset: 'position': {'type': 'Offset', 'dx': 10.0, 'dy': 20.0}
  /// - Size: 'bounds': {'type': 'Size', 'width': 100.0, 'height': 200.0}
  ///
  /// This design enables:
  /// 1. Type-safe deserialization during playback
  /// 2. Extension to new control types without breaking existing data
  /// 3. JSON serialization for persistence and sharing
  /// 4. Human-readable debugging of recorded scenarios
  ///
  /// Empty map is valid and represents a scenario with no controls.
  @override
  Map<String, dynamic> get controlValues;

  /// Canvas state including zoom, pan, and UI configuration.
  ///
  /// Captures the complete visual state of the stage canvas for accurate
  /// playback reproduction. When applied during playback, the canvas view
  /// will be restored to exactly match the recorded state.
  ///
  /// Standard canvas state structure:
  /// ```dart
  /// canvasState: {
  ///   // Visual state
  ///   'zoom': 1.5,              // Zoom level (1.0 = 100%, 2.0 = 200%)
  ///   'panX': 100.0,            // Pan offset X in logical pixels
  ///   'panY': -50.0,            // Pan offset Y in logical pixels
  ///
  ///   // UI toggles
  ///   'showRulers': true,       // Whether rulers are visible
  ///   'showCrosshair': false,   // Whether crosshair overlay is visible
  ///   'showGrid': true,         // Whether background grid is visible
  ///
  ///   // Configuration
  ///   'gridSpacing': 20.0,      // Grid spacing in logical pixels
  ///   'textScaling': 1.2,       // Text scaling factor for accessibility
  ///   'rulerOriginX': 0.0,      // Ruler origin point X (if configurable)
  ///   'rulerOriginY': 0.0,      // Ruler origin point Y (if configurable)
  /// }
  /// ```
  ///
  /// Null when no canvas controller was present during capture.
  /// This occurs in:
  /// - Preview mode without canvas features
  /// - Simplified widget testing scenarios
  /// - Controls-only recordings
  ///
  /// During playback, null canvasState is safely ignored, allowing
  /// the same StateFrame to work in both canvas and non-canvas environments.
  @override
  Map<String, dynamic>? get canvasState;

  /// Create a copy of StateFrame
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StateFrameImplCopyWith<_$StateFrameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
