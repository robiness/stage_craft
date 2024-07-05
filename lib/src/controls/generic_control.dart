import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class GenericControl<T> extends ValueControl<T?> {
  GenericControl({
    required super.label,
    required super.initialValue,
    required this.values,
  });

  final List<DropdownMenuItem<T>> values;

  @override
  Widget builder(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButton<T>(
        value: value,
        items: values,
        onChanged: (e) {
          value = e;
        },
      ),
    );
  }
}
