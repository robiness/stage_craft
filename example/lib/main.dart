import 'package:example/stage_data/my_other_widget_stage.dart';
import 'package:example/stage_data/my_widget_stage.dart';
import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: _themeMode,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: WidgetStage(
        widgets: [
          MyWidgetStageData(
            color: Colors.yellow,
            text: 'MyWidget',
            borderRadius: 4,
          ),
          MyOtherWidgetStageData(
            text: 'MyOtherWidget',
          ),
        ],
        onThemeSwitchChanged: (ThemeMode themeMode) {
          setState(() {
            _themeMode = themeMode;
          });
        },
      ),
    );
  }
}
