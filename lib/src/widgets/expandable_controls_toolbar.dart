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
        color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
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
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.8)
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

/// A controller to manage the expansion state of multiple expandable controls.
class ExpandableControlsController extends ChangeNotifier {
  final Map<String, bool> _expansionStates = {};

  bool getExpansionState(String controlId) {
    return _expansionStates[controlId] ?? false;
  }

  void setExpansionState(String controlId, bool isExpanded) {
    if (_expansionStates[controlId] != isExpanded) {
      _expansionStates[controlId] = isExpanded;
      notifyListeners();
    }
  }

  void expandAll(List<String> controlIds) {
    for (final id in controlIds) {
      _expansionStates[id] = true;
    }
    notifyListeners();
  }

  void collapseAll(List<String> controlIds) {
    for (final id in controlIds) {
      _expansionStates[id] = false;
    }
    notifyListeners();
  }

  int getExpandedCount() {
    return _expansionStates.values.where((expanded) => expanded).length;
  }

  int getTotalCount() {
    return _expansionStates.length;
  }
}
