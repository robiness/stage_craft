import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/stage/control_bar.dart';
import 'package:stage_craft/src/stage/measure_grid.dart';
import 'package:stage_craft/src/stage/ruler.dart';
import 'package:stage_craft/src/stage/settings_bar.dart';
import 'package:stage_craft/src/stage/stage_constraints_handles.dart';
import 'package:stage_craft/src/stage/stage_style.dart';

/// The heart of StageCraft.
/// Puts it's builder on a stage where it can be manipulated.
/// It contains of a Canvas where the Stage is located and a ControlBar where the controls are located to manipulate the stage.
class StageBuilder extends StatefulWidget {
  /// Creates a [StageBuilder].
  const StageBuilder({
    super.key,
    required this.builder,
    List<ValueControl>? controls,
    this.style,
    this.forceSize = true,
  }) : controls = controls ?? const [];

  /// The builder for the widget on stage.
  final WidgetBuilder builder;

  /// The controls to manipulate the widget on stage.
  final List<ValueControl> controls;

  /// The style of the stage.
  final StageStyleData? style;

  /// If true, the size of the stage will be forced to the size of the child.
  final bool forceSize;

  @override
  State<StageBuilder> createState() => _StageBuilderState();
}

class _StageBuilderState extends State<StageBuilder> {
  late ThemeData _theme;
  late StageStyleData _style;
  late StageSettings _settings = StageSettings(forceSize: widget.forceSize);

  @override
  void initState() {
    super.initState();
    if (widget.style != null) {
      _style = widget.style!;
    }
  }

