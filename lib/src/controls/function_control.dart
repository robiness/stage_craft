import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/controls.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';

/// A control that holds a function that returns void.
class VoidFunctionControl extends ValueControl<VoidCallback> {
  /// Creates a [VoidFunctionControl] with the given [label].
  VoidFunctionControl({required super.label})
      : super(
          initialValue: () {
            debugPrint('$label got pressed');
          },
        );

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange.withAlpha(100),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('PrintCallBack'),
      ),
    );
  }
}

/// A control that holds a function that returns void.
class VoidFunctionControlNullable extends ValueControl<VoidCallback?> {
  /// Creates a [VoidFunctionControl] with the given [label].
  VoidFunctionControlNullable({required super.label})
      : super(
          initialValue: () {
            debugPrint('$label got pressed');
          },
        ) {
    _initialValue = () {
      debugPrint('$label got pressed');
    };
  }

  late final VoidCallback _initialValue;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: GestureDetector(
        onTap: () {
          if (value == null) {
            value = _initialValue;
          } else {
            value = null;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange.withAlpha(100),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('PrintCallBack'),
        ),
      ),
    );
  }
}
