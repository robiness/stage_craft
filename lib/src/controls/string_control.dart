import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class StringControl extends ValueControl<String> {
  StringControl({required super.initialValue, required super.label});

  late final TextEditingController _controller = TextEditingController(text: value);

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: TextField(
        controller: _controller,
        onChanged: (newString) {
          value = newString;
        },
      ),
    );
  }
}

class StringControlNullable extends ValueControl<String?> {
  StringControlNullable({required super.initialValue, required super.label});

  late final TextEditingController _controller = TextEditingController(text: value);

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: TextField(
        controller: _controller,
        onChanged: (newString) {
          value = newString;
        },
      ),
    );
  }
}
