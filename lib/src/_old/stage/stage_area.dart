import 'package:flutter/material.dart';
import 'package:stage_craft/src/_old/stage/stage_controller.dart';
import 'package:stage_craft/src/_old/stage/stage_craft.dart';
import 'package:stage_craft/src/_old/stage/stage_settings.dart';

class StageArea extends StatefulWidget {
  const StageArea({
    super.key,
    required this.stageController,
    required this.settings,
  });

  final StageController stageController;
  final StageCraftSettings settings;

  @override
  State<StageArea> createState() => _StageAreaState();
}

class _StageAreaState extends State<StageArea> {
  late double handleBallSize = widget.stageController.scale(widget.settings.handleBallSize);

  late final List<StageHandle> handles = [
    // top left
    StageHandle(
      position: (stagePosition, stageSize) {
        return Offset(
          stagePosition.dx - handleBallSize / 2,
          stagePosition.dy - handleBallSize / 2,
        );
      },
      onDrag: ({
        required double dx,
        required double dy,
        required StageController controller,
      }) {
        _dragLeft(dx: dx, controller: controller);
        _dragUp(dy: dy, controller: controller);
      },
    ),
    // top center
    StageHandle(
      position: (stagePosition, stageSize) {
        return Offset(
          (stagePosition.dx + stageSize.width / 2) - handleBallSize / 2,
          stagePosition.dy - handleBallSize / 2,
        );
      },
      onDrag: ({
        required double dx,
        required double dy,
        required StageController controller,
      }) {
        _dragUp(dy: dy, controller: controller);
      },
    ),
    //top right
    StageHandle(
      position: (stagePosition, stageSize) {
        return Offset(
          (stagePosition.dx + stageSize.width) - handleBallSize / 2,
          stagePosition.dy - handleBallSize / 2,
        );
      },
      onDrag: ({
        required double dx,
        required double dy,
        required StageController controller,
      }) {
        _dragRight(dx: dx, controller: controller);
        _dragUp(dy: dy, controller: controller);
      },
    ),
    //right center
    StageHandle(
      position: (stagePosition, stageSize) {
        return Offset(
          (stagePosition.dx + stageSize.width) - handleBallSize / 2,
          (stagePosition.dy + stageSize.height / 2) - handleBallSize / 2,
        );
      },
      onDrag: ({
        required double dx,
        required double dy,
        required StageController controller,
      }) {
        _dragRight(dx: dx, controller: controller);
      },
    ),
    //right bottom
    StageHandle(
      position: (stagePosition, stageSize) {
        return Offset(
          (stagePosition.dx + stageSize.width) - handleBallSize / 2,
          (stagePosition.dy + stageSize.height) - handleBallSize / 2,
        );
      },
      onDrag: ({
        required double dx,
        required double dy,
        required StageController controller,
      }) {
        _dragRight(dx: dx, controller: controller);
        _dragDown(dy: dy, controller: controller);
      },
    ),
    // bottom center
    StageHandle(
      position: (stagePosition, stageSize) {
        return Offset(
          (stagePosition.dx + stageSize.width / 2) - handleBallSize / 2,
          (stagePosition.dy + stageSize.height) - handleBallSize / 2,
        );
      },
      onDrag: ({
        required double dx,
        required double dy,
        required StageController controller,
      }) {
        _dragDown(dy: dy, controller: controller);
      },
    ),
    // bottom left
    StageHandle(
      position: (stagePosition, stageSize) {
        return Offset(
          (stagePosition.dx) - handleBallSize / 2,
          (stagePosition.dy + stageSize.height) - handleBallSize / 2,
        );
      },
      onDrag: ({
        required double dx,
        required double dy,
        required StageController controller,
      }) {
        _dragLeft(dx: dx, controller: controller);
        _dragDown(dy: dy, controller: controller);
      },
    ),
    // left center
    StageHandle(
      position: (stagePosition, stageSize) {
        return Offset(
          (stagePosition.dx) - handleBallSize / 2,
          (stagePosition.dy + stageSize.height / 2) - handleBallSize / 2,
        );
      },
      onDrag: ({
        required double dx,
        required double dy,
        required StageController controller,
      }) {
        _dragLeft(dx: dx, controller: controller);
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    widget.stageController.addListener(() {
      setState(() {
        handleBallSize = widget.stageController.scale(widget.settings.handleBallSize);
      });
    });
    // center the stage in the middle of the available space
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.stageController.centerStage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              // TODO we might want to use a RenderObject to get the constraints
              widget.stageController.stageConstraints = constraints;
              return InteractiveViewer(
                minScale: 0.1,
                maxScale: 5,
                transformationController: widget.stageController.transformationController,
                scaleEnabled: false,
                child: SizedBox(
                  height: constraints.maxHeight * 10,
                  width: constraints.maxWidth * 10,
                  child: CustomPaint(
                    painter: GridRaster(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: widget.stageController.stagePosition.dx,
                          top: widget.stageController.stagePosition.dy,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              widget.stageController.stagePosition = Offset(
                                widget.stageController.stagePosition.dx + details.delta.dx,
                                widget.stageController.stagePosition.dy + details.delta.dy,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: widget.stageController.backgroundColor,
                              ),
                              height: widget.stageController.stageSize.height,
                              width: widget.stageController.stageSize.width,
                              child: widget.stageController.selectedWidget?.widgetBuilder(context),
                            ),
                          ),
                        ),
                        if (widget.stageController.showBalls)
                          ...handles.map((handle) {
                            return StageHandleBall(
                              handle: handle,
                              controller: widget.stageController,
                              size: handleBallSize,
                              color: widget.settings.handleBallColor,
                              onDragStart: () => widget.stageController.isDragging = true,
                              onDragEnd: () {
                                widget.stageController.isDragging = false;
                              },
                            );
                          }),
                        Positioned(
                          top: widget.stageController.stagePosition.dy +
                              widget.stageController.stageSize.height -
                              handleBallSize / 2 +
                              widget.stageController.scale(40),
                          left: widget.stageController.stagePosition.dx -
                              handleBallSize / 2 +
                              widget.stageController.scale(10),
                          child: StageSizeIndicator(
                            controller: widget.stageController,
                          ),
                        ),
                        ShowBallsArea(
                          stageController: widget.stageController,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: StageSettingsWidget(
              stageController: widget.stageController,
            ),
          ),
        ],
      ),
    );
  }

