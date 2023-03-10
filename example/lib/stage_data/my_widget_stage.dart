import 'package:example/widgets/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Defines everything you need to put it on the stage.
class MyWidgetStageData implements WidgetStageData {
  MyWidgetStageData()
      : _color = ColorFieldConfigurator(value: Colors.yellow, name: 'color'),
        _text = StringFieldConfigurator(value: 'MyWidget', name: 'text'),
        _borderRadius = DoubleFieldConfigurator(value: 4, name: 'borderRadius');

  @override
  String get name => 'MyWidget';

  final ColorFieldConfigurator _color;
  final StringFieldConfigurator _text;
  final DoubleFieldConfigurator _borderRadius;

  @override
  Widget widgetBuilder(BuildContext context) {
    return MyWidget(
      color: _color.value,
      text: _text.value,
      borderRadius: _borderRadius.value,
    );
  }

  @override
  List<FieldConfigurator> get fieldConfigurators {
    return [
      _color,
      _text,
      _borderRadius,
    ];
  }
}
