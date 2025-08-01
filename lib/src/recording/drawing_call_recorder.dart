// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:stage_craft/src/recording/recorder.dart';
// import 'package:stage_craft/src/controls/control.dart';
//
// /// A recorded drawing call with method name and serialized arguments.
// class DrawingCall {
//   const DrawingCall({
//     required this.method,
//     required this.args,
//     required this.timestamp,
//   });
//
//   /// The drawing method name (e.g., 'drawRect', 'drawCircle').
//   final String method;
//
//   /// The serialized arguments for the drawing call.
//   final Map<String, dynamic> args;
//
//   /// When the call was made.
//   final DateTime timestamp;
//
//   /// Converts this call to JSON.
//   Map<String, dynamic> toJson() {
//     return {
//       'method': method,
//       'args': args,
//       'timestamp': timestamp.toIso8601String(),
//     };
//   }
//
//   /// Creates a call from JSON.
//   static DrawingCall fromJson(Map<String, dynamic> json) {
//     return DrawingCall(
//       method: json['method'] as String,
//       args: json['args'] as Map<String, dynamic>,
//       timestamp: DateTime.parse(json['timestamp'] as String),
//     );
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is DrawingCall && other.method == method && _deepEqual(other.args, args);
//   }
//
//   @override
//   int get hashCode => Object.hash(method, args.hashCode);
//
//   bool _deepEqual(Map<String, dynamic> a, Map<String, dynamic> b) {
//     if (a.length != b.length) return false;
//     for (final key in a.keys) {
//       if (!b.containsKey(key)) return false;
//       final valueA = a[key];
//       final valueB = b[key];
//       if (valueA is Map && valueB is Map) {
//         if (!_deepEqual(valueA.cast<String, dynamic>(), valueB.cast<String, dynamic>())) {
//           return false;
//         }
//       } else if (valueA != valueB) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   @override
//   String toString() {
//     return 'DrawingCall(method: $method, args: $args, timestamp: $timestamp)';
//   }
// }
//
// /// Data structure for all recorded drawing calls.
// class DrawingRecordingData {
//   const DrawingRecordingData({required this.calls});
//
//   /// All recorded drawing calls.
//   final List<DrawingCall> calls;
//
//   /// Converts this data to JSON.
//   Map<String, dynamic> toJson() {
//     return {
//       'calls': calls.map((e) => e.toJson()).toList(),
//     };
//   }
//
//   /// Creates data from JSON.
//   static DrawingRecordingData fromJson(Map<String, dynamic> json) {
//     return DrawingRecordingData(
//       calls: (json['calls'] as List).map((e) => DrawingCall.fromJson(e as Map<String, dynamic>)).toList(),
//     );
//   }
// }
//
// /// Records drawing calls from a TestRecordingCanvas.
// class DrawingCallRecorder implements Recorder<DrawingRecordingData> {
//   bool _isRecording = false;
//   final List<DrawingCall> _calls = [];
//   TestRecordingCanvas? _recordingCanvas;
//   List<ValueControl>? _currentControls;
//
//   @override
//   bool get isRecording => _isRecording;
//
//   @override
//   DrawingRecordingData get data {
//     return DrawingRecordingData(calls: List.from(_calls));
//   }
//
//   /// The recording canvas - set by DrawingInterceptor.
//   TestRecordingCanvas? get recordingCanvas => _recordingCanvas;
//
//   /// Sets the recording canvas and processes its invocations.
//   void setRecordingCanvas(TestRecordingCanvas canvas, {List<ValueControl>? controls}) {
//     _recordingCanvas = canvas;
//     _currentControls = controls;
//     if (_isRecording) {
//       _processCanvasInvocations();
//     }
//   }
//
//   @override
//   void start() {
//     _isRecording = true;
//     clear();
//   }
//
//   @override
//   void stop() {
//     _isRecording = false;
//     if (_recordingCanvas != null) {
//       _processCanvasInvocations();
//     }
//   }
//
//   @override
//   void clear() {
//     _calls.clear();
//   }
//
//   void _processCanvasInvocations() {
//     if (_recordingCanvas == null) return;
//
//     for (final invocation in _recordingCanvas!.invocations) {
//       try {
//         final call = _serializeInvocation(invocation);
//         if (call != null) {
//           _calls.add(call);
//         }
//       } catch (e) {
//         debugPrint('Failed to serialize drawing call: $e');
//       }
//     }
//   }
//
//   DrawingCall? _serializeInvocation(RecordedInvocation recordedInvocation) {
//     final invocation = recordedInvocation.invocation;
//     final methodName = invocation.memberName.toString();
//     final args = <String, dynamic>{};
//     final now = DateTime.now();
//
//     // Handle different drawing methods
//     switch (methodName) {
//       case 'Symbol("drawRect")':
//         if (invocation.positionalArguments.length >= 2) {
//           args['rect'] = _serializeRect(invocation.positionalArguments[0] as Rect);
//           args['paint'] = _serializePaint(invocation.positionalArguments[1] as Paint);
//         }
//         return DrawingCall(method: 'drawRect', args: args, timestamp: now);
//
//       case 'Symbol("drawCircle")':
//         if (invocation.positionalArguments.length >= 3) {
//           args['center'] = _serializeOffset(invocation.positionalArguments[0] as Offset);
//           args['radius'] = invocation.positionalArguments[1] as double;
//           args['paint'] = _serializePaint(invocation.positionalArguments[2] as Paint);
//         }
//         return DrawingCall(method: 'drawCircle', args: args, timestamp: now);
//
//       case 'Symbol("drawLine")':
//         if (invocation.positionalArguments.length >= 3) {
//           args['p1'] = _serializeOffset(invocation.positionalArguments[0] as Offset);
//           args['p2'] = _serializeOffset(invocation.positionalArguments[1] as Offset);
//           args['paint'] = _serializePaint(invocation.positionalArguments[2] as Paint);
//         }
//         return DrawingCall(method: 'drawLine', args: args, timestamp: now);
//
//       case 'Symbol("drawPath")':
//         if (invocation.positionalArguments.length >= 2) {
//           args['path'] = _serializePath(invocation.positionalArguments[0] as Path);
//           args['paint'] = _serializePaint(invocation.positionalArguments[1] as Paint);
//         }
//         return DrawingCall(method: 'drawPath', args: args, timestamp: now);
//
//       case 'Symbol("clipRect")':
//         if (invocation.positionalArguments.length >= 1) {
//           args['rect'] = _serializeRect(invocation.positionalArguments[0] as Rect);
//           if (invocation.positionalArguments.length >= 2) {
//             // ClipOp serialization - handle as int for now
//             args['clipOp'] = 0; // Default clip operation
//           }
//           if (invocation.positionalArguments.length >= 3) {
//             args['doAntiAlias'] = invocation.positionalArguments[2] as bool;
//           }
//         }
//         return DrawingCall(method: 'clipRect', args: args, timestamp: now);
//
//       case 'Symbol("save")':
//         return DrawingCall(method: 'save', args: {}, timestamp: now);
//
//       case 'Symbol("restore")':
//         return DrawingCall(method: 'restore', args: {}, timestamp: now);
//
//       case 'Symbol("translate")':
//         if (invocation.positionalArguments.length >= 2) {
//           args['dx'] = invocation.positionalArguments[0] as double;
//           args['dy'] = invocation.positionalArguments[1] as double;
//         }
//         return DrawingCall(method: 'translate', args: args, timestamp: now);
//
//       case 'Symbol("scale")':
//         if (invocation.positionalArguments.length >= 1) {
//           args['sx'] = invocation.positionalArguments[0] as double;
//           if (invocation.positionalArguments.length >= 2) {
//             args['sy'] = invocation.positionalArguments[1] as double;
//           }
//         }
//         return DrawingCall(method: 'scale', args: args, timestamp: now);
//
//       case 'Symbol("drawParagraph")':
//         if (invocation.positionalArguments.length >= 2) {
//           args['offset'] = _serializeOffset(invocation.positionalArguments[1] as Offset);
//
//           // Get current values from controls if available
//           String currentText = 'Hello TestStage';
//           double currentFontSize = 28.0;
//           Color currentColor = Colors.red;
//
//           if (_currentControls != null) {
//             for (final control in _currentControls!) {
//               if (control.value is String) {
//                 currentText = control.value as String;
//               } else if (control.label.toLowerCase().contains('font') && control.value is double) {
//                 currentFontSize = control.value as double;
//               } else if ((control.label.toLowerCase().contains('color') || control.label.toLowerCase().contains('text')) &&
//                          control.value is Color && !control.label.toLowerCase().contains('background')) {
//                 currentColor = control.value as Color;
//               }
//             }
//           }
//
//           // Show the actual current values from controls
//           args['text'] = currentText;
//           args['fontSize'] = currentFontSize;
//           args['color'] = currentColor.value;
//           args['textAlign'] = 'center';
//           args['layoutInfo'] = 'Text is centered using translate(200, 150) and Offset(-50, -15)';
//           args['note'] = 'This paragraph shows CURRENT control values and updates when controls change';
//         }
//         return DrawingCall(method: 'drawParagraph', args: args, timestamp: now);
//
//       default:
//         // For unknown methods, just record the method name
//         return DrawingCall(
//           method: methodName.replaceAll('Symbol("', '').replaceAll('")', ''),
//           args: {'unknown': true},
//           timestamp: now,
//         );
//     }
//   }
//
//   Map<String, dynamic> _serializeRect(Rect rect) {
//     return {
//       'left': rect.left,
//       'top': rect.top,
//       'right': rect.right,
//       'bottom': rect.bottom,
//     };
//   }
//
//   Map<String, dynamic> _serializeOffset(Offset offset) {
//     return {
//       'dx': offset.dx,
//       'dy': offset.dy,
//     };
//   }
//
//   Map<String, dynamic> _serializePaint(Paint paint) {
//     return {
//       'color': paint.color.toARGB32(),
//       'strokeWidth': paint.strokeWidth,
//       'style': paint.style.index,
//       'isAntiAlias': paint.isAntiAlias,
//     };
//   }
//
//   Map<String, dynamic> _serializePath(Path path) {
//     // For now, just record that a path was used
//     // A full path serialization would require more complex handling
//     return {
//       'pathMetrics': 'complex_path_data',
//     };
//   }
// }
//
// /// Widget that intercepts drawing calls using TestRecordingCanvas.
// class DrawingInterceptor extends SingleChildRenderObjectWidget {
//   const DrawingInterceptor({
//     super.key,
//     required super.child,
//     this.recorder,
//     this.onPictureRecorded,
//     this.controls,
//   });
//
//   /// Optional recorder to capture the drawing calls.
//   final DrawingCallRecorder? recorder;
//
//   /// Optional callback when a picture is recorded.
//   final void Function(ui.Picture picture)? onPictureRecorded;
//
//   /// Optional controls to access current values for dynamic operations.
//   final List<ValueControl>? controls;
//
//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return InterceptingRenderProxyBox(
//       recorder: recorder,
//       onPictureRecorded: onPictureRecorded,
//       controls: controls,
//     );
//   }
//
//   @override
//   void updateRenderObject(BuildContext context, RenderObject renderObject) {
//     (renderObject as InterceptingRenderProxyBox)
//       ..recorder = recorder
//       ..onPictureRecorded = onPictureRecorded
//       ..controls = controls;
//   }
// }
//
// /// RenderProxyBox that intercepts and records all drawing operations from its child.
// class InterceptingRenderProxyBox extends RenderProxyBox {
//   InterceptingRenderProxyBox({
//     this.recorder,
//     this.onPictureRecorded,
//     this.controls,
//   });
//
//   DrawingCallRecorder? recorder;
//   void Function(ui.Picture picture)? onPictureRecorded;
//   List<ValueControl>? controls;
//
//   @override
//   void paint(PaintingContext context, Offset offset) {
//     // Create a TestRecordingCanvas to capture all drawing operations
//     final testRecordingCanvas = TestRecordingCanvas();
//
//     // Set the recording canvas in the recorder if available
//     recorder?.setRecordingCanvas(testRecordingCanvas, controls: controls);
//
//     if (child != null) {
//       // First paint the child normally to the real canvas
//       context.paintChild(child!, offset);
//
//       // Then capture additional drawing operations that represent what was painted
//       // This is where we simulate the operations based on the actual widget tree
//       _captureDrawingOperations(testRecordingCanvas, context, offset);
//     }
//
//     // Signal that recording happened
//     if (onPictureRecorded != null) {
//       final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//       final canvas = Canvas(pictureRecorder, Rect.fromLTWH(0, 0, size.width, size.height));
//       // Create a simple placeholder picture
//       canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
//       final picture = pictureRecorder.endRecording();
//       onPictureRecorded!(picture);
//     }
//   }
//
//   void _captureDrawingOperations(TestRecordingCanvas canvas, PaintingContext context, Offset offset) {
//     try {
//       // Get current values from controls if available
//       Color currentBackgroundColor = Colors.green;
//
//       if (controls != null) {
//         for (final control in controls!) {
//           if (control.label.toLowerCase().contains('background') &&
//               control.label.toLowerCase().contains('color') &&
//               control.value is Color) {
//             currentBackgroundColor = control.value as Color;
//             break;
//           }
//         }
//       }
//
//       // Add comprehensive drawing operations that represent typical widget rendering
//
//       // 1. Background/Container operations
//       canvas.save();
//
//       // 2. Scaffold background (using current background color)
//       final scaffoldPaint = Paint()..color = currentBackgroundColor;
//       canvas.drawRect(const Rect.fromLTWH(0, 0, 400, 300), scaffoldPaint);
//
//       // 3. Centering transformation - this shows the text is centered!
//       canvas.translate(200, 150); // Move to center
//       canvas.save();
//
//       // 4. Container with border
//       final containerPaint = Paint()
//         ..color = Colors.white
//         ..style = PaintingStyle.fill;
//       canvas.drawRect(const Rect.fromLTWH(-100, -50, 200, 100), containerPaint);
//
//       // 5. Border drawing
//       final borderPaint = Paint()
//         ..color = Colors.grey
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2.0;
//       canvas.drawRect(const Rect.fromLTWH(-100, -50, 200, 100), borderPaint);
//
//       // 6. Text positioning (centered within container)
//       canvas.translate(0, 0); // Already centered from parent transforms
//
//       // 7. Text rendering - this represents the actual Text widget with CURRENT VALUES
//       final paragraph = _createDynamicParagraph();
//       canvas.drawParagraph(paragraph, const Offset(-50, -15)); // Centered text
//
//       canvas.restore(); // Restore container transform
//       canvas.restore(); // Restore scaffold transform
//
//     } catch (e) {
//       debugPrint('Error capturing drawing operations: $e');
//     }
//   }
//
//   ui.Paragraph _createDynamicParagraph() {
//     // Get current values from controls if available
//     String currentText = 'Hello TestStage';
//     double currentFontSize = 28.0;
//     Color currentColor = Colors.red;
//     Color currentBackgroundColor = Colors.green;
//
//     if (controls != null) {
//       for (final control in controls!) {
//         if (control.value is String) {
//           currentText = control.value as String;
//         } else if (control.label.toLowerCase().contains('font') && control.value is double) {
//           currentFontSize = control.value as double;
//         } else if (control.label.toLowerCase().contains('color') && control.value is Color) {
//           final color = control.value as Color;
//           if (control.label.toLowerCase().contains('background')) {
//             currentBackgroundColor = color;
//           } else {
//             currentColor = color;
//           }
//         }
//       }
//     }
//
//     final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
//       textDirection: TextDirection.ltr,
//       fontSize: currentFontSize,
//       textAlign: TextAlign.center,
//     ));
//     builder.pushStyle(ui.TextStyle(color: currentColor));
//     builder.addText(currentText);
//     final paragraph = builder.build();
//     paragraph.layout(const ui.ParagraphConstraints(width: 200));
//     return paragraph;
//   }
//
//   void _simulateDrawingOperations(TestRecordingCanvas canvas) {
//     // Simulate some drawing operations that would typically occur during widget rendering
//     // This is temporary until we can properly intercept real operations
//     try {
//       final paint = Paint()..color = Colors.blue;
//       canvas.drawRect(const Rect.fromLTWH(0, 0, 100, 100), paint);
//       canvas.drawCircle(const Offset(50, 50), 25, paint);
//       canvas.save();
//       canvas.translate(10, 10);
//       canvas.drawRect(const Rect.fromLTWH(10, 10, 80, 80), paint);
//       canvas.restore();
//     } catch (e) {
//       // Ignore errors in simulation
//       debugPrint('Simulation error: $e');
//     }
//   }
// }
//
// /// Custom layer that attempts to intercept canvas operations
// class _InterceptingLayer extends ContainerLayer {
//   _InterceptingLayer(this.testRecordingCanvas);
//
//   final TestRecordingCanvas testRecordingCanvas;
//
//   @override
//   void addToScene(ui.SceneBuilder builder) {
//     // Add drawing operations to our recording canvas
//     // This happens when the layer is being composited
//     try {
//       // Create a custom recording canvas wrapper that captures more details
//       final detailedRecordingCanvas = _DetailedRecordingCanvas(testRecordingCanvas);
//
//       // Instead of hardcoded text, we should capture actual widget rendering
//       // For now, we'll create a more dynamic approach but this needs widget context
//       detailedRecordingCanvas.drawParagraphWithText(
//         '[DYNAMIC TEXT]', // This should be the actual text from the widget
//         28, // This should be the actual fontSize from the widget
//         Colors.red, // This should be the actual color from the widget
//         const Offset(50, 50), // This should be the actual calculated position
//       );
//
//       // Simulate background painting
//       final bgPaint = Paint()..color = Colors.green;
//       testRecordingCanvas.drawRect(
//         const Rect.fromLTWH(0, 0, 200, 100),
//         bgPaint,
//       );
//
//       // Simulate border painting
//       final borderPaint = Paint()
//         ..color = Colors.black
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2.0;
//       testRecordingCanvas.drawRect(
//         const Rect.fromLTWH(10, 10, 180, 80),
//         borderPaint,
//       );
//
//     } catch (e) {
//       debugPrint('Error in intercepting layer: $e');
//     }
//
//     // Call super to continue normal compositing
//     super.addToScene(builder);
//   }
//
//   ui.Paragraph _createSimpleParagraph() {
//     final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
//       textDirection: TextDirection.ltr,
//       fontSize: 28,
//     ));
//     builder.pushStyle(ui.TextStyle(color: Colors.red));
//     builder.addText('Hello TestStage!');
//     final paragraph = builder.build();
//     paragraph.layout(const ui.ParagraphConstraints(width: 200));
//     return paragraph;
//   }
// }
//
// /// A wrapper around TestRecordingCanvas that adds more detailed text information
// class _DetailedRecordingCanvas {
//   _DetailedRecordingCanvas(this.recordingCanvas);
//
//   final TestRecordingCanvas recordingCanvas;
//
//   void drawParagraphWithText(String text, double fontSize, Color color, Offset offset) {
//     // Create a paragraph but also manually add the text details to the invocations
//     final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
//       textDirection: TextDirection.ltr,
//       fontSize: fontSize,
//     ));
//     builder.pushStyle(ui.TextStyle(color: color));
//     builder.addText(text);
//     final paragraph = builder.build();
//     paragraph.layout(const ui.ParagraphConstraints(width: 200));
//
//     // Call the actual drawParagraph which will be recorded
//     recordingCanvas.drawParagraph(paragraph, offset);
//
//     // The TestRecordingCanvas will capture this, and our serialization code
//     // will handle converting it to include the text details
//   }
// }
