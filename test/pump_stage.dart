import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';

import 'test_stage_data.dart';

extension PumpStageExtension on WidgetTester {
  Future<void> pumpStage({StageData? stageData}) async {
    await pumpWidget(
      MaterialApp(
        home: StageCraft(
          stageData: stageData ?? TestStageData(),
        ),
      ),
    );
    await pumpAndSettle();
  }

  Size get testStageSize => getSize(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageTopLeft => getTopLeft(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageCenter => getCenter(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageBottomRight => getBottomRight(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageBottomLeft => getBottomLeft(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageTopRight => getTopRight(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );
}
