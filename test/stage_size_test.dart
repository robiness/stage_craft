import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:spot/spot.dart';
import 'package:stage_craft/stage_craft.dart';

import 'pump_stage.dart';
import 'test_stage_data.dart';

void main() {
  testWidgets('Initially the defaultStageSize from StageSettings are taken', (tester) async {
    await tester.pumpStage();
    expect(
      tester.testStageSize,
      const StageCraftSettings().defaultStageSize,
    );
  });

  testWidgets('The initialStageSize of the StageData is taken', (tester) async {
    await tester.pumpStage(
      stageData: TestStageData(
        initialStageSize: const Size(100, 100),
      ),
    );
    expect(
      tester.testStageSize,
      const Size(100, 100),
    );
  });
  group('The size is manipulated correctly when dragging the stages borders', () {
    testWidgets('top left', (tester) async {
      await tester.pumpStage();
      const offset = Offset(50, 0);
      final startPoint = tester.testStageTopLeft;
      await tester.resizeStage(initialPosition: startPoint, dragOffset: offset);
      await tester.pumpAndSettle();
      expect(
        tester.testStageTopLeft,
        equals(startPoint + offset),
        reason: 'The widget should be dragged to the right by 50 pixels.',
      );
    });
    test('bottom right', () async {});
    test('bottom left', () async {});
    test('top', () async {});
    test('right', () async {});
    test('bottom', () async {});
    test('left', () async {});
  });
}

extension StageSizeExtension on WidgetTester {
  Future<void> resizeStage({
    required Offset initialPosition,
    required Offset dragOffset,
  }) async {
    final pointer = TestPointer(1, PointerDeviceKind.mouse);
    final hoverEvent = pointer.hover(initialPosition);
    await sendEventToBinding(hoverEvent);
    await pumpAndSettle();

    await takeScreenshot(name: 'hover over top left corner');
    await sendEventToBinding(pointer.down(initialPosition));
    final newPosition = initialPosition + dragOffset;
    await sendEventToBinding(pointer.move(newPosition));
    await pumpAndSettle();
  }
}
