import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

/// A default implementation of a control bar row.
/// It displays the label, a `null` button if the value is nullable and the child widget to modify the value.
class DefaultControlBarRow extends StatelessWidget {
  /// Creates a new [DefaultControlBarRow] with the given control and child.
  const DefaultControlBarRow({
    super.key,
    required this.control,
    required this.child,
  });

  /// The control to display in the control bar.
  final ValueControl control;

  /// The widget to display in the control bar to modify the value.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: control,
      builder: (context, _) {
        if (control.isNullable) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 4),
                  if (control.minValue != null)
                    Text(
                      _minMaxLabel(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
              Row(
                children: [
                  Expanded(child: child),
                  const SizedBox(width: 4),
                  NullButton(control: control),
                ],
              ),
            ],
          );
        }
        return child;
      },
    );
  }

  String _minMaxLabel() {
    final minLabel = control.minValue != null ? 'min: ${control.minValue}' : '';
    final maxLabel = control.maxValue != null ? 'max: ${control.maxValue}' : '';
    final separator = minLabel.isNotEmpty && maxLabel.isNotEmpty ? ', ' : '';
    return '$minLabel$separator$maxLabel';
  }
}

/// A button to toggle the value between `null` and the previous value.
class NullButton extends StatelessWidget {
  /// Creates a new [NullButton] with the given control.
  const NullButton({
    super.key,
    required this.control,
  });

  /// The control to toggle the value.
  final ValueControl control;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: control.toggleNull,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: control.value == null ? Colors.orange[200] : null,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              'null',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: control.value == null ? Colors.orange : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
