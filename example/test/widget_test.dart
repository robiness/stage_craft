// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example/stage_data/my_other_widget_stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidgetData(MyOtherWidgetStageData());
    expect(find.text('MyOtherWidget'), findsNWidgets(2));
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetData(
    WidgetStageData stageData,
  ) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StageCraft(
            stageData: stageData,
          ),
        ),
      ),
    );
    await pumpAndSettle();
  }
}
