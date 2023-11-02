import 'package:example/stage_data/my_widget_stage.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StageCraft Demo',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StageCraft(
          stageData: MyWidgetStageData(),
        ),
      ),
    );
  }
}
