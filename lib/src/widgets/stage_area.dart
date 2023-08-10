import 'package:flutter/material.dart';
import 'package:stage_craft/src/stage_settings.dart';
import 'package:stage_craft/stage_craft.dart';

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
  BoxConstraints? _currentConstraints;
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
        widget.stageController.stagePosition = Offset(
          (_currentConstraints!.maxWidth / 2) - (widget.stageController.stageSize.width / 2),
          (_currentConstraints!.maxHeight / 2) - (widget.stageController.stageSize.height / 2),
        );
      });
    });
    // center the stage in the middle of the available space
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.stageController.stagePosition = Offset(
        (_currentConstraints!.maxWidth / 2) - (widget.stageController.stageSize.width / 2),
        (_currentConstraints!.maxHeight / 2) - (widget.stageController.stageSize.height / 2),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              _currentConstraints = constraints;
              return InteractiveViewer(
                minScale: 0.1,
                maxScale: 5,
                transformationController: widget.stageController.transformationController,
                scaleEnabled: false,
                constrained: false,
                child: SizedBox(
                  height: _currentConstraints!.maxHeight * 10,
                  width: _currentConstraints!.maxWidth * 10,
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
                                border: Border.all(
                                  color: Colors.grey,
                                ),
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
                        Positioned(
                          top: widget.stageController.stagePosition.dy,
                          left: widget.stageController.stagePosition.dx,
                          child: MouseRegion(
                            hitTestBehavior: HitTestBehavior.translucent,
                            onEnter: (_) {
                              widget.stageController.showBalls = true;
                            },
                            onExit: (_) {
                              setState(() {
                                if (widget.stageController.isDragging == false) {
                                  widget.stageController.showBalls = false;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(50),
                              child: SizedBox(
                                height: widget.stageController.stageSize.height,
                                width: widget.stageController.stageSize.width,
                              ),
                            ),
                          ),
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
              constraints: _currentConstraints,
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
      controller.stagePosition = Offset(controller.stagePosition.dx + dx, controller.stagePosition.dy);
      controller.stageSize = Size(newWidth > 0 ? newWidth : 0, controller.stageSize.height);
    }
  }

  void _dragRight({required double dx, required StageController controller}) {
    final newWidth = controller.stageSize.width + dx;
    if (newWidth + controller.stagePosition.dx < controller.scale(_currentConstraints!.maxWidth) - 50) {
      controller.stageSize = Size(newWidth > 0 ? newWidth : 0, controller.stageSize.height);
    }
  }

  void _dragUp({required double dy, required StageController controller}) {
    final newHeight = controller.stageSize.height - dy;
    if (controller.stagePosition.dy + dy > 0 && newHeight > 0) {
      controller.stageSize = Size(controller.stageSize.width, newHeight > 0 ? newHeight : 0);
      controller.stagePosition = Offset(controller.stagePosition.dx, controller.stagePosition.dy + dy);
    }
  }

  void _dragDown({required double dy, required StageController controller}) {
    final newHeight = controller.stageSize.height + dy;
    if (newHeight + controller.stagePosition.dy < controller.scale(_currentConstraints!.maxHeight) - 50) {
      controller.stageSize = Size(controller.stageSize.width, newHeight > 0 ? newHeight : 0);
    }
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
              dx: details.delta.dx,
              dy: details.delta.dy,
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
  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < size.width; i += 100) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        Paint()..color = const Color(0xFF646464).withOpacity(0.2),
      );
    }
    for (var i = 0; i < size.height; i += 100) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        Paint()..color = const Color(0xFF646464).withOpacity(0.2),
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
                        widget.controller.stageSize = Size(
                          widget.controller.stageSize.width,
                          double.tryParse(value) ?? 0,
                        );
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
                        widget.controller.stageSize = Size(
                          double.tryParse(value) ?? 0,
                          widget.controller.stageSize.height,
                        );
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
