// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:meta/meta.dart';
//
// import 'package:stage_craft/src/recording/drawing_call_recorder.dart';
// import 'package:stage_craft/src/recording/state_recorder.dart';
// import 'package:stage_craft/src/recording/test_scenario.dart';
//
// /// Matcher for comparing drawing calls against a golden file.
// Matcher matchesGoldenDrawingCalls(String goldenFile) {
//   return _GoldenDrawingCallsMatcher(goldenFile);
// }
//
// /// Matcher for comparing state recordings against a golden file.
// Matcher matchesGoldenStateRecording(String goldenFile) {
//   return _GoldenStateRecordingMatcher(goldenFile);
// }
//
// /// Matcher for comparing complete test scenarios against a golden file.
// Matcher matchesGoldenScenario(String goldenFile) {
//   return _GoldenScenarioMatcher(goldenFile);
// }
//
// class _GoldenDrawingCallsMatcher extends Matcher {
//   const _GoldenDrawingCallsMatcher(this.goldenFile);
//
//   final String goldenFile;
//
//   @override
//   bool matches(dynamic item, Map matchState) {
//     if (item is! DrawingRecordingData) {
//       matchState['error'] = 'Expected DrawingRecordingData, got ${item.runtimeType}';
//       return false;
//     }
//
//     try {
//       final goldenPath = _getGoldenPath(goldenFile);
//       final expectedJson = _loadGoldenFile(goldenPath);
//       final expected = DrawingRecordingData.fromJson(expectedJson);
//
//       return _compareDrawingCalls(item, expected, matchState);
//     } catch (e) {
//       matchState['error'] = 'Failed to load or parse golden file: $e';
//       return false;
//     }
//   }
//
//   bool _compareDrawingCalls(
//     DrawingRecordingData actual,
//     DrawingRecordingData expected,
//     Map matchState,
//   ) {
//     if (actual.calls.length != expected.calls.length) {
//       matchState['error'] = 'Different number of drawing calls. '
//           'Expected: ${expected.calls.length}, Actual: ${actual.calls.length}';
//       return false;
//     }
//
//     for (int i = 0; i < actual.calls.length; i++) {
//       final actualCall = actual.calls[i];
//       final expectedCall = expected.calls[i];
//
//       if (actualCall.method != expectedCall.method) {
//         matchState['error'] = 'Drawing call $i method mismatch. '
//             'Expected: ${expectedCall.method}, Actual: ${actualCall.method}';
//         return false;
//       }
//
//       if (!_deepEqual(actualCall.args, expectedCall.args)) {
//         matchState['error'] = 'Drawing call $i arguments mismatch. '
//             'Expected: ${expectedCall.args}, Actual: ${actualCall.args}';
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   @override
//   Description describe(Description description) {
//     return description.add('matches golden drawing calls in $goldenFile');
//   }
//
//   @override
//   Description describeMismatch(
//     dynamic item,
//     Description mismatchDescription,
//     Map matchState,
//     bool verbose,
//   ) {
//     final error = matchState['error'] as String?;
//     if (error != null) {
//       return mismatchDescription.add(error);
//     }
//     return mismatchDescription.add('does not match golden drawing calls');
//   }
// }
//
// class _GoldenStateRecordingMatcher extends Matcher {
//   const _GoldenStateRecordingMatcher(this.goldenFile);
//
//   final String goldenFile;
//
//   @override
//   bool matches(dynamic item, Map matchState) {
//     if (item is! StateRecordingData) {
//       matchState['error'] = 'Expected StateRecordingData, got ${item.runtimeType}';
//       return false;
//     }
//
//     try {
//       final goldenPath = _getGoldenPath(goldenFile);
//       final expectedJson = _loadGoldenFile(goldenPath);
//       final expected = StateRecordingData.fromJson(expectedJson);
//
//       return _compareStateRecordings(item, expected, matchState);
//     } catch (e) {
//       matchState['error'] = 'Failed to load or parse golden file: $e';
//       return false;
//     }
//   }
//
//   bool _compareStateRecordings(
//     StateRecordingData actual,
//     StateRecordingData expected,
//     Map matchState,
//   ) {
//     // Compare initial states
//     if (!_deepEqual(actual.initialControlStates, expected.initialControlStates)) {
//       matchState['error'] = 'Initial control states do not match';
//       return false;
//     }
//
//     if (!_deepEqual(actual.initialCanvasState, expected.initialCanvasState)) {
//       matchState['error'] = 'Initial canvas state does not match';
//       return false;
//     }
//
//     // Compare state changes
//     if (actual.stateChanges.length != expected.stateChanges.length) {
//       matchState['error'] = 'Different number of state changes. '
//           'Expected: ${expected.stateChanges.length}, Actual: ${actual.stateChanges.length}';
//       return false;
//     }
//
//     for (int i = 0; i < actual.stateChanges.length; i++) {
//       final actualChange = actual.stateChanges[i];
//       final expectedChange = expected.stateChanges[i];
//
//       if (actualChange.controlLabel != expectedChange.controlLabel ||
//           !_deepEqual(actualChange.newValue, expectedChange.newValue)) {
//         matchState['error'] = 'State change $i does not match';
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   @override
//   Description describe(Description description) {
//     return description.add('matches golden state recording in $goldenFile');
//   }
//
//   @override
//   Description describeMismatch(
//     dynamic item,
//     Description mismatchDescription,
//     Map matchState,
//     bool verbose,
//   ) {
//     final error = matchState['error'] as String?;
//     if (error != null) {
//       return mismatchDescription.add(error);
//     }
//     return mismatchDescription.add('does not match golden state recording');
//   }
// }
//
// class _GoldenScenarioMatcher extends Matcher {
//   const _GoldenScenarioMatcher(this.goldenFile);
//
//   final String goldenFile;
//
//   @override
//   bool matches(dynamic item, Map matchState) {
//     if (item is! TestScenario) {
//       matchState['error'] = 'Expected TestScenario, got ${item.runtimeType}';
//       return false;
//     }
//
//     try {
//       final goldenPath = _getGoldenPath(goldenFile);
//       final expectedJson = _loadGoldenFile(goldenPath);
//       final expected = TestScenario.fromJson(expectedJson);
//
//       return _compareScenarios(item, expected, matchState);
//     } catch (e) {
//       matchState['error'] = 'Failed to load or parse golden file: $e';
//       return false;
//     }
//   }
//
//   bool _compareScenarios(
//     TestScenario actual,
//     TestScenario expected,
//     Map matchState,
//   ) {
//     // Compare initial states
//     if (!_deepEqual(actual.initialState, expected.initialState)) {
//       matchState['error'] = 'Initial states do not match';
//       return false;
//     }
//
//     // Compare recordings by type
//     if (actual.recordings.keys.length != expected.recordings.keys.length) {
//       matchState['error'] = 'Different number of recording types';
//       return false;
//     }
//
//     for (final type in actual.recordings.keys) {
//       if (!expected.recordings.containsKey(type)) {
//         matchState['error'] = 'Expected recordings missing type: $type';
//         return false;
//       }
//
//       if (!_deepEqual(actual.recordings[type], expected.recordings[type])) {
//         matchState['error'] = 'Recordings for type $type do not match';
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   @override
//   Description describe(Description description) {
//     return description.add('matches golden scenario in $goldenFile');
//   }
//
//   @override
//   Description describeMismatch(
//     dynamic item,
//     Description mismatchDescription,
//     Map matchState,
//     bool verbose,
//   ) {
//     final error = matchState['error'] as String?;
//     if (error != null) {
//       return mismatchDescription.add(error);
//     }
//     return mismatchDescription.add('does not match golden scenario');
//   }
// }
//
// // Helper functions
//
// String _getGoldenPath(String goldenFile) {
//   // Follow Flutter's golden file convention
//   if (!goldenFile.endsWith('.golden.json')) {
//     goldenFile = '$goldenFile.golden.json';
//   }
//   return 'test/goldens/$goldenFile';
// }
//
// Map<String, dynamic> _loadGoldenFile(String path) {
//   final file = File(path);
//   if (!file.existsSync()) {
//     throw FileSystemException('Golden file not found', path);
//   }
//
//   final content = file.readAsStringSync();
//   return json.decode(content) as Map<String, dynamic>;
// }
//
// bool _deepEqual(dynamic a, dynamic b) {
//   if (identical(a, b)) return true;
//
//   if (a is Map && b is Map) {
//     if (a.length != b.length) return false;
//     for (final key in a.keys) {
//       if (!b.containsKey(key) || !_deepEqual(a[key], b[key])) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   if (a is List && b is List) {
//     if (a.length != b.length) return false;
//     for (int i = 0; i < a.length; i++) {
//       if (!_deepEqual(a[i], b[i])) return false;
//     }
//     return true;
//   }
//
//   return a == b;
// }
//
// /// Utility functions for generating and managing golden files.
// class GoldenFileManager {
//   /// Saves drawing calls to a golden file.
//   static Future<void> saveDrawingCallsGolden(
//     DrawingRecordingData data,
//     String goldenFile,
//   ) async {
//     await _saveGoldenFile(data.toJson(), goldenFile);
//   }
//
//   /// Saves state recording to a golden file.
//   static Future<void> saveStateRecordingGolden(
//     StateRecordingData data,
//     String goldenFile,
//   ) async {
//     await _saveGoldenFile(data.toJson(), goldenFile);
//   }
//
//   /// Saves a complete test scenario to a golden file.
//   static Future<void> saveScenarioGolden(
//     TestScenario scenario,
//     String goldenFile,
//   ) async {
//     await _saveGoldenFile(scenario.toJson(), goldenFile);
//   }
//
//   static Future<void> _saveGoldenFile(
//     Map<String, dynamic> data,
//     String goldenFile,
//   ) async {
//     final goldenPath = _getGoldenPath(goldenFile);
//     final file = File(goldenPath);
//
//     // Create directory if it doesn't exist
//     await file.parent.create(recursive: true);
//
//     // Write formatted JSON
//     final encoder = JsonEncoder.withIndent('  ');
//     final formattedJson = encoder.convert(data);
//     await file.writeAsString(formattedJson);
//   }
// }
