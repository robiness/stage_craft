import 'package:flutter/material.dart';

class DiscreteResizableComponent extends StatefulWidget {
  const DiscreteResizableComponent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

const ballDiameter = 30.0;
const discreteStepSize = 1;

class _ResizableWidgetState extends State<DiscreteResizableComponent> {
  double height = 400;
  double width = 200;

  double top = 50;
  double left = 50;

  BoxConstraints? currentConstraints;

  bool _isDragging = false;

  static const handlePadding = 32.0;

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
      setState(() {
        top = currentConstraints!.maxHeight / 2 - height / 2;
        left = currentConstraints!.maxWidth / 2 - width / 2;
      });
    });
  }

  bool showManipulatingBalls = false;

  void onDragStart() {
    _isDragging = true;
  }

  void onDragEnd() {
    _isDragging = false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        currentConstraints = constraints;
        return Stack(
          children: <Widget>[
            // The actual widget
            Positioned(
              top: top,
              left: left,
              child: Padding(
                padding: const EdgeInsets.all(handlePadding),
                child: Container(
                  height: height,
                  width: width,
                  color: Colors.black26,
                  child: widget.child,
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
                  setState(() {
                    final newHeight = height - dy;
                    final newWidth = width - dx;
                    if (top + dy > 0) {
                      top += dy;
                      height = newHeight > 0 ? newHeight : 0;
                    }
                    if (left + dx > 0) {
                      left += dx;
                      width = newWidth > 0 ? newWidth : 0;
                    }
                  });
                },
              ),
            ),
            // // center center
            // Positioned(
            //   top: top + height / 2 - ballDiameter / 2 + handlePadding,
            //   left: left + width / 2 - ballDiameter / 2 + handlePadding,
            //   child: ManipulatingBall(
            //     show: showManipulatingBalls,
            //     onDragStart: onDragStart,
            //     onDragEnd: onDragEnd,
            //     onDrag: (dx, dy) {
            //       setState(() {
            //         top += dy;
            //         left += dx;
            //       });
            //     },
            //   ),
            // ),

            // top right
            Positioned(
              top: top - ballDiameter / 2 + handlePadding,
              left: left + width - ballDiameter / 2 + handlePadding,
              child: ManipulatingBall(
                show: showManipulatingBalls,
                onDragStart: onDragStart,
                onDragEnd: onDragEnd,
                onDrag: (dx, dy) {
                  setState(() {
                    final newHeight = height - dy;
                    final newWidth = width + dx;
                    if (newWidth + left < currentConstraints!.maxWidth - 70) {
                      width = newWidth > 0 ? newWidth : 0;
                    }

                    if (top + dy > 0) {
                      height = newHeight > 0 ? newHeight : 0;
                      top += dy;
                    }
                  });
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
                  setState(() {
                    final newHeight = height + dy;
                    height = newHeight > 0 ? newHeight : 0;
                    final newWidth = width + dx;
                    if (newWidth + left < currentConstraints!.maxWidth - 70) {
                      width = newWidth > 0 ? newWidth : 0;
                    }
                  });
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
                onDrag: (dx, dy) {
                  setState(() {
                    final newHeight = height - dy;
                    if (top + dy > 0) {
                      height = newHeight > 0 ? newHeight : 0;
                      top += dy;
                    }
                  });
                },
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
                onDrag: (dx, dy) {
                  setState(() {
                    final newHeight = height + dy;
                    height = newHeight > 0 ? newHeight : 0;
                  });
                },
              ),
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
                  setState(() {
                    final newHeight = height + dy;
                    height = newHeight > 0 ? newHeight : 0;
                    final newWidth = width - dx;
                    if (left + dx > 0) {
                      left += dx;
                      width = newWidth > 0 ? newWidth : 0;
                    }
                  });
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
                onDrag: (dx, dy) {
                  setState(() {
                    final newWidth = width - dx;
                    if (left + dx > 0) {
                      left += dx;
                      width = newWidth > 0 ? newWidth : 0;
                    }
                  });
                },
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
                onDrag: (dx, dy) {
                  setState(() {
                    final newWidth = width + dx;
                    if (newWidth + left < currentConstraints!.maxWidth - 70) {
                      width = newWidth > 0 ? newWidth : 0;
                    }
                  });
                },
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
