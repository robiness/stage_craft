import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stage_craft/stage_craft.dart';

class ColorFieldConfiguratorStageData extends StageData {
  @override
  String get name => 'ColorFieldConfiguration';

  static const colorSamples = [
    ColorSample(color: Color(0xFF000000), name: 'Black'),
    ColorSample(color: Color(0xFFFFFFFF), name: 'White'),
    ColorSample(color: Color(0xFFE63946), name: 'Sunset Red'),
    ColorSample(color: Color(0xFFF4A261), name: 'Sandy Brown'),
    ColorSample(color: Color(0xFF2A9D8F), name: 'Teal Blue'),
    ColorSample(color: Color(0xFF264653), name: 'Gunmetal Blue'),
    ColorSample(color: Color(0xFFE9C46A), name: 'Saffron Yellow')
  ];

  final backgroundColor = ColorFieldConfigurator(
    value: Colors.red,
    name: 'Background Color',
    colorSamples: colorSamples,
  );

  final iconColor = ColorFieldConfigurator(
    value: Colors.blue,
    name: 'Icon color',
    colorSamples: colorSamples,
  );

  @override
  List<FieldConfigurator> get stageConfigurators => [];

  @override
  List<FieldConfigurator> get widgetConfigurators => [
        backgroundColor,
        iconColor,
      ];

  @override
  Widget widgetBuilder(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: backgroundColor.value,
        child: Icon(
          Icons.add,
          color: iconColor.value,
        ),
      ),
    );
  }
}
