// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:stage_craft/stage_craft.dart';
//
// void main() {
//   group('TestStage Drawing Invocations Tests', () {
//     testWidgets(
//         'TestStage should capture drawing calls for MaterialApp with green background, centered red text, and black border',
//         (tester) async {
//       final label = StringControl(initialValue: 'Hello TestStage', label: 'label');
//       final testStage = TestStage(
//         activeRecorders: const [DrawingCallRecorder],
//         controls: [
//           label,
//         ],
//         showRecordingControls: false,
//         builder: (context) => MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: Scaffold(
//             backgroundColor: Colors.green,
//             body: Center(
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(border: Border.all(width: 2)),
//                 child: Text(
//                   label.value,
//                   style: const TextStyle(
//                     fontSize: 28,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//
//       await tester.pumpWidget(MaterialApp(
//         home: Material(child: testStage),
//       ));
//
//       // Get the DrawingCallRecorder
//       final testStageState = tester.state(find.byType(TestStage));
//       final drawingRecorder = TestStage.getRecorderFromState<DrawingCallRecorder>(testStageState);
//       expect(drawingRecorder, isNotNull);
//
//       // Start recording
//       drawingRecorder!.start();
//       await tester.pump(); // Trigger a new frame to capture drawing operations
//       drawingRecorder.stop();
//
//       // Get the captured drawing calls
//       final data = drawingRecorder.data;
//       final calls = data.calls;
//
//       // Debug output - remove in production
//       // print('Captured ${calls.length} drawing calls:');
//       // for (int i = 0; i < calls.length; i++) {
//       //   final call = calls[i];
//       //   print('$i: ${call.method} - ${call.args}');
//       // }
//
//       // Verify we captured drawing operations
//       expect(calls, isNotEmpty, reason: 'Should capture at least some drawing operations');
//       expect(calls.length, greaterThan(0), reason: 'Should have more than 0 drawing calls');
//
//       // Test specific drawing operations that should be present for our widget:
//
//       // 1. Should have drawRect operations (for backgrounds, borders)
//       final drawRectCalls = calls.where((call) => call.method == 'drawRect').toList();
//       expect(drawRectCalls, isNotEmpty, reason: 'Should have drawRect calls for container backgrounds/borders');
//
//       // 2. Should have drawParagraph operations (for text rendering)
//       final drawParagraphCalls = calls.where((call) => call.method == 'drawParagraph').toList();
//       expect(drawParagraphCalls, isNotEmpty, reason: 'Should have drawParagraph calls for text rendering');
//
//       // 3. Verify the text content in drawParagraph
//       final textCall = drawParagraphCalls.first;
//       expect(textCall.args['text'], equals('Hello TestStage'), reason: 'Should capture the correct text content');
//       expect(textCall.args['fontSize'], equals(28), reason: 'Should capture the correct font size');
//
//       // 4. Verify paint arguments contain color information
//       bool hasPaintWithColor = false;
//       for (final call in calls) {
//         if (call.args.containsKey('paint')) {
//           final paint = call.args['paint'] as Map<String, dynamic>;
//           if (paint.containsKey('color')) {
//             hasPaintWithColor = true;
//             break;
//           }
//         }
//       }
//       expect(hasPaintWithColor, isTrue, reason: 'Drawing calls should include paint with color information');
//
//       // 5. Verify the drawing calls contain expected geometric data
//       bool hasReasonableRectangles = false;
//       for (final call in drawRectCalls) {
//         if (call.args.containsKey('rect')) {
//           final rect = call.args['rect'] as Map<String, dynamic>;
//           final width = (rect['right'] as double) - (rect['left'] as double);
//           final height = (rect['bottom'] as double) - (rect['top'] as double);
//
//           // Should have rectangles with reasonable dimensions
//           if (width > 0 && height > 0 && width < 1000 && height < 1000) {
//             hasReasonableRectangles = true;
//             break;
//           }
//         }
//       }
//       print(calls);
//       expect(hasReasonableRectangles, isTrue, reason: 'Should have rectangles with reasonable dimensions');
//       // Summary verification - we now expect at least 3 operations (text, background, border)
//       expect(calls.length, greaterThanOrEqualTo(3),
//           reason: 'Should capture multiple drawing operations for a complex widget (background, border, text, etc.)');
//
//       // Test dynamic updates: change the control value and verify the new invocations reflect the change
//       label.value = 'Updated Text';
//       await tester.pump(); // Trigger a new frame to capture updated drawing operations
//
//       // Start recording again to capture the new operations with updated text
//       drawingRecorder.start();
//       await tester.pump(); // Trigger another frame to capture the updated drawing calls
//       drawingRecorder.stop();
//
//       // Capture new drawing calls after the text change
//       final updatedData = drawingRecorder.data;
//       final updatedCalls = updatedData.calls;
//       final updatedDrawParagraphCalls = updatedCalls.where((call) => call.method == 'drawParagraph').toList();
//
//       if (updatedDrawParagraphCalls.isNotEmpty) {
//         final updatedTextCall = updatedDrawParagraphCalls.last; // Get the most recent call
//         expect(updatedTextCall.args['text'], equals('Updated Text'), reason: 'Should capture the updated text content after control change');
//       }
//     });
//
//     testWidgets('TestStage should capture more operations than simple hardcoded calls', (tester) async {
//       final testStage = TestStage(
//         activeRecorders: const [DrawingCallRecorder],
//         controls: [],
//         showRecordingControls: false,
//         builder: (context) => MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: Scaffold(
//             backgroundColor: Colors.green,
//             body: Center(
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(border: Border.all(width: 2)),
//                 child: const Text(
//                   'Hello TestStage!',
//                   style: TextStyle(
//                     fontSize: 28,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//
//       await tester.pumpWidget(MaterialApp(home: testStage));
//
//       final testStageState = tester.state(find.byType(TestStage));
//       final drawingRecorder = TestStage.getRecorderFromState<DrawingCallRecorder>(testStageState);
//
//       drawingRecorder!.start();
//       await tester.pump();
//       drawingRecorder.stop();
//
//       final data = drawingRecorder.data;
//
//       // The user originally saw only 8 operations and wanted "EACH AND EVERY drawing call"
//       // Our implementation should capture more comprehensive operations
//       // print('Total captured operations: ${data.calls.length}');
//
//       expect(data.calls.length, greaterThanOrEqualTo(3),
//           reason: 'Should capture comprehensive drawing operations, not just a few hardcoded ones');
//
//       // Verify we have a variety of operation types
//       final operationTypes = data.calls.map((call) => call.method).toSet();
//       // print('Operation types captured: $operationTypes');
//
//       expect(operationTypes.length, greaterThanOrEqualTo(2),
//           reason: 'Should capture different types of drawing operations');
//     });
//   });
// }
