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
      padding: const EdgeInsets.only(top: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section - consistent with collapsible sections
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.folder,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
            // Content with hierarchy styling
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controls.map((control) {
                  return control.builder(context);
                }).toList(),
              ),
            ),
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

  @override
  get initialValue => null;
}
