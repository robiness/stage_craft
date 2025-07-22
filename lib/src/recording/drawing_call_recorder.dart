import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/recording/recorder.dart';

/// A recorded drawing call with method name and serialized arguments.
class DrawingCall {
  const DrawingCall({
    required this.method,
    required this.args,
    required this.timestamp,
  });

  /// The drawing method name (e.g., 'drawRect', 'drawCircle').
  final String method;

  /// The serialized arguments for the drawing call.
  final Map<String, dynamic> args;

  /// When the call was made.
  final DateTime timestamp;

  /// Converts this call to JSON.
  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'args': args,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Creates a call from JSON.
  static DrawingCall fromJson(Map<String, dynamic> json) {
    return DrawingCall(
      method: json['method'] as String,
      args: json['args'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DrawingCall &&
        other.method == method &&
        _deepEqual(other.args, args);
  }

  @override
  int get hashCode => Object.hash(method, args.hashCode);

  bool _deepEqual(Map<String, dynamic> a, Map<String, dynamic> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key)) return false;
      final valueA = a[key];
      final valueB = b[key];
      if (valueA is Map && valueB is Map) {
        if (!_deepEqual(valueA.cast<String, dynamic>(), valueB.cast<String, dynamic>())) {
          return false;
        }
      } else if (valueA != valueB) {
        return false;
      }
    }
    return true;
  }
}

/// Data structure for all recorded drawing calls.
class DrawingRecordingData {
  const DrawingRecordingData({required this.calls});

  /// All recorded drawing calls.
  final List<DrawingCall> calls;

  /// Converts this data to JSON.
  Map<String, dynamic> toJson() {
    return {
      'calls': calls.map((e) => e.toJson()).toList(),
    };
  }

