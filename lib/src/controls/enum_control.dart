import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/controls.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_hover_control.dart';

/// A control to modify a enum parameter of the widget on stage.
class EnumControl<T extends Enum> extends ValueControl<T> {
  /// Creates a control to modify a enum parameter of the widget on stage.
  EnumControl({
    required super.label,
    required super.initialValue,
    required this.values,
  });

  /// The values of the enum.
  final List<T> values;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: StageCraftHoverControl(
        child: DropdownButton<T>(
          style: Theme.of(context).textTheme.labelLarge,
          borderRadius: BorderRadius.circular(4),
          value: value,
          onChanged: (T? newValue) {
            if (newValue != null) {
              value = newValue;
            }
          },
          isDense: true,
          itemHeight: null,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          underline: const SizedBox(),
          isExpanded: true,
          items: values.map((value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// A control to modify a nullable enum parameter of the widget on stage.
class EnumControlNullable<T extends Enum> extends ValueControl<T?> {
  /// Creates a control to modify a nullable enum parameter of the widget on stage.
  EnumControlNullable({
    super.initialValue,
    required super.label,
    required this.values,
  });

  /// The values of the enum.
  final List<T> values;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: StageCraftHoverControl(
        child: DropdownButton<T>(
          style: Theme.of(context).textTheme.labelLarge,
          borderRadius: BorderRadius.circular(4),
          value: value,
          onChanged: (T? newValue) {
            value = newValue;
          },
          isDense: true,
          itemHeight: null,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          underline: const SizedBox(),
          isExpanded: true,
          items: values.map((value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}
