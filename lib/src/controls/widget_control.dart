import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';

/// A control to modify a widget parameter of the widget on stage.
class WidgetControl extends ValueControl<Widget> {
  /// Creates a widget control.
  WidgetControl({
    required super.initialValue,
    required super.label,
  });

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: value,
    );
  }
}

/// A control to modify a nullable widget parameter of the widget on stage.
class WidgetControlNullable extends ValueControl<Widget?> {
  /// Creates a widget control.
  WidgetControlNullable({
    required super.initialValue,
    required super.label,
  });

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: value ?? const SizedBox.shrink(),
    );
  }
}
