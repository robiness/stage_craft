import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

/// A custom header to be used in the control panel. Can be used to provide headers or other non control widgets.
class ControlGroup implements ValueControl {
  /// The builder for the child widget.
  ControlGroup({
    required this.controls,
    required this.label,
  });

  /// The builder for the child widget.
  final List<ValueControl> controls;

  @override
  final String label;

  @override
  Widget builder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...controls.map((control) {
              return control.builder(context);
            }),
          ],
        ),
      ),
    );
  }

  @override
  void addListener(VoidCallback listener) {
    for (final control in controls) {
      control.addListener(listener);
    }
  }

  @override
  void dispose() {
    for (final control in controls) {
      control.dispose();
    }
  }

  @override
  bool get hasListeners => false;

  @override
  bool get isNullable => false;

  @override
  void notifyListeners() {
    for (final control in controls) {
      control.notifyListeners();
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    for (final control in controls) {
      control.removeListener(listener);
    }
  }

  @override
  void toggleNull() {}

  @override
  Object? value;

  @override
  Null get maxValue => null;

  @override
  Null get minValue => null;
}
