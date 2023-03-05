import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a int parameter for a widget on a [WidgetStage].
class IntFieldConfigurator extends FieldConfigurator<int> {
  IntFieldConfigurator(int value) : super(value: value);

  @override
  Widget builder(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'text',
      ),
      controller: TextEditingController(text: value.toString()),
      onChanged: (String newValue) {
        value = int.tryParse(newValue) ?? 0;
        notifyListeners();
      },
    );
  }
}
