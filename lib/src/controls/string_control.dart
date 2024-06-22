import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class StringControl extends ValueControl<String> {
  StringControl({required super.initialValue});

  late final TextEditingController _controller = TextEditingController(text: value);

  @override
  Widget builder(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (newString) {
        value = newString;
      },
    );
  }
}