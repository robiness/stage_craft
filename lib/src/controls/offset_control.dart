import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

class OffsetControl extends ValueControl<Offset> {
  OffsetControl({required super.initialValue, required super.label});

  late final TextEditingController _controllerX = TextEditingController();
  late final TextEditingController _controllerY = TextEditingController();

  @override
  Widget builder(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controllerX,
          onChanged: (newString) {
            value = Offset(double.parse(newString), value.dy);
          },
        ),
        TextField(
          controller: _controllerY,
          onChanged: (newString) {
            value = Offset(value.dx, double.parse(newString));
          },
        ),
      ],
    );
  }

  @override
  Listenable? get listenable => Listenable.merge([_controllerX, _controllerY]);
}
