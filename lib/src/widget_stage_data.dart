import 'package:flutter/material.dart';

abstract class WidgetStageData implements ChangeNotifier {
  String get name;

  Widget get widget;

  List<Widget> get configurationFields;
}