  void _dragLeft({required double dx, required StageController controller}) {
    final newWidth = controller.stageSize.width - dx;
    if (controller.stagePosition.dx + dx > 0 && newWidth > 0) {
      controller.stagePosition =
          Offset(controller.stagePosition.dx + dx / 2, controller.stagePosition.dy); // Adjust the stage position
      final newSize = Size(newWidth > 0 ? newWidth : 0, controller.stageSize.height);
      controller.resizeStage(newSize);
    }
  }

  void _dragRight({required double dx, required StageController controller}) {
    final newWidth = controller.stageSize.width + dx;
    if (newWidth + controller.stagePosition.dx < controller.scale(controller.stageConstraints!.maxWidth) - 50) {
      final newSize = Size(newWidth > 0 ? newWidth : 0, controller.stageSize.height);
      controller.resizeStage(newSize);
    }
  }

  void _dragUp({required double dy, required StageController controller}) {
    final newHeight = controller.stageSize.height - dy;
    if (controller.stagePosition.dy + dy > 0 && newHeight > 0) {
      final newSize = Size(controller.stageSize.width, newHeight > 0 ? newHeight : 0);
      controller.resizeStage(newSize);

      controller.stagePosition = Offset(controller.stagePosition.dx, controller.stagePosition.dy + dy);
    }
  }

  void _dragDown({required double dy, required StageController controller}) {
    final newHeight = controller.stageSize.height + dy;
    if (newHeight + controller.stagePosition.dy < controller.scale(controller.stageConstraints!.maxHeight) - 50) {
      final newSize = Size(controller.stageSize.width, newHeight > 0 ? newHeight : 0);
      controller.resizeStage(newSize);
    }
  }
}

class ShowBallsArea extends StatelessWidget {
  const ShowBallsArea({
    super.key,
    required this.stageController,
  });

  final StageController stageController;

  static const int extension = 25;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: stageController.stagePosition.dy - extension,
      left: stageController.stagePosition.dx - extension,
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (_) {
          stageController.showBalls = true;
        },
        onExit: (_) {
          if (stageController.isDragging == false) {
            stageController.showBalls = false;
          }
        },
        child: SizedBox(
          height: stageController.stageSize.height + extension * 2,
          width: stageController.stageSize.width + extension * 2,
        ),
      ),
    );
  }
}

class StageHandleBall extends StatelessWidget {
  const StageHandleBall({
    super.key,
    required this.handle,
    required this.controller,
    required this.size,
    required this.color,
    this.onDragStart,
    this.onDragEnd,
  });

  final StageHandle handle;
  final StageController controller;
  final double size;
  final Color color;
  final VoidCallback? onDragStart;
  final VoidCallback? onDragEnd;

