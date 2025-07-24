// /// Example usage of the StageCraft recording system.
// /// This demonstrates how to use the TestStage widget with different recorders
// /// and how to create platform-agnostic golden tests.
// library example_usage;
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:stage_craft/src/controls/controls.dart';
// import 'package:stage_craft/src/recording/recording.dart';
//
// /// Example widget that we want to test.
// class ExampleTestWidget extends StatelessWidget {
//   const ExampleTestWidget({
//     super.key,
//     required this.width,
//     required this.height,
//     required this.color,
//     required this.text,
//     this.showBorder = false,
//   });
//
//   final double width;
//   final double height;
//   final Color color;
//   final String text;
//   final bool showBorder;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         color: color,
//         border: showBorder ? Border.all(color: Colors.black, width: 2) : null,
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// Example of how to create a TestStage with recording capabilities.
// class ExampleTestStage extends StatefulWidget {
//   const ExampleTestStage({super.key});
//
//   @override
//   State<ExampleTestStage> createState() => _ExampleTestStageState();
// }
//
// class _ExampleTestStageState extends State<ExampleTestStage> {
//   TestScenario? _lastScenario;
//
//   // Define controls for our example widget
//   final List<ValueControl> _controls = [
//     DoubleControl(label: 'Width', initialValue: 200.0, min: 50.0, max: 400.0),
//     DoubleControl(label: 'Height', initialValue: 100.0, min: 30.0, max: 200.0),
//     ColorControl(label: 'Color', initialValue: Colors.blue),
//     StringControl(label: 'Text', initialValue: 'Hello World'),
//     BoolControl(label: 'Show Border', initialValue: false),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('StageCraft Recording Example'),
//       ),
//       body: TestStage(
//         controls: _controls,
//         // Enable both state and drawing call recording
//         activeRecorders: const [StateRecorder, DrawingCallRecorder],
//         builder: (context) {
//           // Extract control values
//           final width = _controls[0].value as double;
//           final height = _controls[1].value as double;
//           final color = _controls[2].value as Color;
//           final text = _controls[3].value as String;
//           final showBorder = _controls[4].value as bool;
//
//           return ExampleTestWidget(
//             width: width,
//             height: height,
//             color: color,
//             text: text,
//             showBorder: showBorder,
//           );
//         },
//         onScenarioGenerated: (scenario) {
//           setState(() {
//             _lastScenario = scenario;
//           });
//           debugPrint('Scenario generated with ${scenario.recordings.length} recording types');
//         },
//         onRecordingChanged: (isRecording) {
//           debugPrint('Recording state changed: $isRecording');
//         },
//       ),
//     );
//   }
// }
//
// /// Example test functions showing how to use the recording system in tests.
// void exampleTests() {
//   group('StageCraft Recording System Tests', () {
//     testWidgets('should record state changes', (tester) async {
//       final sizeControl = DoubleControl(label: 'size', initialValue: 100.0);
//       final colorControl = ColorControl(label: 'color', initialValue: Colors.red);
//       final controls = <ValueControl>[sizeControl, colorControl];
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: TestStage(
//             controls: controls,
//             activeRecorders: const [StateRecorder],
//             builder: (context) => Container(
//               width: sizeControl.value,
//               height: sizeControl.value,
//               color: colorControl.value,
//             ),
//           ),
//         ),
//       );
//
//       // Find the test stage widget
//       final testStageState = tester.state(find.byType(TestStage));
//
//       // Start recording
//       (testStageState as dynamic).startRecording();
//
//       // Make some changes to controls
//       sizeControl.value = 150.0;
//       colorControl.value = Colors.blue;
//
//       await tester.pump();
//
//       // Stop recording and get scenario
//       final scenario = (testStageState as dynamic).stopRecording() as TestScenario;
//
//       // Verify the recording contains our changes
//       expect(scenario.recordings[StateRecorder], isNotNull);
//       final stateData = scenario.recordings[StateRecorder] as StateRecordingData;
//       expect(stateData.stateChanges.length, equals(2)); // Two control changes
//     });
//
//     testWidgets('should record drawing calls', (tester) async {
//       final colorControl = ColorControl(label: 'color', initialValue: Colors.green);
//       final controls = <ValueControl>[colorControl];
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: TestStage(
//             controls: controls,
//             activeRecorders: const [DrawingCallRecorder],
//             builder: (context) => Container(
//               width: 100,
//               height: 100,
//               color: colorControl.value,
//             ),
//           ),
//         ),
//       );
//
//       // The drawing calls are recorded automatically
//       // In a real test, you would verify specific drawing calls were made
//       await tester.pumpAndSettle();
//     });
//
//     testWidgets('golden test example', (tester) async {
//       final sizeControl = DoubleControl(label: 'size', initialValue: 100.0);
//       final colorControl = ColorControl(label: 'color', initialValue: Colors.red);
//       final controls = <ValueControl>[sizeControl, colorControl];
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: TestStage(
//             controls: controls,
//             activeRecorders: const [DrawingCallRecorder],
//             builder: (context) => Container(
//               width: sizeControl.value,
//               height: sizeControl.value,
//               color: colorControl.value,
//             ),
//           ),
//         ),
//       );
//
//       await tester.pumpAndSettle();
//
//       // Get the recorded drawing calls
//       final testStageState = tester.state(find.byType(TestStage));
//       final drawingRecorder = (testStageState as dynamic)
//           .getRecorder<DrawingCallRecorder>() as DrawingCallRecorder?;
//
//       if (drawingRecorder != null) {
//         final drawingData = drawingRecorder.data;
//
//         // Compare against golden file
//         await expectLater(
//           drawingData,
//           matchesGoldenDrawingCalls('example_widget_drawing_calls'),
//         );
//       }
//     });
//   });
// }
//
// /// Example of saving a scenario as a golden file.
// Future<void> saveExampleGolden() async {
//   final scenario = ConcreteTestScenario(
//     initialState: {
//       'controls': {
//         'width': 200.0,
//         'height': 100.0,
//         'color': Colors.blue.toARGB32(),
//       }
//     },
//     recordings: {
//       StateRecorder: StateRecordingData(
//         initialControlStates: {
//           'width': {'type': 'double', 'value': 200.0},
//           'height': {'type': 'double', 'value': 100.0},
//           'color': {'type': 'Color', 'value': {'value': Colors.blue.toARGB32()}},
//         },
//         initialCanvasState: {
//           'zoomFactor': 1.0,
//           'showRuler': false,
//           'showCrossHair': false,
//           'textScale': 1.0,
//         },
//         stateChanges: [],
//         canvasChanges: [],
//       ),
//     },
//     metadata: {
//       'timestamp': DateTime.now().toIso8601String(),
//       'version': '1.0',
//       'description': 'Example golden scenario',
//     },
//   );
//
//   await GoldenFileManager.saveScenarioGolden(scenario, 'example_scenario');
// }
