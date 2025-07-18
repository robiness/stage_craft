import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';
import 'package:stage_craft/src/widgets/control_tile.dart';
import 'package:stage_craft/src/widgets/expandable_controls_toolbar.dart';

/// A control bar that displays a list of controls to manipulate the stage.
class ControlBar extends StatefulWidget {
  /// Creates a [ControlBar].
  const ControlBar({
    super.key,
    required this.controls,
  });

  /// The controls to manipulate the widget on stage.
  final List<ValueControl> controls;

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  late ExpandableControlsController _expandableController;
  
  @override
  void initState() {
    super.initState();
    _expandableController = ExpandableControlsController();
    _expandableController.addListener(_update);
    for (final control in widget.controls) {
      control.addListener(_update);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _expandableController.removeListener(_update);
    _expandableController.dispose();
    for (final control in widget.controls) {
      control.removeListener(_update);
    }
  }

  @override
  void didUpdateWidget(covariant ControlBar oldWidget) {
    for (final control in widget.controls) {
      control.addListener(_update);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controlIds = widget.controls.map((control) => '${control.runtimeType}_${control.label}').toList();
    
    return ColoredBox(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 4,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
          ),
          Flexible(
            child: Column(
              children: [
                // Toolbar
                ExpandableControlsToolbar(
                  onExpandAll: () => _expandableController.expandAll(controlIds),
                  onCollapseAll: () => _expandableController.collapseAll(controlIds),
                  expandedCount: _expandableController.getExpandedCount(),
                  totalCount: _expandableController.getTotalCount(),
                ),
                
                // Controls list
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
                    children: widget.controls.map((control) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: ControlTile(
                          control: control,
                          controller: _expandableController,
                          isExpandedByDefault: false,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
