import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

/// A control to modify an offset parameter of the widget on stage.
class OffsetControl extends ValueControl<Offset> {
  /// Creates an offset control.
  OffsetControl({
    required super.initialValue,
    required super.label,
  });

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
}

/// A control to modify a nullable offset parameter of the widget on stage.
class OffsetControlNullable extends ValueControl<Offset?> {
  /// Creates an offset control.
  OffsetControlNullable({
    required super.initialValue,
    required super.label,
  });

  late final TextEditingController _controllerX = TextEditingController(text: value?.dx.toString() ?? '');
  late final TextEditingController _controllerY = TextEditingController(text: value?.dy.toString() ?? '');

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Column(
        children: [
          StageCraftTextField(
            controller: _controllerX,
            onChanged: (newString) {
              final double? dx = double.tryParse(newString);
              if (dx == null) {
                value = null;
              }
              value = Offset(dx!, value!.dy);
            },
          ),
          StageCraftTextField(
            controller: _controllerY,
            onChanged: (newString) {
              value = Offset(value!.dx, double.parse(newString));
            },
          ),
        ],
      ),
    );
  }
}
