import 'package:flutter/widgets.dart';
import 'package:stage_craft/stage_craft.dart';

class ColorFieldConfiguratorStageData extends StageData {
  @override
  String get name => 'ColorFieldConfiguration';

  final value = ColorFieldConfigurator(value: const Color(0xFF000000), name: 'value');

  @override
  List<FieldConfigurator> get stageConfigurators => [];

  @override
  List<FieldConfigurator> get widgetConfigurators => [value];

  @override
  Widget widgetBuilder(BuildContext context) {
    return ColorConfigurationWidget(
      value: value.value,
      updateValue: (value) {
        this.value.value = value!;
      },
    );
  }
}
