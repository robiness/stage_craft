import 'package:example/widgets/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

class MyWidgetStageData implements WidgetStageData {
  MyWidgetStageData({
    required Color color,
    required String text,
    required double borderRadius,
  })  : _color = ColorFieldConfigurator(color),
        _text = StringFieldConfigurator(text),
        _borderRadius = DoubleFieldConfigurator(borderRadius);

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
