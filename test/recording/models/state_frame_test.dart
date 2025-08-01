import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/recording/models/state_frame.dart';

void main() {
  group('StateFrame', () {
    group('Basic Construction', () {
      test('creates frame with required parameters', () {
        final frame = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
        );

        expect(frame.timestamp, Duration(seconds: 1));
        expect(frame.controlValues, {'size': 100.0});
        expect(frame.canvasState, isNull);
      });

      test('creates frame with all parameters', () {
        final controlValues = {
          'size': 150.0,
          'color': {'type': 'Color', 'value': 0xFFFF0000},
          'enabled': true,
        };
        final canvasState = {
          'zoom': 1.5,
          'panX': 100.0,
          'panY': 50.0,
          'showRulers': true,
        };

        final frame = StateFrame(
          timestamp: Duration(milliseconds: 1500),
          controlValues: controlValues,
          canvasState: canvasState,
        );

        expect(frame.timestamp, Duration(milliseconds: 1500));
        expect(frame.controlValues, controlValues);
        expect(frame.canvasState, canvasState);
      });

      test('handles empty control values', () {
        final frame = StateFrame(
          timestamp: Duration.zero,
          controlValues: {},
        );

        expect(frame.controlValues, isEmpty);
        expect(frame.hasControlValues, isFalse);
        expect(frame.controlCount, 0);
      });

      test('handles null canvas state', () {
        final frame = StateFrame(
          timestamp: Duration.zero,
          controlValues: {'test': 'value'},
          canvasState: null,
        );

        expect(frame.canvasState, isNull);
        expect(frame.hasCanvasState, isFalse);
      });
    });

    group('JSON Serialization', () {
      test('serializes and deserializes correctly', () {
        final original = StateFrame(
          timestamp: Duration(milliseconds: 2500),
          controlValues: {
            'size': 200.0,
            'name': 'Test Widget',
            'enabled': true,
            'color': {'type': 'Color', 'value': 0xFF00FF00},
          },
          canvasState: {
            'zoom': 2.0,
            'panX': -50.0,
            'panY': 75.0,
            'showRulers': false,
            'showGrid': true,
          },
        );

        final json = original.toJson();
        final deserialized = StateFrame.fromJson(json);

        expect(deserialized, equals(original));
        expect(deserialized.timestamp, original.timestamp);
        expect(deserialized.controlValues, original.controlValues);
        expect(deserialized.canvasState, original.canvasState);
      });

      test('handles null canvas state in JSON', () {
        final original = StateFrame(
          timestamp: Duration(seconds: 3),
          controlValues: {'value': 42},
          canvasState: null,
        );

        final json = original.toJson();
        final deserialized = StateFrame.fromJson(json);

        expect(deserialized, equals(original));
        expect(deserialized.canvasState, isNull);
      });

      test('serializes complex control values correctly', () {
        final original = StateFrame(
          timestamp: Duration(milliseconds: 750),
          controlValues: {
            'string': 'Hello World',
            'int': 42,
            'double': 3.14159,
            'bool': true,
            'color': {'type': 'Color', 'value': 0xFFFF00FF},
            'datetime': {'type': 'DateTime', 'value': '2024-01-01T10:00:00.000Z'},
            'duration': {'type': 'Duration', 'value': 5000000}, // 5 seconds in microseconds
            'offset': {'type': 'Offset', 'dx': 10.0, 'dy': 20.0},
            'size': {'type': 'Size', 'width': 100.0, 'height': 200.0},
          },
        );

        final json = original.toJson();
        final deserialized = StateFrame.fromJson(json);

        expect(deserialized, equals(original));
        expect(deserialized.controlValues['string'], 'Hello World');
        expect(deserialized.controlValues['int'], 42);
        expect(deserialized.controlValues['double'], 3.14159);
        expect(deserialized.controlValues['bool'], true);
        expect(deserialized.controlValues['color'], {'type': 'Color', 'value': 0xFFFF00FF});
      });
    });

    group('Extension Methods', () {
      group('hasControlValues', () {
        test('returns true when control values exist', () {
          final frame = StateFrame(
            timestamp: Duration.zero,
            controlValues: {'test': 'value'},
          );

          expect(frame.hasControlValues, isTrue);
        });

        test('returns false when control values are empty', () {
          final frame = StateFrame(
            timestamp: Duration.zero,
            controlValues: {},
          );

          expect(frame.hasControlValues, isFalse);
        });
      });

      group('hasCanvasState', () {
        test('returns true when canvas state exists and non-empty', () {
          final frame = StateFrame(
            timestamp: Duration.zero,
            controlValues: {},
            canvasState: {'zoom': 1.0},
          );

          expect(frame.hasCanvasState, isTrue);
        });

        test('returns false when canvas state is null', () {
          final frame = StateFrame(
            timestamp: Duration.zero,
            controlValues: {},
            canvasState: null,
          );

          expect(frame.hasCanvasState, isFalse);
        });

        test('returns false when canvas state is empty', () {
          final frame = StateFrame(
            timestamp: Duration.zero,
            controlValues: {},
            canvasState: {},
          );

          expect(frame.hasCanvasState, isFalse);
        });
      });

      group('controlCount', () {
        test('returns correct count of control values', () {
          final frame = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 0xFFFF0000,
              'enabled': true,
            },
          );

          expect(frame.controlCount, 3);
        });

        test('returns zero for empty control values', () {
          final frame = StateFrame(
            timestamp: Duration.zero,
            controlValues: {},
          );

          expect(frame.controlCount, 0);
        });
      });

      group('withTimestampOffset', () {
        test('adjusts timestamp by positive offset', () {
          final original = StateFrame(
            timestamp: Duration(seconds: 5),
            controlValues: {'test': 'value'},
          );

          final adjusted = original.withTimestampOffset(Duration(seconds: 2));

          expect(adjusted.timestamp, Duration(seconds: 7));
          expect(adjusted.controlValues, original.controlValues);
          expect(adjusted.canvasState, original.canvasState);
        });

        test('adjusts timestamp by negative offset', () {
          final original = StateFrame(
            timestamp: Duration(seconds: 5),
            controlValues: {'test': 'value'},
          );

          final adjusted = original.withTimestampOffset(Duration(seconds: -3));

          expect(adjusted.timestamp, Duration(seconds: 2));
          expect(adjusted.controlValues, original.controlValues);
        });

        test('can create loops by resetting to zero', () {
          final original = StateFrame(
            timestamp: Duration(seconds: 10),
            controlValues: {'test': 'value'},
          );

          final loopFrame = original.withTimestampOffset(-original.timestamp);

          expect(loopFrame.timestamp, Duration.zero);
          expect(loopFrame.controlValues, original.controlValues);
        });
      });

      group('withControlValues', () {
        test('adds new control values to existing ones', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'existing': 'value',
              'size': 100.0,
            },
          );

          final modified = original.withControlValues({
            'newControl': 42.0,
            'anotherNew': 'test',
          });

          expect(modified.controlValues, {
            'existing': 'value',
            'size': 100.0,
            'newControl': 42.0,
            'anotherNew': 'test',
          });
          expect(modified.timestamp, original.timestamp);
          expect(modified.canvasState, original.canvasState);
        });

        test('overrides existing control values', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 'red',
            },
          );

          final modified = original.withControlValues({
            'size': 200.0, // Override existing
            'newValue': 'added',
          });

          expect(modified.controlValues, {
            'size': 200.0, // Overridden
            'color': 'red', // Preserved
            'newValue': 'added', // Added
          });
        });

        test('handles empty additional values', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {'test': 'value'},
          );

          final modified = original.withControlValues({});

          expect(modified.controlValues, original.controlValues);
        });
      });

      group('withCanvasState', () {
        test('adds canvas state to frame without existing canvas state', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {'test': 'value'},
            canvasState: null,
          );

          final modified = original.withCanvasState({
            'zoom': 1.5,
            'showRulers': true,
          });

          expect(modified.canvasState, {
            'zoom': 1.5,
            'showRulers': true,
          });
          expect(modified.controlValues, original.controlValues);
          expect(modified.timestamp, original.timestamp);
        });

        test('merges with existing canvas state', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {'test': 'value'},
            canvasState: {
              'zoom': 1.0,
              'panX': 0.0,
              'showRulers': false,
            },
          );

          final modified = original.withCanvasState({
            'zoom': 2.0, // Override existing
            'showGrid': true, // Add new
          });

          expect(modified.canvasState, {
            'zoom': 2.0, // Overridden
            'panX': 0.0, // Preserved
            'showRulers': false, // Preserved
            'showGrid': true, // Added
          });
        });

        test('handles empty new canvas state', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {'test': 'value'},
            canvasState: {'zoom': 1.0},
          );

          final modified = original.withCanvasState({});

          expect(modified.canvasState, original.canvasState);
        });
      });

      group('withOnlyControls', () {
        test('filters to only specified control labels', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 'red',
              'enabled': true,
              'name': 'widget',
            },
          );

          final filtered = original.withOnlyControls(['size', 'color']);

          expect(filtered.controlValues, {
            'size': 100.0,
            'color': 'red',
          });
          expect(filtered.timestamp, original.timestamp);
          expect(filtered.canvasState, original.canvasState);
        });

        test('handles non-existent control labels gracefully', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 'red',
            },
          );

          final filtered = original.withOnlyControls(['size', 'nonexistent']);

          expect(filtered.controlValues, {
            'size': 100.0,
          });
        });

        test('returns empty control values when no labels match', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 'red',
            },
          );

          final filtered = original.withOnlyControls(['nonexistent']);

          expect(filtered.controlValues, isEmpty);
        });

        test('handles empty label list', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 'red',
            },
          );

          final filtered = original.withOnlyControls([]);

          expect(filtered.controlValues, isEmpty);
        });
      });

      group('withoutControls', () {
        test('removes specified control labels', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 'red',
              'enabled': true,
              'name': 'widget',
            },
          );

          final filtered = original.withoutControls(['color', 'enabled']);

          expect(filtered.controlValues, {
            'size': 100.0,
            'name': 'widget',
          });
          expect(filtered.timestamp, original.timestamp);
          expect(filtered.canvasState, original.canvasState);
        });

        test('handles non-existent control labels gracefully', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 'red',
            },
          );

          final filtered = original.withoutControls(['nonexistent', 'color']);

          expect(filtered.controlValues, {
            'size': 100.0,
          });
        });

        test('returns original when no labels to remove', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 'red',
            },
          );

          final filtered = original.withoutControls(['nonexistent']);

          expect(filtered.controlValues, original.controlValues);
        });

        test('handles empty label list', () {
          final original = StateFrame(
            timestamp: Duration.zero,
            controlValues: {
              'size': 100.0,
              'color': 'red',
            },
          );

          final filtered = original.withoutControls([]);

          expect(filtered.controlValues, original.controlValues);
        });
      });
    });

    group('Equality and Hash Code', () {
      test('frames with same values are equal', () {
        final frame1 = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
          canvasState: {'zoom': 1.5},
        );

        final frame2 = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
          canvasState: {'zoom': 1.5},
        );

        expect(frame1, equals(frame2));
        expect(frame1.hashCode, equals(frame2.hashCode));
      });

      test('frames with different timestamps are not equal', () {
        final frame1 = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
        );

        final frame2 = StateFrame(
          timestamp: Duration(seconds: 2),
          controlValues: {'size': 100.0},
        );

        expect(frame1, isNot(equals(frame2)));
      });

      test('frames with different control values are not equal', () {
        final frame1 = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
        );

        final frame2 = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 200.0},
        );

        expect(frame1, isNot(equals(frame2)));
      });

      test('frames with different canvas states are not equal', () {
        final frame1 = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
          canvasState: {'zoom': 1.0},
        );

        final frame2 = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
          canvasState: {'zoom': 2.0},
        );

        expect(frame1, isNot(equals(frame2)));
      });
    });

    group('CopyWith', () {
      test('copies with new timestamp', () {
        final original = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
          canvasState: {'zoom': 1.5},
        );

        final copied = original.copyWith(timestamp: Duration(seconds: 5));

        expect(copied.timestamp, Duration(seconds: 5));
        expect(copied.controlValues, original.controlValues);
        expect(copied.canvasState, original.canvasState);
      });

      test('copies with new control values', () {
        final original = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
          canvasState: {'zoom': 1.5},
        );

        final newControlValues = {'color': 'red', 'enabled': true};
        final copied = original.copyWith(controlValues: newControlValues);

        expect(copied.timestamp, original.timestamp);
        expect(copied.controlValues, newControlValues);
        expect(copied.canvasState, original.canvasState);
      });

      test('copies with new canvas state', () {
        final original = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
          canvasState: {'zoom': 1.5},
        );

        final newCanvasState = {'zoom': 2.0, 'panX': 50.0};
        final copied = original.copyWith(canvasState: newCanvasState);

        expect(copied.timestamp, original.timestamp);
        expect(copied.controlValues, original.controlValues);
        expect(copied.canvasState, newCanvasState);
      });

      test('copies with null canvas state', () {
        final original = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'size': 100.0},
          canvasState: {'zoom': 1.5},
        );

        final copied = original.copyWith(canvasState: null);

        expect(copied.timestamp, original.timestamp);
        expect(copied.controlValues, original.controlValues);
        expect(copied.canvasState, isNull);
      });
    });

    group('Edge Cases', () {
      test('handles very large timestamps', () {
        final frame = StateFrame(
          timestamp: Duration(days: 365),
          controlValues: {'test': 'value'},
        );

        final json = frame.toJson();
        final deserialized = StateFrame.fromJson(json);

        expect(deserialized.timestamp, Duration(days: 365));
      });

      test('handles zero timestamp', () {
        final frame = StateFrame(
          timestamp: Duration.zero,
          controlValues: {'initial': 'state'},
        );

        expect(frame.timestamp, Duration.zero);
        expect(frame.timestamp.inMicroseconds, 0);
      });

      test('handles deeply nested control values', () {
        final complexValue = {
          'nested': {
            'level1': {
              'level2': {
                'value': 42,
                'list': [1, 2, 3],
              },
            },
          },
        };

        final frame = StateFrame(
          timestamp: Duration(seconds: 1),
          controlValues: {'complex': complexValue},
        );

        final json = frame.toJson();
        final deserialized = StateFrame.fromJson(json);

        expect(deserialized.controlValues['complex'], complexValue);
      });

      test('handles empty canvas state map', () {
        final frame = StateFrame(
          timestamp: Duration.zero,
          controlValues: {'test': 'value'},
          canvasState: {},
        );

        expect(frame.hasCanvasState, isFalse);
        
        final json = frame.toJson();
        final deserialized = StateFrame.fromJson(json);
        
        expect(deserialized.canvasState, {});
        expect(deserialized.hasCanvasState, isFalse);
      });
    });
  });
}