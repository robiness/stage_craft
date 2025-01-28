import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';

/// A generic control that can be used to select a specified value from a list of values.
class GenericControl<T> extends ValueControl<T> {
  /// Creates a new generic control.
  GenericControl({
    required super.label,
    required super.initialValue,
    required this.options,
  });

  /// The values that can be selected.
  final List<DropdownMenuItem<T>> options;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: DropdownButton<T>(
        value: value,
        items: options,
        onChanged: (e) {
          if (e != null) {
            value = e;
          }
        },
      ),
    );
  }
}

/// A generic control that can be used to select a specified value from a list of values.
class GenericControlNullable<T> extends ValueControl<T?> {
  /// Creates a new generic control.
  GenericControlNullable({
    required super.label,
    required super.initialValue,
    required this.options,
  });

  /// The options that can be selected.
  final List<DropdownMenuItem<T>> options;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: DropdownButton<T>(
        value: value,
        items: options,
        onChanged: (e) {
          value = e;
        },
      ),
    );
  }
}
