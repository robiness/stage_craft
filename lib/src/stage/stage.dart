import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/stage/measure_grid.dart';
import 'package:stage_craft/src/stage/ruler.dart';
import 'package:stage_craft/src/stage/settings_bar.dart';
import 'package:stage_craft/src/stage/stage_constraints_handles.dart';

class StageBuilder extends StatefulWidget {
  const StageBuilder({
    super.key,
    required this.builder,
    this.initialWidth = 200,
    this.initialHeight = 300,
    this.controls = const [],
  });

  final WidgetBuilder builder;
  final double initialWidth;
  final double initialHeight;
  final List<ValueControl> controls;

  @override
  State<StageBuilder> createState() => _StageBuilderState();
}

class _StageBuilderState extends State<StageBuilder> {
  late Rect _rect = Rect.fromLTWH(100, 100, widget.initialWidth, widget.initialHeight);

  late Offset _dragStart;

  StageSettings _settings = StageSettings();

  void _onPanStart(DragDownDetails details) {
    _dragStart = details.globalPosition;
  }

  void _onPanUpdate(DragUpdateDetails details, BoxConstraints constraints, Alignment alignment) {
    late double width = _rect.width;
    late double height = _rect.height;
    double top = _rect.top;
    double left = _rect.left;
    final dx = details.globalPosition.dx - _dragStart.dx;
    final dy = details.globalPosition.dy - _dragStart.dy;
    setState(() {
      if (alignment == Alignment.center) {
        left = left + dx;
        top = top + dy;
      }
      if (alignment == Alignment.topLeft) {
        left = left + dx;
        top = top + dy;
        width = width - dx;
        height = height - dy;
      }
      if (alignment == Alignment.topRight) {
        top = top + dy;
        width = width + dx;
        height = height - dy;
      }
      if (alignment == Alignment.bottomLeft) {
        left = left + dx;
        width = width - dx;
        height = height + dy;
      }
      if (alignment == Alignment.bottomRight) {
        width = width + dx;
        height = height + dy;
      }
      if (alignment == Alignment.topCenter) {
        top = top + dy;
        height = height - dy;
      }
      if (alignment == Alignment.bottomCenter) {
        height = height + dy;
      }
      if (alignment == Alignment.centerLeft) {
        left = left + dx;
        width = width - dx;
      }
      if (alignment == Alignment.centerRight) {
        width = width + dx;
      }
      // The size controls should also be always visible
      final sizeControlsArea = style.mouseArea;
      // // Ensure minimum size constraints
      width = width.clamp(sizeControlsArea, constraints.maxWidth - sizeControlsArea);
      height = height.clamp(sizeControlsArea, constraints.maxHeight - sizeControlsArea);

      // Ensure top and left are within constraints
      left = left.clamp(sizeControlsArea, constraints.maxWidth - width - sizeControlsArea);
      top = top.clamp(sizeControlsArea, constraints.maxHeight - height - sizeControlsArea);

      _rect = Rect.fromLTWH(left, top, width, height);
      // Update drag start position
      _dragStart = details.globalPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _settings.stageColor,
      child: MeasureGrid(
        size: 100,
        showGrid: !_settings.showRuler,
        child: Row(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      // The widget on stage
                      StageRect(
                        rect: _rect,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanDown: _onPanStart,
                          onPanUpdate: (details) => _onPanUpdate(details, constraints, Alignment.center),
                          child: ListenableBuilder(
                            listenable: Listenable.merge(widget.controls),
                            builder: (context, child) {
                              return widget.builder(context);
                            },
                          ),
                        ),
                      ),
                      // The border of the widget on stage
                      StageRect(
                        rect: _rect,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanDown: _onPanStart,
                          onPanUpdate: (details) => _onPanUpdate(details, constraints, Alignment.center),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_settings.showRuler)
                        Rulers(
                          rect: _rect,
                        ),
                      StageConstraintsHandles(
                        rect: _rect,
                        onPanUpdate: (details, alignment) {
                          _onPanUpdate(details, constraints, alignment);
                        },
                        onPanStart: _onPanStart,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SettingsBar(
                            settings: _settings,
                            onSettingsChanged: (settings) {
                              setState(() {
                                _settings = settings;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            if (widget.controls.isNotEmpty)
              ControlBar(
                controls: widget.controls,
              ),
          ],
        ),
      ),
    );
  }
}

/// A control bar that displays a list of controls to manipulate the stage.
class ControlBar extends StatelessWidget {
  const ControlBar({
    super.key,
    required this.controls,
  });

  final List<ValueControl> controls;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListView(
        children: controls.map((control) {
          return control.builder(context);
        }).toList(),
      ),
    );
  }
}

final style = StageStyle();

/// Style settings for the stage.
class StageStyle {
  final double ballSize = 10.0;
  final double mouseArea = 20.0;
}

/// Settings for the stage.
class StageSettings {
  StageSettings({
    this.showRuler = true,
    this.stageColor = Colors.white,
  });

  final bool showRuler;
  final Color stageColor;

  StageSettings copyWith({
    bool? showRuler,
    Color? stageColor,
  }) {
    return StageSettings(
      showRuler: showRuler ?? this.showRuler,
      stageColor: stageColor ?? this.stageColor,
    );
  }
}

/// Draws a rectangle the size of the rect on the stage, which is a stack.
class StageRect extends StatelessWidget {
  const StageRect({
    super.key,
    required this.rect,
    required this.child,
  });

  final Rect rect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: rect.top,
      left: rect.left,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: rect.width,
          maxHeight: rect.height,
        ),
        child: child,
      ),
    );
  }
}
