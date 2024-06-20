import 'package:example/new/stage/stage.dart';
import 'package:flutter/widgets.dart';

class StageConstraintsHandles extends StatefulWidget {
  const StageConstraintsHandles({
    super.key,
    required this.rect,
    required this.onPanUpdate,
    required this.onPanStart,
  });

  final Rect rect;
  final void Function(DragUpdateDetails, Alignment alignment) onPanUpdate;
  final void Function(DragDownDetails details) onPanStart;

  @override
  State<StageConstraintsHandles> createState() => _StageConstraintsHandlesState();
}

class _StageConstraintsHandlesState extends State<StageConstraintsHandles> {
  final double mouseArea = 20.0;
  final double padding = 4.0;

  bool _hovered = false;
  bool _dragged = false;

  @override
  Widget build(BuildContext context) {
    return StageRect(
      rect: widget.rect.inflate(style.ballSize + mouseArea + padding),
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
                padding: const EdgeInsets.all(20.0),
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
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
  });

  final Alignment alignment;
  final void Function(DragDownDetails)? onPanStart;
  final void Function(DragUpdateDetails, Alignment alignment)? onPanUpdate;
  final void Function(DragEndDetails)? onPanEnd;

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
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xFF949393),
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
