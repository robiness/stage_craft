import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class TextEditingControl extends ValueControl<String> {
  TextEditingControl({
    required super.initialValue,
  });

  late final TextEditingController controller = TextEditingController(text: value);

  @override
  Widget builder(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (newString) {
        value = newString;
      },
    );
  }

  @override
  Listenable? get listenable => controller;
}
