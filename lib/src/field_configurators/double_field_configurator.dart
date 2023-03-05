import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a double parameter for a widget on a [WidgetStage].
class DoubleFieldConfigurator extends FieldConfigurator<double> {
  DoubleFieldConfigurator(double value) : super(value: value);

  @override
  Widget builder(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'text',
      ),
      controller: TextEditingController(text: value.toString()),
      onChanged: (String newValue) {
        value = double.tryParse(newValue) ?? 0;
        notifyListeners();
      },
    );
  }
}
