import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/recording/models/test_scenario.dart';
import 'package:stage_craft/src/recording/models/state_frame.dart';
import 'package:stage_craft/src/recording/models/drawing_frame.dart';

void main() {
  group('TestScenario', () {
    group('Basic Construction', () {
      test('creates scenario with required parameters', () {
        final createdAt = DateTime.now();
        final scenario = TestScenario(
          name: 'Basic Test',
          stateFrames: [],
          createdAt: createdAt,
        );

        expect(scenario.name, 'Basic Test');
        expect(scenario.stateFrames, isEmpty);
        expect(scenario.drawingFrames, isEmpty);
        expect(scenario.createdAt, createdAt);
        expect(scenario.metadata, isEmpty);
      });

      test('creates scenario with all parameters', () {
        final stateFrames = [
          StateFrame(
            timestamp: Duration.zero,
            controlValues: {'size': 100.0},
          ),
          StateFrame(
            timestamp: Duration(seconds: 1),
            controlValues: {'size': 200.0},
          ),
        ];

        final drawingFrames = [
          DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(operations: []),
          ),
          DrawingFrame(
            timestamp: Duration(seconds: 1),
            commands: DrawingCommands(operations: []),
          ),
        ];

        final createdAt = DateTime.now();
        final metadata = {
          'author': 'Test User',
          'description': 'Test scenario',
          'tags': ['test', 'basic'],
        };

        final scenario = TestScenario(
          name: 'Complete Test',
          stateFrames: stateFrames,
          drawingFrames: drawingFrames,
          createdAt: createdAt,
          metadata: metadata,
        );

        expect(scenario.name, 'Complete Test');
        expect(scenario.stateFrames, stateFrames);
        expect(scenario.drawingFrames, drawingFrames);
        expect(scenario.createdAt, createdAt);
        expect(scenario.metadata, metadata);
      });

      test('creates scenario with empty frames lists', () {
        final scenario = TestScenario(
          name: 'Empty Test',
          stateFrames: [],
          drawingFrames: [],
          createdAt: DateTime.now(),
        );

        expect(scenario.isEmpty, isTrue);
        expect(scenario.hasStateData, isFalse);
        expect(scenario.hasDrawingData, isFalse);
        expect(scenario.supportsVisualTesting, isFalse);
      });
    });

    group('JSON Serialization', () {
      test('creates JSON structure correctly', () {
        final original = TestScenario(
          name: 'Test Scenario',
          stateFrames: [],
          drawingFrames: [],
          createdAt: DateTime.parse('2024-01-01T10:00:00.000Z'),
          metadata: {'version': '1.0'},
        );

        final json = original.toJson();
        expect(json, isA<Map<String, dynamic>>());
        expect(json['name'], 'Test Scenario');
        expect(json['stateFrames'], isA<List>());
        expect(json['drawingFrames'], isA<List>());
        expect(json['createdAt'], '2024-01-01T10:00:00.000Z');
        expect(json['metadata'], {'version': '1.0'});
      });

      test('handles empty scenario correctly', () {
        final original = TestScenario(
          name: 'Empty Test',
          stateFrames: [],
          drawingFrames: [],
          createdAt: DateTime.now(),
          metadata: {},
        );

        final json = original.toJson();
        expect(json, isA<Map<String, dynamic>>());
        expect(json['stateFrames'], isEmpty);
        expect(json['drawingFrames'], isEmpty);
        expect(json['metadata'], isEmpty);
      });
    });

    group('Extension Methods - Duration Calculations', () {
      group('duration', () {
        test('returns duration of last state frame', () {
          final stateFrames = [
            StateFrame(timestamp: Duration.zero, controlValues: {}),
            StateFrame(timestamp: Duration(seconds: 2), controlValues: {}),
            StateFrame(timestamp: Duration(seconds: 5), controlValues: {}),
          ];

          final scenario = TestScenario(
            name: 'Duration Test',
            stateFrames: stateFrames,
            createdAt: DateTime.now(),
          );

          expect(scenario.duration, Duration(seconds: 5));
        });

        test('returns zero when no state frames', () {
          final scenario = TestScenario(
            name: 'Empty Test',
            stateFrames: [],
            createdAt: DateTime.now(),
          );

          expect(scenario.duration, Duration.zero);
        });
      });

      group('drawingDuration', () {
        test('returns duration of last drawing frame', () {
          final drawingFrames = [
            DrawingFrame(timestamp: Duration.zero, commands: DrawingCommands(operations: [])),
            DrawingFrame(timestamp: Duration(seconds: 3), commands: DrawingCommands(operations: [])),
            DrawingFrame(timestamp: Duration(seconds: 7), commands: DrawingCommands(operations: [])),
          ];

          final scenario = TestScenario(
            name: 'Drawing Duration Test',
            stateFrames: [],
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          expect(scenario.drawingDuration, Duration(seconds: 7));
        });

        test('returns zero when no drawing frames', () {
          final scenario = TestScenario(
            name: 'No Drawing Test',
            stateFrames: [],
            drawingFrames: [],
            createdAt: DateTime.now(),
          );

          expect(scenario.drawingDuration, Duration.zero);
        });
      });

      group('totalDuration', () {
        test('returns maximum of state and drawing durations', () {
          final stateFrames = [
            StateFrame(timestamp: Duration(seconds: 10), controlValues: {}),
          ];
          final drawingFrames = [
            DrawingFrame(timestamp: Duration(seconds: 15), commands: DrawingCommands(operations: [])),
          ];

          final scenario = TestScenario(
            name: 'Total Duration Test',
            stateFrames: stateFrames,
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          expect(scenario.totalDuration, Duration(seconds: 15));
        });

        test('returns state duration when drawing duration is shorter', () {
          final stateFrames = [
            StateFrame(timestamp: Duration(seconds: 20), controlValues: {}),
          ];
          final drawingFrames = [
            DrawingFrame(timestamp: Duration(seconds: 5), commands: DrawingCommands(operations: [])),
          ];

          final scenario = TestScenario(
            name: 'State Longer Test',
            stateFrames: stateFrames,
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          expect(scenario.totalDuration, Duration(seconds: 20));
        });

        test('returns zero when both frame lists are empty', () {
          final scenario = TestScenario(
            name: 'Empty Test',
            stateFrames: [],
            drawingFrames: [],
            createdAt: DateTime.now(),
          );

          expect(scenario.totalDuration, Duration.zero);
        });
      });
    });

    group('Extension Methods - Frame Counting', () {
      test('counts frames correctly', () {
        final stateFrames = List.generate(5, (i) => 
          StateFrame(timestamp: Duration(seconds: i), controlValues: {}));
        final drawingFrames = List.generate(3, (i) => 
          DrawingFrame(timestamp: Duration(seconds: i), commands: DrawingCommands(operations: [])));

        final scenario = TestScenario(
          name: 'Frame Count Test',
          stateFrames: stateFrames,
          drawingFrames: drawingFrames,
          createdAt: DateTime.now(),
        );

        expect(scenario.stateFrameCount, 5);
        expect(scenario.drawingFrameCount, 3);
        expect(scenario.totalFrameCount, 8);
      });

      test('handles empty frame lists', () {
        final scenario = TestScenario(
          name: 'Empty Frame Test',
          stateFrames: [],
          drawingFrames: [],
          createdAt: DateTime.now(),
        );

        expect(scenario.stateFrameCount, 0);
        expect(scenario.drawingFrameCount, 0);
        expect(scenario.totalFrameCount, 0);
      });
    });

    group('Extension Methods - Data Presence Checks', () {
      test('isEmpty works correctly', () {
        // Both empty
        final emptyScenario = TestScenario(
          name: 'Empty',
          stateFrames: [],
          drawingFrames: [],
          createdAt: DateTime.now(),
        );
        expect(emptyScenario.isEmpty, isTrue);

        // Has state frames
        final stateScenario = TestScenario(
          name: 'State Only',
          stateFrames: [StateFrame(timestamp: Duration.zero, controlValues: {})],
          drawingFrames: [],
          createdAt: DateTime.now(),
        );
        expect(stateScenario.isEmpty, isFalse);

        // Has drawing frames
        final drawingScenario = TestScenario(
          name: 'Drawing Only',
          stateFrames: [],
          drawingFrames: [DrawingFrame(timestamp: Duration.zero, commands: DrawingCommands(operations: []))],
          createdAt: DateTime.now(),
        );
        expect(drawingScenario.isEmpty, isFalse);
      });

      test('hasStateData works correctly', () {
        final withState = TestScenario(
          name: 'With State',
          stateFrames: [StateFrame(timestamp: Duration.zero, controlValues: {})],
          createdAt: DateTime.now(),
        );
        expect(withState.hasStateData, isTrue);

        final withoutState = TestScenario(
          name: 'Without State',
          stateFrames: [],
          createdAt: DateTime.now(),
        );
        expect(withoutState.hasStateData, isFalse);
      });

      test('hasDrawingData works correctly', () {
        final withDrawing = TestScenario(
          name: 'With Drawing',
          stateFrames: [],
          drawingFrames: [DrawingFrame(timestamp: Duration.zero, commands: DrawingCommands(operations: []))],
          createdAt: DateTime.now(),
        );
        expect(withDrawing.hasDrawingData, isTrue);

        final withoutDrawing = TestScenario(
          name: 'Without Drawing',
          stateFrames: [],
          drawingFrames: [],
          createdAt: DateTime.now(),
        );
        expect(withoutDrawing.hasDrawingData, isFalse);
      });

      test('supportsVisualTesting works correctly', () {
        // Needs both state and drawing data
        final fullScenario = TestScenario(
          name: 'Full Scenario',
          stateFrames: [StateFrame(timestamp: Duration.zero, controlValues: {})],
          drawingFrames: [DrawingFrame(timestamp: Duration.zero, commands: DrawingCommands(operations: []))],
          createdAt: DateTime.now(),
        );
        expect(fullScenario.supportsVisualTesting, isTrue);

        // Only state data
        final stateOnlyScenario = TestScenario(
          name: 'State Only',
          stateFrames: [StateFrame(timestamp: Duration.zero, controlValues: {})],
          drawingFrames: [],
          createdAt: DateTime.now(),
        );
        expect(stateOnlyScenario.supportsVisualTesting, isFalse);

        // Only drawing data
        final drawingOnlyScenario = TestScenario(
          name: 'Drawing Only',
          stateFrames: [],
          drawingFrames: [DrawingFrame(timestamp: Duration.zero, commands: DrawingCommands(operations: []))],
          createdAt: DateTime.now(),
        );
        expect(drawingOnlyScenario.supportsVisualTesting, isFalse);

        // No data
        final emptyScenario = TestScenario(
          name: 'Empty',
          stateFrames: [],
          drawingFrames: [],
          createdAt: DateTime.now(),
        );
        expect(emptyScenario.supportsVisualTesting, isFalse);
      });
    });

    group('Extension Methods - Size Estimation', () {
      test('estimates file size based on frame counts', () {
        final stateFrames = List.generate(10, (i) => 
          StateFrame(timestamp: Duration(seconds: i), controlValues: {}));
        final drawingFrames = List.generate(5, (i) => 
          DrawingFrame(timestamp: Duration(seconds: i), commands: DrawingCommands(operations: [])));

        final scenario = TestScenario(
          name: 'Size Test',
          stateFrames: stateFrames,
          drawingFrames: drawingFrames,
          createdAt: DateTime.now(),
        );

        final estimatedSize = scenario.estimatedSizeBytes;
        
        // Should be base (1000) + state frames (10 * 500) + drawing frames (5 * 2000)
        expect(estimatedSize, 1000 + (10 * 500) + (5 * 2000));
        expect(estimatedSize, 16000);
      });

      test('handles empty scenario size estimation', () {
        final scenario = TestScenario(
          name: 'Empty',
          stateFrames: [],
          drawingFrames: [],
          createdAt: DateTime.now(),
        );

        expect(scenario.estimatedSizeBytes, 1000); // Just base size
      });
    });

    group('Extension Methods - Metadata Manipulation', () {
      group('withMetadata', () {
        test('adds new metadata key', () {
          final scenario = TestScenario(
            name: 'Test',
            stateFrames: [],
            createdAt: DateTime.now(),
            metadata: {'existing': 'value'},
          );

          final modified = scenario.withMetadata('newKey', 'newValue');

          expect(modified.metadata, {
            'existing': 'value',
            'newKey': 'newValue',
          });
          expect(modified.name, scenario.name);
          expect(modified.stateFrames, scenario.stateFrames);
        });

        test('overrides existing metadata key', () {
          final scenario = TestScenario(
            name: 'Test',
            stateFrames: [],
            createdAt: DateTime.now(),
            metadata: {'key': 'oldValue', 'other': 'preserved'},
          );

          final modified = scenario.withMetadata('key', 'newValue');

          expect(modified.metadata, {
            'key': 'newValue',
            'other': 'preserved',
          });
        });
      });

      group('withAllMetadata', () {
        test('merges multiple metadata entries', () {
          final scenario = TestScenario(
            name: 'Test',
            stateFrames: [],
            createdAt: DateTime.now(),
            metadata: {'existing': 'value'},
          );

          final modified = scenario.withAllMetadata({
            'priority': 'high',
            'automatedTest': true,
            'tags': ['test', 'animation'],
          });

          expect(modified.metadata, {
            'existing': 'value',
            'priority': 'high',
            'automatedTest': true,
            'tags': ['test', 'animation'],
          });
        });

        test('overrides existing keys', () {
          final scenario = TestScenario(
            name: 'Test',
            stateFrames: [],
            createdAt: DateTime.now(),
            metadata: {'key1': 'old1', 'key2': 'old2'},
          );

          final modified = scenario.withAllMetadata({
            'key1': 'new1',
            'key3': 'new3',
          });

          expect(modified.metadata, {
            'key1': 'new1', // Overridden
            'key2': 'old2', // Preserved
            'key3': 'new3', // Added
          });
        });
      });
    });

    group('Extension Methods - Timeline Manipulation', () {
      group('trimToTimeRange', () {
        test('trims scenario to specified time range', () {
          final stateFrames = [
            StateFrame(timestamp: Duration(seconds: 1), controlValues: {'step': 1}),
            StateFrame(timestamp: Duration(seconds: 3), controlValues: {'step': 2}),
            StateFrame(timestamp: Duration(seconds: 5), controlValues: {'step': 3}),
            StateFrame(timestamp: Duration(seconds: 7), controlValues: {'step': 4}),
          ];

          final drawingFrames = [
            DrawingFrame(timestamp: Duration(seconds: 2), commands: DrawingCommands(operations: [])),
            DrawingFrame(timestamp: Duration(seconds: 4), commands: DrawingCommands(operations: [])),
            DrawingFrame(timestamp: Duration(seconds: 6), commands: DrawingCommands(operations: [])),
          ];

          final scenario = TestScenario(
            name: 'Original Scenario',
            stateFrames: stateFrames,
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          final trimmed = scenario.trimToTimeRange(
            Duration(seconds: 2),
            Duration(seconds: 6),
          );

          // Should include frames at t=3, t=5 (state) and t=2, t=4, t=6 (drawing)
          expect(trimmed.stateFrames.length, 2);
          expect(trimmed.drawingFrames.length, 3);
          
          // Timestamps should be adjusted to start at zero
          expect(trimmed.stateFrames[0].timestamp, Duration(seconds: 1)); // 3 - 2
          expect(trimmed.stateFrames[1].timestamp, Duration(seconds: 3)); // 5 - 2
          
          expect(trimmed.drawingFrames[0].timestamp, Duration.zero); // 2 - 2
          expect(trimmed.drawingFrames[1].timestamp, Duration(seconds: 2)); // 4 - 2
          expect(trimmed.drawingFrames[2].timestamp, Duration(seconds: 4)); // 6 - 2

          // Name should be updated
          expect(trimmed.name, 'Original Scenario (2s-6s)');
          
          // Metadata should include trim info
          expect(trimmed.metadata['trimmedFrom'], 'Original Scenario');
          expect(trimmed.metadata['originalStart'], 2000); // milliseconds
          expect(trimmed.metadata['originalEnd'], 6000);
        });

        test('handles empty time range', () {
          final stateFrames = [
            StateFrame(timestamp: Duration(seconds: 5), controlValues: {}),
          ];

          final scenario = TestScenario(
            name: 'Test',
            stateFrames: stateFrames,
            createdAt: DateTime.now(),
          );

          final trimmed = scenario.trimToTimeRange(
            Duration(seconds: 1),
            Duration(seconds: 3),
          );

          expect(trimmed.stateFrames, isEmpty);
          expect(trimmed.drawingFrames, isEmpty);
        });
      });

      group('withoutDrawingFrames', () {
        test('removes drawing frames and updates metadata', () {
          final drawingFrames = List.generate(5, (i) => 
            DrawingFrame(timestamp: Duration(seconds: i), commands: DrawingCommands(operations: [])));

          final scenario = TestScenario(
            name: 'With Drawing',
            stateFrames: [StateFrame(timestamp: Duration.zero, controlValues: {})],
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          final stripped = scenario.withoutDrawingFrames();

          expect(stripped.drawingFrames, isEmpty);
          expect(stripped.stateFrames, scenario.stateFrames); // Preserved
          expect(stripped.name, scenario.name); // Preserved
          
          // Metadata should be updated
          expect(stripped.metadata['drawingFramesRemoved'], true);
          expect(stripped.metadata['originalDrawingFrameCount'], 5);
          expect(stripped.metadata, containsPair('strippedAt', isA<String>()));
        });

        test('handles scenario with no drawing frames', () {
          final scenario = TestScenario(
            name: 'No Drawing',
            stateFrames: [StateFrame(timestamp: Duration.zero, controlValues: {})],
            drawingFrames: [],
            createdAt: DateTime.now(),
          );

          final stripped = scenario.withoutDrawingFrames();

          expect(stripped.drawingFrames, isEmpty);
          expect(stripped.metadata['originalDrawingFrameCount'], 0);
        });
      });

      group('withoutStateFrames', () {
        test('removes state frames and updates metadata', () {
          final stateFrames = List.generate(3, (i) => 
            StateFrame(timestamp: Duration(seconds: i), controlValues: {}));

          final scenario = TestScenario(
            name: 'With State',
            stateFrames: stateFrames,
            drawingFrames: [DrawingFrame(timestamp: Duration.zero, commands: DrawingCommands(operations: []))],
            createdAt: DateTime.now(),
          );

          final stripped = scenario.withoutStateFrames();

          expect(stripped.stateFrames, isEmpty);
          expect(stripped.drawingFrames, scenario.drawingFrames); // Preserved
          expect(stripped.name, scenario.name); // Preserved
          
          // Metadata should be updated
          expect(stripped.metadata['stateFramesRemoved'], true);
          expect(stripped.metadata['originalStateFrameCount'], 3);
          expect(stripped.metadata, containsPair('strippedAt', isA<String>()));
        });
      });
    });

    group('Extension Methods - Frame Finding', () {
      group('findDrawingAtTime', () {
        test('finds exact timestamp match', () {
          final drawingFrames = [
            DrawingFrame(timestamp: Duration(seconds: 1), commands: DrawingCommands(operations: [])),
            DrawingFrame(timestamp: Duration(seconds: 3), commands: DrawingCommands(operations: [])),
            DrawingFrame(timestamp: Duration(seconds: 5), commands: DrawingCommands(operations: [])),
          ];

          final scenario = TestScenario(
            name: 'Test',
            stateFrames: [],
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          final found = scenario.findDrawingAtTime(Duration(seconds: 3));
          expect(found, isNotNull);
          expect(found!.timestamp, Duration(seconds: 3));
        });

        test('finds closest match within tolerance', () {
          final drawingFrames = [
            DrawingFrame(timestamp: Duration(milliseconds: 1000), commands: DrawingCommands(operations: [])),
            DrawingFrame(timestamp: Duration(milliseconds: 3000), commands: DrawingCommands(operations: [])),
          ];

          final scenario = TestScenario(
            name: 'Test',
            stateFrames: [],
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          // Looking for 1050ms, should find 1000ms frame (within default 100ms tolerance)
          final found = scenario.findDrawingAtTime(Duration(milliseconds: 1050));
          expect(found, isNotNull);
          expect(found!.timestamp, Duration(milliseconds: 1000));
        });

        test('returns null when no match within tolerance', () {
          final drawingFrames = [
            DrawingFrame(timestamp: Duration(seconds: 1), commands: DrawingCommands(operations: [])),
          ];

          final scenario = TestScenario(
            name: 'Test',
            stateFrames: [],
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          // Looking for 2s, but frame is at 1s and default tolerance is 100ms
          final found = scenario.findDrawingAtTime(Duration(seconds: 2));
          expect(found, isNull);
        });

        test('uses custom tolerance', () {
          final drawingFrames = [
            DrawingFrame(timestamp: Duration(seconds: 1), commands: DrawingCommands(operations: [])),
          ];

          final scenario = TestScenario(
            name: 'Test',
            stateFrames: [],
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          // With 2 second tolerance, should find the 1s frame when looking for 2s
          final found = scenario.findDrawingAtTime(
            Duration(seconds: 2),
            tolerance: Duration(seconds: 2),
          );
          expect(found, isNotNull);
          expect(found!.timestamp, Duration(seconds: 1));
        });

        test('returns closest when multiple frames within tolerance', () {
          final drawingFrames = [
            DrawingFrame(timestamp: Duration(milliseconds: 950), commands: DrawingCommands(operations: [])),
            DrawingFrame(timestamp: Duration(milliseconds: 1050), commands: DrawingCommands(operations: [])),
            DrawingFrame(timestamp: Duration(milliseconds: 1100), commands: DrawingCommands(operations: [])),
          ];

          final scenario = TestScenario(
            name: 'Test',
            stateFrames: [],
            drawingFrames: drawingFrames,
            createdAt: DateTime.now(),
          );

          // Looking for 1000ms with 200ms tolerance - should find 1050ms (closest)
          final found = scenario.findDrawingAtTime(
            Duration(milliseconds: 1000),
            tolerance: Duration(milliseconds: 200),
          );
          expect(found, isNotNull);
          expect(found!.timestamp, Duration(milliseconds: 1050));
        });

        test('returns null for empty drawing frames', () {
          final scenario = TestScenario(
            name: 'Empty',
            stateFrames: [],
            drawingFrames: [],
            createdAt: DateTime.now(),
          );

          final found = scenario.findDrawingAtTime(Duration(seconds: 1));
          expect(found, isNull);
        });
      });

      group('findStateAtTime', () {
        test('finds exact timestamp match', () {
          final stateFrames = [
            StateFrame(timestamp: Duration(seconds: 1), controlValues: {'step': 1}),
            StateFrame(timestamp: Duration(seconds: 3), controlValues: {'step': 2}),
            StateFrame(timestamp: Duration(seconds: 5), controlValues: {'step': 3}),
          ];

          final scenario = TestScenario(
            name: 'Test',
            stateFrames: stateFrames,
            createdAt: DateTime.now(),
          );

          final found = scenario.findStateAtTime(Duration(seconds: 3));
          expect(found, isNotNull);
          expect(found!.timestamp, Duration(seconds: 3));
          expect(found!.controlValues['step'], 2);
        });

        test('works with custom tolerance like findDrawingAtTime', () {
          final stateFrames = [
            StateFrame(timestamp: Duration(seconds: 1), controlValues: {'value': 'test'}),
          ];

          final scenario = TestScenario(
            name: 'Test',
            stateFrames: stateFrames,
            createdAt: DateTime.now(),
          );

          final found = scenario.findStateAtTime(
            Duration(seconds: 2),
            tolerance: Duration(seconds: 2),
          );
          expect(found, isNotNull);
          expect(found!.controlValues['value'], 'test');
        });
      });
    });

    group('Extension Methods - Statistics', () {
      test('provides comprehensive statistics', () {
        final stateFrames = [
          StateFrame(timestamp: Duration(seconds: 2), controlValues: {}),
          StateFrame(timestamp: Duration(seconds: 5), controlValues: {}),
        ];
        final drawingFrames = [
          DrawingFrame(timestamp: Duration(seconds: 7), commands: DrawingCommands(operations: [])),
        ];

        final scenario = TestScenario(
          name: 'Stats Test',
          stateFrames: stateFrames,
          drawingFrames: drawingFrames,
          createdAt: DateTime.now(),
          metadata: {'author': 'test', 'version': '1.0'},
        );

        final stats = scenario.statistics;

        expect(stats['duration']['total'], 7000); // 7 seconds in ms
        expect(stats['duration']['state'], 5000); // 5 seconds in ms
        expect(stats['duration']['drawing'], 7000); // 7 seconds in ms

        expect(stats['frames']['state'], 2);
        expect(stats['frames']['drawing'], 1);
        expect(stats['frames']['total'], 3);

        expect(stats['size']['estimated_bytes'], isA<int>());
        expect(stats['size']['estimated_kb'], isA<int>());

        expect(stats['capabilities']['playback'], true);
        expect(stats['capabilities']['visual_testing'], true);
        expect(stats['capabilities']['empty'], false);

        expect(stats['metadata_keys'], ['author', 'version']);
      });

      test('handles empty scenario statistics', () {
        final scenario = TestScenario(
          name: 'Empty',
          stateFrames: [],
          drawingFrames: [],
          createdAt: DateTime.now(),
        );

        final stats = scenario.statistics;

        expect(stats['duration']['total'], 0);
        expect(stats['frames']['total'], 0);
        expect(stats['capabilities']['empty'], true);
        expect(stats['capabilities']['playback'], false);
        expect(stats['capabilities']['visual_testing'], false);
      });
    });

    group('Equality and Hash Code', () {
      test('scenarios with same values are equal', () {
        final createdAt = DateTime.now();
        final stateFrames = [
          StateFrame(timestamp: Duration.zero, controlValues: {'test': 'value'}),
        ];

        final scenario1 = TestScenario(
          name: 'Test',
          stateFrames: stateFrames,
          createdAt: createdAt,
          metadata: {'key': 'value'},
        );

        final scenario2 = TestScenario(
          name: 'Test',
          stateFrames: stateFrames,
          createdAt: createdAt,
          metadata: {'key': 'value'},
        );

        expect(scenario1, equals(scenario2));
        expect(scenario1.hashCode, equals(scenario2.hashCode));
      });

      test('scenarios with different values are not equal', () {
        final createdAt = DateTime.now();

        final scenario1 = TestScenario(
          name: 'Test 1',
          stateFrames: [],
          createdAt: createdAt,
        );

        final scenario2 = TestScenario(
          name: 'Test 2',
          stateFrames: [],
          createdAt: createdAt,
        );

        expect(scenario1, isNot(equals(scenario2)));
      });
    });

    group('CopyWith', () {
      test('copies with new name', () {
        final original = TestScenario(
          name: 'Original',
          stateFrames: [],
          createdAt: DateTime.now(),
        );

        final copied = original.copyWith(name: 'Modified');

        expect(copied.name, 'Modified');
        expect(copied.stateFrames, original.stateFrames);
        expect(copied.createdAt, original.createdAt);
      });

      test('copies with new frames', () {
        final original = TestScenario(
          name: 'Test',
          stateFrames: [],
          createdAt: DateTime.now(),
        );

        final newStateFrames = [
          StateFrame(timestamp: Duration.zero, controlValues: {}),
        ];
        final newDrawingFrames = [
          DrawingFrame(timestamp: Duration.zero, commands: DrawingCommands(operations: [])),
        ];

        final copied = original.copyWith(
          stateFrames: newStateFrames,
          drawingFrames: newDrawingFrames,
        );

        expect(copied.stateFrames, newStateFrames);
        expect(copied.drawingFrames, newDrawingFrames);
        expect(copied.name, original.name);
      });

      test('copies with new metadata', () {
        final original = TestScenario(
          name: 'Test',
          stateFrames: [],
          createdAt: DateTime.now(),
          metadata: {'old': 'value'},
        );

        final newMetadata = {'new': 'value', 'another': 'key'};
        final copied = original.copyWith(metadata: newMetadata);

        expect(copied.metadata, newMetadata);
        expect(copied.name, original.name);
      });
    });

    group('Real-world Usage Scenarios', () {
      test('typical recording scenario workflow', () {
        // Create scenario as if recorded from user interaction
        final stateFrames = [
          StateFrame(
            timestamp: Duration.zero,
            controlValues: {'color': 'red', 'size': 100.0},
            canvasState: {'zoom': 1.0, 'panX': 0.0, 'panY': 0.0},
          ),
          StateFrame(
            timestamp: Duration(milliseconds: 500),
            controlValues: {'color': 'red', 'size': 150.0},
            canvasState: {'zoom': 1.0, 'panX': 0.0, 'panY': 0.0},
          ),
          StateFrame(
            timestamp: Duration(seconds: 1),
            controlValues: {'color': 'blue', 'size': 150.0},
            canvasState: {'zoom': 1.2, 'panX': 10.0, 'panY': 5.0},
          ),
        ];

        final drawingFrames = [
          DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.rect(
                  rect: Rect.fromLTWH(0, 0, 100, 100),
                  paint: {'color': 0xFFFF0000},
                ),
              ],
            ),
          ),
          DrawingFrame(
            timestamp: Duration(seconds: 1),
            commands: DrawingCommands(
              operations: [
                DrawingOperation.rect(
                  rect: Rect.fromLTWH(0, 0, 150, 150),
                  paint: {'color': 0xFF0000FF},
                ),
              ],
            ),
          ),
        ];

        final scenario = TestScenario(
          name: 'Color Picker Interaction',
          stateFrames: stateFrames,
          drawingFrames: drawingFrames,
          createdAt: DateTime.now(),
          metadata: {
            'description': 'User changes color from red to blue and increases size',
            'author': 'test@example.com',
            'tags': ['color-picker', 'animation', 'smoke-test'],
            'widgetUnderTest': 'ColorPickerWidget',
          },
        );

        // Verify scenario properties
        expect(scenario.duration, Duration(seconds: 1));
        expect(scenario.hasStateData, isTrue);
        expect(scenario.hasDrawingData, isTrue);
        expect(scenario.supportsVisualTesting, isTrue);
        expect(scenario.isEmpty, isFalse);

        // Test frame finding for testing workflow
        final stateAtHalfSecond = scenario.findStateAtTime(Duration(milliseconds: 500));
        expect(stateAtHalfSecond, isNotNull);
        expect(stateAtHalfSecond!.controlValues['size'], 150.0);

        final drawingAtStart = scenario.findDrawingAtTime(Duration.zero);
        expect(drawingAtStart, isNotNull);
        expect(drawingAtStart!.commands.operations.length, 1);

        // Test scenario manipulation
        final trimmed = scenario.trimToTimeRange(
          Duration(milliseconds: 250),
          Duration(milliseconds: 750),
        );
        expect(trimmed.stateFrames.length, 1); // Only the 500ms frame
        expect(trimmed.stateFrames[0].timestamp, Duration(milliseconds: 250)); // Adjusted
        expect(trimmed.name, 'Color Picker Interaction (0s-0s)'); // Truncated seconds

        // Test metadata manipulation
        final enhanced = scenario.withAllMetadata({
          'priority': 'high',
          'automatedTest': true,
          'jiraTicket': 'PROJ-123',
        });
        expect(enhanced.metadata['author'], 'test@example.com'); // Preserved
        expect(enhanced.metadata['priority'], 'high'); // Added
        expect(enhanced.metadata['automatedTest'], true); // Added
      });

      test('playback-only scenario (no drawing frames)', () {
        final scenario = TestScenario(
          name: 'Playback Only Test',
          stateFrames: [
            StateFrame(timestamp: Duration.zero, controlValues: {'value': 1}),
            StateFrame(timestamp: Duration(seconds: 2), controlValues: {'value': 2}),
          ],
          drawingFrames: [], // No drawing data
          createdAt: DateTime.now(),
        );

        expect(scenario.hasStateData, isTrue);
        expect(scenario.hasDrawingData, isFalse);
        expect(scenario.supportsVisualTesting, isFalse); // Can't test without drawing data

        // Can still be used for playback
        expect(scenario.duration, Duration(seconds: 2));
        expect(scenario.stateFrameCount, 2);
      });

      test('visual testing scenario (drawing frames only)', () {
        final scenario = TestScenario(
          name: 'Visual Only Test',
          stateFrames: [], // No state data
          drawingFrames: [
            DrawingFrame(
              timestamp: Duration.zero,
              commands: DrawingCommands(
                operations: [
                  DrawingOperation.text(
                    text: 'Hello World',
                    offset: Offset(10, 10),
                    textStyle: {'fontSize': 16.0},
                  ),
                ],
              ),
            ),
          ],
          createdAt: DateTime.now(),
        );

        expect(scenario.hasStateData, isFalse);
        expect(scenario.hasDrawingData, isTrue);
        expect(scenario.supportsVisualTesting, isFalse); // Need state data to set up test conditions

        // Could be used for drawing analysis
        expect(scenario.drawingDuration, Duration.zero);
        expect(scenario.drawingFrameCount, 1);
      });
    });

    group('Edge Cases', () {
      test('handles very large scenarios', () {
        final stateFrames = List.generate(1000, (i) => 
          StateFrame(timestamp: Duration(milliseconds: i * 10), controlValues: {'step': i}));
        final drawingFrames = List.generate(500, (i) => 
          DrawingFrame(timestamp: Duration(milliseconds: i * 20), commands: DrawingCommands(operations: [])));

        final scenario = TestScenario(
          name: 'Large Scenario',
          stateFrames: stateFrames,
          drawingFrames: drawingFrames,
          createdAt: DateTime.now(),
        );

        expect(scenario.stateFrameCount, 1000);
        expect(scenario.drawingFrameCount, 500);
        expect(scenario.duration, Duration(milliseconds: 9990)); // Last state frame
        expect(scenario.drawingDuration, Duration(milliseconds: 9980)); // Last drawing frame
        expect(scenario.totalDuration, Duration(milliseconds: 9990));

        // Size estimation should handle large scenarios
        expect(scenario.estimatedSizeBytes, greaterThan(500000)); // Roughly 500KB+
      });

      test('handles scenarios with timestamps out of order', () {
        final stateFrames = [
          StateFrame(timestamp: Duration(seconds: 3), controlValues: {'step': 3}),
          StateFrame(timestamp: Duration(seconds: 1), controlValues: {'step': 1}),
          StateFrame(timestamp: Duration(seconds: 2), controlValues: {'step': 2}),
        ];

        final scenario = TestScenario(
          name: 'Unordered Test',
          stateFrames: stateFrames,
          createdAt: DateTime.now(),
        );

        // Duration should be based on last frame in the list, not chronologically last
        expect(scenario.duration, Duration(seconds: 2));

        // Finding should still work
        final found = scenario.findStateAtTime(Duration(seconds: 1));
        expect(found, isNotNull);
        expect(found!.controlValues['step'], 1);
      });

      test('handles scenarios with duplicate timestamps', () {
        final stateFrames = [
          StateFrame(timestamp: Duration(seconds: 1), controlValues: {'version': 'a'}),
          StateFrame(timestamp: Duration(seconds: 1), controlValues: {'version': 'b'}),
        ];

        final scenario = TestScenario(
          name: 'Duplicate Timestamps',
          stateFrames: stateFrames,
          createdAt: DateTime.now(),
        );

        expect(scenario.stateFrameCount, 2);
        expect(scenario.duration, Duration(seconds: 1));

        // Finding should return one of them (implementation-dependent)
        final found = scenario.findStateAtTime(Duration(seconds: 1));
        expect(found, isNotNull);
        expect(['a', 'b'], contains(found!.controlValues['version']));
      });

      test('handles extreme timestamp values', () {
        final scenario = TestScenario(
          name: 'Extreme Timestamps',
          stateFrames: [
            StateFrame(timestamp: Duration.zero, controlValues: {}),
            StateFrame(timestamp: Duration(days: 365), controlValues: {}), // 1 year
          ],
          createdAt: DateTime.now(),
        );

        expect(scenario.duration, Duration(days: 365));

        final json = scenario.toJson();
        final deserialized = TestScenario.fromJson(json);
        expect(deserialized.duration, Duration(days: 365));
      });
    });
  });
}