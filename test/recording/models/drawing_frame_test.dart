import 'dart:math' as math;
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/recording/models/drawing_frame.dart';

void main() {
  group('DrawingFrame', () {
    group('Basic Construction', () {
      test('creates frame with required parameters', () {
        final commands = DrawingCommands(
          operations: [
            DrawingOperation.rect(
              rect: Rect.fromLTWH(10.0, 10.0, 100.0, 50.0),
              paint: {'color': 0xFFFF0000, 'style': 'fill'},
            ),
          ],
        );

        final frame = DrawingFrame(
          timestamp: Duration(milliseconds: 1500),
          commands: commands,
        );

        expect(frame.timestamp, Duration(milliseconds: 1500));
        expect(frame.commands, commands);
        expect(frame.hasOperations, isTrue);
        expect(frame.operationCount, 1);
      });

      test('creates frame with empty operations', () {
        final commands = DrawingCommands(operations: []);
        final frame = DrawingFrame(
          timestamp: Duration.zero,
          commands: commands,
        );

        expect(frame.hasOperations, isFalse);
        expect(frame.operationCount, 0);
      });

      test('creates frame with canvas size and clip bounds', () {
        final commands = DrawingCommands(
          operations: [],
          canvasSize: {'width': 200.0, 'height': 100.0},
          clipBounds: {'left': 0.0, 'top': 0.0, 'right': 200.0, 'bottom': 100.0},
          metadata: {'devicePixelRatio': 2.0},
        );

        final frame = DrawingFrame(
          timestamp: Duration(seconds: 1),
          commands: commands,
        );

        expect(frame.commands.canvasSize, {'width': 200.0, 'height': 100.0});
        expect(frame.commands.clipBounds, {'left': 0.0, 'top': 0.0, 'right': 200.0, 'bottom': 100.0});
        expect(frame.commands.metadata, {'devicePixelRatio': 2.0});
        expect(frame.canvasArea, 20000.0); // 200 * 100
      });
    });

    group('JSON Serialization', () {
      test('serializes and deserializes correctly', () {
        final original = DrawingFrame(
          timestamp: Duration(milliseconds: 2500),
          commands: DrawingCommands(
            operations: [
              DrawingOperation.rect(
                rect: Rect.fromLTWH(10.0, 10.0, 100.0, 50.0),
                paint: {'color': 0xFFFF0000, 'style': 'fill'},
              ),
              DrawingOperation.circle(
                center: Offset(50.0, 50.0),
                radius: 25.0,
                paint: {'color': 0xFF00FF00, 'style': 'stroke'},
              ),
            ],
            canvasSize: {'width': 200.0, 'height': 150.0},
            clipBounds: {'left': 5.0, 'top': 5.0, 'right': 195.0, 'bottom': 145.0},
            metadata: {'test': 'value'},
          ),
        );

        final json = original.toJson();
        final deserialized = DrawingFrame.fromJson(json);

        expect(deserialized, equals(original));
        expect(deserialized.timestamp, original.timestamp);
        expect(deserialized.commands.operations.length, 2);
        expect(deserialized.commands.canvasSize, original.commands.canvasSize);
        expect(deserialized.commands.clipBounds, original.commands.clipBounds);
        expect(deserialized.commands.metadata, original.commands.metadata);
      });

      test('handles null canvas size and clip bounds', () {
        final original = DrawingFrame(
          timestamp: Duration(seconds: 3),
          commands: DrawingCommands(
            operations: [
              DrawingOperation.text(
                text: 'Hello World',
                offset: Offset(20.0, 30.0),
                textStyle: {'fontSize': 16.0, 'color': 0xFF000000},
              ),
            ],
            canvasSize: null,
            clipBounds: null,
          ),
        );

        final json = original.toJson();
        final deserialized = DrawingFrame.fromJson(json);

        expect(deserialized, equals(original));
        expect(deserialized.commands.canvasSize, isNull);
        expect(deserialized.commands.clipBounds, isNull);
        expect(deserialized.canvasArea, isNull);
      });
    });

    group('Extension Methods', () {
      group('hasOperations', () {
        test('returns true when operations exist', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.rect(
                  rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0),
                  paint: {'color': 0xFF000000},
                ),
              ],
            ),
          );

          expect(frame.hasOperations, isTrue);
        });

        test('returns false when no operations', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(operations: []),
          );

          expect(frame.hasOperations, isFalse);
        });
      });

      group('operationCount', () {
        test('returns correct count of operations', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), paint: {}),
                DrawingOperation.circle(center: Offset.zero, radius: 5.0, paint: {}),
                DrawingOperation.text(text: 'test', offset: Offset.zero, textStyle: {}),
              ],
            ),
          );

          expect(frame.operationCount, 3);
        });
      });

      group('canvasArea', () {
        test('calculates area when canvas size is available', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [],
              canvasSize: {'width': 100.0, 'height': 200.0},
            ),
          );

          expect(frame.canvasArea, 20000.0);
        });

        test('returns null when canvas size is not available', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(operations: []),
          );

          expect(frame.canvasArea, isNull);
        });

        test('returns null when canvas size is incomplete', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [],
              canvasSize: {'width': 100.0}, // Missing height
            ),
          );

          expect(frame.canvasArea, isNull);
        });
      });

      group('operation type detection', () {
        test('detects text operations', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), paint: {}),
                DrawingOperation.text(text: 'test', offset: Offset.zero, textStyle: {}),
              ],
            ),
          );

          expect(frame.hasTextOperations, isTrue);
        });

        test('detects image operations', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.image(
                  offset: Offset.zero,
                  size: Size(100.0, 100.0),
                  imageHash: 'hash123',
                  paint: {},
                ),
              ],
            ),
          );

          expect(frame.hasImageOperations, isTrue);
        });

        test('detects path operations', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.path(
                  pathData: 'M10,10 L50,10 L50,50 Z',
                  paint: {},
                ),
              ],
            ),
          );

          expect(frame.hasPathOperations, isTrue);
        });

        test('returns false when operation types not present', () {
          final frame = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), paint: {}),
                DrawingOperation.circle(center: Offset.zero, radius: 5.0, paint: {}),
              ],
            ),
          );

          expect(frame.hasTextOperations, isFalse);
          expect(frame.hasImageOperations, isFalse);
          expect(frame.hasPathOperations, isFalse);
        });
      });

      group('withTimestampOffset', () {
        test('adjusts timestamp by offset', () {
          final original = DrawingFrame(
            timestamp: Duration(seconds: 5),
            commands: DrawingCommands(operations: []),
          );

          final adjusted = original.withTimestampOffset(Duration(seconds: 2));

          expect(adjusted.timestamp, Duration(seconds: 7));
          expect(adjusted.commands, original.commands);
        });

        test('handles negative offset', () {
          final original = DrawingFrame(
            timestamp: Duration(seconds: 5),
            commands: DrawingCommands(operations: []),
          );

          final adjusted = original.withTimestampOffset(Duration(seconds: -3));

          expect(adjusted.timestamp, Duration(seconds: 2));
        });
      });

      group('withOnlyOperationTypes', () {
        test('filters operations by type', () {
          final original = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), paint: {}),
                DrawingOperation.circle(center: Offset.zero, radius: 5.0, paint: {}),
                DrawingOperation.text(text: 'test', offset: Offset.zero, textStyle: {}),
                DrawingOperation.rect(rect: Rect.fromLTWH(20.0, 20.0, 10.0, 10.0), paint: {}),
              ],
            ),
          );

          final filtered = original.withOnlyOperationTypes([DrawRect]);

          expect(filtered.operationCount, 2);
          expect(filtered.commands.operations.every((op) => op is DrawRect), isTrue);
        });

        test('returns empty when no matching types', () {
          final original = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), paint: {}),
                DrawingOperation.circle(center: Offset.zero, radius: 5.0, paint: {}),
              ],
            ),
          );

          final filtered = original.withOnlyOperationTypes([DrawText]);

          expect(filtered.operationCount, 0);
        });

        test('handles multiple operation types', () {
          final original = DrawingFrame(
            timestamp: Duration.zero,
            commands: DrawingCommands(
              operations: [
                DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), paint: {}),
                DrawingOperation.circle(center: Offset.zero, radius: 5.0, paint: {}),
                DrawingOperation.text(text: 'test', offset: Offset.zero, textStyle: {}),
                DrawingOperation.oval(rect: Rect.fromLTWH(10.0, 10.0, 20.0, 15.0), paint: {}),
              ],
            ),
          );

          final filtered = original.withOnlyOperationTypes([DrawRect, DrawText]);

          expect(filtered.operationCount, 2);
          expect(filtered.commands.operations.every((op) => op is DrawRect || op is DrawText), isTrue);
        });
      });
    });
  });

  group('DrawingCommands', () {
    group('Basic Construction', () {
      test('creates with required operations', () {
        final commands = DrawingCommands(
          operations: [
            DrawingOperation.rect(
              rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
              paint: {'color': 0xFFFF0000},
            ),
          ],
        );

        expect(commands.operations.length, 1);
        expect(commands.canvasSize, isNull);
        expect(commands.clipBounds, isNull);
        expect(commands.metadata, isEmpty);
      });

      test('creates with all parameters', () {
        final operations = [
          DrawingOperation.circle(center: Offset(50.0, 50.0), radius: 25.0, paint: {}),
        ];
        const canvasSize = {'width': 200.0, 'height': 100.0};
        const clipBounds = {'left': 0.0, 'top': 0.0, 'right': 200.0, 'bottom': 100.0};
        const metadata = {'test': 'value', 'devicePixelRatio': 2.0};

        final commands = DrawingCommands(
          operations: operations,
          canvasSize: canvasSize,
          clipBounds: clipBounds,
          metadata: metadata,
        );

        expect(commands.operations, operations);
        expect(commands.canvasSize, canvasSize);
        expect(commands.clipBounds, clipBounds);
        expect(commands.metadata, metadata);
      });
    });

    group('Extension Methods', () {
      group('operationsByType', () {
        test('groups operations by type correctly', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), paint: {}),
              DrawingOperation.circle(center: Offset.zero, radius: 5.0, paint: {}),
              DrawingOperation.rect(rect: Rect.fromLTWH(20.0, 20.0, 10.0, 10.0), paint: {}),
              DrawingOperation.text(text: 'test', offset: Offset.zero, textStyle: {}),
            ],
          );

          final groupedOps = commands.operationsByType;

          expect(groupedOps.keys.length, 3);
          expect(groupedOps['DrawRect']?.length, 2);
          expect(groupedOps['DrawCircle']?.length, 1);
          expect(groupedOps['DrawText']?.length, 1);
        });

        test('handles empty operations', () {
          final commands = DrawingCommands(operations: []);
          final groupedOps = commands.operationsByType;

          expect(groupedOps, isEmpty);
        });
      });

      group('operationCounts', () {
        test('counts operations by type', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), paint: {}),
              DrawingOperation.rect(rect: Rect.fromLTWH(20.0, 20.0, 10.0, 10.0), paint: {}),
              DrawingOperation.circle(center: Offset.zero, radius: 5.0, paint: {}),
            ],
          );

          final counts = commands.operationCounts;

          expect(counts['DrawRect'], 2);
          expect(counts['DrawCircle'], 1);
        });
      });

      group('boundingRect', () {
        test('calculates bounding rectangle for rect operations', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.rect(rect: Rect.fromLTWH(10.0, 20.0, 30.0, 40.0), paint: {}),
              DrawingOperation.rect(rect: Rect.fromLTWH(50.0, 10.0, 20.0, 30.0), paint: {}),
            ],
          );

          final bounds = commands.boundingRect;

          expect(bounds, isNotNull);
          expect(bounds!.left, 10.0);
          expect(bounds.top, 10.0);
          expect(bounds.right, 70.0); // 50 + 20
          expect(bounds.bottom, 60.0); // 20 + 40
        });

        test('calculates bounding rectangle for circle operations', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.circle(center: Offset(50.0, 50.0), radius: 25.0, paint: {}),
              DrawingOperation.circle(center: Offset(100.0, 30.0), radius: 15.0, paint: {}),
            ],
          );

          final bounds = commands.boundingRect;

          expect(bounds, isNotNull);
          expect(bounds!.left, 25.0); // 50 - 25
          expect(bounds.top, 15.0); // 30 - 15
          expect(bounds.right, 115.0); // 100 + 15
          expect(bounds.bottom, 75.0); // 50 + 25
        });

        test('calculates bounding rectangle for line operations', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.line(p1: Offset(10.0, 20.0), p2: Offset(50.0, 80.0), paint: {}),
              DrawingOperation.line(p1: Offset(30.0, 10.0), p2: Offset(60.0, 40.0), paint: {}),
            ],
          );

          final bounds = commands.boundingRect;

          expect(bounds, isNotNull);
          expect(bounds!.left, 10.0);
          expect(bounds.top, 10.0);
          expect(bounds.right, 60.0);
          expect(bounds.bottom, 80.0);
        });

        test('calculates bounding rectangle for image operations', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.image(
                offset: Offset(20.0, 30.0),
                size: Size(100.0, 80.0),
                imageHash: 'hash1',
                paint: {},
              ),
              DrawingOperation.image(
                offset: Offset(50.0, 10.0),
                size: Size(60.0, 90.0),
                imageHash: 'hash2',
                paint: {},
              ),
            ],
          );

          final bounds = commands.boundingRect;

          expect(bounds, isNotNull);
          expect(bounds!.left, 20.0);
          expect(bounds.top, 10.0);
          expect(bounds.right, 120.0); // 20 + 100
          expect(bounds.bottom, 110.0); // 30 + 80
        });

        test('calculates bounding rectangle for points operations', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.points(
                points: [Offset(10.0, 20.0), Offset(50.0, 80.0), Offset(30.0, 10.0)],
                pointMode: 'points',
                paint: {},
              ),
            ],
          );

          final bounds = commands.boundingRect;

          expect(bounds, isNotNull);
          expect(bounds!.left, 10.0);
          expect(bounds.top, 10.0);
          expect(bounds.right, 50.0);
          expect(bounds.bottom, 80.0);
        });

        test('handles mixed operation types', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0), paint: {}),
              DrawingOperation.circle(center: Offset(100.0, 100.0), radius: 30.0, paint: {}),
              DrawingOperation.line(p1: Offset(200.0, 200.0), p2: Offset(250.0, 250.0), paint: {}),
            ],
          );

          final bounds = commands.boundingRect;

          expect(bounds, isNotNull);
          expect(bounds!.left, 0.0);
          expect(bounds.top, 0.0);
          expect(bounds.right, 250.0);
          expect(bounds.bottom, 250.0);
        });

        test('returns null for empty operations', () {
          final commands = DrawingCommands(operations: []);
          expect(commands.boundingRect, isNull);
        });

        test('returns null for operations without position info', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.custom(operationType: 'unknown', parameters: {}),
            ],
          );

          expect(commands.boundingRect, isNull);
        });

        test('handles points operations with empty points list', () {
          final commands = DrawingCommands(
            operations: [
              DrawingOperation.points(points: [], pointMode: 'points', paint: {}),
            ],
          );

          expect(commands.boundingRect, isNull);
        });
      });
    });
  });

  group('DrawingOperation', () {
    group('Rectangle Operations', () {
      test('creates rect operation correctly', () {
        final rect = Rect.fromLTWH(10.0, 20.0, 100.0, 80.0);
        final paint = {'color': 0xFFFF0000, 'style': 'fill', 'strokeWidth': 2.0};

        final operation = DrawingOperation.rect(rect: rect, paint: paint);

        operation.when(
          rect: (r, p) {
            expect(r, rect);
            expect(p, paint);
          },
          circle: (_, __, ___) => fail('Should be rect operation'),
          oval: (_, __) => fail('Should be rect operation'),
          line: (_, __, ___) => fail('Should be rect operation'),
          path: (_, __) => fail('Should be rect operation'),
          text: (_, __, ___) => fail('Should be rect operation'),
          image: (_, __, ___, ____) => fail('Should be rect operation'),
          points: (_, __, ___) => fail('Should be rect operation'),
          roundedRect: (_, __, ___, ____) => fail('Should be rect operation'),
          custom: (_, __) => fail('Should be rect operation'),
        );
      });

      test('serializes rect operation correctly', () {
        final operation = DrawingOperation.rect(
          rect: Rect.fromLTWH(10.0, 20.0, 100.0, 80.0),
          paint: {'color': 0xFFFF0000},
        );

        final json = operation.toJson();
        final deserialized = DrawingOperation.fromJson(json);

        expect(deserialized, equals(operation));
      });
    });

    group('Circle Operations', () {
      test('creates circle operation correctly', () {
        final center = Offset(50.0, 60.0);
        const radius = 25.0;
        final paint = {'color': 0xFF00FF00, 'style': 'stroke'};

        final operation = DrawingOperation.circle(
          center: center,
          radius: radius,
          paint: paint,
        );

        operation.when(
          rect: (_, __) => fail('Should be circle operation'),
          circle: (c, r, p) {
            expect(c, center);
            expect(r, radius);
            expect(p, paint);
          },
          oval: (_, __) => fail('Should be circle operation'),
          line: (_, __, ___) => fail('Should be circle operation'),
          path: (_, __) => fail('Should be circle operation'),
          text: (_, __, ___) => fail('Should be circle operation'),
          image: (_, __, ___, ____) => fail('Should be circle operation'),
          points: (_, __, ___) => fail('Should be circle operation'),
          roundedRect: (_, __, ___, ____) => fail('Should be circle operation'),
          custom: (_, __) => fail('Should be circle operation'),
        );
      });
    });

    group('Text Operations', () {
      test('creates text operation correctly', () {
        const text = 'Hello World';
        final offset = Offset(20.0, 30.0);
        final textStyle = {
          'fontSize': 16.0,
          'color': 0xFF000000,
          'fontFamily': 'Roboto',
        };

        final operation = DrawingOperation.text(
          text: text,
          offset: offset,
          textStyle: textStyle,
        );

        operation.when(
          rect: (_, __) => fail('Should be text operation'),
          circle: (_, __, ___) => fail('Should be text operation'),
          oval: (_, __) => fail('Should be text operation'),
          line: (_, __, ___) => fail('Should be text operation'),
          path: (_, __) => fail('Should be text operation'),
          text: (t, o, ts) {
            expect(t, text);
            expect(o, offset);
            expect(ts, textStyle);
          },
          image: (_, __, ___, ____) => fail('Should be text operation'),
          points: (_, __, ___) => fail('Should be text operation'),
          roundedRect: (_, __, ___, ____) => fail('Should be text operation'),
          custom: (_, __) => fail('Should be text operation'),
        );
      });
    });

    group('Path Operations', () {
      test('creates path operation correctly', () {
        const pathData = 'M10,10 L50,10 L50,50 L10,50 Z';
        final paint = {'color': 0xFF0000FF, 'style': 'fill'};

        final operation = DrawingOperation.path(
          pathData: pathData,
          paint: paint,
        );

        operation.when(
          rect: (_, __) => fail('Should be path operation'),
          circle: (_, __, ___) => fail('Should be path operation'),
          oval: (_, __) => fail('Should be path operation'),
          line: (_, __, ___) => fail('Should be path operation'),
          path: (pd, p) {
            expect(pd, pathData);
            expect(p, paint);
          },
          text: (_, __, ___) => fail('Should be path operation'),
          image: (_, __, ___, ____) => fail('Should be path operation'),
          points: (_, __, ___) => fail('Should be path operation'),
          roundedRect: (_, __, ___, ____) => fail('Should be path operation'),
          custom: (_, __) => fail('Should be path operation'),
        );
      });
    });

    group('Image Operations', () {
      test('creates image operation correctly', () {
        final offset = Offset(100.0, 200.0);
        final size = Size(150.0, 100.0);
        const imageHash = 'sha256:abc123...';
        final paint = {'opacity': 0.8};

        final operation = DrawingOperation.image(
          offset: offset,
          size: size,
          imageHash: imageHash,
          paint: paint,
        );

        operation.when(
          rect: (_, __) => fail('Should be image operation'),
          circle: (_, __, ___) => fail('Should be image operation'),
          oval: (_, __) => fail('Should be image operation'),
          line: (_, __, ___) => fail('Should be image operation'),
          path: (_, __) => fail('Should be image operation'),
          text: (_, __, ___) => fail('Should be image operation'),
          image: (o, s, ih, p) {
            expect(o, offset);
            expect(s, size);
            expect(ih, imageHash);
            expect(p, paint);
          },
          points: (_, __, ___) => fail('Should be image operation'),
          roundedRect: (_, __, ___, ____) => fail('Should be image operation'),
          custom: (_, __) => fail('Should be image operation'),
        );
      });
    });

    group('Points Operations', () {
      test('creates points operation correctly', () {
        final points = [Offset(10.0, 10.0), Offset(20.0, 20.0), Offset(30.0, 30.0)];
        const pointMode = 'points';
        final paint = {'color': 0xFFFFFF00, 'strokeWidth': 3.0};

        final operation = DrawingOperation.points(
          points: points,
          pointMode: pointMode,
          paint: paint,
        );

        operation.when(
          rect: (_, __) => fail('Should be points operation'),
          circle: (_, __, ___) => fail('Should be points operation'),
          oval: (_, __) => fail('Should be points operation'),
          line: (_, __, ___) => fail('Should be points operation'),
          path: (_, __) => fail('Should be points operation'),
          text: (_, __, ___) => fail('Should be points operation'),
          image: (_, __, ___, ____) => fail('Should be points operation'),
          points: (pts, pm, p) {
            expect(pts, points);
            expect(pm, pointMode);
            expect(p, paint);
          },
          roundedRect: (_, __, ___, ____) => fail('Should be points operation'),
          custom: (_, __) => fail('Should be points operation'),
        );
      });

      test('handles different point modes', () {
        final points = [Offset(0.0, 0.0), Offset(10.0, 10.0)];
        
        for (final mode in ['points', 'lines', 'polygon']) {
          final operation = DrawingOperation.points(
            points: points,
            pointMode: mode,
            paint: {},
          );
          
          operation.when(
            points: (pts, pm, p) {
              expect(pm, mode);
            },
            rect: (_, __) => fail('Should be points operation'),
            circle: (_, __, ___) => fail('Should be points operation'),
            oval: (_, __) => fail('Should be points operation'),
            line: (_, __, ___) => fail('Should be points operation'),
            path: (_, __) => fail('Should be points operation'),
            text: (_, __, ___) => fail('Should be points operation'),
            image: (_, __, ___, ____) => fail('Should be points operation'),
            roundedRect: (_, __, ___, ____) => fail('Should be points operation'),
            custom: (_, __) => fail('Should be points operation'),
          );
        }
      });
    });

    group('Rounded Rectangle Operations', () {
      test('creates rounded rect operation correctly', () {
        final rect = Rect.fromLTWH(50.0, 50.0, 100.0, 80.0);
        const radiusX = 10.0;
        const radiusY = 15.0;
        final paint = {'color': 0xFF00FFFF, 'style': 'fill'};

        final operation = DrawingOperation.roundedRect(
          rect: rect,
          radiusX: radiusX,
          radiusY: radiusY,
          paint: paint,
        );

        operation.when(
          rect: (_, __) => fail('Should be rounded rect operation'),
          circle: (_, __, ___) => fail('Should be rounded rect operation'),
          oval: (_, __) => fail('Should be rounded rect operation'),
          line: (_, __, ___) => fail('Should be rounded rect operation'),
          path: (_, __) => fail('Should be rounded rect operation'),
          text: (_, __, ___) => fail('Should be rounded rect operation'),
          image: (_, __, ___, ____) => fail('Should be rounded rect operation'),
          points: (_, __, ___) => fail('Should be rounded rect operation'),
          roundedRect: (r, rx, ry, p) {
            expect(r, rect);
            expect(rx, radiusX);
            expect(ry, radiusY);
            expect(p, paint);
          },
          custom: (_, __) => fail('Should be rounded rect operation'),
        );
      });
    });

    group('Custom Operations', () {
      test('creates custom operation correctly', () {
        const operationType = 'customDraw';
        final parameters = {
          'param1': 'value1',
          'param2': 42,
          'param3': [1, 2, 3],
        };

        final operation = DrawingOperation.custom(
          operationType: operationType,
          parameters: parameters,
        );

        operation.when(
          rect: (_, __) => fail('Should be custom operation'),
          circle: (_, __, ___) => fail('Should be custom operation'),
          oval: (_, __) => fail('Should be custom operation'),
          line: (_, __, ___) => fail('Should be custom operation'),
          path: (_, __) => fail('Should be custom operation'),
          text: (_, __, ___) => fail('Should be custom operation'),
          image: (_, __, ___, ____) => fail('Should be custom operation'),
          points: (_, __, ___) => fail('Should be custom operation'),
          roundedRect: (_, __, ___, ____) => fail('Should be custom operation'),
          custom: (ot, p) {
            expect(ot, operationType);
            expect(p, parameters);
          },
        );
      });
    });

    group('JSON Serialization', () {
      test('serializes all operation types correctly', () {
        final operations = [
          DrawingOperation.rect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), paint: {}),
          DrawingOperation.circle(center: Offset(5.0, 5.0), radius: 5.0, paint: {}),
          DrawingOperation.oval(rect: Rect.fromLTWH(10.0, 10.0, 20.0, 15.0), paint: {}),
          DrawingOperation.line(p1: Offset(0.0, 0.0), p2: Offset(10.0, 10.0), paint: {}),
          DrawingOperation.path(pathData: 'M0,0 L10,10', paint: {}),
          DrawingOperation.text(text: 'test', offset: Offset(0.0, 0.0), textStyle: {}),
          DrawingOperation.image(offset: Offset(0.0, 0.0), size: Size(10.0, 10.0), imageHash: 'hash', paint: {}),
          DrawingOperation.points(points: [Offset(0.0, 0.0)], pointMode: 'points', paint: {}),
          DrawingOperation.roundedRect(rect: Rect.fromLTWH(0.0, 0.0, 10.0, 10.0), radiusX: 2.0, radiusY: 2.0, paint: {}),
          DrawingOperation.custom(operationType: 'test', parameters: {}),
        ];

        for (final operation in operations) {
          final json = operation.toJson();
          final deserialized = DrawingOperation.fromJson(json);
          expect(deserialized, equals(operation));
        }
      });
    });
  });

  group('JSON Serialization Helpers', () {
    group('Size helpers', () {
      test('converts Size to map and back', () {
        final size = Size(100.0, 200.0);
        final map = _sizeToMap(size);
        final restored = _sizeFromMap(map);

        expect(map, {'width': 100.0, 'height': 200.0});
        expect(restored, size);
      });

      test('handles zero size', () {
        final size = Size.zero;
        final map = _sizeToMap(size);
        final restored = _sizeFromMap(map);

        expect(restored, size);
      });
    });

    group('Rect helpers', () {
      test('converts Rect to map and back', () {
        final rect = Rect.fromLTRB(10.0, 20.0, 100.0, 200.0);
        final map = _rectToMap(rect);
        final restored = _rectFromMap(map);

        expect(map, {
          'left': 10.0,
          'top': 20.0,
          'right': 100.0,
          'bottom': 200.0,
        });
        expect(restored, rect);
      });

      test('handles zero rect', () {
        final rect = Rect.zero;
        final map = _rectToMap(rect);
        final restored = _rectFromMap(map);

        expect(restored, rect);
      });
    });

    group('Offset helpers', () {
      test('converts Offset to map and back', () {
        final offset = Offset(50.0, 75.0);
        final map = _offsetToMap(offset);
        final restored = _offsetFromMap(map);

        expect(map, {'dx': 50.0, 'dy': 75.0});
        expect(restored, offset);
      });

      test('handles zero offset', () {
        final offset = Offset.zero;
        final map = _offsetToMap(offset);
        final restored = _offsetFromMap(map);

        expect(restored, offset);
      });
    });

    group('Offset list helpers', () {
      test('converts offset list to JSON and back', () {
        final offsets = [
          Offset(10.0, 20.0),
          Offset(30.0, 40.0),
          Offset(50.0, 60.0),
        ];

        final json = _offsetListToJson(offsets);
        final restored = _offsetListFromJson(json);

        expect(restored, offsets);
      });

      test('handles empty offset list', () {
        final offsets = <Offset>[];
        final json = _offsetListToJson(offsets);
        final restored = _offsetListFromJson(json);

        expect(restored, isEmpty);
      });
    });
  });
}

