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
  bool _expanded = true;

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

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          alignment: Alignment.centerLeft,
          width: _expanded ? context.stageStyle.controlPanelWidth + 44 : 48,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    _expanded ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
              Container(
                width: _expanded ? 4 : 8,
                height: double.infinity,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          right: _expanded ? 0 : -context.stageStyle.controlPanelWidth,
          child: SizedBox(
            width: context.stageStyle.controlPanelWidth,
            height: MediaQuery.of(context).size.height,
            child: ColoredBox(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView(
                  children: widget.controls.map((control) {
                    return control.builder(context);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
