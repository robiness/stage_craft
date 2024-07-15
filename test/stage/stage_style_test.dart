//
// 1. A control gets created and the a control widget does get created with the correct value
// The test widget takes in a control.value of that type and gets the set value

// 2. The control does get changed per user interaction and the test widget does get rebuild with the new value.
// Also the control widget does reflect the new state.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';

import 'stage_test_extensions.dart';

void main() {
  testWidgets('When the apps brightness is dark a dark style is used', (WidgetTester tester) async {
    StageStyleData? style;
    await tester.pumpWidgetOnStage(
      widget: TestWidget(
        didChangeDependencies: (context) {
          style = StageStyle.of(context);
        },
      ),
      brightness: Brightness.dark,
    );
    await tester.pump();
    expect(style?.brightness, Brightness.dark);
  });
  testWidgets('When the apps brightness is light a light style is used', (WidgetTester tester) async {
    StageStyleData? style;
    await tester.pumpWidgetOnStage(
      widget: TestWidget(
        didChangeDependencies: (context) {
          style = StageStyle.of(context);
        },
      ),
      brightness: Brightness.light,
    );
    await tester.pump();
    expect(style?.brightness, Brightness.light);
  });
  testWidgets('When a style is provided in the widget tree, that one is used', (WidgetTester tester) async {
    StageStyleData? style;
    await tester.pumpWidgetOnStage(
      widget: TestWidget(
        didChangeDependencies: (context) {
          style = StageStyle.of(context);
        },
      ),
      inheritedStyle: testStyle,
      brightness: Brightness.dark,
    );
    await tester.pump();
    expect(style == testStyle, true);
  });
  testWidgets('When a style is passed directly that one is used', (WidgetTester tester) async {
    StageStyleData? style;
    await tester.pumpWidgetOnStage(
      widget: TestWidget(
        didChangeDependencies: (context) {
          style = StageStyle.of(context);
        },
      ),
      parameterStyle: testStyle,
      brightness: Brightness.dark,
    );
    await tester.pump();
    expect(style == testStyle, true);
  });
}

StageStyleData testStyle = StageStyleData(
  brightness: Brightness.dark,
  canvasColor: Colors.blue,
  primaryColor: Colors.purple,
  onSurface: Colors.orange,
  borderColor: Colors.red,
  ballSize: 100,
);
