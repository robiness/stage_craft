import 'dart:math' as math;

import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'drawing_frame.freezed.dart';
part 'drawing_frame.g.dart';

@freezed
class DrawingFrame with _$DrawingFrame {
  /// Creates a drawing frame containing paint operations at a specific timestamp.
  ///
  /// A [DrawingFrame] captures the complete set of drawing commands executed
  /// during widget rendering at a particular moment. These frames are used
  /// exclusively for visual regression testing - they are NOT applied during
  /// playback (widgets redraw naturally from restored StateFrames).
  ///
  /// DrawingFrames enable precise visual testing by comparing expected vs
  /// actual drawing operations, detecting any changes in widget rendering
  /// that might indicate regressions or visual bugs.
  ///
  /// Example:
  /// ```dart
  /// final frame = DrawingFrame(
  ///   timestamp: Duration(milliseconds: 1500),
  ///   commands: DrawingCommands(
  ///     operations: [
  ///       DrawingOperation.rect(
  ///         rect: Rect.fromLTWH(10, 10, 100, 50),
  ///         paint: {'color': 0xFFFF0000, 'style': 'fill'},
  ///       ),
  ///       DrawingOperation.text(
  ///         text: 'Hello World',
  ///         offset: Offset(20, 30),
  ///         textStyle: {'fontSize': 16.0, 'color': 0xFF000000},
  ///       ),
  ///     ],
  ///     canvasSize: Size(200, 100),
  ///   ),
  /// );
  /// ```
  const factory DrawingFrame({
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
    required Duration timestamp,

    /// Complete set of drawing commands executed during this frame.
    ///
    /// Contains all paint operations that were intercepted during widget
    /// rendering, including shapes, text, images, and complex paths.
    ///
    /// These commands represent the exact visual output of the widget
    /// and can be compared against future runs to detect visual changes.
    required DrawingCommands commands,
  }) = _DrawingFrame;

  factory DrawingFrame.fromJson(Map<String, dynamic> json) => _$DrawingFrameFromJson(json);
}

@freezed
class DrawingCommands with _$DrawingCommands {
  /// Contains the complete set of drawing operations for a single frame.
  ///
  /// Represents everything that was painted to the canvas during widget
  /// rendering, including the drawing context (canvas size, clip bounds)
  /// and all individual drawing operations in execution order.
  ///
  /// Drawing operations are stored in the exact order they were executed,
  /// which is important for correct visual comparison since later operations
  /// can overdraw earlier ones.
  const factory DrawingCommands({
    /// Ordered list of drawing operations executed on the canvas.
    ///
    /// Operations are stored in execution order, which is critical for
    /// accurate visual comparison. Each operation represents a single
    /// paint call (drawRect, drawPath, drawText, etc.).
    ///
    /// Empty list is valid and represents a frame where no drawing occurred
    /// (e.g., completely transparent or clipped widget).
    required List<DrawingOperation> operations,

    /// Size of the canvas during drawing.
    ///
    /// Represents the available drawing area. Important for testing because
    /// the same widget might draw differently on canvases of different sizes
    /// due to responsive layout or clipping.
    ///
    /// Stored as a map with 'width' and 'height' keys for JSON serialization.
    /// Null when canvas size information is not available or not relevant.
    @JsonKey(
      fromJson: _sizeFromJson,
      toJson: _sizeToJson,
    )
    Map<String, double>? canvasSize,

    /// Clipping bounds applied during drawing.
    ///
    /// Many widgets apply clipping to constrain drawing to specific areas.
    /// This information is crucial for accurate visual comparison since
    /// the same drawing operations might produce different results with
    /// different clip bounds.
    ///
    /// Stored as a map with 'left', 'top', 'right', 'bottom' keys for JSON serialization.
    /// Null when no clipping was applied or clip information is unavailable.
    @JsonKey(
      fromJson: _rectFromJson,
      toJson: _rectToJson,
    )
    Map<String, double>? clipBounds,

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
    @Default({}) Map<String, dynamic> metadata,
  }) = _DrawingCommands;

