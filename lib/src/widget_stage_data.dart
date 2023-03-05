import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

abstract class WidgetStageData {
  const WidgetStageData();

  String get name;

  Widget widgetBuilder(BuildContext context);

  List<FieldConfigurator> get fieldConfigurators;
}
