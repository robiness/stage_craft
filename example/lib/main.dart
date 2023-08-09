import 'package:example/stage_data/my_app_stage_data.dart';
import 'package:example/stage_data/my_list_tile_widget_stage.dart';
import 'package:example/stage_data/my_other_widget_stage.dart';
import 'package:example/stage_data/my_widget_stage.dart';
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
  final ThemeData theme = ThemeData.light();

  late final StageController _stageController = StageController(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  );

  final widgetsOnStage = [
    MyWidgetStageData(),
    MyOtherWidgetStageData(),
    MyListTileWidgetStage(),
    MyAppStageData(),
  ];

  @override
  void initState() {
    super.initState();
    _stageController.selectWidget(widgetsOnStage.first);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            SizedBox(
              width: 200,
              child: ListView(
                children: widgetsOnStage.map(
                  (e) {
                    return ListTile(
                      onTap: () => _stageController.selectWidget(e),
                      title: Text(e.name),
                    );
                  },
                ).toList(),
              ),
            ),
            Expanded(
              child: StageCraft(
                stageController: _stageController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
