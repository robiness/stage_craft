import 'package:flutter/material.dart';
import 'package:stage_craft/src/widgets/stage_craft_hover_control.dart';

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
    return StageCraftHoverControl(
      child: TextField(
        style: Theme.of(context).textTheme.labelLarge,
        controller: controller,
        onChanged: onChanged,
        cursorColor: Theme.of(context).colorScheme.onSurface,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(8),
          isCollapsed: true,
        ),
      ),
    );
  }
}
