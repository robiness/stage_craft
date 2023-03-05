import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a String parameter for a widget on a [WidgetStage].
class StringFieldConfigurator extends FieldConfigurator<String> {
  StringFieldConfigurator({
    required super.value,
    required super.name,
  });

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
