import 'package:example/stage_data/my_other_widget_stage.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  final StageController controller = StageController();
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  const WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MaterialApp(
      home: Scaffold(
        body: StageCraft(
          stageController: controller,
        ),
      ),
    ),
  );
  controller.selectWidget(MyOtherWidgetStageData());
}