// Helper functions for testing (these should match the actual implementations)
Map<String, double> _sizeToMap(Size size) {
  return {
    'width': size.width,
    'height': size.height,
  };
}

Size _sizeFromMap(Map<String, dynamic> map) {
  return Size(
    (map['width'] as num?)?.toDouble() ?? 0.0,
    (map['height'] as num?)?.toDouble() ?? 0.0,
  );
}

Map<String, double> _rectToMap(Rect rect) {
  return {
    'left': rect.left,
    'top': rect.top,
    'right': rect.right,
    'bottom': rect.bottom,
  };
}

Rect _rectFromMap(Map<String, dynamic> map) {
  return Rect.fromLTRB(
    (map['left'] as num?)?.toDouble() ?? 0.0,
    (map['top'] as num?)?.toDouble() ?? 0.0,
    (map['right'] as num?)?.toDouble() ?? 0.0,
    (map['bottom'] as num?)?.toDouble() ?? 0.0,
  );
}

Map<String, double> _offsetToMap(Offset offset) {
  return {
    'dx': offset.dx,
    'dy': offset.dy,
  };
}

Offset _offsetFromMap(Map<String, dynamic> map) {
  return Offset(
    (map['dx'] as num?)?.toDouble() ?? 0.0,
    (map['dy'] as num?)?.toDouble() ?? 0.0,
  );
}

List<Map<String, double>> _offsetListToJson(List<Offset> offsets) {
  return offsets.map(_offsetToMap).toList();
}

List<Offset> _offsetListFromJson(List<dynamic> json) {
  return json.map((item) => _offsetFromMap(item as Map<String, dynamic>)).toList();
}