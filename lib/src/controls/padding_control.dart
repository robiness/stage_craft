import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/edge_insets_control.dart';

/// A control specifically for padding values, using EdgeInsets internally.
/// This provides better discoverability for developers looking for padding controls.
class PaddingControl extends EdgeInsetsControl {
  /// Creates a padding control.
  PaddingControl({
    required super.initialValue,
    String? label,
  }) : super(label: label ?? 'padding');

  /// Creates a padding control with common default values.
  PaddingControl.all(double value, {String? label})
      : super(
          initialValue: EdgeInsets.all(value),
          label: label ?? 'padding',
        );

  /// Creates a padding control with symmetric values.
  PaddingControl.symmetric({
    double horizontal = 0,
    double vertical = 0,
    String? label,
  }) : super(
          initialValue: EdgeInsets.symmetric(
            horizontal: horizontal,
            vertical: vertical,
          ),
          label: label ?? 'padding',
        );

  /// Creates a padding control with custom values for each side.
  PaddingControl.only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
    String? label,
  }) : super(
          initialValue: EdgeInsets.only(
            left: left,
            top: top,
            right: right,
            bottom: bottom,
          ),
          label: label ?? 'padding',
        );
}

/// A control specifically for nullable padding values, using EdgeInsets internally.
/// This provides better discoverability for developers looking for padding controls.
class PaddingControlNullable extends EdgeInsetsControlNullable {
  /// Creates a nullable padding control.
  PaddingControlNullable({
    super.initialValue,
    String? label,
  }) : super(label: label ?? 'padding');

  /// Creates a nullable padding control with common default values.
  PaddingControlNullable.all(double value, {String? label})
      : super(
          initialValue: EdgeInsets.all(value),
          label: label ?? 'padding',
        );

  /// Creates a nullable padding control with symmetric values.
  PaddingControlNullable.symmetric({
    double horizontal = 0,
    double vertical = 0,
    String? label,
  }) : super(
          initialValue: EdgeInsets.symmetric(
            horizontal: horizontal,
            vertical: vertical,
          ),
          label: label ?? 'padding',
        );

  /// Creates a nullable padding control with custom values for each side.
  PaddingControlNullable.only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
    String? label,
  }) : super(
          initialValue: EdgeInsets.only(
            left: left,
            top: top,
            right: right,
            bottom: bottom,
          ),
          label: label ?? 'padding',
        );
}
