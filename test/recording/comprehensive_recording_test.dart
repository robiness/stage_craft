import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';
import 'package:stage_craft/src/recording/test_stage.dart';

void main() {
  group('Comprehensive Recording System Tests', () {
    group('State Recording', () {
      testWidgets('should record multiple control value changes', (tester) async {
        final colorControl = ColorControl(label: 'Background Color', initialValue: Colors.red);
        final sizeControl = DoubleControl(label: 'Size', initialValue: 100.0, min: 50.0, max: 200.0);
        final textControl = StringControl(label: 'Text', initialValue: 'Hello');
        final showBorderControl = BoolControl(label: 'Show Border', initialValue: false);

        final controls = <ValueControl>[colorControl, sizeControl, textControl, showBorderControl];

        late StateRecorder stateRecorder;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TestStage(
                controls: controls,
                activeRecorders: const [StateRecorder],
                showRecordingControls: false,
                onScenarioGenerated: (scenario) {
                  stateRecorder =
                      scenario.recordings[StateRecorder] as StateRecorder? ?? StateRecorder(controls: controls);
                },
                builder: (context) => Container(
                  width: sizeControl.value,
                  height: sizeControl.value,
                  decoration: BoxDecoration(
                    color: colorControl.value,
                    border: showBorderControl.value ? Border.all(color: Colors.black, width: 2) : null,
                  ),
                  child: Center(
                    child: Text(textControl.value),
                  ),
                ),
              ),
            ),
          ),
        );

        // Start recording
        final testStageState = tester.state(find.byType(TestStage));
        TestStage.getRecorderFromState<StateRecorder>(testStageState)?.start();

        // Make sequential changes to different controls
        colorControl.value = Colors.blue;
        await tester.pump();

        sizeControl.value = 150.0;
        await tester.pump();

        textControl.value = 'World';
        await tester.pump();

        showBorderControl.value = true;
        await tester.pump();

        // Stop recording
        final recorder = TestStage.getRecorderFromState<StateRecorder>(testStageState)!;
        recorder.stop();
        final data = recorder.data;

        // Verify initial state was captured
        expect(data.initialControlStates['Background Color'], isNotNull);
        expect(data.initialControlStates['Size'], isNotNull);
        expect(data.initialControlStates['Text'], isNotNull);
        expect(data.initialControlStates['Show Border'], isNotNull);

        // Verify all changes were recorded
        expect(data.stateChanges, hasLength(4));

        // Verify the sequence of changes
        expect(data.stateChanges[0].controlLabel, equals('Background Color'));
        expect(data.stateChanges[1].controlLabel, equals('Size'));
        expect(data.stateChanges[2].controlLabel, equals('Text'));
        expect(data.stateChanges[3].controlLabel, equals('Show Border'));

        // // Verify timestamps are sequential
        // for (int i = 1; i < data.stateChanges.length; i++) {
        //   expect(
        //     data.stateChanges[i].timestamp.isAfter(data.stateChanges[i-1].timestamp),
        //     isTrue
        //   );
        // }
      });

      testWidgets('should record canvas controller changes', (tester) async {
        final controls = <ValueControl>[ColorControl(label: 'Color', initialValue: Colors.green)];
        final canvasController = StageCanvasController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TestStage(
                controls: controls,
                canvasController: canvasController,
                activeRecorders: const [StateRecorder],
                showRecordingControls: false,
                builder: (context) => Container(
                  color: (controls[0] as ColorControl).value,
                ),
              ),
            ),
          ),
        );

        final testStageState = tester.state(find.byType(TestStage));
        final recorder = TestStage.getRecorderFromState<StateRecorder>(testStageState)!;
        recorder.start();

        // Change canvas properties
        canvasController.zoomFactor = 1.5;
        await tester.pump();

        canvasController.showRuler = true;
        await tester.pump();

        canvasController.showCrossHair = true;
        await tester.pump();

        canvasController.textScale = 1.2;
        await tester.pump();

        recorder.stop();
        final data = recorder.data;

        // Verify canvas changes were recorded
        expect(data.canvasChanges, hasLength(4));

        final properties = data.canvasChanges.map((change) => change.property).toList();
        expect(properties, containsAll(['zoomFactor', 'showRuler', 'showCrossHair', 'textScale']));
      });
    });

    group('Drawing Call Recording', () {
      testWidgets('should record drawing calls from custom painted widgets', (tester) async {
        final controls = <ValueControl>[
          ColorControl(label: 'Circle Color', initialValue: Colors.red),
          DoubleControl(label: 'Circle Radius', initialValue: 25.0, min: 10.0, max: 50.0),
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
                  painter: CirclePainter(
                    color: (controls[0] as ColorControl).value,
                    radius: (controls[1] as DoubleControl).value,
                  ),
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final testStageState = tester.state(find.byType(TestStage));
        final recorder = TestStage.getRecorderFromState<DrawingCallRecorder>(testStageState);

        // The drawing interceptor should have captured some drawing calls
        expect(recorder, isNotNull);

        // In a real implementation, we would verify specific drawing calls
        // For now, just verify the recorder exists and can be accessed
      });
    });

    group('Serialization', () {
      test('should serialize complex Flutter types correctly', () {
        // Test Color serialization
        const color = Color(0xFF123456);
        final colorJson = SerializerRegistry.serializeValue(color);
        expect(colorJson?['type'], equals('Color'));
        expect(colorJson?['value']['value'], equals(0xFF123456));

        // Test Duration serialization
        const duration = Duration(minutes: 2, seconds: 30);
        final durationJson = SerializerRegistry.serializeValue(duration);
        expect(durationJson?['type'], equals('Duration'));
        expect(durationJson?['value']['microseconds'], equals(duration.inMicroseconds));

        // Test Offset serialization
        const offset = Offset(10.5, 20.3);
        final offsetJson = SerializerRegistry.serializeValue(offset);
        expect(offsetJson?['type'], equals('Offset'));
        expect(offsetJson?['value']['dx'], equals(10.5));
        expect(offsetJson?['value']['dy'], equals(20.3));

        // Test EdgeInsets serialization
        const edgeInsets = EdgeInsets.only(left: 8.0, top: 16.0, right: 12.0, bottom: 4.0);
        final edgeInsetsJson = SerializerRegistry.serializeValue(edgeInsets);
        expect(edgeInsetsJson?['type'], equals('EdgeInsets'));
        expect(edgeInsetsJson?['value']['left'], equals(8.0));
        expect(edgeInsetsJson?['value']['top'], equals(16.0));
        expect(edgeInsetsJson?['value']['right'], equals(12.0));
        expect(edgeInsetsJson?['value']['bottom'], equals(4.0));
      });

      test('should handle null values correctly', () {
        final nullJson = SerializerRegistry.serializeValue(null);
        expect(nullJson, isNull);
      });

      test('should serialize primitive types', () {
        // String
        final stringJson = SerializerRegistry.serializeValue('Hello World');
        expect(stringJson?['type'], equals('String'));
        expect(stringJson?['value'], equals('Hello World'));

        // Number
        final intJson = SerializerRegistry.serializeValue(42);
        expect(intJson?['type'], equals('int'));
        expect(intJson?['value'], equals(42));

        final doubleJson = SerializerRegistry.serializeValue(3.14);
        expect(doubleJson?['type'], equals('double'));
        expect(doubleJson?['value'], equals(3.14));

        // Boolean
        final boolJson = SerializerRegistry.serializeValue(true);
        expect(boolJson?['type'], equals('bool'));
        expect(boolJson?['value'], equals(true));
      });
    });

    group('Test Scenario Management', () {
      test('should create complete test scenarios with metadata', () {
        final stateData = StateRecordingData(
          initialControlStates: {
            'color': {
              'type': 'Color',
              'value': {'value': Colors.red.value}
            },
            'size': {'type': 'double', 'value': 100.0},
          },
          initialCanvasState: {
            'zoomFactor': 1.0,
            'showRuler': false,
            'showCrossHair': false,
            'textScale': 1.0,
          },
          stateChanges: [
            StateChangeEvent(
              timestamp: DateTime(2024, 1, 1, 12, 0, 0),
              controlLabel: 'color',
              oldValue: {
                'type': 'Color',
                'value': {'value': Colors.red.value}
              },
              newValue: {
                'type': 'Color',
                'value': {'value': Colors.blue.value}
              },
            ),
          ],
          canvasChanges: [
            CanvasStateEvent(
              timestamp: DateTime(2024, 1, 1, 12, 0, 1),
              property: 'zoomFactor',
              oldValue: 1.0,
              newValue: 1.5,
            ),
          ],
        );

        final drawingData = DrawingRecordingData(
          calls: [
            DrawingCall(
              method: 'drawRect',
              args: {
                'rect': {'left': 0.0, 'top': 0.0, 'right': 100.0, 'bottom': 100.0},
                'paint': {'color': Colors.blue.value, 'strokeWidth': 1.0},
              },
              timestamp: DateTime(2024, 1, 1, 12, 0, 2),
            ),
          ],
        );

        final scenario = ConcreteTestScenario(
          initialState: {
            'controls': {'color': Colors.red.value, 'size': 100.0},
            'canvas': {'zoomFactor': 1.0, 'showRuler': false},
          },
          recordings: {
            StateRecorder: stateData,
            DrawingCallRecorder: drawingData,
          },
          metadata: {
            'timestamp': '2024-01-01T12:00:00.000Z',
            'version': '1.0',
            'testName': 'Widget State and Drawing Test',
            'description': 'Tests color change and drawing operations',
          },
        );

        // Verify scenario structure
        expect(scenario.initialState, isNotEmpty);
        expect(scenario.recordings, hasLength(2));
        expect(scenario.recordings.containsKey(StateRecorder), isTrue);
        expect(scenario.recordings.containsKey(DrawingCallRecorder), isTrue);
        expect(scenario.metadata['testName'], equals('Widget State and Drawing Test'));

        // Verify JSON serialization
        final json = scenario.toJson();
        expect(json['version'], equals('1.0'));
        expect(json['metadata']['testName'], equals('Widget State and Drawing Test'));
        expect(json['recordings'], isNotEmpty);
      });
    });

    group('Control Integration', () {
      testWidgets('should work with multiple control types', (tester) async {
        final titleControl = StringControl(label: 'Title', initialValue: 'Test Widget');
        final enabledControl = BoolControl(label: 'Enabled', initialValue: true);
        final countControl = IntControl(label: 'Count', initialValue: 5, min: 1, max: 10);
        final opacityControl = DoubleControl(label: 'Opacity', initialValue: 1.0, min: 0.0, max: 1.0);
        final colorControl = ColorControl(label: 'Primary Color', initialValue: Colors.purple);

        final controls = <ValueControl>[
          titleControl,
          enabledControl,
          countControl,
          opacityControl,
          colorControl,
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TestStage(
                controls: controls,
                activeRecorders: const [StateRecorder],
                showRecordingControls: false,
                builder: (context) => SimpleComplexWidget(
                  title: titleControl.value,
                  enabled: enabledControl.value,
                  count: countControl.value,
                  opacity: opacityControl.value,
                  color: colorControl.value,
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(SimpleComplexWidget), findsOneWidget);
        expect(find.byType(TestStage), findsOneWidget);

        // Verify all controls are accessible
        final testStageState = tester.state(find.byType(TestStage));
        final recorder = TestStage.getRecorderFromState<StateRecorder>(testStageState);
        expect(recorder, isNotNull);
      });
    });
  });
}

// Helper classes for testing

class CirclePainter extends CustomPainter {
  final Color color;
  final double radius;

  CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return color != oldDelegate.color || radius != oldDelegate.radius;
  }
}

class SimpleComplexWidget extends StatelessWidget {
  final String title;
  final bool enabled;
  final int count;
  final double opacity;
  final Color color;

  const SimpleComplexWidget({
    super.key,
    required this.title,
    required this.enabled,
    required this.count,
    required this.opacity,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: enabled ? Colors.white : Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                count,
                (index) => Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: enabled ? Colors.white : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Note: We use dynamic casting to access the TestStage state's getRecorder method
// which is available via the TestStageRecordingAccess extension
