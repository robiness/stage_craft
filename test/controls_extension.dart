//
// 1. A control gets created and the a control widget does get created with the correct value
// The test widget takes in a control.value of that type and gets the set value

// 2. The control does get changed per user interaction and the test widget does get rebuild with the new value.
// Also the control widget does reflect the new state.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';

extension ControlsExtensions on WidgetTester {
  Future<void> pumpControl<T>(ValueControl<T> control) async {
    await pumpWidget(
      StageStyle(
        data: StageStyleData(
          brightness: Brightness.light,
          canvasColor: Colors.orange,
          rulerColor: Colors.green,
          onSurface: Colors.green,
          primaryColor: Colors.pink,
        ),
        child: MaterialApp(
          home: Scaffold(
            body: StageBuilder(
              controls: [control],
              builder: (context) {
                return control.builder(context);
              },
            ),
          ),
        ),
      ),
    );
    await pump();
  }
}