  /// Creates data from JSON.
  static DrawingRecordingData fromJson(Map<String, dynamic> json) {
    return DrawingRecordingData(
      calls: (json['calls'] as List)
          .map((e) => DrawingCall.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Records drawing calls from a TestRecordingCanvas.
class DrawingCallRecorder implements Recorder<DrawingRecordingData> {
  bool _isRecording = false;
  final List<DrawingCall> _calls = [];
  TestRecordingCanvas? _recordingCanvas;

  @override
  bool get isRecording => _isRecording;

  @override
  DrawingRecordingData get data {
    return DrawingRecordingData(calls: List.from(_calls));
  }

  /// The recording canvas - set by DrawingInterceptor.
  TestRecordingCanvas? get recordingCanvas => _recordingCanvas;

  /// Sets the recording canvas and processes its invocations.
  void setRecordingCanvas(TestRecordingCanvas canvas) {
    _recordingCanvas = canvas;
    if (_isRecording) {
      _processCanvasInvocations();
    }
  }

  @override
  void start() {
    _isRecording = true;
    clear();
  }

  @override
  void stop() {
    _isRecording = false;
    if (_recordingCanvas != null) {
      _processCanvasInvocations();
    }
  }

  @override
  void clear() {
    _calls.clear();
  }

  void _processCanvasInvocations() {
    if (_recordingCanvas == null) return;

    for (final invocation in _recordingCanvas!.invocations) {
      try {
        final call = _serializeInvocation(invocation);
        if (call != null) {
          _calls.add(call);
        }
      } catch (e) {
        debugPrint('Failed to serialize drawing call: $e');
      }
    }
  }

  DrawingCall? _serializeInvocation(RecordedInvocation recordedInvocation) {
    final invocation = recordedInvocation.invocation;
    final methodName = invocation.memberName.toString();
    final args = <String, dynamic>{};
    final now = DateTime.now();

    // Handle different drawing methods
    switch (methodName) {
      case 'Symbol("drawRect")':
        if (invocation.positionalArguments.length >= 2) {
          args['rect'] = _serializeRect(invocation.positionalArguments[0] as Rect);
          args['paint'] = _serializePaint(invocation.positionalArguments[1] as Paint);
        }
        return DrawingCall(method: 'drawRect', args: args, timestamp: now);

      case 'Symbol("drawCircle")':
        if (invocation.positionalArguments.length >= 3) {
          args['center'] = _serializeOffset(invocation.positionalArguments[0] as Offset);
          args['radius'] = invocation.positionalArguments[1] as double;
          args['paint'] = _serializePaint(invocation.positionalArguments[2] as Paint);
        }
        return DrawingCall(method: 'drawCircle', args: args, timestamp: now);

      case 'Symbol("drawLine")':
        if (invocation.positionalArguments.length >= 3) {
          args['p1'] = _serializeOffset(invocation.positionalArguments[0] as Offset);
          args['p2'] = _serializeOffset(invocation.positionalArguments[1] as Offset);
          args['paint'] = _serializePaint(invocation.positionalArguments[2] as Paint);
        }
        return DrawingCall(method: 'drawLine', args: args, timestamp: now);

      case 'Symbol("drawPath")':
        if (invocation.positionalArguments.length >= 2) {
          args['path'] = _serializePath(invocation.positionalArguments[0] as Path);
          args['paint'] = _serializePaint(invocation.positionalArguments[1] as Paint);
        }
        return DrawingCall(method: 'drawPath', args: args, timestamp: now);

      case 'Symbol("clipRect")':
        if (invocation.positionalArguments.length >= 1) {
          args['rect'] = _serializeRect(invocation.positionalArguments[0] as Rect);
          if (invocation.positionalArguments.length >= 2) {
            // ClipOp serialization - handle as int for now
            args['clipOp'] = 0; // Default clip operation
          }
          if (invocation.positionalArguments.length >= 3) {
            args['doAntiAlias'] = invocation.positionalArguments[2] as bool;
          }
        }
        return DrawingCall(method: 'clipRect', args: args, timestamp: now);

      case 'Symbol("save")':
        return DrawingCall(method: 'save', args: {}, timestamp: now);

      case 'Symbol("restore")':
        return DrawingCall(method: 'restore', args: {}, timestamp: now);

      case 'Symbol("translate")':
        if (invocation.positionalArguments.length >= 2) {
          args['dx'] = invocation.positionalArguments[0] as double;
          args['dy'] = invocation.positionalArguments[1] as double;
        }
        return DrawingCall(method: 'translate', args: args, timestamp: now);

      case 'Symbol("scale")':
        if (invocation.positionalArguments.length >= 1) {
          args['sx'] = invocation.positionalArguments[0] as double;
          if (invocation.positionalArguments.length >= 2) {
            args['sy'] = invocation.positionalArguments[1] as double;
          }
        }
        return DrawingCall(method: 'scale', args: args, timestamp: now);

      default:
        // For unknown methods, just record the method name
        return DrawingCall(
          method: methodName.replaceAll('Symbol("', '').replaceAll('")', ''),
          args: {'unknown': true},
          timestamp: now,
        );
    }
  }

  Map<String, dynamic> _serializeRect(Rect rect) {
    return {
      'left': rect.left,
      'top': rect.top,
      'right': rect.right,
      'bottom': rect.bottom,
    };
  }

  Map<String, dynamic> _serializeOffset(Offset offset) {
    return {
      'dx': offset.dx,
      'dy': offset.dy,
    };
  }

  Map<String, dynamic> _serializePaint(Paint paint) {
    return {
      'color': paint.color.toARGB32(),
      'strokeWidth': paint.strokeWidth,
      'style': paint.style.index,
      'isAntiAlias': paint.isAntiAlias,
    };
  }

  Map<String, dynamic> _serializePath(Path path) {
    // For now, just record that a path was used
    // A full path serialization would require more complex handling
    return {
      'pathMetrics': 'complex_path_data',
    };
  }
}

/// Widget that intercepts drawing calls using TestRecordingCanvas.
class DrawingInterceptor extends StatelessWidget {
  const DrawingInterceptor({
    super.key,
    required this.child,
    this.recorder,
    this.onPictureRecorded,
  });

  /// The widget to intercept drawing calls for.
  final Widget child;

  /// Optional recorder to capture the drawing calls.
  final DrawingCallRecorder? recorder;

  /// Optional callback when a picture is recorded.
  final void Function(ui.Picture picture)? onPictureRecorded;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _InterceptingPainter(
          recorder: recorder,
          onPictureRecorded: onPictureRecorded,
        ),
        child: child,
      ),
    );
  }
}

/// Custom painter that uses TestRecordingCanvas to intercept drawing calls.
class _InterceptingPainter extends CustomPainter {
  const _InterceptingPainter({
    this.recorder,
    this.onPictureRecorded,
  });

  final DrawingCallRecorder? recorder;
  final void Function(ui.Picture picture)? onPictureRecorded;

  @override
  void paint(Canvas canvas, Size size) {
    // Create a recorder to capture drawing commands
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final recordingCanvas = Canvas(pictureRecorder, Rect.fromLTWH(0, 0, size.width, size.height));
    
    // Create a TestRecordingCanvas for recording invocations
    final testRecordingCanvas = TestRecordingCanvas();

    // Set the recording canvas in the recorder if available
    recorder?.setRecordingCanvas(testRecordingCanvas);

    // For demonstration, we'll create some sample drawing calls
    // In a real implementation, this would involve rendering the actual widget
    _drawSampleContent(recordingCanvas, size);
    _drawSampleContent(testRecordingCanvas, size);

    // Finish recording
    final ui.Picture picture = pictureRecorder.endRecording();
    onPictureRecorded?.call(picture);

    // Draw the captured picture to the main canvas
    canvas.drawPicture(picture);
  }

  void _drawSampleContent(Canvas canvas, Size size) {
    // This is a placeholder for actual widget rendering
    // In practice, you would need to render the child widget's RenderObject
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.1,
      Paint()..color = Colors.red,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint for recording purposes
  }
}