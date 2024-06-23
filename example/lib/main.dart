import 'package:example/my_awesome_widget_stage.dart';
import 'package:flutter/material.dart';
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
    const MaterialApp(
      home: Scaffold(
        body: ColoredBox(
          color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(84.0),
            child: MyAwesomeWidgetStage(),
          ),
        ),
      ),
    ),
  );
}
