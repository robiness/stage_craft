import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class IntControl extends ValueControl<int> {
  IntControl({
    required super.label,
    required super.initialValue,
  });

  final controller = TextEditingController();

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: TextField(
        controller: controller,
        onChanged: (String value) {
          this.value = int.tryParse(value) ?? 0;
        },
      ),
    );
  }
}

class IntControlNullable extends ValueControl<int?> {
  IntControlNullable({
    required super.label,
    required super.initialValue,
  });

  final controller = TextEditingController();

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: TextField(
        controller: controller,
        onChanged: (String value) {
          this.value = int.tryParse(value);
        },
      ),
    );
  }
}
