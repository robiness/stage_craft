import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

class StringListConfiguratorStageData extends StageData {
  StringListConfiguratorStageData({
    super.initialStageSize,
  }) : super(name: 'StringListConfiguratorStageData');

  final value = StringListConfigurator(value: ['jo', 'jojo2', 'jojojo'], name: 'value');

  @override
  Size? get initialStageSize => const Size(300, 300);

  @override
  List<FieldConfigurator> get stageConfigurators => [];

  @override
  List<FieldConfigurator> get widgetConfigurators => [
        value,
      ];

  @override
  Widget widgetBuilder(BuildContext context) {
    return StringListConfiguratorWidget(configurator: value);
  }
}
