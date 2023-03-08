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
  final StageController _stageController = StageController();

  final widgetsOnStage = [
    MyWidgetStageData(),
    MyOtherWidgetStageData(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
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
              child: WidgetStage(
                controller: _stageController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
