import 'package:example/widgets/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

/// Defines everything you need to put it on the stage.
class MyWidgetStageData extends WidgetStageData {
  MyWidgetStageData()
      : _color = ColorFieldConfiguratorNullable(value: null, name: 'color'),
        _borderColor = ColorFieldConfiguratorNullable(value: null, name: 'borderColor'),
        _text = StringFieldConfigurator(value: "My text", name: 'text'),
        _nullableBool = BoolFieldConfiguratorNullable(value: false, name: 'nullableBool'),
        _borderRadius = DoubleFieldConfiguratorNullable(value: 4, name: 'borderRadius'),
        _padding = PaddingFieldConfigurator(value: const EdgeInsets.all(8), name: 'padding');

  @override
  String get name => 'MyWidget';

  @override
  Size get stageSize => const Size(400, 200);

  final ColorFieldConfiguratorNullable _color;
  final ColorFieldConfiguratorNullable _borderColor;
  final StringFieldConfigurator _text;
  final BoolFieldConfiguratorNullable _nullableBool;
  final DoubleFieldConfiguratorNullable _borderRadius;
  final PaddingFieldConfigurator _padding;

  @override
  Widget widgetBuilder(BuildContext context) {
    return MyWidget(
      color: _color.value,
      borderColor: _borderColor.value,
      text: _text.value,
      borderRadius: _borderRadius.value,
      isTrue: _nullableBool.value,
      padding: _padding.value,
    );
  }

  @override
  List<FieldConfigurator> get widgetConfigurators {
    return [
      _color,
      _borderColor,
      _text,
      _borderRadius,
      _nullableBool,
      _padding,
    ];
  }

  @override
  List<FieldConfigurator> get stageConfigurators => [];
}
