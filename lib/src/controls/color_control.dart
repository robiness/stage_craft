import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class ColorControl extends ValueControl<Color> {
  ColorControl({
    required super.label,
    required super.initialValue,
  });

  @override
  Widget builder(BuildContext context) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        Expanded(
          child: Container(
            height: 40,
            color: value,
          ),
        ),
      ],
    );
  }
}
