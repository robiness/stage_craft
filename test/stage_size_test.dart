import 'dart:ui';

import 'package:flutter/material.dart';
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
  // group('The size is manipulated correctly when dragging the stages borders', () {
  //   testWidgets('top left', (tester) async {
  //     final debugMarker = ValueNotifier<Offset?>(null);
  //     await tester.pumpStage(debugMarker: debugMarker);
  //     await takeScreenshot(name: 'top_left_initial');
  //
  //     // expect no handles are shown
  //     final initialPosition = tester.testStageTopLeft;
  //     // Create a gesture and simulate hover
  //     final pointer = TestPointer(1, PointerDeviceKind.mouse);
  //     print('Buttons: ${pointer.buttons}');
  //     print('-----------');
  //
  //     // Hover over the top left corner
  //     final hoverEvent = pointer.hover(initialPosition);
  //     await tester.sendEventToBinding(hoverEvent);
  //     debugMarker.value = initialPosition;
  //     await tester.pumpAndSettle();
  //     print('Hover at ${pointer.location}');
  //     print(pointer.isDown);
  //     print('Buttons: ${pointer.buttons}');
  //     await tester.pumpAndSettle();
  //     await takeScreenshot(name: 'hover over top left corner');
  //     print('-----------');
  //
  //     // Pointer Down at initial position
  //     await tester.sendEventToBinding(pointer.down(initialPosition));
  //     print('Down at ${pointer.location}');
  //     print(pointer.isDown);
  //     print('Buttons: ${pointer.buttons}');
  //     await tester.pumpAndSettle();
  //     await takeScreenshot();
  //     print('-----------');
  //
  //     // Move Pointer
  //     final newPosition = initialPosition + const Offset(50, 0);
  //     await tester.sendEventToBinding(pointer.move(newPosition));
  //     print('Moved pointer to ${pointer.location}');
  //     print(pointer.isDown);
  //     print('Buttons: ${pointer.buttons}');
  //
  //     await tester.pumpAndSettle();
  //     await takeScreenshot();
  //     print('-----------');
  //
  //     // Assuming you have a way to verify the new position, typically via debugMarker or another method
  //     // This expectation needs to be adjusted based on your actual app logic and what you're testing.
  //     expect(
  //       tester.testStageTopLeft,
  //       equals(newPosition),
  //       reason: 'The widget should be dragged to the right by 50 pixels.',
  //     );
  //   });
  //   test('bottom right', () async {});
  //   test('bottom left', () async {});
  //   test('top', () async {});
  //   test('right', () async {});
  //   test('bottom', () async {});
  //   test('left', () async {});
  // });
}
