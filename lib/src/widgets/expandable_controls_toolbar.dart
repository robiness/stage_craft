import 'dart:async';

import 'package:flutter/material.dart';

/// Provides global controls for managing expandable controls.
class ExpandableControlsToolbar extends StatelessWidget {
  const ExpandableControlsToolbar({
    super.key,
    required this.onExpandAll,
    required this.onCollapseAll,
  });

  final VoidCallback onExpandAll;
  final VoidCallback onCollapseAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Expand all button
          _ToolbarButton(
            icon: Icons.unfold_more,
            label: 'Expand All',
            onPressed: onExpandAll,
          ),

          const SizedBox(width: 4),

          // Collapse all button
          _ToolbarButton(
            icon: Icons.unfold_less,
            label: 'Collapse All',
            onPressed: onCollapseAll,
          ),
        ],
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.all(6),
          child: Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}

/// Commands that can be broadcast to expandable controls.
enum ExpandCommand {
  expandAll,
  collapseAll,
}

/// A controller to broadcast expansion commands to multiple expandable controls.
/// Each control tile listens to the stream and decides independently whether to respond.
class ExpandableControlsController {
  final StreamController<ExpandCommand> _commandController = StreamController<ExpandCommand>.broadcast();

  /// Stream of expansion commands that tiles can listen to.
  Stream<ExpandCommand> get commandStream => _commandController.stream;

  /// Broadcast expand all command to all listening tiles.
  void expandAll() {
    _commandController.add(ExpandCommand.expandAll);
  }

  /// Broadcast collapse all command to all listening tiles.
  void collapseAll() {
    _commandController.add(ExpandCommand.collapseAll);
  }

  /// Dispose of the controller and close the stream.
  void dispose() {
    _commandController.close();
  }
}
