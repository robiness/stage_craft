import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class GenericControl<T> extends ValueControl<T> {
  GenericControl({
    required super.label,
    required super.initialValue,
    required this.values,
  });

  final List<DropdownMenuItem<T>> values;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: DropdownButton<T>(
        value: value,
        items: values,
        onChanged: (e) {
          if (e != null) {
            value = e;
          }
        },
      ),
    );
  }
}

class GenericControlNullable<T> extends ValueControl<T?> {
  GenericControlNullable({
    required super.label,
    required super.initialValue,
    required this.values,
  });

  final List<DropdownMenuItem<T>> values;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: DropdownButton<T>(
        value: value,
        items: values,
        onChanged: (e) {
          value = e;
        },
      ),
    );
  }
}
