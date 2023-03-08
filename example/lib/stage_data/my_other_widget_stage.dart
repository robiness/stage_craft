import 'package:example/widgets/my_other_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

class MyOtherWidgetStageData implements WidgetStageData {
  MyOtherWidgetStageData() : _text = StringFieldConfigurator(value: 'MyOtherWidget', name: 'text');

  final StringFieldConfigurator _text;

  @override
  String get name => 'MyOtherWidget';

  @override
  Widget widgetBuilder(BuildContext context) {
    return MyOtherWidget(
      text: _text.value,
    );
  }

  @override
  List<FieldConfigurator> get fieldConfigurators {
    return [
      _text,
    ];
  }
}
