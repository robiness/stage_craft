import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';
import 'package:stage_craft/src/recording/test_stage.dart';
import 'package:stage_craft/src/recording/serialization.dart';

void main() {
  group('Recording and Replay Workflow', () {
    group('Interactive Test Scenario Creation', () {
      testWidgets('should record a complete user interaction scenario', (tester) async {
        // Create a realistic widget with multiple controls
        final backgroundColorControl = ColorControl(
          label: 'Background Color',
          initialValue: Colors.grey.shade100,
        );
        final textColorControl = ColorControl(
          label: 'Text Color',
          initialValue: Colors.black87,
        );
        final fontSizeControl = DoubleControl(
          label: 'Font Size',
          initialValue: 16.0,
          min: 12.0,
          max: 24.0,
        );
        final paddingControl = EdgeInsetsControl(
          label: 'Padding',
          initialValue: const EdgeInsets.all(16.0),
        );
        final showShadowControl = BoolControl(
          label: 'Show Shadow',
          initialValue: false,
        );

        final controls = <ValueControl>[
          backgroundColorControl,
          textColorControl,
          fontSizeControl,
          paddingControl,
          showShadowControl,
        ];

        TestScenario? recordedScenario;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TestStage(
                controls: controls,
                activeRecorders: const [StateRecorder, DrawingCallRecorder],
                showRecordingControls: false,
                onScenarioGenerated: (scenario) {
                  recordedScenario = scenario;
                },
                builder: (context) => InteractiveCard(
                  backgroundColor: backgroundColorControl.value,
                  textColor: textColorControl.value,
                  fontSize: fontSizeControl.value,
                  padding: paddingControl.value,
                  showShadow: showShadowControl.value,
                ),
              ),
            ),
          ),
        );

        // Simulate a user interaction workflow
        final testStageState = tester.state(find.byType(TestStage));

        // 1. Start recording
        final stateRecorder = TestStage.getRecorderFromState<StateRecorder>(testStageState)!;
        stateRecorder.start();

        // 2. User changes background color (dark theme)
        backgroundColorControl.value = Colors.grey.shade800;
        await tester.pump();

        // 3. User adjusts text color for contrast
        textColorControl.value = Colors.white;
        await tester.pump();

        // 4. User increases font size for readability
        fontSizeControl.value = 18.0;
        await tester.pump();

        // 5. User adds more padding
        paddingControl.value = const EdgeInsets.all(20.0);
        await tester.pump();

        // 6. User enables shadow for depth
        showShadowControl.value = true;
        await tester.pump();

        // 7. Stop recording and generate scenario
        stateRecorder.stop();
        final data = stateRecorder.data;

        // Verify the complete interaction was recorded
        expect(data.stateChanges, hasLength(5)); // All 5 control changes

        // Verify the sequence matches our interaction
        expect(data.stateChanges[0].controlLabel, equals('Background Color'));
        expect(data.stateChanges[1].controlLabel, equals('Text Color'));
        expect(data.stateChanges[2].controlLabel, equals('Font Size'));
        expect(data.stateChanges[3].controlLabel, equals('Padding'));
        expect(data.stateChanges[4].controlLabel, equals('Show Shadow'));

        // Verify we have the correct initial state
        expect(data.initialControlStates, hasLength(5));
        expect(data.initialControlStates.containsKey('Background Color'), isTrue);
        expect(data.initialControlStates.containsKey('Text Color'), isTrue);

        // // Verify timestamps are sequential (simulating real user interaction)
        // for (int i = 1; i < data.stateChanges.length; i++) {
        //   expect(
        //     data.stateChanges[i].timestamp.isAfter(data.stateChanges[i-1].timestamp),
        //     isTrue,
        //     reason: 'Change ${i} should occur after change ${i-1}',
        //   );
        // }
      });
    });

    group('Test Scenario Replay', () {
      testWidgets('should be able to replay a recorded scenario', (tester) async {
        // Create the same controls as in the recording
        final backgroundColorControl = ColorControl(
          label: 'Background Color',
          initialValue: Colors.grey.shade100,
        );
        final textSizeControl = DoubleControl(
          label: 'Text Size',
          initialValue: 14.0,
        );
        final showBorderControl = BoolControl(
          label: 'Show Border',
          initialValue: false,
        );

        final controls = <ValueControl>[
          backgroundColorControl,
          textSizeControl,
          showBorderControl,
        ];

        // Create a pre-recorded scenario (as if loaded from a golden file)
        final recordedScenario = ConcreteTestScenario(
          initialState: {
            'controls': {
              'Background Color': Colors.grey.shade100.value,
              'Text Size': 14.0,
              'Show Border': false,
            },
          },
          recordings: {
            StateRecorder: StateRecordingData(
              initialControlStates: {
                'Background Color': {
                  'type': 'Color',
                  'value': {'value': Colors.grey.shade100.value}
                },
                'Text Size': {'type': 'double', 'value': 14.0},
                'Show Border': {'type': 'bool', 'value': false},
              },
              initialCanvasState: {'zoomFactor': 1.0},
              stateChanges: [
                StateChangeEvent(
                  timestamp: DateTime(2024, 1, 1, 10, 0, 0),
                  controlLabel: 'Background Color',
                  oldValue: {
                    'type': 'Color',
                    'value': {'value': Colors.grey.shade100.value}
                  },
                  newValue: {
                    'type': 'Color',
                    'value': {'value': Colors.blue.value}
                  },
                ),
                StateChangeEvent(
                  timestamp: DateTime(2024, 1, 1, 10, 0, 1),
                  controlLabel: 'Text Size',
                  oldValue: {'type': 'double', 'value': 14.0},
                  newValue: {'type': 'double', 'value': 16.0},
                ),
                StateChangeEvent(
                  timestamp: DateTime(2024, 1, 1, 10, 0, 2),
                  controlLabel: 'Show Border',
                  oldValue: {'type': 'bool', 'value': false},
                  newValue: {'type': 'bool', 'value': true},
                ),
              ],
              canvasChanges: [],
            ),
          },
          metadata: {
            'testName': 'UI Theming Test',
            'description': 'Tests color and sizing changes',
            'recordedAt': '2024-01-01T10:00:00Z',
          },
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TestStage(
                controls: controls,
                activeRecorders: const [StateRecorder],
                showRecordingControls: false,
                builder: (context) => SimpleTestWidget(
                  backgroundColor: backgroundColorControl.value,
                  textSize: textSizeControl.value,
                  showBorder: showBorderControl.value,
                ),
              ),
            ),
          ),
        );

        // Verify initial state
        expect(backgroundColorControl.value, equals(Colors.grey.shade100));
        expect(textSizeControl.value, equals(14.0));
        expect(showBorderControl.value, equals(false));

        // Now replay the recorded changes
        final stateData = recordedScenario.recordings[StateRecorder] as StateRecordingData;

        for (final change in stateData.stateChanges) {
          switch (change.controlLabel) {
            case 'Background Color':
              final colorValue = change.newValue?['value']['value'] as int?;
              if (colorValue != null) {
                backgroundColorControl.value = Color(colorValue);
              }
              break;
            case 'Text Size':
              final sizeValue = change.newValue?['value'] as double?;
              if (sizeValue != null) {
                textSizeControl.value = sizeValue;
              }
              break;
            case 'Show Border':
              final borderValue = change.newValue?['value'] as bool?;
              if (borderValue != null) {
                showBorderControl.value = borderValue;
              }
              break;
          }
          await tester.pump();
        }

        // Verify final state matches the recorded scenario
        expect(backgroundColorControl.value.toARGB32(), equals(Colors.blue.toARGB32()));
        expect(textSizeControl.value, equals(16.0));
        expect(showBorderControl.value, equals(true));

        // Verify the widget reflects these changes
        final widget = tester.widget<SimpleTestWidget>(find.byType(SimpleTestWidget));
        expect(widget.backgroundColor.toARGB32(), equals(Colors.blue.toARGB32()));
        expect(widget.textSize, equals(16.0));
        expect(widget.showBorder, equals(true));
      });
    });

    group('Test Failure Reproduction', () {
      testWidgets('should help reproduce test failures visually', (tester) async {
        // Simulate a test that fails at a specific state
        final controls = <ValueControl>[
          ColorControl(label: 'Color', initialValue: Colors.green),
          DoubleControl(label: 'Opacity', initialValue: 1.0, min: 0.0, max: 1.0),
          StringControl(label: 'Message', initialValue: 'Success'),
        ];

        // Create a scenario that represents the state when a test failed
        final failureScenario = ConcreteTestScenario(
          initialState: {
            'controls': {
              'Color': Colors.green.value,
              'Opacity': 1.0,
              'Message': 'Success',
            },
          },
          recordings: {
            StateRecorder: StateRecordingData(
              initialControlStates: {
                'Color': {
                  'type': 'Color',
                  'value': {'value': Colors.green.value}
                },
                'Opacity': {'type': 'double', 'value': 1.0},
                'Message': {'type': 'String', 'value': 'Success'},
              },
              initialCanvasState: {},
              stateChanges: [
                // The sequence of changes that led to failure
                StateChangeEvent(
                  timestamp: DateTime(2024, 1, 1, 10, 0, 0),
                  controlLabel: 'Color',
                  oldValue: {
                    'type': 'Color',
                    'value': {'value': Colors.green.value}
                  },
                  newValue: {
                    'type': 'Color',
                    'value': {'value': Colors.red.value}
                  },
                ),
                StateChangeEvent(
                  timestamp: DateTime(2024, 1, 1, 10, 0, 1),
                  controlLabel: 'Opacity',
                  oldValue: {'type': 'double', 'value': 1.0},
                  newValue: {'type': 'double', 'value': 0.1}, // Very low opacity
                ),
                StateChangeEvent(
                  timestamp: DateTime(2024, 1, 1, 10, 0, 2),
                  controlLabel: 'Message',
                  oldValue: {'type': 'String', 'value': 'Success'},
                  newValue: {'type': 'String', 'value': 'Error: Connection failed'},
                ),
              ],
              canvasChanges: [],
            ),
          },
          metadata: {
            'testName': 'Error State Reproduction',
            'testFailure': true,
            'failureReason': 'Widget not visible due to low opacity',
            'expectedBehavior': 'Error message should be visible',
          },
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TestStage(
                controls: controls,
                activeRecorders: const [StateRecorder],
                showRecordingControls: false,
                builder: (context) => StatusWidget(
                  color: (controls[0] as ColorControl).value,
                  opacity: (controls[1] as DoubleControl).value,
                  message: (controls[2] as StringControl).value,
                ),
              ),
            ),
          ),
        );

        // Reproduce the failure scenario step by step
        final stateData = failureScenario.recordings[StateRecorder] as StateRecordingData;

        // Apply each change that led to the failure
        for (final change in stateData.stateChanges) {
          switch (change.controlLabel) {
            case 'Color':
              (controls[0] as ColorControl).value = Color(change.newValue?['value']['value'] as int);
              break;
            case 'Opacity':
              (controls[1] as DoubleControl).value = change.newValue?['value'] as double;
              break;
            case 'Message':
              (controls[2] as StringControl).value = change.newValue?['value'] as String;
              break;
          }
          await tester.pump();
        }

        // Now we can visually inspect the failing state
        final statusWidget = tester.widget<StatusWidget>(find.byType(StatusWidget));
        expect(statusWidget.color.toARGB32(), equals(Colors.red.toARGB32()));
        expect(statusWidget.opacity, equals(0.1)); // This is the problem!
        expect(statusWidget.message, equals('Error: Connection failed'));

        // The test failure is now reproducible:
        // The error message is nearly invisible due to 0.1 opacity
        // expect(statusWidget.opacity, greaterThan(0.5), reason: 'Error messages should be clearly visible');
      });
    });
  });
}

// Test widgets for realistic scenarios

class InteractiveCard extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;
  final bool showShadow;

  const InteractiveCard({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.fontSize,
    required this.padding,
    required this.showShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Interactive Card',
            style: TextStyle(
              color: textColor,
              fontSize: fontSize + 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This card demonstrates how different controls affect the visual appearance. '
            'Changes to color, typography, spacing, and shadows are all recorded.',
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: textColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'Demo',
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize - 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}

class SimpleTestWidget extends StatelessWidget {
  final Color backgroundColor;
  final double textSize;
  final bool showBorder;

  const SimpleTestWidget({
    super.key,
    required this.backgroundColor,
    required this.textSize,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: showBorder ? Border.all(color: Colors.black, width: 2) : null,
      ),
      child: Text(
        'Test Widget',
        style: TextStyle(fontSize: textSize),
      ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  final Color color;
  final double opacity;
  final String message;

  const StatusWidget({
    super.key,
    required this.color,
    required this.opacity,
    required this.message,
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
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
