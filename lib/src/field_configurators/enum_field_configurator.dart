import 'package:flutter/material.dart';
import 'package:widget_stage/src/widget_stage.dart';

class EnumFieldConfigurator<T extends Enum> extends FieldConfigurator<T> {
  EnumFieldConfigurator({
    required super.value,
    required super.name,
    required this.enumValues,
  });

  final List<T> enumValues;

  @override
  Widget builder(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: enumValues
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(e.toString()),
            ),
          )
          .toList(),
      onChanged: (newValue) {
        if (newValue == null) return;
        value = newValue;
        notifyListeners();
      },
    );
  }
}
