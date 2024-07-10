import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/stage/stage.dart';
import 'package:stage_craft/src/stage/stage_style.dart';

extension ControlsExtensions on WidgetTester {
  Future<void> pumpWidgetOnStage<T>({
    required Widget widget,
    StageStyleData? inheritedStyle,
    StageStyleData? parameterStyle,
    Brightness? brightness,
  }) async {
    if (inheritedStyle == null) {
      await pumpWidget(
        MaterialApp(
          theme: ThemeData(
            brightness: brightness,
          ),
          home: Scaffold(
            body: StageBuilder(
              style: parameterStyle,
              builder: (context) {
                return widget;
              },
            ),
          ),
        ),
      );
      return;
    }
    await pumpWidget(
      StageStyle(
        data: inheritedStyle,
        child: MaterialApp(
          theme: ThemeData(
            brightness: brightness,
          ),
          home: Scaffold(
            body: StageBuilder(
              style: parameterStyle,
              builder: (context) {
                return widget;
              },
            ),
          ),
        ),
      ),
    );
  }
}
