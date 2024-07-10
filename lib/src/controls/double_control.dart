import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class DoubleControl extends ValueControl<double> {
  DoubleControl({
    required super.label,
    required super.initialValue,
  });

  late final controller = TextEditingController(text: value.toString());

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: TextField(
        controller: controller,
        onChanged: (String value) {
          this.value = double.tryParse(value) ?? 0;
        },
      ),
    );
  }
}

class DoubleControlNullable extends ValueControl<double?> {
  DoubleControlNullable({
    required super.label,
    required super.initialValue,
  });

  late final controller = TextEditingController(text: value?.toString() ?? '');

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: TextField(
        controller: controller,
        onChanged: (String value) {
          this.value = double.tryParse(value);
        },
      ),
    );
  }
}
