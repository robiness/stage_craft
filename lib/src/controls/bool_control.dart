import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class BoolControl extends ValueControl<bool> {
  BoolControl({required super.initialValue});

  @override
  Widget builder(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (newValue) {
        value = newValue!;
      },
    );
  }
}
