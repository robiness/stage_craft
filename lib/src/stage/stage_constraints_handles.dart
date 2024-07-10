import 'package:flutter/widgets.dart';
import 'package:stage_craft/src/stage/stage.dart';

class StageConstraintsHandles extends StatefulWidget {
  const StageConstraintsHandles({
    super.key,
    required this.rect,
    required this.onPanUpdate,
    required this.onPanStart,
    required this.currentScale,
  });

  final Rect rect;
  final void Function(DragUpdateDetails, Alignment alignment) onPanUpdate;
  final void Function(DragDownDetails details) onPanStart;
  final double currentScale;

  @override
  State<StageConstraintsHandles> createState() => _StageConstraintsHandlesState();
}

class _StageConstraintsHandlesState extends State<StageConstraintsHandles> {
  final double padding = 4.0;

  bool _hovered = false;
  bool _dragged = false;

  @override
  Widget build(BuildContext context) {
    return StageRect(
      rect: widget.rect.inflate(
        context.stageStyle.ballSize * (1 / widget.currentScale) +
            context.stageStyle.dragPadding * (1 / widget.currentScale) +
            padding,
      ),
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (event) {
          setState(() {
            _hovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            _hovered = false;
          });
        },
        child: !_hovered && !_dragged
            ? null
            : Padding(
                padding: EdgeInsets.all(20.0 * (1 / widget.currentScale)),
                child: Stack(
                  children: [
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
                      return StageConstraintHandle(
                        currentScale: widget.currentScale,
                        alignment: alignment,
                        onPanStart: (details) {
                          setState(() {
                            _dragged = true;
                          });
                          widget.onPanStart(details);
                        },
                        onPanUpdate: widget.onPanUpdate,
                        onPanEnd: (details) {
                          setState(() {
                            _dragged = false;
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
      ),
    );
  }
}

class StageConstraintHandle extends StatelessWidget {
  const StageConstraintHandle({
    super.key,
    required this.alignment,
    required this.currentScale,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
  });

  final Alignment alignment;
  final void Function(DragDownDetails)? onPanStart;
  final void Function(DragUpdateDetails, Alignment alignment)? onPanUpdate;
  final void Function(DragEndDetails)? onPanEnd;
  final double currentScale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: GestureDetector(
          onPanDown: (details) {
            onPanStart?.call(details);
          },
          onPanEnd: onPanEnd,
          onPanUpdate: (details) => onPanUpdate?.call(details, alignment),
          child: Container(
            width: context.stageStyle.ballSize * (1 / currentScale),
            height: context.stageStyle.ballSize * (1 / currentScale),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4 * (1 / currentScale)),
              border: Border.all(
                color: const Color(0xFF949393),
                width: 2 * (1 / currentScale),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
