// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drawing_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DrawingFrame _$DrawingFrameFromJson(Map<String, dynamic> json) {
  return _DrawingFrame.fromJson(json);
}

/// @nodoc
mixin _$DrawingFrame {
  /// Timestamp relative to recording start.
  ///
  /// Synchronized with StateFrame timestamps to enable correlation between
  /// UI state changes and resulting drawing operations.
  ///
  /// During testing, DrawingFrames are matched with StateFrames by timestamp
  /// to verify that a given UI state produces the expected drawing output.
  ///
  /// Example timeline correlation:
  /// - StateFrame at t=1.5s: Sets color to red, size to 100px
  /// - DrawingFrame at t=1.5s: Shows red rectangle at 100px size
  Duration get timestamp => throw _privateConstructorUsedError;

  /// Complete set of drawing commands executed during this frame.
  ///
  /// Contains all paint operations that were intercepted during widget
  /// rendering, including shapes, text, images, and complex paths.
  ///
  /// These commands represent the exact visual output of the widget
  /// and can be compared against future runs to detect visual changes.
  DrawingCommands get commands => throw _privateConstructorUsedError;

  /// Serializes this DrawingFrame to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DrawingFrame
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrawingFrameCopyWith<DrawingFrame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawingFrameCopyWith<$Res> {
  factory $DrawingFrameCopyWith(
          DrawingFrame value, $Res Function(DrawingFrame) then) =
      _$DrawingFrameCopyWithImpl<$Res, DrawingFrame>;
  @useResult
  $Res call({Duration timestamp, DrawingCommands commands});

  $DrawingCommandsCopyWith<$Res> get commands;
}

/// @nodoc
class _$DrawingFrameCopyWithImpl<$Res, $Val extends DrawingFrame>
    implements $DrawingFrameCopyWith<$Res> {
  _$DrawingFrameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrawingFrame
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? commands = null,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Duration,
      commands: null == commands
          ? _value.commands
          : commands // ignore: cast_nullable_to_non_nullable
              as DrawingCommands,
    ) as $Val);
  }

  /// Create a copy of DrawingFrame
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DrawingCommandsCopyWith<$Res> get commands {
    return $DrawingCommandsCopyWith<$Res>(_value.commands, (value) {
      return _then(_value.copyWith(commands: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DrawingFrameImplCopyWith<$Res>
    implements $DrawingFrameCopyWith<$Res> {
  factory _$$DrawingFrameImplCopyWith(
          _$DrawingFrameImpl value, $Res Function(_$DrawingFrameImpl) then) =
      __$$DrawingFrameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration timestamp, DrawingCommands commands});

  @override
  $DrawingCommandsCopyWith<$Res> get commands;
}

/// @nodoc
class __$$DrawingFrameImplCopyWithImpl<$Res>
    extends _$DrawingFrameCopyWithImpl<$Res, _$DrawingFrameImpl>
    implements _$$DrawingFrameImplCopyWith<$Res> {
  __$$DrawingFrameImplCopyWithImpl(
      _$DrawingFrameImpl _value, $Res Function(_$DrawingFrameImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingFrame
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? commands = null,
  }) {
    return _then(_$DrawingFrameImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Duration,
      commands: null == commands
          ? _value.commands
          : commands // ignore: cast_nullable_to_non_nullable
              as DrawingCommands,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawingFrameImpl implements _DrawingFrame {
  const _$DrawingFrameImpl({required this.timestamp, required this.commands});

  factory _$DrawingFrameImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawingFrameImplFromJson(json);

  /// Timestamp relative to recording start.
  ///
  /// Synchronized with StateFrame timestamps to enable correlation between
  /// UI state changes and resulting drawing operations.
  ///
  /// During testing, DrawingFrames are matched with StateFrames by timestamp
  /// to verify that a given UI state produces the expected drawing output.
  ///
  /// Example timeline correlation:
  /// - StateFrame at t=1.5s: Sets color to red, size to 100px
  /// - DrawingFrame at t=1.5s: Shows red rectangle at 100px size
  @override
  final Duration timestamp;

  /// Complete set of drawing commands executed during this frame.
  ///
  /// Contains all paint operations that were intercepted during widget
  /// rendering, including shapes, text, images, and complex paths.
  ///
  /// These commands represent the exact visual output of the widget
  /// and can be compared against future runs to detect visual changes.
  @override
  final DrawingCommands commands;

  @override
  String toString() {
    return 'DrawingFrame(timestamp: $timestamp, commands: $commands)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawingFrameImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.commands, commands) ||
                other.commands == commands));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, commands);

  /// Create a copy of DrawingFrame
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawingFrameImplCopyWith<_$DrawingFrameImpl> get copyWith =>
      __$$DrawingFrameImplCopyWithImpl<_$DrawingFrameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawingFrameImplToJson(
      this,
    );
  }
}

abstract class _DrawingFrame implements DrawingFrame {
  const factory _DrawingFrame(
      {required final Duration timestamp,
      required final DrawingCommands commands}) = _$DrawingFrameImpl;

  factory _DrawingFrame.fromJson(Map<String, dynamic> json) =
      _$DrawingFrameImpl.fromJson;

  /// Timestamp relative to recording start.
  ///
  /// Synchronized with StateFrame timestamps to enable correlation between
  /// UI state changes and resulting drawing operations.
  ///
  /// During testing, DrawingFrames are matched with StateFrames by timestamp
  /// to verify that a given UI state produces the expected drawing output.
  ///
  /// Example timeline correlation:
  /// - StateFrame at t=1.5s: Sets color to red, size to 100px
  /// - DrawingFrame at t=1.5s: Shows red rectangle at 100px size
  @override
  Duration get timestamp;

  /// Complete set of drawing commands executed during this frame.
  ///
  /// Contains all paint operations that were intercepted during widget
  /// rendering, including shapes, text, images, and complex paths.
  ///
  /// These commands represent the exact visual output of the widget
  /// and can be compared against future runs to detect visual changes.
  @override
  DrawingCommands get commands;

  /// Create a copy of DrawingFrame
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawingFrameImplCopyWith<_$DrawingFrameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DrawingCommands _$DrawingCommandsFromJson(Map<String, dynamic> json) {
  return _DrawingCommands.fromJson(json);
}

/// @nodoc
mixin _$DrawingCommands {
  /// Ordered list of drawing operations executed on the canvas.
  ///
  /// Operations are stored in execution order, which is critical for
  /// accurate visual comparison. Each operation represents a single
  /// paint call (drawRect, drawPath, drawText, etc.).
  ///
  /// Empty list is valid and represents a frame where no drawing occurred
  /// (e.g., completely transparent or clipped widget).
  List<DrawingOperation> get operations => throw _privateConstructorUsedError;

  /// Size of the canvas during drawing.
  ///
  /// Represents the available drawing area. Important for testing because
  /// the same widget might draw differently on canvases of different sizes
  /// due to responsive layout or clipping.
  ///
  /// Stored as a map with 'width' and 'height' keys for JSON serialization.
  /// Null when canvas size information is not available or not relevant.
  @JsonKey(fromJson: _sizeFromJson, toJson: _sizeToJson)
  Map<String, double>? get canvasSize => throw _privateConstructorUsedError;

  /// Clipping bounds applied during drawing.
  ///
  /// Many widgets apply clipping to constrain drawing to specific areas.
  /// This information is crucial for accurate visual comparison since
  /// the same drawing operations might produce different results with
  /// different clip bounds.
  ///
  /// Stored as a map with 'left', 'top', 'right', 'bottom' keys for JSON serialization.
  /// Null when no clipping was applied or clip information is unavailable.
  @JsonKey(fromJson: _rectFromJson, toJson: _rectToJson)
  Map<String, double>? get clipBounds => throw _privateConstructorUsedError;

  /// Additional drawing context metadata.
  ///
  /// Flexible map for storing drawing-related context that might affect
  /// visual output:
  /// - Device pixel ratio
  /// - Platform-specific rendering hints
  /// - Coordinate system transformations
  /// - Custom rendering properties
  ///
  /// Empty map when no additional context is available.
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this DrawingCommands to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DrawingCommands
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrawingCommandsCopyWith<DrawingCommands> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawingCommandsCopyWith<$Res> {
  factory $DrawingCommandsCopyWith(
          DrawingCommands value, $Res Function(DrawingCommands) then) =
      _$DrawingCommandsCopyWithImpl<$Res, DrawingCommands>;
  @useResult
  $Res call(
      {List<DrawingOperation> operations,
      @JsonKey(fromJson: _sizeFromJson, toJson: _sizeToJson)
      Map<String, double>? canvasSize,
      @JsonKey(fromJson: _rectFromJson, toJson: _rectToJson)
      Map<String, double>? clipBounds,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$DrawingCommandsCopyWithImpl<$Res, $Val extends DrawingCommands>
    implements $DrawingCommandsCopyWith<$Res> {
  _$DrawingCommandsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrawingCommands
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operations = null,
    Object? canvasSize = freezed,
    Object? clipBounds = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      operations: null == operations
          ? _value.operations
          : operations // ignore: cast_nullable_to_non_nullable
              as List<DrawingOperation>,
      canvasSize: freezed == canvasSize
          ? _value.canvasSize
          : canvasSize // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      clipBounds: freezed == clipBounds
          ? _value.clipBounds
          : clipBounds // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DrawingCommandsImplCopyWith<$Res>
    implements $DrawingCommandsCopyWith<$Res> {
  factory _$$DrawingCommandsImplCopyWith(_$DrawingCommandsImpl value,
          $Res Function(_$DrawingCommandsImpl) then) =
      __$$DrawingCommandsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<DrawingOperation> operations,
      @JsonKey(fromJson: _sizeFromJson, toJson: _sizeToJson)
      Map<String, double>? canvasSize,
      @JsonKey(fromJson: _rectFromJson, toJson: _rectToJson)
      Map<String, double>? clipBounds,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$DrawingCommandsImplCopyWithImpl<$Res>
    extends _$DrawingCommandsCopyWithImpl<$Res, _$DrawingCommandsImpl>
    implements _$$DrawingCommandsImplCopyWith<$Res> {
  __$$DrawingCommandsImplCopyWithImpl(
      _$DrawingCommandsImpl _value, $Res Function(_$DrawingCommandsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingCommands
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operations = null,
    Object? canvasSize = freezed,
    Object? clipBounds = freezed,
    Object? metadata = null,
  }) {
    return _then(_$DrawingCommandsImpl(
      operations: null == operations
          ? _value._operations
          : operations // ignore: cast_nullable_to_non_nullable
              as List<DrawingOperation>,
      canvasSize: freezed == canvasSize
          ? _value._canvasSize
          : canvasSize // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      clipBounds: freezed == clipBounds
          ? _value._clipBounds
          : clipBounds // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawingCommandsImpl implements _DrawingCommands {
  const _$DrawingCommandsImpl(
      {required final List<DrawingOperation> operations,
      @JsonKey(fromJson: _sizeFromJson, toJson: _sizeToJson)
      final Map<String, double>? canvasSize,
      @JsonKey(fromJson: _rectFromJson, toJson: _rectToJson)
      final Map<String, double>? clipBounds,
      final Map<String, dynamic> metadata = const {}})
      : _operations = operations,
        _canvasSize = canvasSize,
        _clipBounds = clipBounds,
        _metadata = metadata;

  factory _$DrawingCommandsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawingCommandsImplFromJson(json);

  /// Ordered list of drawing operations executed on the canvas.
  ///
  /// Operations are stored in execution order, which is critical for
  /// accurate visual comparison. Each operation represents a single
  /// paint call (drawRect, drawPath, drawText, etc.).
  ///
  /// Empty list is valid and represents a frame where no drawing occurred
  /// (e.g., completely transparent or clipped widget).
  final List<DrawingOperation> _operations;

  /// Ordered list of drawing operations executed on the canvas.
  ///
  /// Operations are stored in execution order, which is critical for
  /// accurate visual comparison. Each operation represents a single
  /// paint call (drawRect, drawPath, drawText, etc.).
  ///
  /// Empty list is valid and represents a frame where no drawing occurred
  /// (e.g., completely transparent or clipped widget).
  @override
  List<DrawingOperation> get operations {
    if (_operations is EqualUnmodifiableListView) return _operations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_operations);
  }

  /// Size of the canvas during drawing.
  ///
  /// Represents the available drawing area. Important for testing because
  /// the same widget might draw differently on canvases of different sizes
  /// due to responsive layout or clipping.
  ///
  /// Stored as a map with 'width' and 'height' keys for JSON serialization.
  /// Null when canvas size information is not available or not relevant.
  final Map<String, double>? _canvasSize;

  /// Size of the canvas during drawing.
  ///
  /// Represents the available drawing area. Important for testing because
  /// the same widget might draw differently on canvases of different sizes
  /// due to responsive layout or clipping.
  ///
  /// Stored as a map with 'width' and 'height' keys for JSON serialization.
  /// Null when canvas size information is not available or not relevant.
  @override
  @JsonKey(fromJson: _sizeFromJson, toJson: _sizeToJson)
  Map<String, double>? get canvasSize {
    final value = _canvasSize;
    if (value == null) return null;
    if (_canvasSize is EqualUnmodifiableMapView) return _canvasSize;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Clipping bounds applied during drawing.
  ///
  /// Many widgets apply clipping to constrain drawing to specific areas.
  /// This information is crucial for accurate visual comparison since
  /// the same drawing operations might produce different results with
  /// different clip bounds.
  ///
  /// Stored as a map with 'left', 'top', 'right', 'bottom' keys for JSON serialization.
  /// Null when no clipping was applied or clip information is unavailable.
  final Map<String, double>? _clipBounds;

  /// Clipping bounds applied during drawing.
  ///
  /// Many widgets apply clipping to constrain drawing to specific areas.
  /// This information is crucial for accurate visual comparison since
  /// the same drawing operations might produce different results with
  /// different clip bounds.
  ///
  /// Stored as a map with 'left', 'top', 'right', 'bottom' keys for JSON serialization.
  /// Null when no clipping was applied or clip information is unavailable.
  @override
  @JsonKey(fromJson: _rectFromJson, toJson: _rectToJson)
  Map<String, double>? get clipBounds {
    final value = _clipBounds;
    if (value == null) return null;
    if (_clipBounds is EqualUnmodifiableMapView) return _clipBounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Additional drawing context metadata.
  ///
  /// Flexible map for storing drawing-related context that might affect
  /// visual output:
  /// - Device pixel ratio
  /// - Platform-specific rendering hints
  /// - Coordinate system transformations
  /// - Custom rendering properties
  ///
  /// Empty map when no additional context is available.
  final Map<String, dynamic> _metadata;

  /// Additional drawing context metadata.
  ///
  /// Flexible map for storing drawing-related context that might affect
  /// visual output:
  /// - Device pixel ratio
  /// - Platform-specific rendering hints
  /// - Coordinate system transformations
  /// - Custom rendering properties
  ///
  /// Empty map when no additional context is available.
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'DrawingCommands(operations: $operations, canvasSize: $canvasSize, clipBounds: $clipBounds, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawingCommandsImpl &&
            const DeepCollectionEquality()
                .equals(other._operations, _operations) &&
            const DeepCollectionEquality()
                .equals(other._canvasSize, _canvasSize) &&
            const DeepCollectionEquality()
                .equals(other._clipBounds, _clipBounds) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_operations),
      const DeepCollectionEquality().hash(_canvasSize),
      const DeepCollectionEquality().hash(_clipBounds),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of DrawingCommands
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawingCommandsImplCopyWith<_$DrawingCommandsImpl> get copyWith =>
      __$$DrawingCommandsImplCopyWithImpl<_$DrawingCommandsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawingCommandsImplToJson(
      this,
    );
  }
}

abstract class _DrawingCommands implements DrawingCommands {
  const factory _DrawingCommands(
      {required final List<DrawingOperation> operations,
      @JsonKey(fromJson: _sizeFromJson, toJson: _sizeToJson)
      final Map<String, double>? canvasSize,
      @JsonKey(fromJson: _rectFromJson, toJson: _rectToJson)
      final Map<String, double>? clipBounds,
      final Map<String, dynamic> metadata}) = _$DrawingCommandsImpl;

  factory _DrawingCommands.fromJson(Map<String, dynamic> json) =
      _$DrawingCommandsImpl.fromJson;

  /// Ordered list of drawing operations executed on the canvas.
  ///
  /// Operations are stored in execution order, which is critical for
  /// accurate visual comparison. Each operation represents a single
  /// paint call (drawRect, drawPath, drawText, etc.).
  ///
  /// Empty list is valid and represents a frame where no drawing occurred
  /// (e.g., completely transparent or clipped widget).
  @override
  List<DrawingOperation> get operations;

  /// Size of the canvas during drawing.
  ///
  /// Represents the available drawing area. Important for testing because
  /// the same widget might draw differently on canvases of different sizes
  /// due to responsive layout or clipping.
  ///
  /// Stored as a map with 'width' and 'height' keys for JSON serialization.
  /// Null when canvas size information is not available or not relevant.
  @override
  @JsonKey(fromJson: _sizeFromJson, toJson: _sizeToJson)
  Map<String, double>? get canvasSize;

  /// Clipping bounds applied during drawing.
  ///
  /// Many widgets apply clipping to constrain drawing to specific areas.
  /// This information is crucial for accurate visual comparison since
  /// the same drawing operations might produce different results with
  /// different clip bounds.
  ///
  /// Stored as a map with 'left', 'top', 'right', 'bottom' keys for JSON serialization.
  /// Null when no clipping was applied or clip information is unavailable.
  @override
  @JsonKey(fromJson: _rectFromJson, toJson: _rectToJson)
  Map<String, double>? get clipBounds;

  /// Additional drawing context metadata.
  ///
  /// Flexible map for storing drawing-related context that might affect
  /// visual output:
  /// - Device pixel ratio
  /// - Platform-specific rendering hints
  /// - Coordinate system transformations
  /// - Custom rendering properties
  ///
  /// Empty map when no additional context is available.
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of DrawingCommands
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawingCommandsImplCopyWith<_$DrawingCommandsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DrawingOperation _$DrawingOperationFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'rect':
      return DrawRect.fromJson(json);
    case 'circle':
      return DrawCircle.fromJson(json);
    case 'oval':
      return DrawOval.fromJson(json);
    case 'line':
      return DrawLine.fromJson(json);
    case 'path':
      return DrawPath.fromJson(json);
    case 'text':
      return DrawText.fromJson(json);
    case 'image':
      return DrawImage.fromJson(json);
    case 'points':
      return DrawPoints.fromJson(json);
    case 'roundedRect':
      return DrawRoundedRect.fromJson(json);
    case 'custom':
      return DrawCustom.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'DrawingOperation',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$DrawingOperation {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this DrawingOperation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawingOperationCopyWith<$Res> {
  factory $DrawingOperationCopyWith(
          DrawingOperation value, $Res Function(DrawingOperation) then) =
      _$DrawingOperationCopyWithImpl<$Res, DrawingOperation>;
}

/// @nodoc
class _$DrawingOperationCopyWithImpl<$Res, $Val extends DrawingOperation>
    implements $DrawingOperationCopyWith<$Res> {
  _$DrawingOperationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DrawRectImplCopyWith<$Res> {
  factory _$$DrawRectImplCopyWith(
          _$DrawRectImpl value, $Res Function(_$DrawRectImpl) then) =
      __$$DrawRectImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
      Map<String, dynamic> paint});
}

/// @nodoc
class __$$DrawRectImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawRectImpl>
    implements _$$DrawRectImplCopyWith<$Res> {
  __$$DrawRectImplCopyWithImpl(
      _$DrawRectImpl _value, $Res Function(_$DrawRectImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rect = null,
    Object? paint = null,
  }) {
    return _then(_$DrawRectImpl(
      rect: null == rect
          ? _value.rect
          : rect // ignore: cast_nullable_to_non_nullable
              as Rect,
      paint: null == paint
          ? _value._paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawRectImpl implements DrawRect {
  const _$DrawRectImpl(
      {@JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) required this.rect,
      required final Map<String, dynamic> paint,
      final String? $type})
      : _paint = paint,
        $type = $type ?? 'rect';

  factory _$DrawRectImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawRectImplFromJson(json);

  @override
  @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap)
  final Rect rect;
  final Map<String, dynamic> _paint;
  @override
  Map<String, dynamic> get paint {
    if (_paint is EqualUnmodifiableMapView) return _paint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paint);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.rect(rect: $rect, paint: $paint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawRectImpl &&
            (identical(other.rect, rect) || other.rect == rect) &&
            const DeepCollectionEquality().equals(other._paint, _paint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, rect, const DeepCollectionEquality().hash(_paint));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawRectImplCopyWith<_$DrawRectImpl> get copyWith =>
      __$$DrawRectImplCopyWithImpl<_$DrawRectImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return rect(this.rect, paint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return rect?.call(this.rect, paint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (rect != null) {
      return rect(this.rect, paint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return rect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return rect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (rect != null) {
      return rect(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawRectImplToJson(
      this,
    );
  }
}

abstract class DrawRect implements DrawingOperation {
  const factory DrawRect(
      {@JsonKey(fromJson: _rectFromMap, toJson: _rectToMap)
      required final Rect rect,
      required final Map<String, dynamic> paint}) = _$DrawRectImpl;

  factory DrawRect.fromJson(Map<String, dynamic> json) =
      _$DrawRectImpl.fromJson;

  @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap)
  Rect get rect;
  Map<String, dynamic> get paint;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawRectImplCopyWith<_$DrawRectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawCircleImplCopyWith<$Res> {
  factory _$$DrawCircleImplCopyWith(
          _$DrawCircleImpl value, $Res Function(_$DrawCircleImpl) then) =
      __$$DrawCircleImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset center,
      double radius,
      Map<String, dynamic> paint});
}

/// @nodoc
class __$$DrawCircleImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawCircleImpl>
    implements _$$DrawCircleImplCopyWith<$Res> {
  __$$DrawCircleImplCopyWithImpl(
      _$DrawCircleImpl _value, $Res Function(_$DrawCircleImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? center = null,
    Object? radius = null,
    Object? paint = null,
  }) {
    return _then(_$DrawCircleImpl(
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as Offset,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double,
      paint: null == paint
          ? _value._paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawCircleImpl implements DrawCircle {
  const _$DrawCircleImpl(
      {@JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
      required this.center,
      required this.radius,
      required final Map<String, dynamic> paint,
      final String? $type})
      : _paint = paint,
        $type = $type ?? 'circle';

  factory _$DrawCircleImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawCircleImplFromJson(json);

  @override
  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  final Offset center;
  @override
  final double radius;
  final Map<String, dynamic> _paint;
  @override
  Map<String, dynamic> get paint {
    if (_paint is EqualUnmodifiableMapView) return _paint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paint);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.circle(center: $center, radius: $radius, paint: $paint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawCircleImpl &&
            (identical(other.center, center) || other.center == center) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            const DeepCollectionEquality().equals(other._paint, _paint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, center, radius, const DeepCollectionEquality().hash(_paint));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawCircleImplCopyWith<_$DrawCircleImpl> get copyWith =>
      __$$DrawCircleImplCopyWithImpl<_$DrawCircleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return circle(center, radius, paint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return circle?.call(center, radius, paint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (circle != null) {
      return circle(center, radius, paint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return circle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return circle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (circle != null) {
      return circle(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawCircleImplToJson(
      this,
    );
  }
}

abstract class DrawCircle implements DrawingOperation {
  const factory DrawCircle(
      {@JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
      required final Offset center,
      required final double radius,
      required final Map<String, dynamic> paint}) = _$DrawCircleImpl;

  factory DrawCircle.fromJson(Map<String, dynamic> json) =
      _$DrawCircleImpl.fromJson;

  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  Offset get center;
  double get radius;
  Map<String, dynamic> get paint;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawCircleImplCopyWith<_$DrawCircleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawOvalImplCopyWith<$Res> {
  factory _$$DrawOvalImplCopyWith(
          _$DrawOvalImpl value, $Res Function(_$DrawOvalImpl) then) =
      __$$DrawOvalImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
      Map<String, dynamic> paint});
}

/// @nodoc
class __$$DrawOvalImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawOvalImpl>
    implements _$$DrawOvalImplCopyWith<$Res> {
  __$$DrawOvalImplCopyWithImpl(
      _$DrawOvalImpl _value, $Res Function(_$DrawOvalImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rect = null,
    Object? paint = null,
  }) {
    return _then(_$DrawOvalImpl(
      rect: null == rect
          ? _value.rect
          : rect // ignore: cast_nullable_to_non_nullable
              as Rect,
      paint: null == paint
          ? _value._paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawOvalImpl implements DrawOval {
  const _$DrawOvalImpl(
      {@JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) required this.rect,
      required final Map<String, dynamic> paint,
      final String? $type})
      : _paint = paint,
        $type = $type ?? 'oval';

  factory _$DrawOvalImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawOvalImplFromJson(json);

  @override
  @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap)
  final Rect rect;
  final Map<String, dynamic> _paint;
  @override
  Map<String, dynamic> get paint {
    if (_paint is EqualUnmodifiableMapView) return _paint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paint);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.oval(rect: $rect, paint: $paint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawOvalImpl &&
            (identical(other.rect, rect) || other.rect == rect) &&
            const DeepCollectionEquality().equals(other._paint, _paint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, rect, const DeepCollectionEquality().hash(_paint));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawOvalImplCopyWith<_$DrawOvalImpl> get copyWith =>
      __$$DrawOvalImplCopyWithImpl<_$DrawOvalImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return oval(this.rect, paint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return oval?.call(this.rect, paint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (oval != null) {
      return oval(this.rect, paint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return oval(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return oval?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (oval != null) {
      return oval(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawOvalImplToJson(
      this,
    );
  }
}

abstract class DrawOval implements DrawingOperation {
  const factory DrawOval(
      {@JsonKey(fromJson: _rectFromMap, toJson: _rectToMap)
      required final Rect rect,
      required final Map<String, dynamic> paint}) = _$DrawOvalImpl;

  factory DrawOval.fromJson(Map<String, dynamic> json) =
      _$DrawOvalImpl.fromJson;

  @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap)
  Rect get rect;
  Map<String, dynamic> get paint;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawOvalImplCopyWith<_$DrawOvalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawLineImplCopyWith<$Res> {
  factory _$$DrawLineImplCopyWith(
          _$DrawLineImpl value, $Res Function(_$DrawLineImpl) then) =
      __$$DrawLineImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
      @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
      Map<String, dynamic> paint});
}

/// @nodoc
class __$$DrawLineImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawLineImpl>
    implements _$$DrawLineImplCopyWith<$Res> {
  __$$DrawLineImplCopyWithImpl(
      _$DrawLineImpl _value, $Res Function(_$DrawLineImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? p1 = null,
    Object? p2 = null,
    Object? paint = null,
  }) {
    return _then(_$DrawLineImpl(
      p1: null == p1
          ? _value.p1
          : p1 // ignore: cast_nullable_to_non_nullable
              as Offset,
      p2: null == p2
          ? _value.p2
          : p2 // ignore: cast_nullable_to_non_nullable
              as Offset,
      paint: null == paint
          ? _value._paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawLineImpl implements DrawLine {
  const _$DrawLineImpl(
      {@JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
      required this.p1,
      @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) required this.p2,
      required final Map<String, dynamic> paint,
      final String? $type})
      : _paint = paint,
        $type = $type ?? 'line';

  factory _$DrawLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawLineImplFromJson(json);

  @override
  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  final Offset p1;
  @override
  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  final Offset p2;
  final Map<String, dynamic> _paint;
  @override
  Map<String, dynamic> get paint {
    if (_paint is EqualUnmodifiableMapView) return _paint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paint);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.line(p1: $p1, p2: $p2, paint: $paint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawLineImpl &&
            (identical(other.p1, p1) || other.p1 == p1) &&
            (identical(other.p2, p2) || other.p2 == p2) &&
            const DeepCollectionEquality().equals(other._paint, _paint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, p1, p2, const DeepCollectionEquality().hash(_paint));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawLineImplCopyWith<_$DrawLineImpl> get copyWith =>
      __$$DrawLineImplCopyWithImpl<_$DrawLineImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return line(p1, p2, paint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return line?.call(p1, p2, paint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (line != null) {
      return line(p1, p2, paint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return line(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return line?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (line != null) {
      return line(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawLineImplToJson(
      this,
    );
  }
}

abstract class DrawLine implements DrawingOperation {
  const factory DrawLine(
      {@JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
      required final Offset p1,
      @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
      required final Offset p2,
      required final Map<String, dynamic> paint}) = _$DrawLineImpl;

  factory DrawLine.fromJson(Map<String, dynamic> json) =
      _$DrawLineImpl.fromJson;

  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  Offset get p1;
  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  Offset get p2;
  Map<String, dynamic> get paint;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawLineImplCopyWith<_$DrawLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawPathImplCopyWith<$Res> {
  factory _$$DrawPathImplCopyWith(
          _$DrawPathImpl value, $Res Function(_$DrawPathImpl) then) =
      __$$DrawPathImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String pathData, Map<String, dynamic> paint});
}

/// @nodoc
class __$$DrawPathImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawPathImpl>
    implements _$$DrawPathImplCopyWith<$Res> {
  __$$DrawPathImplCopyWithImpl(
      _$DrawPathImpl _value, $Res Function(_$DrawPathImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pathData = null,
    Object? paint = null,
  }) {
    return _then(_$DrawPathImpl(
      pathData: null == pathData
          ? _value.pathData
          : pathData // ignore: cast_nullable_to_non_nullable
              as String,
      paint: null == paint
          ? _value._paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawPathImpl implements DrawPath {
  const _$DrawPathImpl(
      {required this.pathData,
      required final Map<String, dynamic> paint,
      final String? $type})
      : _paint = paint,
        $type = $type ?? 'path';

  factory _$DrawPathImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawPathImplFromJson(json);

  @override
  final String pathData;
  final Map<String, dynamic> _paint;
  @override
  Map<String, dynamic> get paint {
    if (_paint is EqualUnmodifiableMapView) return _paint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paint);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.path(pathData: $pathData, paint: $paint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawPathImpl &&
            (identical(other.pathData, pathData) ||
                other.pathData == pathData) &&
            const DeepCollectionEquality().equals(other._paint, _paint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, pathData, const DeepCollectionEquality().hash(_paint));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawPathImplCopyWith<_$DrawPathImpl> get copyWith =>
      __$$DrawPathImplCopyWithImpl<_$DrawPathImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return path(pathData, paint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return path?.call(pathData, paint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (path != null) {
      return path(pathData, paint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return path(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return path?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (path != null) {
      return path(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawPathImplToJson(
      this,
    );
  }
}

abstract class DrawPath implements DrawingOperation {
  const factory DrawPath(
      {required final String pathData,
      required final Map<String, dynamic> paint}) = _$DrawPathImpl;

  factory DrawPath.fromJson(Map<String, dynamic> json) =
      _$DrawPathImpl.fromJson;

  String get pathData;
  Map<String, dynamic> get paint;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawPathImplCopyWith<_$DrawPathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawTextImplCopyWith<$Res> {
  factory _$$DrawTextImplCopyWith(
          _$DrawTextImpl value, $Res Function(_$DrawTextImpl) then) =
      __$$DrawTextImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String text,
      @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset offset,
      Map<String, dynamic> textStyle});
}

/// @nodoc
class __$$DrawTextImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawTextImpl>
    implements _$$DrawTextImplCopyWith<$Res> {
  __$$DrawTextImplCopyWithImpl(
      _$DrawTextImpl _value, $Res Function(_$DrawTextImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? offset = null,
    Object? textStyle = null,
  }) {
    return _then(_$DrawTextImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      textStyle: null == textStyle
          ? _value._textStyle
          : textStyle // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawTextImpl implements DrawText {
  const _$DrawTextImpl(
      {required this.text,
      @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
      required this.offset,
      required final Map<String, dynamic> textStyle,
      final String? $type})
      : _textStyle = textStyle,
        $type = $type ?? 'text';

  factory _$DrawTextImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawTextImplFromJson(json);

  @override
  final String text;
  @override
  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  final Offset offset;
  final Map<String, dynamic> _textStyle;
  @override
  Map<String, dynamic> get textStyle {
    if (_textStyle is EqualUnmodifiableMapView) return _textStyle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_textStyle);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.text(text: $text, offset: $offset, textStyle: $textStyle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawTextImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            const DeepCollectionEquality()
                .equals(other._textStyle, _textStyle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, offset,
      const DeepCollectionEquality().hash(_textStyle));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawTextImplCopyWith<_$DrawTextImpl> get copyWith =>
      __$$DrawTextImplCopyWithImpl<_$DrawTextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return text(this.text, offset, textStyle);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return text?.call(this.text, offset, textStyle);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this.text, offset, textStyle);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawTextImplToJson(
      this,
    );
  }
}

abstract class DrawText implements DrawingOperation {
  const factory DrawText(
      {required final String text,
      @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
      required final Offset offset,
      required final Map<String, dynamic> textStyle}) = _$DrawTextImpl;

  factory DrawText.fromJson(Map<String, dynamic> json) =
      _$DrawTextImpl.fromJson;

  String get text;
  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  Offset get offset;
  Map<String, dynamic> get textStyle;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawTextImplCopyWith<_$DrawTextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawImageImplCopyWith<$Res> {
  factory _$$DrawImageImplCopyWith(
          _$DrawImageImpl value, $Res Function(_$DrawImageImpl) then) =
      __$$DrawImageImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset offset,
      @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
      String imageHash,
      Map<String, dynamic> paint});
}

/// @nodoc
class __$$DrawImageImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawImageImpl>
    implements _$$DrawImageImplCopyWith<$Res> {
  __$$DrawImageImplCopyWithImpl(
      _$DrawImageImpl _value, $Res Function(_$DrawImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? size = null,
    Object? imageHash = null,
    Object? paint = null,
  }) {
    return _then(_$DrawImageImpl(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      imageHash: null == imageHash
          ? _value.imageHash
          : imageHash // ignore: cast_nullable_to_non_nullable
              as String,
      paint: null == paint
          ? _value._paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawImageImpl implements DrawImage {
  const _$DrawImageImpl(
      {@JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
      required this.offset,
      @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) required this.size,
      required this.imageHash,
      required final Map<String, dynamic> paint,
      final String? $type})
      : _paint = paint,
        $type = $type ?? 'image';

  factory _$DrawImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawImageImplFromJson(json);

  @override
  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  final Offset offset;
  @override
  @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap)
  final Size size;
  @override
  final String imageHash;
// Hash or identifier for the image
  final Map<String, dynamic> _paint;
// Hash or identifier for the image
  @override
  Map<String, dynamic> get paint {
    if (_paint is EqualUnmodifiableMapView) return _paint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paint);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.image(offset: $offset, size: $size, imageHash: $imageHash, paint: $paint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawImageImpl &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.imageHash, imageHash) ||
                other.imageHash == imageHash) &&
            const DeepCollectionEquality().equals(other._paint, _paint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, offset, size, imageHash,
      const DeepCollectionEquality().hash(_paint));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawImageImplCopyWith<_$DrawImageImpl> get copyWith =>
      __$$DrawImageImplCopyWithImpl<_$DrawImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return image(offset, size, imageHash, paint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return image?.call(offset, size, imageHash, paint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(offset, size, imageHash, paint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawImageImplToJson(
      this,
    );
  }
}

abstract class DrawImage implements DrawingOperation {
  const factory DrawImage(
      {@JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
      required final Offset offset,
      @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap)
      required final Size size,
      required final String imageHash,
      required final Map<String, dynamic> paint}) = _$DrawImageImpl;

  factory DrawImage.fromJson(Map<String, dynamic> json) =
      _$DrawImageImpl.fromJson;

  @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
  Offset get offset;
  @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap)
  Size get size;
  String get imageHash; // Hash or identifier for the image
  Map<String, dynamic> get paint;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawImageImplCopyWith<_$DrawImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawPointsImplCopyWith<$Res> {
  factory _$$DrawPointsImplCopyWith(
          _$DrawPointsImpl value, $Res Function(_$DrawPointsImpl) then) =
      __$$DrawPointsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
      List<Offset> points,
      String pointMode,
      Map<String, dynamic> paint});
}

/// @nodoc
class __$$DrawPointsImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawPointsImpl>
    implements _$$DrawPointsImplCopyWith<$Res> {
  __$$DrawPointsImplCopyWithImpl(
      _$DrawPointsImpl _value, $Res Function(_$DrawPointsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? points = null,
    Object? pointMode = null,
    Object? paint = null,
  }) {
    return _then(_$DrawPointsImpl(
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
      pointMode: null == pointMode
          ? _value.pointMode
          : pointMode // ignore: cast_nullable_to_non_nullable
              as String,
      paint: null == paint
          ? _value._paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawPointsImpl implements DrawPoints {
  const _$DrawPointsImpl(
      {@JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
      required final List<Offset> points,
      required this.pointMode,
      required final Map<String, dynamic> paint,
      final String? $type})
      : _points = points,
        _paint = paint,
        $type = $type ?? 'points';

  factory _$DrawPointsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawPointsImplFromJson(json);

  final List<Offset> _points;
  @override
  @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
  List<Offset> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  final String pointMode;
// 'points', 'lines', or 'polygon'
  final Map<String, dynamic> _paint;
// 'points', 'lines', or 'polygon'
  @override
  Map<String, dynamic> get paint {
    if (_paint is EqualUnmodifiableMapView) return _paint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paint);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.points(points: $points, pointMode: $pointMode, paint: $paint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawPointsImpl &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.pointMode, pointMode) ||
                other.pointMode == pointMode) &&
            const DeepCollectionEquality().equals(other._paint, _paint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_points),
      pointMode,
      const DeepCollectionEquality().hash(_paint));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawPointsImplCopyWith<_$DrawPointsImpl> get copyWith =>
      __$$DrawPointsImplCopyWithImpl<_$DrawPointsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return points(this.points, pointMode, paint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return points?.call(this.points, pointMode, paint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (points != null) {
      return points(this.points, pointMode, paint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return points(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return points?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (points != null) {
      return points(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawPointsImplToJson(
      this,
    );
  }
}

abstract class DrawPoints implements DrawingOperation {
  const factory DrawPoints(
      {@JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
      required final List<Offset> points,
      required final String pointMode,
      required final Map<String, dynamic> paint}) = _$DrawPointsImpl;

  factory DrawPoints.fromJson(Map<String, dynamic> json) =
      _$DrawPointsImpl.fromJson;

  @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
  List<Offset> get points;
  String get pointMode; // 'points', 'lines', or 'polygon'
  Map<String, dynamic> get paint;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawPointsImplCopyWith<_$DrawPointsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawRoundedRectImplCopyWith<$Res> {
  factory _$$DrawRoundedRectImplCopyWith(_$DrawRoundedRectImpl value,
          $Res Function(_$DrawRoundedRectImpl) then) =
      __$$DrawRoundedRectImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
      double radiusX,
      double radiusY,
      Map<String, dynamic> paint});
}

/// @nodoc
class __$$DrawRoundedRectImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawRoundedRectImpl>
    implements _$$DrawRoundedRectImplCopyWith<$Res> {
  __$$DrawRoundedRectImplCopyWithImpl(
      _$DrawRoundedRectImpl _value, $Res Function(_$DrawRoundedRectImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rect = null,
    Object? radiusX = null,
    Object? radiusY = null,
    Object? paint = null,
  }) {
    return _then(_$DrawRoundedRectImpl(
      rect: null == rect
          ? _value.rect
          : rect // ignore: cast_nullable_to_non_nullable
              as Rect,
      radiusX: null == radiusX
          ? _value.radiusX
          : radiusX // ignore: cast_nullable_to_non_nullable
              as double,
      radiusY: null == radiusY
          ? _value.radiusY
          : radiusY // ignore: cast_nullable_to_non_nullable
              as double,
      paint: null == paint
          ? _value._paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawRoundedRectImpl implements DrawRoundedRect {
  const _$DrawRoundedRectImpl(
      {@JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) required this.rect,
      required this.radiusX,
      required this.radiusY,
      required final Map<String, dynamic> paint,
      final String? $type})
      : _paint = paint,
        $type = $type ?? 'roundedRect';

  factory _$DrawRoundedRectImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawRoundedRectImplFromJson(json);

  @override
  @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap)
  final Rect rect;
  @override
  final double radiusX;
  @override
  final double radiusY;
  final Map<String, dynamic> _paint;
  @override
  Map<String, dynamic> get paint {
    if (_paint is EqualUnmodifiableMapView) return _paint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paint);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.roundedRect(rect: $rect, radiusX: $radiusX, radiusY: $radiusY, paint: $paint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawRoundedRectImpl &&
            (identical(other.rect, rect) || other.rect == rect) &&
            (identical(other.radiusX, radiusX) || other.radiusX == radiusX) &&
            (identical(other.radiusY, radiusY) || other.radiusY == radiusY) &&
            const DeepCollectionEquality().equals(other._paint, _paint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rect, radiusX, radiusY,
      const DeepCollectionEquality().hash(_paint));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawRoundedRectImplCopyWith<_$DrawRoundedRectImpl> get copyWith =>
      __$$DrawRoundedRectImplCopyWithImpl<_$DrawRoundedRectImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return roundedRect(this.rect, radiusX, radiusY, paint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return roundedRect?.call(this.rect, radiusX, radiusY, paint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (roundedRect != null) {
      return roundedRect(this.rect, radiusX, radiusY, paint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return roundedRect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return roundedRect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (roundedRect != null) {
      return roundedRect(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawRoundedRectImplToJson(
      this,
    );
  }
}

abstract class DrawRoundedRect implements DrawingOperation {
  const factory DrawRoundedRect(
      {@JsonKey(fromJson: _rectFromMap, toJson: _rectToMap)
      required final Rect rect,
      required final double radiusX,
      required final double radiusY,
      required final Map<String, dynamic> paint}) = _$DrawRoundedRectImpl;

  factory DrawRoundedRect.fromJson(Map<String, dynamic> json) =
      _$DrawRoundedRectImpl.fromJson;

  @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap)
  Rect get rect;
  double get radiusX;
  double get radiusY;
  Map<String, dynamic> get paint;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawRoundedRectImplCopyWith<_$DrawRoundedRectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawCustomImplCopyWith<$Res> {
  factory _$$DrawCustomImplCopyWith(
          _$DrawCustomImpl value, $Res Function(_$DrawCustomImpl) then) =
      __$$DrawCustomImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String operationType, Map<String, dynamic> parameters});
}

/// @nodoc
class __$$DrawCustomImplCopyWithImpl<$Res>
    extends _$DrawingOperationCopyWithImpl<$Res, _$DrawCustomImpl>
    implements _$$DrawCustomImplCopyWith<$Res> {
  __$$DrawCustomImplCopyWithImpl(
      _$DrawCustomImpl _value, $Res Function(_$DrawCustomImpl) _then)
      : super(_value, _then);

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operationType = null,
    Object? parameters = null,
  }) {
    return _then(_$DrawCustomImpl(
      operationType: null == operationType
          ? _value.operationType
          : operationType // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawCustomImpl implements DrawCustom {
  const _$DrawCustomImpl(
      {required this.operationType,
      required final Map<String, dynamic> parameters,
      final String? $type})
      : _parameters = parameters,
        $type = $type ?? 'custom';

  factory _$DrawCustomImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawCustomImplFromJson(json);

  @override
  final String operationType;
  final Map<String, dynamic> _parameters;
  @override
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DrawingOperation.custom(operationType: $operationType, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawCustomImpl &&
            (identical(other.operationType, operationType) ||
                other.operationType == operationType) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, operationType,
      const DeepCollectionEquality().hash(_parameters));

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawCustomImplCopyWith<_$DrawCustomImpl> get copyWith =>
      __$$DrawCustomImplCopyWithImpl<_$DrawCustomImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        rect,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)
        circle,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)
        oval,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)
        line,
    required TResult Function(String pathData, Map<String, dynamic> paint) path,
    required TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)
        text,
    required TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)
        image,
    required TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)
        points,
    required TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)
        roundedRect,
    required TResult Function(
            String operationType, Map<String, dynamic> parameters)
        custom,
  }) {
    return custom(operationType, parameters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult? Function(String pathData, Map<String, dynamic> paint)? path,
    TResult? Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult? Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult? Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult? Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult? Function(String operationType, Map<String, dynamic> parameters)?
        custom,
  }) {
    return custom?.call(operationType, parameters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        rect,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset center,
            double radius,
            Map<String, dynamic> paint)?
        circle,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            Map<String, dynamic> paint)?
        oval,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p1,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) Offset p2,
            Map<String, dynamic> paint)?
        line,
    TResult Function(String pathData, Map<String, dynamic> paint)? path,
    TResult Function(
            String text,
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            Map<String, dynamic> textStyle)?
        text,
    TResult Function(
            @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap)
            Offset offset,
            @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) Size size,
            String imageHash,
            Map<String, dynamic> paint)?
        image,
    TResult Function(
            @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson)
            List<Offset> points,
            String pointMode,
            Map<String, dynamic> paint)?
        points,
    TResult Function(
            @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) Rect rect,
            double radiusX,
            double radiusY,
            Map<String, dynamic> paint)?
        roundedRect,
    TResult Function(String operationType, Map<String, dynamic> parameters)?
        custom,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(operationType, parameters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawRect value) rect,
    required TResult Function(DrawCircle value) circle,
    required TResult Function(DrawOval value) oval,
    required TResult Function(DrawLine value) line,
    required TResult Function(DrawPath value) path,
    required TResult Function(DrawText value) text,
    required TResult Function(DrawImage value) image,
    required TResult Function(DrawPoints value) points,
    required TResult Function(DrawRoundedRect value) roundedRect,
    required TResult Function(DrawCustom value) custom,
  }) {
    return custom(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawRect value)? rect,
    TResult? Function(DrawCircle value)? circle,
    TResult? Function(DrawOval value)? oval,
    TResult? Function(DrawLine value)? line,
    TResult? Function(DrawPath value)? path,
    TResult? Function(DrawText value)? text,
    TResult? Function(DrawImage value)? image,
    TResult? Function(DrawPoints value)? points,
    TResult? Function(DrawRoundedRect value)? roundedRect,
    TResult? Function(DrawCustom value)? custom,
  }) {
    return custom?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawRect value)? rect,
    TResult Function(DrawCircle value)? circle,
    TResult Function(DrawOval value)? oval,
    TResult Function(DrawLine value)? line,
    TResult Function(DrawPath value)? path,
    TResult Function(DrawText value)? text,
    TResult Function(DrawImage value)? image,
    TResult Function(DrawPoints value)? points,
    TResult Function(DrawRoundedRect value)? roundedRect,
    TResult Function(DrawCustom value)? custom,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawCustomImplToJson(
      this,
    );
  }
}

abstract class DrawCustom implements DrawingOperation {
  const factory DrawCustom(
      {required final String operationType,
      required final Map<String, dynamic> parameters}) = _$DrawCustomImpl;

  factory DrawCustom.fromJson(Map<String, dynamic> json) =
      _$DrawCustomImpl.fromJson;

  String get operationType;
  Map<String, dynamic> get parameters;

  /// Create a copy of DrawingOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawCustomImplCopyWith<_$DrawCustomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
