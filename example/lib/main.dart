import 'package:example/stage_data/my_other_widget_stage.dart';
import 'package:example/stage_data/my_widget_stage.dart';
import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
      ),
    );
  }
}
