import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

/// Value preview widget for controls.
class ControlValuePreview extends StatelessWidget {
  const ControlValuePreview({
    super.key,
    required this.control,
  });

  final ValueControl control;

  @override
  Widget build(BuildContext context) {
    final value = control.value;

    if (value == null) {
      return Text(
        'null',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
      );
    }

    // Simple fallback: just show the value as string
    return Text(
      value.toString(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