  @override
  Widget build(BuildContext context) {
    final position = handle.position(controller.stagePosition, controller.stageSize);
    return Positioned(
      top: position.dy,
      left: position.dx,
      child: MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: GestureDetector(
          onPanStart: (_) {
            onDragStart?.call();
          },
          onPanEnd: (_) {
            onDragEnd?.call();
          },
          onPanUpdate: (details) {
            handle.onDrag(
              dx: details.delta.dx * 2,
              dy: details.delta.dy * 2,
              controller: controller,
            );
          },
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class StageHandle {
  final Offset Function(Offset stagePosition, Size stageSize) position;
  final void Function({
    required double dx,
    required double dy,
    required StageController controller,
  }) onDrag;

  StageHandle({
    required this.position,
    required this.onDrag,
  });
}

class GridRaster extends CustomPainter {
  final rasterPaint = Paint()..color = const Color(0xFF646464).withOpacity(0.2);

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < size.width; i += 100) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        rasterPaint,
      );
    }
    for (var i = 0; i < size.height; i += 100) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        rasterPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GridRaster oldDelegate) {
    return false;
  }
}

class StageSizeIndicator extends StatefulWidget {
  const StageSizeIndicator({super.key, required this.controller});

  final StageController controller;

  @override
  State<StageSizeIndicator> createState() => _StageSizeIndicatorState();
}

class _StageSizeIndicatorState extends State<StageSizeIndicator> {
  bool get _showEditButtons => _fieldsHaveFocus || _hovered;
  bool _fieldsHaveFocus = false;
  bool _hovered = false;

  late final TextEditingController _widthController;
  late final TextEditingController _heightController;

  final FocusNode _widthFocusNode = FocusNode();
  final FocusNode _heightFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _widthController = TextEditingController()..text = widget.controller.stageSize.width.toInt().toString();
    _heightController = TextEditingController()..text = widget.controller.stageSize.height.toInt().toString();
    widget.controller.addListener(_updateController);
    _widthFocusNode.addListener(_textFieldsHaveFocus);
    _heightFocusNode.addListener(_textFieldsHaveFocus);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateController);
    _widthFocusNode.removeListener(_textFieldsHaveFocus);
    _heightFocusNode.removeListener(_textFieldsHaveFocus);
    _heightController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  void _textFieldsHaveFocus() {
    setState(() {
      _fieldsHaveFocus = _widthFocusNode.hasFocus || _heightFocusNode.hasFocus;
    });
  }

  void _updateController() {
    setState(() {
      _widthController.text = widget.controller.stageSize.width.toInt().toString();
      _heightController.text = widget.controller.stageSize.height.toInt().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
        });
      },
      child: SizedBox(
        width: 300 * (1 / widget.controller.zoom),
        height: 40 * (1 / widget.controller.zoom),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 24 * (1 / widget.controller.zoom),
            right: 24 * (1 / widget.controller.zoom),
          ),
          child: _showEditButtons
              ? Row(
                  children: [
                    SizeInput(
                      controller: _heightController,
                      focusNode: _heightFocusNode,
                      stageController: widget.controller,
                      onSubmitted: (value) {
                        final newSize = Size(
                          widget.controller.stageSize.width,
                          double.tryParse(value) ?? 0,
                        );
                        widget.controller.resizeStage(newSize);
                      },
                      isHovered: _showEditButtons,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0 * (1 / widget.controller.zoom)),
                      child: Text(
                        'x',
                        style: TextStyle(fontSize: 14 * (1 / widget.controller.zoom)),
                      ),
                    ),
                    SizeInput(
                      controller: _widthController,
                      stageController: widget.controller,
                      focusNode: _widthFocusNode,
                      onSubmitted: (value) {
                        final newSize = Size(
                          double.tryParse(value) ?? 0,
                          widget.controller.stageSize.height,
                        );
                        widget.controller.resizeStage(newSize);
                      },
                      isHovered: _showEditButtons,
                    ),
                  ],
                )
              : Text(
                  '${widget.controller.stageSize.height.toInt()} x ${widget.controller.stageSize.width.toInt()}',
                  style: TextStyle(
                    fontSize: 12 * (1 / widget.controller.zoom),
                  ),
                ),
        ),
      ),
    );
  }
}

class SizeInput extends StatelessWidget {
  const SizeInput({
    super.key,
    required this.isHovered,
    required this.controller,
    required this.onSubmitted,
    required this.focusNode,
    required this.stageController,
  });

  final bool isHovered;
  final void Function(String value) onSubmitted;
  final TextEditingController controller;
  final StageController stageController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60 * (1 / stageController.zoom),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: isHovered ? Colors.blue.withOpacity(0.5) : Colors.transparent,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0 * (1 / stageController.zoom)),
        child: TextField(
          focusNode: focusNode,
          style: TextStyle(
            fontSize: 12 * (1 / stageController.zoom),
          ),
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
          ),
          controller: controller,
          onEditingComplete: () {
            onSubmitted(controller.text);
          },
        ),
      ),
    );
  }
}
