import 'package:flutter/material.dart';

class DiscreteResizableComponent extends StatefulWidget {
  const DiscreteResizableComponent({super.key, required this.child});

  final Widget child;
  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

const ballDiameter = 30.0;
const discreteStepSize = 1;

class _ResizableWidgetState extends State<DiscreteResizableComponent> {
  double height = 400;
  double width = 200;

  double top = 0;
  double left = 0;

  double cumulativeDy = 0;
  double cumulativeDx = 0;
  double cumulativeMid = 0;

  void onDrag(double dx, double dy) {
    final newHeight = height + dy;
    final newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: Container(
            height: height,
            width: width,
            color: Colors.black26,
            child: widget.child,
          ),
        ),
        // top left
        Positioned(
          top: top - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              final mid = (dx + dy) / 2;
              cumulativeMid -= 2 * mid;
              if (cumulativeMid >= discreteStepSize) {
                setState(() {
                  final newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  final newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  top -= discreteStepSize;
                  left -= discreteStepSize;

                  cumulativeMid = 0;
                });
              } else if (cumulativeMid <= -discreteStepSize) {
                setState(() {
                  final newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  final newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  top += discreteStepSize;
                  left += discreteStepSize;
                  cumulativeMid = 0;
                });
              }
            },
          ),
        ),
        // center center
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              // top
              // dy -
              //bottom
              // dy +
              cumulativeDy += dy;

              if (cumulativeDy >= discreteStepSize) {
                setState(() {
                  top += discreteStepSize;
                  cumulativeDy = 0;
                });
              } else if (cumulativeDy <= -discreteStepSize) {
                setState(() {
                  top -= discreteStepSize;
                  cumulativeDy = 0;
                });
              }
              // left -> -dx
              // right -> +dx
              cumulativeDx += dx;

              if (cumulativeDx >= discreteStepSize) {
                setState(() {
                  left += discreteStepSize;
                  cumulativeDx = 0;
                });
              } else if (cumulativeDx <= -discreteStepSize) {
                setState(() {
                  left -= discreteStepSize;
                  cumulativeDx = 0;
                });
              }
            },
          ),
        ),

        // top right
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              final mid = (dx + (dy * -1)) / 2;
              cumulativeMid += 2 * mid;
              if (cumulativeMid >= discreteStepSize) {
                setState(() {
                  final newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  final newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  top -= discreteStepSize;

                  cumulativeMid = 0;
                });
              } else if (cumulativeMid <= -discreteStepSize) {
                setState(() {
                  final newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  final newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  top += discreteStepSize;

                  cumulativeMid = 0;
                });
              }
            },
          ),
        ),

        // bottom right
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              final mid = (dx + dy) / 2;

              cumulativeMid += 2 * mid;
              if (cumulativeMid >= discreteStepSize) {
                setState(() {
                  final newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  final newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              } else if (cumulativeMid <= -discreteStepSize) {
                setState(() {
                  final newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  final newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeMid = 0;
                });
              }
            },
          ),
        ),
        // top middle
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              cumulativeDy -= dy;
              if (cumulativeDy >= discreteStepSize) {
                setState(() {
                  final newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  top -= discreteStepSize;

                  cumulativeDy = 0;
                });
              } else if (cumulativeDy <= -discreteStepSize) {
                setState(() {
                  final newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  top += discreteStepSize;

                  cumulativeDy = 0;
                });
              }
            },
          ),
        ),
        // bottom center
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              cumulativeDy += dy;

              if (cumulativeDy >= discreteStepSize) {
                setState(() {
                  final newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  cumulativeDy = 0;
                });
              } else if (cumulativeDy <= -discreteStepSize) {
                setState(() {
                  final newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  cumulativeDy = 0;
                });
              }
            },
          ),
        ),
        // bottom left
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              final mid = ((dx * -1) + dy) / 2;

              cumulativeMid += 2 * mid;
              if (cumulativeMid >= discreteStepSize) {
                setState(() {
                  final newHeight = height + discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  final newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  left -= discreteStepSize;
                  cumulativeMid = 0;
                });
              } else if (cumulativeMid <= -discreteStepSize) {
                setState(() {
                  final newHeight = height - discreteStepSize;
                  height = newHeight > 0 ? newHeight : 0;
                  final newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  left += discreteStepSize;
                  cumulativeMid = 0;
                });
              }
            },
          ),
        ),
        //left center
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              cumulativeDx -= dx;

              if (cumulativeDx >= discreteStepSize) {
                setState(() {
                  final newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;

                  left = left - discreteStepSize;

                  cumulativeDx = 0;
                });
              } else if (cumulativeDx <= -discreteStepSize) {
                setState(() {
                  final newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;

                  left = left + discreteStepSize;
                  cumulativeDx = 0;
                });
              }
            },
          ),
        ),
        // center right
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              cumulativeDx += dx;

              if (cumulativeDx >= discreteStepSize) {
                setState(() {
                  final newWidth = width + discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeDx = 0;
                });
              } else if (cumulativeDx <= -discreteStepSize) {
                setState(() {
                  final newWidth = width - discreteStepSize;
                  width = newWidth > 0 ? newWidth : 0;
                  cumulativeDx = 0;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  const ManipulatingBall({required this.onDrag});

  final Function(double, double) onDrag;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  double? initX;
  double? initY;

  _handleDrag(DragStartDetails details) {
    setState(() {
      initX = details.localPosition.dx;
      initY = details.localPosition.dy;
    });
  }

  _handleUpdate(DragUpdateDetails details) {
    final dx = details.localPosition.dx - initX!;
    final dy = details.localPosition.dy - initY!;
    initX = details.localPosition.dx;
    initY = details.localPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
