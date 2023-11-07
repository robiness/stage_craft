import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

class StringListConfiguratorStageData extends StageData {
  final value = StringListConfigurator(value: ['jo', 'jojo2', 'jojojo'], name: 'value');

  @override
  String get name => 'StringListConfigurator';

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
