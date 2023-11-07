import 'package:example/stage_data/bool_field_configurator_stage_data.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
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
          stageData: BoolFieldConfiguratorStageData(),
        ),
      ),
    ),
  );
}
