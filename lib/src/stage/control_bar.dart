import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

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
  @override
  void initState() {
    super.initState();
    for (final control in widget.controls) {
      control.addListener(_update);
    }
  }

  @override
  void dispose() {
    super.dispose();
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
    print('WE DO THE UDPATE');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
              // padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
              children: widget.controls.map((control) {
                return control.builder(context);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
