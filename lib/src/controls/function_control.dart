import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/controls.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';

/// A control that holds a function that returns void.
class VoidFunctionControl extends ValueControl<VoidCallback> {
  /// Creates a [VoidFunctionControl] with the given [label].
  VoidFunctionControl({required super.label})
      : super(
          initialValue: () {},
        );

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Row(
        children: [
          const SizedBox(width: 4),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                value();
                debugPrint('Function $label got called.');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Function $label got called.'),
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text('trigger()'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A control that holds a function that returns void.
class VoidFunctionControlNullable extends ValueControl<VoidCallback?> {
  /// Creates a [VoidFunctionControl] with the given [label].
  VoidFunctionControlNullable({required super.label})
      : super(
          initialValue: () {},
        );

  late final VoidCallback _initialValue;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Row(
        children: [
          const SizedBox(width: 4),
          MouseRegion(
            cursor: value == null ? MouseCursor.defer : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                if (value == null) return;
                value?.call();
                debugPrint('Function $label got called.');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Function $label got called.'),
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: value == null ? Colors.grey : Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text('trigger()'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
