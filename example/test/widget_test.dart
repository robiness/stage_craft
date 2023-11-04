// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example/stage_data/bool_field_configurator_stage_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidgetData(BoolFieldConfiguratorStageData());
    expect(find.text('MyOtherWidget'), findsOneWidget);
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetData(
    StageData stageData,
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
