import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class BoolControl extends ValueControl<bool> {
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

class BoolControlNullable extends ValueControl<bool?> {
  BoolControlNullable({
    required super.initialValue,
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
