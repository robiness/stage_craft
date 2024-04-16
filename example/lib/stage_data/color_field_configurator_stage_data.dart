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

  final outerBoxColor = ColorFieldConfigurator(
    value: colorSamples[2].color,
    name: 'Outer Box Color',
    colorSamples: colorSamples,
  );

  final innerBoxColor = ColorFieldConfiguratorNullable(
    value: colorSamples[4].color,
    name: 'Inner Box Color',
    colorSamples: colorSamples,
  );

  @override
  List<FieldConfigurator> get stageConfigurators => [];

  @override
  List<FieldConfigurator> get widgetConfigurators => [
        outerBoxColor,
        innerBoxColor,
      ];

  @override
  Widget widgetBuilder(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: outerBoxColor.value,
        child: Center(
          child: Container(
            color: innerBoxColor.value,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
