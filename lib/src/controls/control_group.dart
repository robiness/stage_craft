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
  Widget? get iconWidget => const Icon(Icons.folder, size: 16, color: Colors.brown);

  @override
  Widget? get valuePreviewWidget => Text(
    '${controls.length} controls',
    style: const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    ),
  );

  @override
  Widget builder(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: controls.map((control) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Control label
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  control.label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Control widget
              control.builder(context),
            ],
          ),
        );
      }).toList(),
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
