import 'package:flutter/material.dart';
import 'package:stage_craft/src/field_configurators/field_configurator_widget.dart';
import 'package:stage_craft/src/widget_stage.dart';

/// Represents a nullable enum parameter for a widget on a [WidgetStage].
class EnumFieldConfiguratorNullable<T extends Enum> extends FieldConfigurator<T?> {
  EnumFieldConfiguratorNullable({
    required super.value,
    required super.name,
    required this.enumValues,
  });

  final List<T> enumValues;

  @override
  Widget build(BuildContext context) {
    return EnumFieldConfigurationWidget(
      enumValues: enumValues,
      value: value,
      updateValue: updateValue,
    );
  }
}

/// Represents a T parameter for a widget on a [WidgetStage].
class EnumFieldConfigurator<T extends Enum> extends FieldConfigurator<T> {
  EnumFieldConfigurator({
    required super.value,
    required super.name,
    required this.enumValues,
  });

  final List<T> enumValues;

  @override
  Widget build(BuildContext context) {
    return EnumFieldConfigurationWidget(
      enumValues: enumValues,
      value: value,
      updateValue: (value) {
        if (value != null) {
          updateValue(value);
        }
      },
    );
  }
}

class EnumFieldConfigurationWidget<T extends Enum> extends ConfigurationWidget<T?> {
  const EnumFieldConfigurationWidget({
    required super.value,
    required super.updateValue,
    required this.enumValues,
  });

  final List<T> enumValues;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DropdownButtonFormField<T>(
        value: value,
        items: enumValues
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(item.name),
              ),
            )
            .toList(),
        onChanged: updateValue,
      ),
    );
  }
}
