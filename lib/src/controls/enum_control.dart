import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/controls.dart';

/// A control to modify a enum parameter of the widget on stage.
class EnumControl<T extends Enum> extends ValueControl<T> {
  /// Creates a control to modify a enum parameter of the widget on stage.
  EnumControl({
    required super.label,
    required super.initialValue,
    required this.values,
  });

  /// The values of the enum.
  final List<T> values;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: DropdownButton<T>(
        value: value,
        onChanged: (T? newValue) {
          if (newValue != null) {
            value = newValue;
          }
        },
        items: values.map((value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
      ),
    );
  }
}

/// A control to modify a nullable enum parameter of the widget on stage.
class EnumControlNullable<T extends Enum> extends ValueControl<T?> {
  /// Creates a control to modify a nullable enum parameter of the widget on stage.
  EnumControlNullable({
    required super.label,
    required super.initialValue,
    required this.values,
  });

  /// The values of the enum.
  final List<T> values;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: DropdownButton<T>(
        value: value,
        onChanged: (T? newValue) {
          value = newValue;
        },
        items: values.map((value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
      ),
    );
  }
}
