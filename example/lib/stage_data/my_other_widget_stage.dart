import 'package:example/widgets/my_other_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

class MyOtherWidgetStageData extends WidgetStageData {
  MyOtherWidgetStageData()
      : _text = StringFieldConfigurator(value: 'MyOtherWidget', name: 'text'),
        _padding = PaddingFieldConfiguratorNullable(value: null, name: 'padding');

  final StringFieldConfigurator _text;
  final PaddingFieldConfiguratorNullable _padding;

  @override
  String get name => 'MyOtherWidget';

  @override
  Widget widgetBuilder(BuildContext context) {
    return MyOtherWidget(
      text: _text.value,
      padding: _padding.value,
    );
  }

  @override
  List<FieldConfigurator> get widgetConfigurators {
    return [
      _text,
      _padding,
    ];
  }

  @override
  List<FieldConfigurator> get stageConfigurators => [];
}
