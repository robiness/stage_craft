import 'package:example/widgets/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Defines everything you need to put it on the stage.
class MyWidgetStageData extends WidgetStageData {
  MyWidgetStageData()
      : _color = ColorFieldConfiguratorNullable(value: null, name: 'color'),
        _text = StringFieldConfigurator(value: "My text", name: 'text'),
        _nullableBool = BoolFieldConfiguratorNullable(value: false, name: 'nullableBool'),
        _borderRadius = DoubleFieldConfiguratorNullable(value: 4, name: 'borderRadius');

  @override
  String get name => 'MyWidget';

  @override
  Size get stageSize => const Size(200, 200);

  final ColorFieldConfiguratorNullable _color;
  final StringFieldConfigurator _text;
  final BoolFieldConfiguratorNullable _nullableBool;
  final DoubleFieldConfiguratorNullable _borderRadius;

  @override
  Widget widgetBuilder(BuildContext context) {
    return MyWidget(
      color: _color.value,
      text: _text.value,
      borderRadius: _borderRadius.value,
      isTrue: _nullableBool.value,
    );
  }

  @override
  List<FieldConfigurator> get widgetConfigurators {
    return [
      _color,
      _text,
      _borderRadius,
      _nullableBool,
    ];
  }

  @override
  List<FieldConfigurator> get stageConfigurators => [];
}