  @override
  void didUpdateWidget(covariant StageBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The parameter style always takes precedence
    if (widget.style != oldWidget.style) {
      _style = widget.style ?? StageStyleData.fromMaterialTheme(_theme);
    }
    if (widget.forceSize != oldWidget.forceSize) {
      _settings = _settings.copyWith(forceSize: widget.forceSize);
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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _theme,
      child: StageStyle(
        data: _style,
        child: ColoredBox(
          color: _style.canvasColor,
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    StageCanvas(
                      settings: _settings,
                      controls: widget.controls,
                      widgetBuilder: widget.builder,
                      style: _style,
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
                              final overriddenStyle = widget.style ?? StageStyle.maybeOf(context);
                              if (_theme.brightness == Brightness.light) {
                                _theme = ThemeData.dark();
                                if (overriddenStyle?.brightness == Brightness.dark) {
                                  _style = overriddenStyle!;
                                  return;
                                }
                              } else {
                                _theme = ThemeData.light();
                                if (overriddenStyle?.brightness == Brightness.light) {
                                  _style = overriddenStyle!;
                                  return;
                                }
                              }
                              _style = StageStyleData.fromMaterialTheme(_theme);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
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
    );
  }
}

/// The canvas where the stage is placed on.
/// It handles the position and the size of the stage.
class StageCanvas extends StatefulWidget {
  /// Creates a [StageCanvas].
  const StageCanvas({
    super.key,
    required this.settings,
    required this.widgetBuilder,
    required this.controls,
    required this.style,
  });

  /// The settings for the stage which can be manipulated by the user.
  final StageSettings settings;

  /// The builder for the widget on stage.
  final WidgetBuilder widgetBuilder;

  /// The controls to manipulate the widget on stage.
  final List<ValueControl> controls;

  /// The style of the stage.
  final StageStyleData style;

  @override
  State<StageCanvas> createState() => _StageCanvasState();
}

class _StageCanvasState extends State<StageCanvas> {
  Rect? _rect;

  late Offset _dragStart;

  late BoxConstraints canvasConstraints;

  final _childKey = GlobalKey();

  final _transformationController = TransformationController();

  double get currentScale => _transformationController.value.getMaxScaleOnAxis();

  final _hotReloadListener = ValueNotifier<Key>(UniqueKey());

  @override
  void reassemble() {
    super.reassemble();
    _hotReloadListener.value = UniqueKey();
  }

  @override
  void initState() {
    super.initState();
    _sizeAndCenterStage();
    _transformationController.addListener(() {
      setState(() {});
    });
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
        _rect = Rect.fromLTWH(positionX, positionY - 50, clampedSize.width, clampedSize.height).toRounded();
      });
    });
  }

  void _onDragStart(DragDownDetails details) {
    _dragStart = details.globalPosition;
  }

  void _handleDrag(
    DragUpdateDetails details,
    BoxConstraints constraints,
    Alignment alignment,
    StageStyleData style,
  ) {
    late double width = _rect!.width;
    late double height = _rect!.height;
    double top = _rect!.top;
    double left = _rect!.left;
    final dx = (details.globalPosition.dx - _dragStart.dx) * (1 / currentScale);
    final dy = (details.globalPosition.dy - _dragStart.dy) * (1 / currentScale);
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
      width = width.clamp(0, constraints.maxWidth - sizeControlsArea);
      height = height.clamp(0, constraints.maxHeight - sizeControlsArea);

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
    return LayoutBuilder(
      builder: (context, constraints) {
        canvasConstraints = constraints;
        if (_rect == null) {
          return Offstage(
            child: Center(
              child: KeyedSubtree(
                key: _childKey,
                child: widget.widgetBuilder(context),
              ),
            ),
          );
        }
        return Stack(
          children: [
            if (!widget.settings.showRuler)
              Positioned.fill(
                child: MeasureGrid(
                  size: 100 * currentScale,
                ),
              ),
            InteractiveViewer(
              transformationController: _transformationController,
              minScale: 0.1,
              maxScale: 256,
              child: Stack(
                children: [
                  // The widget on stage
                  StageRect(
                    rect: _rect!,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanDown: _onDragStart,
                      onPanUpdate: (details) => _handleDrag(details, constraints, Alignment.center, widget.style),
                      child: SizedBox(
                        height: widget.settings.forceSize ? _rect!.height : null,
                        width: widget.settings.forceSize ? _rect!.width : null,
                        child: ListenableBuilder(
                          listenable: Listenable.merge([...widget.controls, _hotReloadListener]),
                          builder: (context, _) {
                            return widget.widgetBuilder(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  // The border of the stage
                  StageRect(
                    rect: _rect!,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanDown: _onDragStart,
                      onPanUpdate: (details) => _handleDrag(details, constraints, Alignment.center, widget.style),
                      child: IgnorePointer(
                        child: widget.settings.showRuler
                            ? DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: widget.style.borderColor,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    width: 1 * (1 / currentScale),
                                  ),
                                ),
                                child: const SizedBox.expand(),
                              )
                            : const SizedBox.expand(),
                      ),
                    ),
                  ),
                  if (widget.settings.showRuler)
                    Rulers(
                      rect: _rect!,
                    ),
                  StageConstraintsHandles(
                    rect: _rect!,
                    onPanUpdate: (details, alignment) {
                      _handleDrag(details, constraints, alignment, widget.style);
                    },
                    currentScale: currentScale,
                    onPanStart: _onDragStart,
                  ),
                  if (widget.settings.showCrossHair)
                    const Positioned.fill(
                      child: CrossHair(),
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${currentScale.toStringAsFixed(2)}x',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// A crosshair that follows the mouse position.
class CrossHair extends StatefulWidget {
  /// Creates a [CrossHair].
  const CrossHair({
    super.key,
  });

  @override
  State<CrossHair> createState() => _CrossHairState();
}

class _CrossHairState extends State<CrossHair> {
  Offset? mousePosition;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          mousePosition = event.localPosition;
        });
      },
      child: IgnorePointer(
        child: CustomPaint(
          painter: CrossHairPainter(
            mousePosition: mousePosition,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}

/// A Painter which draws a crosshair at the mouse position.
class CrossHairPainter extends CustomPainter {
  /// Creates a [CrossHairPainter].
  CrossHairPainter({
    super.repaint,
    required this.mousePosition,
    required this.color,
  });

  /// The position of the mouse.
  final Offset? mousePosition;

  /// The color of the crosshair.
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (mousePosition != null) {
      final paint = Paint()
        ..color = color
        ..strokeWidth = 1;
      canvas.drawLine(
        Offset(mousePosition!.dx, 0).toRounded() + const Offset(0.5, 0.5),
        Offset(mousePosition!.dx, size.height).toRounded() + const Offset(0.5, 0.5),
        paint,
      );
      canvas.drawLine(
        Offset(0, mousePosition!.dy).toRounded() + const Offset(0.5, 0.5),
        Offset(size.width, mousePosition!.dy).toRounded() + const Offset(0.5, 0.5),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// Settings for the stage.
class StageSettings {
  /// Creates a [StageSettings].
  StageSettings({
    this.showRuler = true,
    this.forceSize = true,
    this.showCrossHair = false,
  });

  /// Whether the rulers should be shown.
  final bool showRuler;

  /// Whether the size of the stage should be forced to the size of the child.
  final bool forceSize;

  /// Whether the crosshair should be shown.
  final bool showCrossHair;

  /// Creates a copy of this [StageSettings] but with the given fields replaced with the new values.
  StageSettings copyWith({
    bool? showRuler,
    bool? forceSize,
    bool? showCrossHair,
  }) {
    return StageSettings(
      showRuler: showRuler ?? this.showRuler,
      forceSize: forceSize ?? this.forceSize,
      showCrossHair: showCrossHair ?? this.showCrossHair,
    );
  }
}

/// Draws a rectangle the size of the rect on the stage, which is a stack.
class StageRect extends StatelessWidget {
  /// Creates a [StageRect].
  const StageRect({
    super.key,
    required this.rect,
    required this.child,
  });

  /// The size and position of the rectangle.
  final Rect rect;

  /// The child of the rectangle.
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

/// A ruler that shows the position of the mouse.
extension StageStyleExtension on BuildContext {
  /// The style of the stage.
  StageStyleData get stageStyle => StageStyle.of(this);
}

/// A ruler that shows the position of the mouse.
extension OffsetPixelExtension on Offset {
  /// Rounds the offset to a whole number.
  Offset toRounded() {
    return Offset(dx.roundToDouble(), dy.roundToDouble());
  }
}

/// A ruler that shows the position of the mouse.
extension RectPixelExtension on Rect {
  /// Rounds the rect to a whole number.
  Rect toRounded() {
    return Rect.fromLTWH(
      left.roundToDouble(),
      top.roundToDouble(),
      width.roundToDouble(),
      height.roundToDouble(),
    );
  }
}
