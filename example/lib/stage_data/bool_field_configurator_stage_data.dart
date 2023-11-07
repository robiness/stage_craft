import 'package:flutter/widgets.dart';
import 'package:stage_craft/stage_craft.dart';

class BoolFieldConfiguratorStageData extends StageData {
  @override
  String get name => 'BoolFieldConfiguration';

  final value = BoolFieldConfigurator(value: true, name: 'value');

  @override
  List<FieldConfigurator> get stageConfigurators => [];

  @override
  List<FieldConfigurator> get widgetConfigurators => [value];

  @override
  Widget widgetBuilder(BuildContext context) {
    return BoolConfigurationWidget(
      value: value.value,
      updateValue: (value) {
        this.value.value = value!;
      },
    );
  }
}
