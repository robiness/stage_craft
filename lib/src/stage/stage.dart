import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/stage/measure_grid.dart';
import 'package:stage_craft/src/stage/ruler.dart';
import 'package:stage_craft/src/stage/settings_bar.dart';
import 'package:stage_craft/src/stage/stage_constraints_handles.dart';
import 'package:stage_craft/src/stage/stage_style.dart';

class StageBuilder extends StatefulWidget {
  const StageBuilder({
    super.key,
    required this.builder,
    this.initialSize = const Size(200, 300),
    this.controls = const [],
    this.style,
  });

  final WidgetBuilder builder;
  final Size initialSize;
  final List<ValueControl> controls;

  final StageStyleData? style;

  @override
  State<StageBuilder> createState() => _StageBuilderState();
}

class _StageBuilderState extends State<StageBuilder> {
  late Rect _rect = Rect.fromLTWH(
    100,
    100,
    widget.initialSize.width,
    widget.initialSize.height,
  );

  late Offset _dragStart;

  StageSettings _settings = StageSettings();

  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }

  void _onDragStart(DragDownDetails details) {
    _dragStart = details.globalPosition;
  }

  void _handleDrag(DragUpdateDetails details, BoxConstraints constraints, Alignment alignment, StageStyleData style) {
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
      final sizeControlsArea = style.dragPadding;
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
    final stageTheme = widget.style ?? StageStyle.maybeOf(context) ?? StageStyleData.fromMaterialTheme(_theme);
    return Theme(
      data: _theme,
      child: StageStyle(
        data: stageTheme,
        child: ColoredBox(
          color: stageTheme.canvasColor,
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
                            child: ColoredBox(
                              color: stageTheme.stageColor,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onPanDown: _onDragStart,
                                onPanUpdate: (details) =>
                                    _handleDrag(details, constraints, Alignment.center, stageTheme),
                                child: ListenableBuilder(
                                  listenable: Listenable.merge(widget.controls),
                                  builder: (context, child) {
                                    return widget.builder(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                          StageBorder(rect: _rect),
                          if (_settings.showRuler)
                            Rulers(
                              rect: _rect,
                            ),
                          StageConstraintsHandles(
                            rect: _rect,
                            onPanUpdate: (details, alignment) {
                              _handleDrag(details, constraints, alignment, stageTheme);
                            },
                            onPanStart: _onDragStart,
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
                                onStyleToggled: () {
                                  setState(() {
                                    if (_theme.brightness == Brightness.light) {
                                      _theme = ThemeData.dark();
                                    } else {
                                      _theme = ThemeData.light();
                                    }
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
        ),
      ),
    );
  }
}

class StageBorder extends StatelessWidget {
  const StageBorder({
    super.key,
    required Rect rect,
  }) : _rect = rect;

  final Rect _rect;

  @override
  Widget build(BuildContext context) {
    return StageRect(
      rect: _rect,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: context.stageStyle.stageBorderDecoration,
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

/// A control bar that displays a list of controls to manipulate the stage.
class ControlBar extends StatefulWidget {
  const ControlBar({
    super.key,
    required this.controls,
  });

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

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListView(
        children: widget.controls.map((control) {
          return control.builder(context);
        }).toList(),
      ),
    );
  }
}

/// Settings for the stage.
class StageSettings {
  StageSettings({
    this.showRuler = true,
  });

  final bool showRuler;

  StageSettings copyWith({
    bool? showRuler,
    Color? stageColor,
  }) {
    return StageSettings(
      showRuler: showRuler ?? this.showRuler,
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

extension StageStyleExtension on BuildContext {
  StageStyleData get stageStyle => StageStyle.of(this);
}
