import 'package:example/new/stage/controls.dart';
import 'package:example/new/stage/measure_grid.dart';
import 'package:example/new/stage/ruler.dart';
import 'package:example/new/stage/stage_constraints_handles.dart';
import 'package:flutter/material.dart';

class Stage extends StatefulWidget {
  const Stage({
    super.key,
    required this.child,
    this.initialWidth = 200,
    this.initialHeight = 300,
  });

  final Widget child;
  final double initialWidth;
  final double initialHeight;

  @override
  State<Stage> createState() => _StageState();
}

class _StageState extends State<Stage> {
  late double _width = widget.initialWidth;
  late double _height = widget.initialHeight;
  double _top = 100;
  double _left = 100;

  late Offset _dragStart;

  StageSettings _settings = StageSettings();

  void _onPanStart(DragDownDetails details) {
    _dragStart = details.globalPosition;
  }

  void _onPanUpdate(DragUpdateDetails details, BoxConstraints constraints, Alignment alignment) {
    setState(() {
      final dx = details.globalPosition.dx - _dragStart.dx;
      final dy = details.globalPosition.dy - _dragStart.dy;

      if (alignment == Alignment.center) {
        _left = _left + dx;
        _top = _top + dy;
      }
      if (alignment == Alignment.topLeft) {
        _left = _left + dx;
        _top = _top + dy;
        _width = _width - dx;
        _height = _height - dy;
      }
      if (alignment == Alignment.topRight) {
        _top = _top + dy;
        _width = _width + dx;
        _height = _height - dy;
      }
      if (alignment == Alignment.bottomLeft) {
        _left = _left + dx;
        _width = _width - dx;
        _height = _height + dy;
      }
      if (alignment == Alignment.bottomRight) {
        _width = _width + dx;
        _height = _height + dy;
      }
      if (alignment == Alignment.topCenter) {
        _top = _top + dy;
        _height = _height - dy;
      }
      if (alignment == Alignment.bottomCenter) {
        _height = _height + dy;
      }
      if (alignment == Alignment.centerLeft) {
        _left = _left + dx;
        _width = _width - dx;
      }
      if (alignment == Alignment.centerRight) {
        _width = _width + dx;
      }

      // // Ensure minimum size constraints
      _width = _width.clamp(0.0, constraints.maxWidth);
      _height = _height.clamp(0.0, constraints.maxHeight);

      // Ensure top and left are within constraints
      _left = _left.clamp(0.0, constraints.maxWidth - _width);
      _top = _top.clamp(0.0, constraints.maxHeight - _height);

      // Update drag start position
      _dragStart = details.globalPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rect = Rect.fromLTWH(_left, _top, _width, _height);
    return ColoredBox(
      color: _settings.stageColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              if (!_settings.showRuler)
                const Positioned.fill(
                  child: MeasureGrid(size: 100),
                ),
              StageRect(
                rect: rect,
                child: GestureDetector(
                  onPanDown: _onPanStart,
                  onPanUpdate: (details) => _onPanUpdate(details, constraints, Alignment.center),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: widget.child,
                  ),
                ),
              ),
              if (_settings.showRuler) Rulers(rect: rect, height: _height, width: _width),
              StageConstraintsHandles(
                rect: rect,
                onPanUpdate: (details, alignment) {
                  _onPanUpdate(details, constraints, alignment);
                },
                onPanStart: _onPanStart,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Controls(
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
    );
  }
}

final style = StageStyle();

class StageStyle {
  final double ballSize = 10.0;
}

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
