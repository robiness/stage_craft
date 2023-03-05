import 'package:example/my_other_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

class MyOtherWidgetStageData implements WidgetStageData {
  MyOtherWidgetStageData({
    required String text,
  }) : _text = StringFieldConfigurator(text);

  final StringFieldConfigurator _text;

  @override
  String get name => 'MyOtherWidget';

  @override
  Widget get widget {
    return MyOtherWidget(
      text: _text.value,
    );
  }

  @override
  List<FieldConfigurator> get configurators {
    return [
      _text,
    ];
  }
}
