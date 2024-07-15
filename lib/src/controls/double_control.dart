import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

/// A control to modify a double parameter of the widget on stage.
class DoubleControl extends ValueControl<double> {
  /// Creates a double control.
  DoubleControl({
    required super.label,
    required super.initialValue,
  });

  /// The controller for the text field.
  late final controller = TextEditingController(text: value.toString());

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: StageCraftTextField(
        controller: controller,
        onChanged: (String value) {
          this.value = double.tryParse(value) ?? 0;
        },
      ),
    );
  }
}

/// A control to modify a nullable double parameter of the widget on stage.
class DoubleControlNullable extends ValueControl<double?> {
  /// Creates a nullable double control.
  DoubleControlNullable({
    required super.label,
    required super.initialValue,
  });

  /// The controller for the text field.
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
