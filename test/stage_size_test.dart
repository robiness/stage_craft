import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
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
      await tester.dragFrom(
        tester.testStageTopLeft,
        const Offset(10, 0),
      );
      expect(
        tester.testStageSize,
        const Size(390, 400),
      );
    });
    test('top right', () async {});
    test('bottom right', () async {});
    test('bottom left', () async {});
    test('top', () async {});
    test('right', () async {});
    test('bottom', () async {});
    test('left', () async {});
  });
}
