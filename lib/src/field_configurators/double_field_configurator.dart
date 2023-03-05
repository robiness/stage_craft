import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a double parameter for a widget on a [WidgetStage].
class DoubleFieldConfigurator extends FieldConfigurator<double> {
  DoubleFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget builder(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'double',
      ),
      controller: TextEditingController(text: value.toString()),
      onChanged: (String newValue) {
        value = double.tryParse(newValue) ?? 0;
        notifyListeners();
      },
    );
  }
}
