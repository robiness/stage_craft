import 'package:flutter/widgets.dart';
import 'package:stage_craft/src/stage/stage.dart';

/// A widget that displays the constraints handles for a [StageRect].
/// Used to modify the stages size and position.
class StageConstraintsHandles extends StatefulWidget {
  /// Creates a new [StageConstraintsHandles] widget.
  const StageConstraintsHandles({
    super.key,
    required this.rect,
    required this.onPanUpdate,
    required this.onPanStart,
    required this.currentScale,
  });

  /// The rect of the stage to be manipulated.
  final Rect rect;

  /// The callback that is called when the stage is being dragged.
  final void Function(DragUpdateDetails, Alignment alignment) onPanUpdate;

  /// The callback that is called when the stage is being dragged.
  final void Function(DragDownDetails details) onPanStart;

  /// The current scale of the stage.
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

/// A widget that displays a single constraint handle for a [StageRect].
class StageConstraintHandle extends StatelessWidget {
  /// Creates a new [StageConstraintHandle] widget.
  const StageConstraintHandle({
    super.key,
    required this.alignment,
    required this.currentScale,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
  });

  /// The alignment of the handle.
  final Alignment alignment;

  /// The callback that is called when the handle is being dragged.
  final void Function(DragDownDetails)? onPanStart;

  /// The callback that is called when the handle is being dragged.
  final void Function(DragUpdateDetails, Alignment alignment)? onPanUpdate;

  /// The callback that is called when the handle is being dragged.
  final void Function(DragEndDetails)? onPanEnd;

  /// The current scale of the stage.
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
