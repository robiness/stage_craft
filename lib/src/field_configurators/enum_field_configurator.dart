import 'package:flutter/material.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/src/widget_stage.dart';

class EnumFieldConfiguratorNullable<T extends Enum> extends FieldConfigurator<T?> {
  EnumFieldConfiguratorNullable({
    required super.value,
    required super.name,
    required this.enumValues,
  });

  final List<T> enumValues;

  @override
  Widget builder(BuildContext context) {
    return FieldConfiguratorWidget(
      onNullTapped: () => updateValue(null),
      name: name,
      isNullable: true,
      child: Material(
        child: DropdownButtonFormField<T>(
          value: value,
          items: enumValues
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onChanged: (newValue) {
            if (newValue == null) return;
            value = newValue;
            notifyListeners();
          },
        ),
      ),
    );
  }
}

class EnumFieldConfigurator<T extends Enum> extends FieldConfigurator<T> {
  EnumFieldConfigurator({
    required super.value,
    required super.name,
    required this.enumValues,
  });

  final List<T> enumValues;

  @override
  Widget builder(BuildContext context) {
    return FieldConfiguratorWidget(
      name: name,
      isNullable: false,
      child: Material(
        child: DropdownButtonFormField<T>(
          value: value,
          items: enumValues
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onChanged: (newValue) {
            if (newValue == null) return;
            value = newValue;
            notifyListeners();
          },
        ),
      ),
    );
  }
}
