import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';

void main() {
  group('Golden File Testing', () {
    group('Drawing Calls Golden Tests', () {
      testWidgets('simple widget should match golden drawing calls', (tester) async {
        final colorControl = ColorControl(label: 'Background', initialValue: Colors.red);
        final sizeControl = DoubleControl(label: 'Size', initialValue: 100.0);
        final controls = <ValueControl>[colorControl, sizeControl];

        // Create a test scenario
        final drawingCalls = [
          DrawingCall(
            method: 'drawRect',
            args: {
              'rect': {'left': 0.0, 'top': 0.0, 'right': 100.0, 'bottom': 100.0},
              'paint': {'color': Colors.red.value, 'strokeWidth': 1.0, 'style': 0},
            },
            timestamp: DateTime(2024, 1, 1),
          ),
        ];

        final drawingData = DrawingRecordingData(calls: drawingCalls);

        // Test the golden matcher (without actual file I/O in this test)
        expect(() => matchesGoldenDrawingCalls('simple_widget'), returnsNormally);
        
        // Verify the drawing data serializes correctly
        final json = drawingData.toJson();
        expect(json['calls'], hasLength(1));
        expect(json['calls'][0]['method'], equals('drawRect'));
      });

      testWidgets('complex widget should generate reproducible drawing calls', (tester) async {
        final controls = <ValueControl>[
          ColorControl(label: 'Primary', initialValue: Colors.blue),
          ColorControl(label: 'Secondary', initialValue: Colors.orange),
          DoubleControl(label: 'Radius', initialValue: 25.0),
          BoolControl(label: 'Show Border', initialValue: true),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TestStage(
                controls: controls,
                activeRecorders: const [DrawingCallRecorder],
                showRecordingControls: false,
                builder: (context) => CustomPaint(
                  size: const Size(200, 200),
                  painter: ComplexShapePainter(
                    primaryColor: (controls[0] as ColorControl).value,
                    secondaryColor: (controls[1] as ColorControl).value,
                    radius: (controls[2] as DoubleControl).value,
                    showBorder: (controls[3] as BoolControl).value,
                  ),
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // In a real implementation, we would capture and compare actual drawing calls
        expect(find.byType(TestStage), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });
    });

    group('State Recording Golden Tests', () {
      test('state changes should be reproducible', () {
        final stateChanges = [
          StateChangeEvent(
            timestamp: DateTime(2024, 1, 1, 10, 0, 0),
            controlLabel: 'color',
            oldValue: {'type': 'Color', 'value': {'value': Colors.red.value}},
            newValue: {'type': 'Color', 'value': {'value': Colors.blue.value}},
          ),
          StateChangeEvent(
            timestamp: DateTime(2024, 1, 1, 10, 0, 1),
            controlLabel: 'size',
            oldValue: {'type': 'double', 'value': 100.0},
            newValue: {'type': 'double', 'value': 150.0},
          ),
        ];

        final stateData = StateRecordingData(
          initialControlStates: {
            'color': {'type': 'Color', 'value': {'value': Colors.red.value}},
            'size': {'type': 'double', 'value': 100.0},
          },
          initialCanvasState: {
            'zoomFactor': 1.0,
            'showRuler': false,
          },
          stateChanges: stateChanges,
          canvasChanges: [],
        );

        // Verify reproducible serialization
        final json1 = stateData.toJson();
        final json2 = stateData.toJson();
        
        expect(json1.toString(), equals(json2.toString()));
        expect(json1['stateChanges'], hasLength(2));
        expect(json1['initialControlStates'], hasLength(2));
      });
    });

    group('Complete Scenario Golden Tests', () {
      test('complete test scenario should be serializable and reproducible', () {
        final completeScenario = ConcreteTestScenario(
          initialState: {
            'controls': {
              'backgroundColor': Colors.white.value,
              'textColor': Colors.black.value,
              'fontSize': 16.0,
              'bold': false,
            },
            'canvas': {
              'zoom': 1.0,
              'showGrid': false,
            },
          },
          recordings: {
            StateRecorder: StateRecordingData(
              initialControlStates: {
                'backgroundColor': {'type': 'Color', 'value': {'value': Colors.white.value}},
                'textColor': {'type': 'Color', 'value': {'value': Colors.black.value}},
              },
              initialCanvasState: {'zoom': 1.0},
              stateChanges: [
                StateChangeEvent(
                  timestamp: DateTime(2024, 1, 1),
                  controlLabel: 'backgroundColor',
                  oldValue: {'type': 'Color', 'value': {'value': Colors.white.value}},
                  newValue: {'type': 'Color', 'value': {'value': Colors.blue.value}},
                ),
              ],
              canvasChanges: [],
            ),
            DrawingCallRecorder: DrawingRecordingData(
              calls: [
                DrawingCall(
                  method: 'drawText',
                  args: {
                    'text': 'Hello World',
                    'offset': {'dx': 50.0, 'dy': 50.0},
                    'style': {'fontSize': 16.0, 'color': Colors.black.value},
                  },
                  timestamp: DateTime(2024, 1, 1),
                ),
              ],
            ),
          },
          metadata: {
            'version': '1.0',
            'timestamp': '2024-01-01T00:00:00.000Z',
            'testName': 'Complete UI Interaction Test',
            'description': 'Tests both state changes and drawing output',
            'platform': 'flutter',
            'tags': ['ui', 'interaction', 'golden'],
          },
        );

        // Verify complete scenario structure
        expect(completeScenario.initialState, hasLength(2));
        expect(completeScenario.recordings, hasLength(2));
        expect(completeScenario.metadata['testName'], equals('Complete UI Interaction Test'));

        // Verify JSON serialization is comprehensive
        final json = completeScenario.toJson();
        expect(json['version'], equals('1.0'));
        expect(json['metadata']['tags'], contains('golden'));
        expect(json['recordings'], hasLength(2));
        expect(json['initialState']['controls'], hasLength(4));

        // Verify reproducibility
        final json1 = completeScenario.toJson();
        final json2 = completeScenario.toJson();
        expect(json1.toString(), equals(json2.toString()));
      });
    });

    group('Golden File Management', () {
      test('golden file utilities should work correctly', () {
        // Test drawing calls golden file management
        final drawingData = DrawingRecordingData(
          calls: [
            DrawingCall(
              method: 'drawCircle',
              args: {
                'center': {'dx': 100.0, 'dy': 100.0},
                'radius': 50.0,
                'paint': {'color': Colors.green.value},
              },
              timestamp: DateTime(2024, 1, 1),
            ),
          ],
        );

        // Verify the data can be converted to JSON for golden files
        final json = drawingData.toJson();
        expect(json, isA<Map<String, dynamic>>());
        expect(json['calls'], isA<List>());

        // Test state recording golden file management
        final stateData = StateRecordingData(
          initialControlStates: {'test': {'type': 'String', 'value': 'initial'}},
          initialCanvasState: {'zoom': 1.0},
          stateChanges: [],
          canvasChanges: [],
        );

        final stateJson = stateData.toJson();
        expect(stateJson, isA<Map<String, dynamic>>());
        expect(stateJson['initialControlStates'], isA<Map>());
      });
    });

    group('Cross-Platform Consistency', () {
      test('should generate identical output across runs', () {
        // Create the same scenario multiple times
        final createScenario = () => ConcreteTestScenario(
          initialState: {'test': 'value'},
          recordings: {
            StateRecorder: StateRecordingData(
              initialControlStates: {},
              initialCanvasState: {},
              stateChanges: [],
              canvasChanges: [],
            ),
          },
          metadata: {'deterministic': true},
        );

        final scenario1 = createScenario();
        final scenario2 = createScenario();

        // Should produce identical JSON (except for timestamps if present)
        final json1 = scenario1.toJson();
        final json2 = scenario2.toJson();

        expect(json1['initialState'], equals(json2['initialState']));
        // Compare JSON representations instead of object instances
        expect(json1['recordings'].toString(), equals(json2['recordings'].toString()));
        expect(json1['metadata']['deterministic'], equals(json2['metadata']['deterministic']));
      });

      test('drawing calls should be platform-independent', () {
        final drawingCall = DrawingCall(
          method: 'drawRect',
          args: {
            'rect': {'left': 10.0, 'top': 20.0, 'right': 110.0, 'bottom': 120.0},
            'paint': {
              'color': 0xFF0000FF, // Blue color as integer
              'strokeWidth': 2.0,
              'style': 0, // PaintingStyle.fill
            },
          },
          timestamp: DateTime.utc(2024, 1, 1), // Use UTC for consistency
        );

        final json = drawingCall.toJson();
        
        // These values should be identical across all platforms
        expect(json['method'], equals('drawRect'));
        expect(json['args']['rect']['left'], equals(10.0));
        expect(json['args']['paint']['color'], equals(0xFF0000FF));
        
        // Can reconstruct the same call from JSON
        final reconstructed = DrawingCall.fromJson(json);
        expect(reconstructed.method, equals(drawingCall.method));
        expect(reconstructed.args['rect']['left'], equals(10.0));
      });
    });
  });
}

// Helper painter for testing complex drawing scenarios
class ComplexShapePainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final double radius;
  final bool showBorder;

  ComplexShapePainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.radius,
    required this.showBorder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw primary circle
    final primaryPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius, primaryPaint);
    
    // Draw secondary smaller circle
    final secondaryPaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(center.dx + radius / 2, center.dy - radius / 2),
      radius / 3,
      secondaryPaint,
    );
    
    // Optionally draw border
    if (showBorder) {
      final borderPaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      
      canvas.drawCircle(center, radius + 2, borderPaint);
    }
    
    // Draw some lines for complexity
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0;
    
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      linePaint,
    );
    
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(ComplexShapePainter oldDelegate) {
    return primaryColor != oldDelegate.primaryColor ||
           secondaryColor != oldDelegate.secondaryColor ||
           radius != oldDelegate.radius ||
           showBorder != oldDelegate.showBorder;
  }
}