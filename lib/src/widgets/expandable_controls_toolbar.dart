import 'package:flutter/material.dart';

/// Provides global controls for managing expandable controls.
class ExpandableControlsToolbar extends StatelessWidget {
  const ExpandableControlsToolbar({
    super.key,
    required this.onExpandAll,
    required this.onCollapseAll,
    this.expandedCount = 0,
    this.totalCount = 0,
  });

  final VoidCallback onExpandAll;
  final VoidCallback onCollapseAll;
  final int expandedCount;
  final int totalCount;

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
            onPressed: expandedCount < totalCount ? onExpandAll : null,
          ),

          const SizedBox(width: 4),

          // Collapse all button
          _ToolbarButton(
            icon: Icons.unfold_less,
            label: 'Collapse All',
            onPressed: expandedCount > 0 ? onCollapseAll : null,
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
            color: onPressed != null
                ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8)
                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}

/// A controller to dispatch expansion commands to multiple expandable controls.
class ExpandableControlsController extends ChangeNotifier {
  final Map<String, VoidCallback> _expandCommands = {};
  final Map<String, VoidCallback> _collapseCommands = {};
  
  int _expandedCount = 0;
  int _totalCount = 0;

  /// Register command callbacks for a control tile.
  void registerControl(String controlId, VoidCallback expandCommand, VoidCallback collapseCommand) {
    _expandCommands[controlId] = expandCommand;
    _collapseCommands[controlId] = collapseCommand;
    _totalCount = _expandCommands.length;
    notifyListeners();
  }

  /// Unregister a control tile.
  void unregisterControl(String controlId) {
    _expandCommands.remove(controlId);
    _collapseCommands.remove(controlId);
    _totalCount = _expandCommands.length;
    notifyListeners();
  }

  /// Update the expanded count when a tile's state changes.
  void updateExpandedCount(int newCount) {
    if (_expandedCount != newCount) {
      _expandedCount = newCount;
      notifyListeners();
    }
  }

  /// Send expand command to all registered controls.
  void expandAll() {
    for (final command in _expandCommands.values) {
      command();
    }
  }

  /// Send collapse command to all registered controls.
  void collapseAll() {
    for (final command in _collapseCommands.values) {
      command();
    }
  }

  int getExpandedCount() => _expandedCount;
  int getTotalCount() => _totalCount;
}
