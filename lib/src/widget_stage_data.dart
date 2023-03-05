import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

abstract class WidgetStageData {
  String get name;

  Widget get widget;

  List<FieldConfigurator> get configurators;
}
