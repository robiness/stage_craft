// import 'package:flutter/material.dart';
// import 'package:stage_craft/src/controls/control.dart';
// import 'package:stage_craft/src/recording/drawing_call_recorder.dart';
// import 'package:stage_craft/src/recording/recorder.dart';
// import 'package:stage_craft/src/recording/state_recorder.dart';
// import 'package:stage_craft/src/recording/test_scenario.dart';
// import 'package:stage_craft/src/stage/stage.dart';
// import 'package:stage_craft/src/stage/stage_style.dart';
//
// /// Widget that provides recording capabilities for stage testing.
// class TestStage extends StatefulWidget {
//   const TestStage({
//     super.key,
//     required this.builder,
//     required this.controls,
//     this.activeRecorders = const [],
//     this.canvasController,
//     this.style,
//     this.onRecordingChanged,
//     this.onScenarioGenerated,
//     this.showRecordingControls = true,
//   });
//
//   /// The builder for the widget under test.
//   final WidgetBuilder builder;
//
//   /// The controls for the stage.
//   final List<ValueControl> controls;
//
//   /// The types of recorders to activate.
//   final List<Type> activeRecorders;
//
//   /// Optional canvas controller.
//   final StageCanvasController? canvasController;
//
//   /// Stage style configuration.
//   final StageStyleData? style;
//
//   /// Called when recording state changes.
//   final void Function(bool isRecording)? onRecordingChanged;
//
//   /// Called when a scenario is generated.
//   final void Function(TestScenario scenario)? onScenarioGenerated;
//
//   /// Whether to show recording control buttons.
//   final bool showRecordingControls;
//
//   @override
//   State<TestStage> createState() => _TestStageState();
//
//   /// Gets a specific recorder by type from the current state.
//   /// This is a convenience method for testing.
//   static T? getRecorderFromState<T extends Recorder>(State state) {
//     if (state is _TestStageState) {
//       return state.getRecorder<T>();
//     }
//     return null;
//   }
// }
//
// class _TestStageState extends State<TestStage> {
//   late final Map<Type, Recorder> _recorders;
//   late final StageCanvasController _canvasController;
//   bool _isRecording = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _canvasController = widget.canvasController ?? StageCanvasController();
//
//     // Initialize active recorders
//     _recorders = {};
//
//     if (widget.activeRecorders.contains(StateRecorder)) {
//       _recorders[StateRecorder] = StateRecorder(
//         controls: widget.controls,
//         canvasController: _canvasController,
//       );
//     }
//
//     if (widget.activeRecorders.contains(DrawingCallRecorder)) {
//       _recorders[DrawingCallRecorder] = DrawingCallRecorder();
//     }
//   }
//
//   @override
//   void dispose() {
//     if (widget.canvasController == null) {
//       _canvasController.dispose();
//     }
//     super.dispose();
//   }
//
//   void _startRecording() {
//     if (_isRecording) return;
//
//     setState(() {
//       _isRecording = true;
//     });
//
//     // Start all recorders
//     for (final recorder in _recorders.values) {
//       recorder.start();
//     }
//
//     widget.onRecordingChanged?.call(true);
//   }
//
//   void _stopRecording() {
//     if (!_isRecording) return;
//
//     setState(() {
//       _isRecording = false;
//     });
//
//     // Stop all recorders
//     for (final recorder in _recorders.values) {
//       recorder.stop();
//     }
//
//     // Generate scenario
//     final scenario = _generateScenario();
//     widget.onScenarioGenerated?.call(scenario);
//     widget.onRecordingChanged?.call(false);
//   }
//
//   TestScenario _generateScenario() {
//     final Map<Type, dynamic> recordings = {};
//
//     // Collect data from all active recorders
//     for (final entry in _recorders.entries) {
//       recordings[entry.key] = entry.value.data;
//     }
//
//     // Generate initial state
//     final initialState = <String, dynamic>{
//       'controls': {
//         for (final control in widget.controls) control.label: control.value,
//       },
//       'canvas': {
//         'zoomFactor': _canvasController.zoomFactor,
//         'showRuler': _canvasController.showRuler,
//         'showCrossHair': _canvasController.showCrossHair,
//         'textScale': _canvasController.textScale,
//       },
//     };
//
//     return ConcreteTestScenario(
//       initialState: initialState,
//       recordings: recordings,
//       metadata: {
//         'timestamp': DateTime.now().toIso8601String(),
//         'version': '1.0',
//         'recordingTypes': widget.activeRecorders.map((t) => t.toString()).toList(),
//       },
//     );
//   }
//
//   void _clearRecordings() {
//     for (final recorder in _recorders.values) {
//       recorder.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget stagedWidget = StageBuilder(
//       controls: widget.controls,
//       builder: widget.builder,
//       style: widget.style,
//     );
//
//     // Wrap with drawing interceptor if drawing recorder is active
//     if (_recorders.containsKey(DrawingCallRecorder)) {
//       stagedWidget = DrawingInterceptor(
//         recorder: _recorders[DrawingCallRecorder]! as DrawingCallRecorder,
//         controls: widget.controls, // Pass controls so dynamic values can be accessed
//         onPictureRecorded: (picture) {
//           debugPrint('Picture recorded with drawing calls');
//         },
//         child: stagedWidget,
//       );
//     }
//
//     return Column(
//       children: [
//         if (widget.showRecordingControls) _buildRecordingControls(),
//         Expanded(child: stagedWidget),
//       ],
//     );
//   }
//
//   Widget _buildRecordingControls() {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           // Recording status indicator
//           Icon(
//             _isRecording ? Icons.fiber_manual_record : Icons.stop,
//             color: _isRecording ? Colors.red : Colors.grey,
//             size: 16,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             _isRecording ? 'Recording...' : 'Ready',
//             style: TextStyle(
//               color: _isRecording ? Colors.red : Colors.grey,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Spacer(),
//
//           // Active recorder indicators
//           if (widget.activeRecorders.isNotEmpty) ...[
//             const Text('Recorders: '),
//             for (final type in widget.activeRecorders) ...[
//               Chip(
//                 label: Text(_getRecorderName(type)),
//                 backgroundColor: _isRecording ? Colors.red.shade100 : Colors.grey.shade200,
//                 labelStyle: TextStyle(fontSize: 10),
//               ),
//               const SizedBox(width: 4),
//             ],
//             const Spacer(),
//           ],
//
//           // Control buttons
//           IconButton(
//             onPressed: _isRecording ? null : _startRecording,
//             icon: Icon(Icons.play_arrow),
//             color: _isRecording ? Colors.grey.shade400 : Colors.green,
//             tooltip: 'Start Recording',
//           ),
//           IconButton(
//             onPressed: _isRecording ? _stopRecording : null,
//             icon: Icon(Icons.stop),
//             color: _isRecording ? Colors.red : Colors.grey.shade400,
//             tooltip: 'Stop Recording',
//           ),
//           IconButton(
//             onPressed: _isRecording ? null : _clearRecordings,
//             icon: const Icon(Icons.clear),
//             tooltip: 'Clear Recordings',
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _getRecorderName(Type type) {
//     switch (type) {
//       case StateRecorder:
//         return 'State';
//       case DrawingCallRecorder:
//         return 'Drawing';
//       default:
//         return type.toString();
//     }
//   }
// }
//
// /// Extension methods for TestStage to access recording data.
// extension TestStageRecordingAccess on _TestStageState {
//   /// Gets the current recording data from all active recorders.
//   Map<Type, dynamic> get currentRecordings {
//     return {
//       for (final entry in _recorders.entries) entry.key: entry.value.data,
//     };
//   }
//
//   /// Gets a specific recorder by type.
//   T? getRecorder<T extends Recorder>() {
//     return _recorders[T] as T?;
//   }
//
//   /// Whether any recorder is currently recording.
//   bool get hasActiveRecording => _recorders.values.any((r) => r.isRecording);
// }
