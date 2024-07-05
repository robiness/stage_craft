import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/controls.dart';

class EnumControl<T extends Enum> extends ValueControl<T> {
  EnumControl({
    required super.label,
    required super.initialValue,
    required this.values,
  });

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

class EnumControlNullable<T extends Enum> extends ValueControl<T?> {
  EnumControlNullable({
    required super.label,
    required super.initialValue,
    required this.values,
  });

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
