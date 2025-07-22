import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';

void main() {
  group('Recording System Tests', () {
    testWidgets('should create TestStage with recording capabilities', (tester) async {
      final sizeControl = DoubleControl(label: 'size', initialValue: 100.0);
      final colorControl = ColorControl(label: 'color', initialValue: Colors.red);
      final controls = <ValueControl>[sizeControl, colorControl];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestStage(
              controls: controls,
              activeRecorders: const [StateRecorder],
              showRecordingControls: false, // Disable UI to avoid Material widget issues
              builder: (context) => Container(
                width: sizeControl.value,
                height: sizeControl.value,
                color: colorControl.value,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(TestStage), findsOneWidget);
    });

    test('should serialize and deserialize drawing calls', () {
      final call = DrawingCall(
        method: 'drawRect',
        args: {'rect': {'left': 0.0, 'top': 0.0, 'right': 100.0, 'bottom': 100.0}},
        timestamp: DateTime(2024, 1, 1),
      );

      final json = call.toJson();
      final deserialized = DrawingCall.fromJson(json);

      expect(deserialized.method, equals('drawRect'));
      expect(deserialized.args['rect']['left'], equals(0.0));
    });

    test('should serialize and deserialize state changes', () {
      final event = StateChangeEvent(
        timestamp: DateTime(2024, 1, 1),
        controlLabel: 'color',
        oldValue: {'type': 'Color', 'value': {'value': Colors.red.value}},
        newValue: {'type': 'Color', 'value': {'value': Colors.blue.value}},
      );

      final json = event.toJson();
      final deserialized = StateChangeEvent.fromJson(json);

      expect(deserialized.controlLabel, equals('color'));
      expect(deserialized.timestamp, equals(DateTime(2024, 1, 1)));
    });

    test('should create complete test scenarios', () {
      final scenario = ConcreteTestScenario(
        initialState: {'control1': 'value1'},
        recordings: {
          StateRecorder: StateRecordingData(
            initialControlStates: {},
            initialCanvasState: {},
            stateChanges: [],
            canvasChanges: [],
          ),
        },
        metadata: {
          'timestamp': '2024-01-01T00:00:00.000Z',
          'version': '1.0',
        },
      );

      expect(scenario.initialState['control1'], equals('value1'));
      expect(scenario.recordings.containsKey(StateRecorder), isTrue);
      expect(scenario.metadata['version'], equals('1.0'));
    });
  });
}