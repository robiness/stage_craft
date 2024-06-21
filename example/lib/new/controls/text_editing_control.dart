import 'package:example/new/controls/control.dart';
import 'package:flutter/material.dart';

class TextEditingControllerControl extends ValueControl<String> {
  TextEditingControllerControl({
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
