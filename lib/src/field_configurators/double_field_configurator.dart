import 'package:flutter/material.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/widget_stage.dart';

class DoubleFieldConfiguratorNullable extends FieldConfigurator<double?> {
  DoubleFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  late final _textEditingController = TextEditingController(text: value.toString());

  @override
  Widget builder(BuildContext context) {
    return FieldConfiguratorWidget(
      onNullTapped: () => updateValue(null),
      name: name,
      isNullable: true,
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        controller: _textEditingController,
        onChanged: (String newValue) {
          value = double.tryParse(newValue) ?? 0;
          notifyListeners();
        },
      ),
    );
  }
}

/// Represents a double parameter for a widget on a [WidgetStage].
class DoubleFieldConfigurator extends FieldConfigurator<double> {
  DoubleFieldConfigurator._({
    required super.value,
    required super.name,
  });

  late final _textEditingController = TextEditingController(text: value.toString());

  @override
  Widget builder(BuildContext context) {
    return FieldConfiguratorWidget(
      name: name,
      isNullable: false,
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        controller: _textEditingController,
        onChanged: (String newValue) {
          value = double.tryParse(newValue) ?? 0;
          notifyListeners();
        },
      ),
    );
  }
}
