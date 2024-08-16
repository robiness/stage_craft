import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

/// A control to modify a int parameter of the widget on stage.
class IntControl extends ValueControl<int> {
  /// Creates a new int control.
  IntControl({
    required super.label,
    required super.initialValue,
    super.max,
    super.min,
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
          this.value = int.tryParse(value) ?? 0;
        },
      ),
    );
  }
}

/// A control to modify a nullable int parameter of the widget on stage.
class IntControlNullable extends ValueControl<int?> {
  /// Creates a new nullable int control.
  IntControlNullable({
    required super.label,
    required super.initialValue,
    super.max,
    super.min,
  });

  /// The controller for the text field.
  late final controller = TextEditingController(text: value?.toString() ?? '');

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: StageCraftTextField(
        controller: controller,
        onChanged: (String value) {
          this.value = int.tryParse(value);
        },
      ),
    );
  }
}
