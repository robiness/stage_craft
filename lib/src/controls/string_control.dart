import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

/// A control to modify a string parameter of the widget on stage.
class StringControl extends ValueControl<String> {
  /// Creates a new string control.
  StringControl({
    required super.initialValue,
    required super.label,
  });

  late final TextEditingController _controller = TextEditingController(text: value);

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: StageCraftTextField(
        controller: _controller,
        onChanged: (newString) {
          value = newString;
        },
      ),
    );
  }
}

/// A control to modify a nullable string parameter of the widget on stage.
class StringControlNullable extends ValueControl<String?> {
  /// Creates a new nullable string control.
  StringControlNullable({required super.initialValue, required super.label});

  late final TextEditingController _controller = TextEditingController(text: value);

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: StageCraftTextField(
        controller: _controller,
        onChanged: (newString) {
          value = newString;
        },
      ),
    );
  }
}
