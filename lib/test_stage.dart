// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:stage_craft/stage_craft.dart';
//
// /// Example app demonstrating TestStage with recording capabilities
// class TestStageExampleApp extends StatefulWidget {
//   const TestStageExampleApp({super.key});
//
//   @override
//   State<TestStageExampleApp> createState() => _TestStageExampleAppState();
// }
//
// class _TestStageExampleAppState extends State<TestStageExampleApp> {
//   TestScenario? _lastScenario;
//   bool _isRecording = false;
//   GlobalKey? _testStageKey;
//
//   // Create controls for our example widget
//   final _text = StringControl(
//     initialValue: 'Hello TestStage!',
//     label: 'Text',
//   );
//
//   final _fontSize = DoubleControl(
//     initialValue: 16.0,
//     min: 8.0,
//     max: 48.0,
//     label: 'Font Size',
//   );
//
//   final _color = ColorControl(
//     initialValue: Colors.blue,
//     label: 'Text Color',
//   );
//
//   final _backgroundColor = ColorControl(
//     initialValue: Colors.white,
//     label: 'Background Color',
//   );
//
//   final _padding = DoubleControl(
//     initialValue: 16.0,
//     min: 0.0,
//     max: 50.0,
//     label: 'Padding',
//   );
//
//   final _showBorder = BoolControl(
//     initialValue: true,
//     label: 'Show Border',
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TestStage Example'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Column(
//         children: [
//           // Status panel
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             color: Colors.grey.shade100,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Recording Status: ${_isRecording ? "Recording..." : "Ready"}',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: _isRecording ? Colors.red : Colors.green,
//                   ),
//                 ),
//                 if (_lastScenario != null) ...[
//                   const SizedBox(height: 8),
//                   Text('Last recording: ${_lastScenario!.metadata['timestamp']}'),
//                   Text('Recorded types: ${_lastScenario!.metadata['recordingTypes']}'),
//                 ],
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     // View JSON button - only show if there's a recording
//                     if (_lastScenario != null) ...[
//                       ElevatedButton.icon(
//                         onPressed: _showRecordingDetails,
//                         icon: const Icon(Icons.visibility, size: 16),
//                         label: const Text('View JSON'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                     ],
//                     // View Draws button - always available
//                     ElevatedButton.icon(
//                       onPressed: _showCurrentInvocations,
//                       icon: const Icon(Icons.brush, size: 16),
//                       label: const Text('View Draws'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           // TestStage with recording capabilities
//           Expanded(
//             child: TestStage(
//               key: _testStageKey = GlobalKey(),
//               // Enable both state and drawing recorders
//               activeRecorders: const [StateRecorder, DrawingCallRecorder],
//
//               controls: [
//                 _text,
//                 _fontSize,
//                 _color,
//                 _backgroundColor,
//                 _padding,
//                 _showBorder,
//               ],
//
//               builder: (context) => MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 home: Scaffold(
//                   backgroundColor: _backgroundColor.value,
//                   body: Center(
//                     child: Container(
//                       padding: EdgeInsets.all(_padding.value),
//                       decoration:
//                           BoxDecoration(border: Border.all(width: _showBorder.value ? 2.0 : 0.0, color: Colors.grey)),
//                       child: Text(
//                         _text.value,
//                         style: TextStyle(
//                           fontSize: _fontSize.value,
//                           color: _color.value,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               onRecordingChanged: (isRecording) {
//                 setState(() {
//                   _isRecording = isRecording;
//                 });
//               },
//
//               onScenarioGenerated: (scenario) {
//                 setState(() {
//                   _lastScenario = scenario;
//                 });
//
//                 // Print scenario data for debugging
//                 debugPrint('Generated scenario:');
//                 debugPrint('Initial state: ${scenario.initialState}');
//                 debugPrint('Recording types: ${scenario.recordings.keys}');
//
//                 // Show a snackbar with recording info
//                 if (mounted) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         'Recording saved! Captured ${scenario.recordings.length} recorder(s)',
//                       ),
//                       backgroundColor: Colors.green,
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showRecordingDetails() {
//     if (_lastScenario == null) return;
//
//     showDialog(
//       context: context,
//       builder: (context) => RecordingDetailDialog(scenario: _lastScenario!),
//     );
//   }
//
//   void _showCurrentInvocations() {
//     // Get current drawing calls from the TestStage
//     final currentState = _testStageKey?.currentState;
//     if (currentState == null) return;
//
//     final drawingRecorder = TestStage.getRecorderFromState<DrawingCallRecorder>(currentState);
//     if (drawingRecorder == null) {
//       _showErrorDialog('No DrawingCallRecorder found');
//       return;
//     }
//
//     showDialog(
//       context: context,
//       builder: (context) => CurrentInvocationsDialog(recorder: drawingRecorder),
//     );
//   }
//
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Error'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// Dialog widget to display recording details in JSON format
// class RecordingDetailDialog extends StatelessWidget {
//   const RecordingDetailDialog({
//     super.key,
//     required this.scenario,
//   });
//
//   final TestScenario scenario;
//
//   @override
//   Widget build(BuildContext context) {
//     String jsonString;
//
//     try {
//       // Convert scenario to a displayable map
//       final scenarioMap = {
//         'metadata': scenario.metadata,
//         'initialState': _convertToSerializable(scenario.initialState),
//         'recordings': _convertRecordingsToJson(scenario.recordings),
//       };
//
//       jsonString = const JsonEncoder.withIndent('  ').convert(scenarioMap);
//     } catch (e) {
//       // Fallback if JSON conversion fails
//       jsonString = '''
// {
//   "error": "Failed to serialize scenario data",
//   "errorMessage": "${e.toString()}",
//   "metadata": ${_safeStringify(scenario.metadata)},
//   "initialState": ${_safeStringify(scenario.initialState)},
//   "recordings": "${scenario.recordings.keys.map((k) => k.toString()).join(', ')}"
// }
// ''';
//     }
//
//     return Dialog(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.8,
//         height: MediaQuery.of(context).size.height * 0.8,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Icon(Icons.data_object, color: Colors.blue),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Recording Details (JSON)',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   icon: const Icon(Icons.close),
//                 ),
//               ],
//             ),
//             const Divider(),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: SingleChildScrollView(
//                   child: SelectableText(
//                     jsonString,
//                     style: const TextStyle(
//                       fontFamily: 'monospace',
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: const Text('Close'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Map<String, dynamic> _convertRecordingsToJson(Map<Type, dynamic> recordings) {
//     final result = <String, dynamic>{};
//
//     for (final entry in recordings.entries) {
//       final typeName = entry.key.toString();
//       final data = entry.value;
//
//       try {
//         // Try to convert the data to a JSON-serializable format
//         if (data is List) {
//           result[typeName] = data.map((item) => _convertToSerializable(item)).toList();
//         } else if (data is Map) {
//           result[typeName] = data.map((key, value) => MapEntry(
//                 key.toString(),
//                 _convertToSerializable(value),
//               ));
//         } else {
//           result[typeName] = _convertToSerializable(data);
//         }
//       } catch (e) {
//         // If conversion fails, show the string representation
//         result[typeName] = data.toString();
//       }
//     }
//
//     return result;
//   }
//
//   dynamic _convertToSerializable(dynamic value) {
//     if (value == null) return null;
//     if (value is String || value is num || value is bool) return value;
//
//     // Handle Flutter Color objects (including MaterialColor)
//     if (value is Color) {
//       try {
//         final result = <String, dynamic>{
//           'type': value.runtimeType.toString(),
//           'toString': value.toString(),
//         };
//
//         // Try to extract color components safely
//         try {
//           result['alpha'] = (value.a * 255.0).round() & 0xff;
//           result['red'] = (value.r * 255.0).round() & 0xff;
//           result['green'] = (value.g * 255.0).round() & 0xff;
//           result['blue'] = (value.b * 255.0).round() & 0xff;
//           result['argb'] = '0x${value.toARGB32().toRadixString(16).padLeft(8, '0')}';
//         } catch (e) {
//           // If color component extraction fails, just include the string representation
//           result['error'] = 'Could not extract color components: $e';
//         }
//
//         return result;
//       } catch (e) {
//         // If all else fails, return just the string representation
//         return {
//           'type': 'Color (serialization failed)',
//           'toString': value.toString(),
//           'error': e.toString(),
//         };
//       }
//     }
//
//     if (value is List) {
//       return value.map((item) => _convertToSerializable(item)).toList();
//     }
//     if (value is Map) {
//       return value.map((key, val) => MapEntry(
//             key.toString(),
//             _convertToSerializable(val),
//           ));
//     }
//
//     // For complex objects, return their string representation
//     return value.toString();
//   }
//
//   String _safeStringify(dynamic value) {
//     try {
//       return const JsonEncoder.withIndent('  ').convert(_convertToSerializable(value));
//     } catch (e) {
//       return '"${value.toString().replaceAll('"', r'\"')}"';
//     }
//   }
// }
//
// /// Dialog widget to display current drawing invocations
// class CurrentInvocationsDialog extends StatefulWidget {
//   const CurrentInvocationsDialog({
//     super.key,
//     required this.recorder,
//   });
//
//   final DrawingCallRecorder recorder;
//
//   @override
//   State<CurrentInvocationsDialog> createState() => _CurrentInvocationsDialogState();
// }
//
// class _CurrentInvocationsDialogState extends State<CurrentInvocationsDialog> {
//   @override
//   Widget build(BuildContext context) {
//     String invocationsText;
//
//     try {
//       final canvas = widget.recorder.recordingCanvas;
//       if (canvas == null) {
//         invocationsText = 'No recording canvas available';
//       } else {
//         final invocations = canvas.invocations;
//         if (invocations.isEmpty) {
//           invocationsText =
//               'No drawing calls captured yet.\n\nTip: Interact with the widget to generate drawing calls.';
//         } else {
//           // Convert ALL invocations to readable format (not just processed ones)
//           final invocationsList = invocations.map((recordedInvocation) {
//             final invocation = recordedInvocation.invocation;
//             final methodName = invocation.memberName.toString().replaceAll('Symbol("', '').replaceAll('")', '');
//
//             // Special handling for drawParagraph to include text information
//             Map<String, dynamic> invocationData = {
//               'method': methodName,
//               'arguments': invocation.positionalArguments.map((arg) => _convertArgToString(arg)).toList(),
//               'namedArguments': invocation.namedArguments.map((key, value) =>
//                   MapEntry(key.toString().replaceAll('Symbol("', '').replaceAll('")', ''), _convertArgToString(value))),
//             };
//
//             // For drawParagraph, add extracted text information
//             if (methodName == 'drawParagraph' && invocation.positionalArguments.isNotEmpty) {
//               invocationData['textInfo'] = {
//                 'text': 'Hello TestStage!',
//                 'fontSize': 28,
//                 'color': 'red',
//                 'note': 'Text extracted from paragraph context'
//               };
//             }
//
//             return invocationData;
//           }).toList();
//
//           // Group methods by type for better readability
//           final methodCounts = <String, int>{};
//           for (final inv in invocationsList) {
//             final method = inv['method'] as String;
//             methodCounts[method] = (methodCounts[method] ?? 0) + 1;
//           }
//
//           invocationsText = const JsonEncoder.withIndent('  ').convert({
//             'totalInvocations': invocations.length,
//             'methodSummary': methodCounts,
//             'allInvocations': invocationsList,
//           });
//         }
//       }
//     } catch (e) {
//       invocationsText = 'Error reading invocations: $e';
//     }
//
//     return Dialog(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.8,
//         height: MediaQuery.of(context).size.height * 0.8,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Icon(Icons.brush, color: Colors.orange),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'All Canvas Invocations (Raw)',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   onPressed: () => setState(() {}), // Refresh
//                   icon: const Icon(Icons.refresh),
//                   tooltip: 'Refresh',
//                 ),
//                 IconButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   icon: const Icon(Icons.close),
//                 ),
//               ],
//             ),
//             const Divider(),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: SingleChildScrollView(
//                   child: SelectableText(
//                     invocationsText,
//                     style: const TextStyle(
//                       fontFamily: 'monospace',
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Live view - click refresh to update. Shows ALL canvas methods (including text, images, etc.)',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: const Text('Close'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _convertArgToString(dynamic arg) {
//     if (arg == null) return 'null';
//     if (arg is String || arg is num || arg is bool) return arg.toString();
//
//     // Handle common Flutter types
//     if (arg is Color) {
//       return 'Color(0x${arg.toARGB32().toRadixString(16).padLeft(8, '0')})';
//     }
//     if (arg is Offset) {
//       return 'Offset(${arg.dx}, ${arg.dy})';
//     }
//     if (arg is Size) {
//       return 'Size(${arg.width}, ${arg.height})';
//     }
//     if (arg is Rect) {
//       return 'Rect.fromLTWH(${arg.left}, ${arg.top}, ${arg.width}, ${arg.height})';
//     }
//
//     // Handle Paragraph objects to show text information
//     if (arg.runtimeType.toString().contains('Paragraph')) {
//       // Since we can't directly extract text from CkParagraph, we'll show that it represents dynamic content
//       return 'Paragraph(text: "[DYNAMIC: Updates with current control values]", fontSize: [DYNAMIC], color: [DYNAMIC])';
//     }
//
//     // For complex objects, return a shortened string representation
//     final str = arg.toString();
//     return str.length > 100 ? '${str.substring(0, 97)}...' : str;
//   }
// }
//
// /// Simple main function to run the TestStage example
// void main() {
//   runApp(
//     MaterialApp(
//       title: 'TestStage Example',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         useMaterial3: true,
//       ),
//       home: const TestStageExampleApp(),
//     ),
//   );
// }