  factory DrawingCommands.fromJson(Map<String, dynamic> json) => _$DrawingCommandsFromJson(json);
}

// JSON serialization helpers for Flutter types
Map<String, double>? _sizeToJson(Map<String, double>? size) => size;

Map<String, double>? _sizeFromJson(Map<String, dynamic>? json) =>
    json?.map((key, value) => MapEntry(key, (value as num).toDouble()));

Map<String, double>? _rectToJson(Map<String, double>? rect) => rect;

Map<String, double>? _rectFromJson(Map<String, dynamic>? json) =>
    json?.map((key, value) => MapEntry(key, (value as num).toDouble()));

Rect _rectFromMap(Map<String, dynamic> map) {
  return Rect.fromLTRB(
    (map['left'] as num?)?.toDouble() ?? 0.0,
    (map['top'] as num?)?.toDouble() ?? 0.0,
    (map['right'] as num?)?.toDouble() ?? 0.0,
    (map['bottom'] as num?)?.toDouble() ?? 0.0,
  );
}

Map<String, double> _rectToMap(Rect rect) {
  return {
    'left': rect.left,
    'top': rect.top,
    'right': rect.right,
    'bottom': rect.bottom,
  };
}

Offset _offsetFromMap(Map<String, dynamic> map) {
  return Offset(
    (map['dx'] as num?)?.toDouble() ?? 0.0,
    (map['dy'] as num?)?.toDouble() ?? 0.0,
  );
}

Map<String, double> _offsetToMap(Offset offset) {
  return {
    'dx': offset.dx,
    'dy': offset.dy,
  };
}

Size _sizeFromMap(Map<String, dynamic> map) {
  return Size(
    (map['width'] as num?)?.toDouble() ?? 0.0,
    (map['height'] as num?)?.toDouble() ?? 0.0,
  );
}

Map<String, double> _sizeToMap(Size size) {
  return {
    'width': size.width,
    'height': size.height,
  };
}

List<Offset> _offsetListFromJson(List<dynamic> json) {
  return json.map((item) => _offsetFromMap(item as Map<String, dynamic>)).toList();
}

List<Map<String, double>> _offsetListToJson(List<Offset> offsets) {
  return offsets.map(_offsetToMap).toList();
}

@freezed
class DrawingOperation with _$DrawingOperation {
  /// Represents a single drawing operation executed on the canvas.
  ///
  /// This is a sealed union type covering all the different types of
  /// drawing operations that can be performed on a Flutter Canvas.
  /// Each operation type captures the specific parameters needed
  /// to reproduce that exact drawing call.
  ///
  /// The union type design ensures type safety and exhaustive handling
  /// of all drawing operation types during comparison and analysis.

