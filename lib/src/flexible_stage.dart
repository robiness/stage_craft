import 'package:flutter/material.dart';
import 'package:stage_craft/src/widget_stage.dart';

class FlexibleStage extends StatefulWidget {
  const FlexibleStage({
    super.key,
    required this.child,
    required this.stageController,
  });

  final Widget child;
  final StageController stageController;

  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

const ballDiameter = 22.0;

class _ResizableWidgetState extends State<FlexibleStage> {
  late BoxConstraints? _currentConstraints;

  bool _isDragging = false;

  static const handlePadding = 32.0;

  double get height => widget.stageController.stageSize.height;

  set height(double newHeight) {
    widget.stageController.stageSize = Size(
      widget.stageController.stageSize.width,
      newHeight,
    );
  }

  double get width => widget.stageController.stageSize.width;

  set width(double newWidth) {
    widget.stageController.stageSize = Size(
      newWidth,
      widget.stageController.stageSize.height,
    );
  }

  double get top => widget.stageController.stagePosition.dy;

  set top(double newTop) {
    widget.stageController.stagePosition = Offset(
      widget.stageController.stagePosition.dx,
      newTop,
    );
  }

  double get left => widget.stageController.stagePosition.dx;

  set left(double newWidth) {
    widget.stageController.stagePosition = Offset(
      newWidth,
      widget.stageController.stagePosition.dy,
    );
  }

