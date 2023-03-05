import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

class StringFieldConfigurator extends FieldConfigurator<String> {
  StringFieldConfigurator(String value) : super(value: value);

  @override
  Widget builder(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'text',
      ),
      controller: TextEditingController(text: value),
      onChanged: (String newValue) {
        value = newValue;
        notifyListeners();
      },
    );
  }
}
