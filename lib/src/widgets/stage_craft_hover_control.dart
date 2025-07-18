import 'package:flutter/material.dart';

/// The border and background of a input for example a textfield or dropdown button.
class StageCraftHoverControl extends StatefulWidget {
  /// Constructs a StageCraftHoverControl that wraps a child widget with a hover effect.
  const StageCraftHoverControl({
    super.key,
    required this.child,
  });

  /// The child widget to be wrapped in the hover control.
  final Widget child;

  @override
  State<StageCraftHoverControl> createState() => _StageCraftHoverControlState();
}

class _StageCraftHoverControlState extends State<StageCraftHoverControl> with TickerProviderStateMixin {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: _hovered ? 0.05 : 0),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: _hovered ? 0.1 : 0),
          ),
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}
