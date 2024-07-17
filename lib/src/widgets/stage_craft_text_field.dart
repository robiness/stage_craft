import 'package:flutter/material.dart';

/// A text field that is styled for StageCraft.
class StageCraftTextField extends StatelessWidget {
  /// Creates a StageCraft text field.
  const StageCraftTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  /// The controller for the text field.
  final TextEditingController controller;

  /// The callback that is called when the text field's value changes.
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
      child: TextField(
        style: Theme.of(context).textTheme.labelLarge,
        controller: controller,
        onChanged: onChanged,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(4),
          isCollapsed: true,
        ),
      ),
    );
  }
}
