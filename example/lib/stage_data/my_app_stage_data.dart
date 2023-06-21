import 'package:example/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

class MyAppStageData extends WidgetStageData {
  @override
  String get name => 'My App';

  @override
  List<FieldConfigurator> get stageConfigurators => [];

  @override
  List<FieldConfigurator> get widgetConfigurators => [];

  @override
  Widget widgetBuilder(BuildContext context) {
    return const MyApp(
      maxContentWidth: 1440,
    );
  }
}