  /// Draws a rectangle with the specified bounds and paint.
  ///
  /// Corresponds to Canvas.drawRect() calls.
  ///
  /// Example:
  /// ```dart
  /// DrawingOperation.rect(
  ///   rect: Rect.fromLTWH(10, 10, 100, 50),
  ///   paint: {
  ///     'color': 0xFFFF0000,
  ///     'style': 'fill',
  ///     'strokeWidth': 2.0,
  ///   },
  /// )
  /// ```
  const factory DrawingOperation.rect({
    @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) required Rect rect,
    required Map<String, dynamic> paint,
  }) = DrawRect;

  /// Draws a circle with the specified center, radius, and paint.
  ///
  /// Corresponds to Canvas.drawCircle() calls.
  ///
  /// Example:
  /// ```dart
  /// DrawingOperation.circle(
  ///   center: Offset(50, 50),
  ///   radius: 25.0,
  ///   paint: {
  ///     'color': 0xFF00FF00,
  ///     'style': 'stroke',
  ///     'strokeWidth': 3.0,
  ///   },
  /// )
  /// ```
  const factory DrawingOperation.circle({
    @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) required Offset center,
    required double radius,
    required Map<String, dynamic> paint,
  }) = DrawCircle;

  /// Draws an oval within the specified bounds.
  ///
  /// Corresponds to Canvas.drawOval() calls.
  const factory DrawingOperation.oval({
    @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) required Rect rect,
    required Map<String, dynamic> paint,
  }) = DrawOval;

  /// Draws a line between two points.
  ///
  /// Corresponds to Canvas.drawLine() calls.
  const factory DrawingOperation.line({
    @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) required Offset p1,
    @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) required Offset p2,
    required Map<String, dynamic> paint,
  }) = DrawLine;

  /// Draws a complex path with the specified paint.
  ///
  /// Corresponds to Canvas.drawPath() calls.
  ///
  /// The path is serialized as an SVG-like string representation
  /// that can be parsed back into a Path object for comparison.
  ///
  /// Example:
  /// ```dart
  /// DrawingOperation.path(
  ///   pathData: 'M10,10 L50,10 L50,50 L10,50 Z', // SVG path format
  ///   paint: {
  ///     'color': 0xFF0000FF,
  ///     'style': 'fill',
  ///   },
  /// )
  /// ```
  const factory DrawingOperation.path({
    required String pathData,
    required Map<String, dynamic> paint,
  }) = DrawPath;

  /// Draws text at the specified position with the given style.
  ///
  /// Corresponds to Canvas.drawParagraph() or TextPainter.paint() calls.
  ///
  /// Example:
  /// ```dart
  /// DrawingOperation.text(
  ///   text: 'Hello World',
  ///   offset: Offset(20, 30),
  ///   textStyle: {
  ///     'fontSize': 16.0,
  ///     'color': 0xFF000000,
  ///     'fontFamily': 'Roboto',
  ///     'fontWeight': 'normal',
  ///   },
  /// )
  /// ```
  const factory DrawingOperation.text({
    required String text,
    @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) required Offset offset,
    required Map<String, dynamic> textStyle,
  }) = DrawText;

  /// Draws an image at the specified position.
  ///
  /// Corresponds to Canvas.drawImage() calls.
  ///
  /// For testing purposes, images are identified by hash or signature
  /// rather than storing full image data.
  const factory DrawingOperation.image({
    @JsonKey(fromJson: _offsetFromMap, toJson: _offsetToMap) required Offset offset,
    @JsonKey(fromJson: _sizeFromMap, toJson: _sizeToMap) required Size size,
    required String imageHash, // Hash or identifier for the image
    required Map<String, dynamic> paint,
  }) = DrawImage;

  /// Draws points (dots) at the specified locations.
  ///
  /// Corresponds to Canvas.drawPoints() calls.
  const factory DrawingOperation.points({
    @JsonKey(fromJson: _offsetListFromJson, toJson: _offsetListToJson) required List<Offset> points,
    required String pointMode, // 'points', 'lines', or 'polygon'
    required Map<String, dynamic> paint,
  }) = DrawPoints;

  /// Draws a rounded rectangle with the specified corner radii.
  ///
  /// Corresponds to Canvas.drawRRect() calls.
  const factory DrawingOperation.roundedRect({
    @JsonKey(fromJson: _rectFromMap, toJson: _rectToMap) required Rect rect,
    required double radiusX,
    required double radiusY,
    required Map<String, dynamic> paint,
  }) = DrawRoundedRect;

  /// Represents any other drawing operation not covered by specific types.
  ///
  /// Used for custom or platform-specific drawing calls.
  /// The operation is identified by name with arbitrary parameters.
  const factory DrawingOperation.custom({
    required String operationType,
    required Map<String, dynamic> parameters,
  }) = DrawCustom;

  factory DrawingOperation.fromJson(Map<String, dynamic> json) => _$DrawingOperationFromJson(json);
}

/// Extension methods for drawing frame analysis and manipulation.
extension DrawingFrameX on DrawingFrame {
  /// Whether this frame contains any drawing operations.
  bool get hasOperations => commands.operations.isNotEmpty;

  /// Number of drawing operations in this frame.
  int get operationCount => commands.operations.length;

