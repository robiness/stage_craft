import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/control_value_preview.dart';
import 'package:stage_craft/src/widgets/expandable_controls_toolbar.dart';

/// A compact control tile that shows a one-liner summary with click-to-expand functionality.
/// Displays control icon, label, and value preview in compact form, expanding to show full control on tap.
class ControlTile extends StatefulWidget {
  const ControlTile({
    super.key,
    required this.control,
    this.isExpandedByDefault = false,
    this.controller,
  });

  final ValueControl control;
  final bool isExpandedByDefault;
  final ExpandableControlsController? controller;

  @override
  State<ControlTile> createState() => _ControlTileState();
}

class _ControlTileState extends State<ControlTile> with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  StreamSubscription<ExpandCommand>? _commandSubscription;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpandedByDefault;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (_isExpanded) {
      _animationController.value = 1.0;
    }

    // Listen to expansion commands from controller
    _commandSubscription = widget.controller?.commandStream.listen(_onCommand);
  }

  @override
  void dispose() {
    _commandSubscription?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _onCommand(ExpandCommand command) {
    switch (command) {
      case ExpandCommand.expandAll:
        if (!_isExpanded) {
          _expand();
        }
        break;
      case ExpandCommand.collapseAll:
        if (_isExpanded) {
          _collapse();
        }
        break;
    }
  }

  void _expand() {
    setState(() {
      _isExpanded = true;
      _animationController.forward();
    });
  }

  void _collapse() {
    setState(() {
      _isExpanded = false;
      _animationController.reverse();
    });
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isExpanded
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.08)
            : Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _isExpanded
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Compact header - always visible
          _ControlTileHeader(
            control: widget.control,
            isExpanded: _isExpanded,
            onToggle: _toggleExpanded,
          ),

          // Expanded content - animated, inside the tile
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: _isExpanded
                ? Container(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: widget.control.builder(context),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

/// Header section of the control tile that shows control name, value preview, and expand button.
class _ControlTileHeader extends StatelessWidget {
  const _ControlTileHeader({
    required this.control,
    required this.isExpanded,
    required this.onToggle,
  });

  final ValueControl control;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Control type icon
            Icon(
              Icons.tune,
              size: 16,
              color: Colors.grey[500],
            ),
            const SizedBox(width: 8),

            // Control label
            Expanded(
              flex: 2,
              child: Text(
                control.label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: isExpanded ? FontWeight.w600 : FontWeight.normal,
                      color: isExpanded ? Theme.of(context).colorScheme.primary : null,
                    ),
              ),
            ),

            // Value preview
            Expanded(
              flex: 3,
              child: ControlValuePreview(control: control),
            ),

            // Nullable indicator
            if (control.isNullable && control.value == null)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  'null',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),

            const SizedBox(width: 8),

            // Expand/collapse arrow
            Icon(
              isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
              size: 20,
              color: isExpanded
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}
