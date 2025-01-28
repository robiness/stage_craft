import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';

/// A control to modify a boolean parameter of the widget on stage.
class BoolControl extends ValueControl<bool> {
  /// Creates a new boolean control.
  BoolControl({
    required super.initialValue,
    required super.label,
  });

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Checkbox(
        value: value,
        onChanged: (newValue) {
          value = newValue!;
        },
      ),
    );
  }
}

/// A control to modify a nullable boolean parameter of the widget on stage.
class BoolControlNullable extends ValueControl<bool?> {
  /// Creates a new nullable boolean control.
  BoolControlNullable({
    super.initialValue,
    required super.label,
  });

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Checkbox(
        value: value ?? false,
        onChanged: (newValue) {
          value = newValue ?? false;
        },
      ),
    );
  }
}
