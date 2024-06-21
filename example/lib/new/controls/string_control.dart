import 'package:example/new/controls/control.dart';
import 'package:flutter/material.dart';

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