  /// Total canvas area if size is available.
  double? get canvasArea =>
      commands.canvasSize != null && commands.canvasSize!['width'] != null && commands.canvasSize!['height'] != null
          ? commands.canvasSize!['width']! * commands.canvasSize!['height']!
          : null;

  /// Whether this frame includes text drawing operations.
  bool get hasTextOperations => commands.operations.any((op) => op is DrawText);

  /// Whether this frame includes image drawing operations.
  bool get hasImageOperations => commands.operations.any((op) => op is DrawImage);

  /// Whether this frame includes path drawing operations.
  bool get hasPathOperations => commands.operations.any((op) => op is DrawPath);

  /// Creates a new frame with the timestamp adjusted by the given offset.
  ///
  /// Useful for synchronizing drawing frames with state frame timelines.
  DrawingFrame withTimestampOffset(Duration offset) {
    return copyWith(timestamp: timestamp + offset);
  }

  /// Creates a simplified frame containing only operations of specified types.
  ///
  /// Useful for focused testing of specific drawing aspects.
  ///
  /// Example:
  /// ```dart
  /// // Extract only text operations for font testing
  /// final textOnlyFrame = frame.withOnlyOperationTypes([DrawText]);
  /// ```
  DrawingFrame withOnlyOperationTypes(List<Type> operationTypes) {
    final filteredOperations = commands.operations.where((op) => operationTypes.contains(op.runtimeType)).toList();

    return copyWith(
      commands: commands.copyWith(operations: filteredOperations),
    );
  }
}

/// Extension methods for drawing commands analysis.
extension DrawingCommandsX on DrawingCommands {
  /// Groups operations by type for analysis.
  ///
  /// Returns a map where keys are operation type names and values are
  /// lists of operations of that type.
  Map<String, List<DrawingOperation>> get operationsByType {
    final groups = <String, List<DrawingOperation>>{};

    for (final operation in operations) {
      final typeName = operation.runtimeType.toString();
      groups.putIfAbsent(typeName, () => []).add(operation);
    }

    return groups;
  }

  /// Total number of each operation type.
  Map<String, int> get operationCounts {
    return operationsByType.map((type, ops) => MapEntry(type, ops.length));
  }

  /// Bounding rectangle that encompasses all drawing operations.
  ///
  /// Useful for understanding the drawing area used by the widget.
  /// Returns null if no operations have position information.
  Rect? get boundingRect {
    double? minX, minY, maxX, maxY;

    for (final operation in operations) {
      Rect? opBounds;

      operation.when(
        rect: (rect, paint) => opBounds = rect,
        circle: (center, radius, paint) => opBounds = Rect.fromCircle(center: center, radius: radius),
        oval: (rect, paint) => opBounds = rect,
        line: (p1, p2, paint) => opBounds = Rect.fromPoints(p1, p2),
        path: (pathData, paint) => {},
        // Would need path parsing
        text: (text, offset, textStyle) => {},
        // Would need text measurement
        image: (offset, size, imageHash, paint) =>
            opBounds = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
        points: (points, pointMode, paint) => {
          if (points.isNotEmpty)
            {
              opBounds = Rect.fromPoints(
                points.reduce((a, b) => Offset(math.min(a.dx, b.dx), math.min(a.dy, b.dy))),
                points.reduce((a, b) => Offset(math.max(a.dx, b.dx), math.max(a.dy, b.dy))),
              ),
            }
        },
        roundedRect: (rect, radiusX, radiusY, paint) => opBounds = rect,
        custom: (operationType, parameters) => {}, // Can't determine bounds
      );

      if (opBounds != null) {
        minX = minX == null ? opBounds!.left : math.min(minX, opBounds!.left);
        minY = minY == null ? opBounds!.top : math.min(minY, opBounds!.top);
        maxX = maxX == null ? opBounds!.right : math.max(maxX, opBounds!.right);
        maxY = maxY == null ? opBounds!.bottom : math.max(maxY, opBounds!.bottom);
      }
    }

    return (minX != null && minY != null && maxX != null && maxY != null)
        ? Rect.fromLTRB(minX, minY, maxX, maxY)
        : null;
  }
}
