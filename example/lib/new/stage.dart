import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Expanded(
          child: ColoredBox(
            color: Colors.grey,
            child: Padding(
              padding: EdgeInsets.all(84.0),
              child: Stage(
                child: MyContainerScene(),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class Stage extends StatefulWidget {
  const Stage({super.key, required this.child});

  final Widget child;

  @override
  State<Stage> createState() => _StageState();
}

class _StageState extends State<Stage> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class Scene extends StatefulWidget {
  const Scene({
    super.key,
    required this.child,
    this.initialWidth = 200,
    this.initialHeight = 300,
  });

  final Widget child;
  final double initialWidth;
  final double initialHeight;

  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  late double _width = widget.initialWidth;
  late double _height = widget.initialHeight;
  double _top = 100;
  double _left = 100;
  late Offset _dragStart;

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

      // Ensure minimum size constraints
      if (_width < 50) _width = 50;
      if (_height < 50) _height = 50;

      // Ensure top and left are within constraints
      _left = _left.clamp(0.0, constraints.maxWidth - _width);
      _top = _top.clamp(0.0, constraints.maxHeight - _height);

      // Update drag start position
      _dragStart = details.globalPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                top: _top,
                left: _left,
                child: GestureDetector(
                  onPanDown: _onPanStart,
                  onPanUpdate: (details) => _onPanUpdate(details, constraints, Alignment.center),
                  child: SizedBox(
                    width: _width,
                    height: _height,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(style.ballSize / 2),
                          child: widget.child,
                        ),
                        ...[
                          Alignment.topLeft,
                          Alignment.topCenter,
                          Alignment.topRight,
                          Alignment.centerRight,
                          Alignment.bottomRight,
                          Alignment.bottomCenter,
                          Alignment.bottomLeft,
                          Alignment.centerLeft,
                        ].map(
                          (alignment) {
                            return MetaBall(
                              alignment: alignment,
                              constraints: constraints,
                              onPanStart: _onPanStart,
                              onPanUpdate: _onPanUpdate,
                            );
                          },
                        ),
                      ],
                    ),
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

class MyContainerScene extends StatefulWidget {
  const MyContainerScene({super.key});

  @override
  State<MyContainerScene> createState() => _MyContainerSceneState();
}

class _MyContainerSceneState extends State<MyContainerScene> {
  @override
  Widget build(BuildContext context) {
    return const Scene(
      initialWidth: 600,
      initialHeight: 800,
      child: FunkyContainer(
        color: Colors.purpleAccent,
        child: Text('Funky!'),
      ),
    );
  }
}

class FunkyContainer extends StatefulWidget {
  const FunkyContainer({
    super.key,
    this.color,
    this.height,
    this.width,
    this.child,
  });

  final Color? color;
  final double? height;
  final double? width;
  final Widget? child;

  @override
  State<FunkyContainer> createState() => _FunkyContainerState();
}

class _FunkyContainerState extends State<FunkyContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          height: widget.height,
          width: widget.width,
          color: widget.color,
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}

class MetaBall extends StatelessWidget {
  const MetaBall({
    super.key,
    required this.alignment,
    required this.constraints,
    this.onPanStart,
    this.onPanUpdate,
  });

  final Alignment alignment;
  final BoxConstraints constraints;
  final void Function(DragDownDetails)? onPanStart;
  final void Function(DragUpdateDetails, BoxConstraints constraints, Alignment alignment)? onPanUpdate;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onPanDown: (details) {
          onPanStart?.call(details);
        },
        onPanUpdate: (details) => onPanUpdate?.call(details, constraints, alignment),
        child: style.ballBuilder(context),
      ),
    );
  }
}

final style = StageStyle();

class StageStyle {
  final double ballSize = 20.0;
  final WidgetBuilder ballBuilder = (context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
    );
  };
}