  void onDrag(double dx, double dy) {
    final newHeight = height + dy;
    final newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerStage();
    });
  }

  void centerStage() {
    setState(() {
      top = _currentConstraints!.maxHeight / 2 - height / 2;
      left = _currentConstraints!.maxWidth / 2 - width / 2;
    });
  }

  bool showManipulatingBalls = false;

  void onDragStart() {
    _isDragging = true;
  }

  void onDragEnd() {
    _isDragging = false;
  }

  void dragLeft(double dx, double dy) {
    final newWidth = width - dx;
    if (left + dx > 0 && newWidth > 0) {
      setState(() {
        left += dx;
        width = newWidth > 0 ? newWidth : 0;
      });
    }
  }

  void dragRight(double dx, double dy) {
    final newWidth = width + dx;
    if (newWidth + left < _currentConstraints!.maxWidth - 70) {
      setState(() {
        width = newWidth > 0 ? newWidth : 0;
      });
    }
  }

  void dragUp(double dx, double dy) {
    final newHeight = height - dy;
    if (top + dy > 0 && newHeight > 0) {
      setState(() {
        top += dy;
        height = newHeight > 0 ? newHeight : 0;
      });
    }
  }

  void dragDown(double dx, double dy) {
    final newHeight = height + dy;
    if (newHeight + top < _currentConstraints!.maxHeight - 70) {
      setState(() {
        height = newHeight > 0 ? newHeight : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _currentConstraints = constraints;
        return CustomPaint(
          painter: GridRaster(),
          child: Stack(
            children: <Widget>[
              // The actual widget
              Positioned(
                top: top,
                left: left,
                child: Padding(
                  padding: const EdgeInsets.all(handlePadding),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        top += details.delta.dy;
                        left += details.delta.dx;
                      });
                    },
                    child: Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
              // top left
              Positioned(
                top: top - ballDiameter / 2 + handlePadding,
                left: left - ballDiameter / 2 + handlePadding,
                child: ManipulatingBall(
                  show: showManipulatingBalls,
                  onDragStart: onDragStart,
                  onDragEnd: onDragEnd,
                  onDrag: (dx, dy) {
                    dragUp(dx, dy);
                    dragLeft(dx, dy);
                  },
                ),
              ),
              // top right
              Positioned(
                top: top - ballDiameter / 2 + handlePadding,
                left: left + width - ballDiameter / 2 + handlePadding,
                child: ManipulatingBall(
                  show: showManipulatingBalls,
                  onDragStart: onDragStart,
                  onDragEnd: onDragEnd,
                  onDrag: (dx, dy) {
                    dragRight(dx, dy);
                    dragUp(dx, dy);
                  },
                ),
              ),

              // bottom right
              Positioned(
                top: top + height - ballDiameter / 2 + handlePadding,
                left: left + width - ballDiameter / 2 + handlePadding,
                child: ManipulatingBall(
                  show: showManipulatingBalls,
                  onDragStart: onDragStart,
                  onDragEnd: onDragEnd,
                  onDrag: (dx, dy) {
                    dragDown(dx, dy);
                    dragRight(dx, dy);
                  },
                ),
              ),
              // top middle
              Positioned(
                top: top - ballDiameter / 2 + handlePadding,
                left: left + width / 2 - ballDiameter / 2 + handlePadding,
                child: ManipulatingBall(
                  show: showManipulatingBalls,
                  onDragStart: onDragStart,
                  onDragEnd: onDragEnd,
                  onDrag: dragUp,
                ),
              ),
              // bottom center
              Positioned(
                top: top + height - ballDiameter / 2 + handlePadding,
                left: left + width / 2 - ballDiameter / 2 + handlePadding,
                child: ManipulatingBall(
                  show: showManipulatingBalls,
                  onDragStart: onDragStart,
                  onDragEnd: onDragEnd,
                  onDrag: dragDown,
                ),
              ),
              // bottom left
              Positioned(
                top: top + height - ballDiameter / 2 + handlePadding + 24,
                left: left + handlePadding,
                child: Text('${width.toStringAsFixed(1)} x ${height.toStringAsFixed(1)}'),
              ),
              // bottom left
              Positioned(
                top: top + height - ballDiameter / 2 + handlePadding,
                left: left - ballDiameter / 2 + handlePadding,
                child: ManipulatingBall(
                  show: showManipulatingBalls,
                  onDragStart: onDragStart,
                  onDragEnd: onDragEnd,
                  onDrag: (dx, dy) {
                    dragLeft(dx, dy);
                    dragDown(dx, dy);
                  },
                ),
              ),
              //left center
              Positioned(
                top: top + height / 2 - ballDiameter / 2 + handlePadding,
                left: left - ballDiameter / 2 + handlePadding,
                child: ManipulatingBall(
                  show: showManipulatingBalls,
                  onDragStart: onDragStart,
                  onDragEnd: onDragEnd,
                  onDrag: dragLeft,
                ),
              ),
              // center right
              Positioned(
                top: top + height / 2 - ballDiameter / 2 + handlePadding,
                left: left + width - ballDiameter / 2 + handlePadding,
                child: ManipulatingBall(
                  show: showManipulatingBalls,
                  onDragStart: onDragStart,
                  onDragEnd: onDragEnd,
                  onDrag: dragRight,
                ),
              ),
              // Just here to detect mouse enter and exit around stage
              Positioned(
                top: top,
                left: left,
                child: MouseRegion(
                  hitTestBehavior: HitTestBehavior.translucent,
                  onEnter: (_) {
                    setState(() {
                      showManipulatingBalls = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      if (_isDragging == false) {
                        showManipulatingBalls = false;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(handlePadding),
                    child: SizedBox(
                      height: height,
                      width: width,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  const ManipulatingBall({
    required this.onDrag,
    required this.onDragEnd,
    required this.onDragStart,
    required this.show,
  });

  final Function(double, double) onDrag;
  final Function() onDragEnd;
  final Function() onDragStart;
  final bool show;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  double? initX;
  double? initY;

  Color _color = Colors.blue.withOpacity(0.5);

  void _handleDrag(DragStartDetails details) {
    setState(() {
      initX = details.localPosition.dx;
      initY = details.localPosition.dy;
    });
    setState(() {
      _color = Colors.blue;
    });
    widget.onDragStart();
  }

  void _handleUpdate(DragUpdateDetails details) {
    final dx = details.localPosition.dx - initX!;
    final dy = details.localPosition.dy - initY!;
    initX = details.localPosition.dx;
    initY = details.localPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: widget.show ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInCubic,
      child: MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: GestureDetector(
          onPanStart: _handleDrag,
          onPanUpdate: _handleUpdate,
          onPanEnd: (_) {
            setState(() {
              _color = Colors.blue.withOpacity(0.5);
            });
            widget.onDragEnd();
          },
          child: Container(
            width: ballDiameter,
            height: ballDiameter,
            decoration: BoxDecoration(
              color: _color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class GridRaster extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < size.width; i += 100) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        Paint()..color = Colors.grey.withOpacity(0.1),
      );
    }
    // draw vertical lines
    for (var i = 0; i < size.height; i += 100) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        Paint()..color = Colors.grey.withOpacity(0.1),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
