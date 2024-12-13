import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

/// A control to modify an offset parameter of the widget on stage.
class OffsetControl extends ValueControl<Offset> {
  /// Creates an offset control.
  OffsetControl({
    required super.initialValue,
    required super.label,
  });

  late final TextEditingController _controllerX = TextEditingController(text: value.dx.toString());
  late final TextEditingController _controllerY = TextEditingController(text: value.dy.toString());

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StageCraftTextField(
            controller: _controllerX,
            onChanged: (newString) {
              final double? dx = double.tryParse(newString);
              if (dx == null) {
                value = Offset(0, value.dy);
                return;
              }
              value = Offset(dx, value.dy);
            },
          ),
          StageCraftTextField(
            controller: _controllerY,
            onChanged: (newString) {
              final double? dy = double.tryParse(newString);
              if (dy == null) {
                value = Offset(value.dx, 0);
                return;
              }
              value = Offset(value.dx, dy);
            },
          ),
        ],
      ),
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

  void _onChanged() {
    final double? dx = double.tryParse(_controllerX.text);
    final double? dy = double.tryParse(_controllerY.text);
    if (dx == null && dy == null) {
      value = null;
      return;
    }

    value = Offset(dx ?? 0, dy ?? 0);
  }

  late final TextEditingController _controllerX = TextEditingController(text: value?.dx.toString() ?? '');
  late final TextEditingController _controllerY = TextEditingController(text: value?.dy.toString() ?? '');

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: StageCraftTextField(
              controller: _controllerX,
              onChanged: (_) {
                _onChanged();
              },
            ),
          ),
          Flexible(
            child: StageCraftTextField(
              controller: _controllerY,
              onChanged: (_) {
                _onChanged();
              },
            ),
          ),
        ],
      ),
    );
  }
}
