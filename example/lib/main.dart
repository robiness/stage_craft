import 'package:example/stage_data/color_field_configurator_stage_data.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StageCraft Demo',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StageCraft(
          stageData: ColorFieldConfiguratorStageData(),
        ),
      ),
    );
  }
}
