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
    this.controls = const [],
    this.style,
  });

  final WidgetBuilder builder;
  final List<ValueControl> controls;

  final StageStyleData? style;

  @override
  State<StageBuilder> createState() => _StageBuilderState();
}

class _StageBuilderState extends State<StageBuilder> {
  Rect? _rect;

  late Offset _dragStart;

  StageSettings _settings = StageSettings();

  late ThemeData _theme;
  late StageStyleData _style;

  late BoxConstraints canvasConstraints;

  final _childKey = GlobalKey();

  final _transformationController = TransformationController();

  double get currentScale => _transformationController.value.getMaxScaleOnAxis();

  @override
  void initState() {
    super.initState();
    if (widget.style != null) {
      _style = widget.style!;
    }
    _sizeAndCenterStage();
    _transformationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant StageBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The parameter style always takes precedence
    if (widget.style != oldWidget.style) {
      _style = widget.style ?? StageStyleData.fromMaterialTheme(_theme);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // If no style is provided, we first check if there is one in the context
    _theme = Theme.of(context);
    if (widget.style == null) {
      final styleFromContext = StageStyle.maybeOf(context);
      if (styleFromContext != null) {
        _style = styleFromContext;
      }
      // If there is no style passed via parameter or context we default to a predefine style based on the MaterialThemes brightness.
      else {
        _style = StageStyleData.fromMaterialTheme(_theme);
      }
    }
  }

  void _sizeAndCenterStage() {
    // Get the size of the child and center it on the canvas
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final renderBox = _childKey.currentContext!.findRenderObject()! as RenderBox;
      final size = renderBox.size;
      final clampedWidth = size.width.clamp(0.0, canvasConstraints.maxWidth - 150);
      final clampedHeight = size.height.clamp(0.0, canvasConstraints.maxHeight - 140);
      final clampedSize = Size(clampedWidth, clampedHeight);
      final positionX = (canvasConstraints.maxWidth - clampedSize.width) / 2;
      final positionY = (canvasConstraints.maxHeight - clampedSize.height) / 2;
      setState(() {
        _rect = Rect.fromLTWH(positionX, positionY - 50, clampedSize.width, clampedSize.height);
      });
    });
  }

  void _onDragStart(DragDownDetails details) {
    _dragStart = details.globalPosition;
  }

  void _handleDrag(DragUpdateDetails details, BoxConstraints constraints, Alignment alignment, StageStyleData style) {
    late double width = _rect!.width;
    late double height = _rect!.height;
    double top = _rect!.top;
    double left = _rect!.left;
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
    return Theme(
      data: _theme,
      child: StageStyle(
        data: _style,
        child: ColoredBox(
          color: _style.canvasColor,
          child: MeasureGrid(
            size: 100 * currentScale,
            showGrid: !_settings.showRuler,
            child: Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      canvasConstraints = constraints;
                      if (_rect == null) {
                        return Offstage(
                          child: Center(
                            child: KeyedSubtree(
                              key: _childKey,
                              child: widget.builder(context),
                            ),
                          ),
                        );
                      }
                      return Stack(
                        children: [
                          InteractiveViewer(
                            transformationController: _transformationController,
                            minScale: 0.1,
                            maxScale: 10,
                            child: Stack(
                              children: [
                                // The widget on stage
                                StageRect(
                                  rect: _rect!,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onPanDown: _onDragStart,
                                    onPanUpdate: (details) =>
                                        _handleDrag(details, constraints, Alignment.center, _style),
                                    child: ListenableBuilder(
                                      listenable: Listenable.merge(widget.controls),
                                      builder: (context, child) {
                                        return widget.builder(context);
                                      },
                                    ),
                                  ),
                                ),
                                // The border of the stage
                                StageRect(
                                  rect: _rect!,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onPanDown: _onDragStart,
                                    onPanUpdate: (details) =>
                                        _handleDrag(details, constraints, Alignment.center, _style),
                                    child: IgnorePointer(
                                      child: _settings.showRuler
                                          ? DecoratedBox(
                                              decoration: context.stageStyle.stageBorderDecoration,
                                              child: const SizedBox.expand(),
                                            )
                                          : const SizedBox.expand(),
                                    ),
                                  ),
                                ),
                                if (_settings.showRuler)
                                  Rulers(
                                    rect: _rect!,
                                  ),
                                StageConstraintsHandles(
                                  rect: _rect!,
                                  onPanUpdate: (details, alignment) {
                                    _handleDrag(details, constraints, alignment, _style);
                                  },
                                  onPanStart: _onDragStart,
                                ),
                              ],
                            ),
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
                                onSurfaceColorChanged: (color) {
                                  setState(() {
                                    _style = _style.copyWith(canvasColor: color);
                                  });
                                },
                                onStyleToggled: () {
                                  setState(() {
                                    if (_theme.brightness == Brightness.light) {
                                      _theme = ThemeData.dark();
                                    } else {
                                      _theme = ThemeData.light();
                                    }
                                    _style = StageStyleData.fromMaterialTheme(_theme);
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
