import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_hover_control.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

/// The mode for creating EdgeInsets values.
enum EdgeInsetsMode {
  /// All sides have the same value.
  all,
  /// Symmetric horizontal and vertical values.
  symmetric,
  /// Custom values for each side.
  custom,
}

/// A control to modify an EdgeInsets parameter of the widget on stage.
class EdgeInsetsControl extends ValueControl<EdgeInsets> {
  /// Creates an EdgeInsets control.
  EdgeInsetsControl({
    required super.initialValue,
    required super.label,
  }) : _mode = _detectMode(initialValue);

  EdgeInsetsMode _mode;
  
  static EdgeInsetsMode _detectMode(EdgeInsets insets) {
    if (insets.left == insets.top && 
        insets.top == insets.right && 
        insets.right == insets.bottom) {
      return EdgeInsetsMode.all;
    } else if (insets.left == insets.right && insets.top == insets.bottom) {
      return EdgeInsetsMode.symmetric;
    } else {
      return EdgeInsetsMode.custom;
    }
  }

  late final TextEditingController _allController = 
      TextEditingController(text: _mode == EdgeInsetsMode.all ? value.left.toString() : '8');
  
  late final TextEditingController _horizontalController = 
      TextEditingController(text: _mode == EdgeInsetsMode.symmetric ? value.left.toString() : '8');
  late final TextEditingController _verticalController = 
      TextEditingController(text: _mode == EdgeInsetsMode.symmetric ? value.top.toString() : '8');
  
  late final TextEditingController _leftController = 
      TextEditingController(text: value.left.toString());
  late final TextEditingController _topController = 
      TextEditingController(text: value.top.toString());
  late final TextEditingController _rightController = 
      TextEditingController(text: value.right.toString());
  late final TextEditingController _bottomController = 
      TextEditingController(text: value.bottom.toString());

  void _updateFromMode() {
    switch (_mode) {
      case EdgeInsetsMode.all:
        final val = double.tryParse(_allController.text) ?? 0;
        value = EdgeInsets.all(val);
      case EdgeInsetsMode.symmetric:
        final horizontal = double.tryParse(_horizontalController.text) ?? 0;
        final vertical = double.tryParse(_verticalController.text) ?? 0;
        value = EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
      case EdgeInsetsMode.custom:
        final left = double.tryParse(_leftController.text) ?? 0;
        final top = double.tryParse(_topController.text) ?? 0;
        final right = double.tryParse(_rightController.text) ?? 0;
        final bottom = double.tryParse(_bottomController.text) ?? 0;
        value = EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
    }
  }

  void _updateControllersFromValue() {
    _leftController.text = value.left.toString();
    _topController.text = value.top.toString();
    _rightController.text = value.right.toString();
    _bottomController.text = value.bottom.toString();
    
    if (_mode == EdgeInsetsMode.all) {
      _allController.text = value.left.toString();
    } else if (_mode == EdgeInsetsMode.symmetric) {
      _horizontalController.text = value.left.toString();
      _verticalController.text = value.top.toString();
    }
  }

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mode selector
          StageCraftHoverControl(
            child: DropdownButton<EdgeInsetsMode>(
              style: Theme.of(context).textTheme.labelSmall,
              borderRadius: BorderRadius.circular(4),
              value: _mode,
              onChanged: (EdgeInsetsMode? newMode) {
                if (newMode != null) {
                  _mode = newMode;
                  _updateFromMode();
                  _updateControllersFromValue();
                }
              },
              isDense: true,
              itemHeight: null,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              underline: const SizedBox(),
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: EdgeInsetsMode.all,
                  child: Text('All'),
                ),
                DropdownMenuItem(
                  value: EdgeInsetsMode.symmetric,
                  child: Text('Symmetric'),
                ),
                DropdownMenuItem(
                  value: EdgeInsetsMode.custom,
                  child: Text('Custom'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Input fields based on mode
          if (_mode == EdgeInsetsMode.all)
            _EdgeInsetsAllInput(
              controller: _allController,
              onChanged: _updateFromMode,
            )
          else if (_mode == EdgeInsetsMode.symmetric)
            _EdgeInsetsSymmetricInput(
              horizontalController: _horizontalController,
              verticalController: _verticalController,
              onChanged: _updateFromMode,
            )
          else
            _EdgeInsetsCustomInput(
              topController: _topController,
              leftController: _leftController,
              rightController: _rightController,
              bottomController: _bottomController,
              onChanged: _updateFromMode,
            ),
        ],
      ),
    );
  }
}

/// Widget for all-sides input mode.
class _EdgeInsetsAllInput extends StatelessWidget {
  const _EdgeInsetsAllInput({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return StageCraftTextField(
      controller: controller,
      onChanged: (_) => onChanged(),
    );
  }
}

/// Widget for symmetric input mode.
class _EdgeInsetsSymmetricInput extends StatelessWidget {
  const _EdgeInsetsSymmetricInput({
    required this.horizontalController,
    required this.verticalController,
    required this.onChanged,
  });

  final TextEditingController horizontalController;
  final TextEditingController verticalController;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                'H',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: StageCraftTextField(
                  controller: horizontalController,
                  onChanged: (_) => onChanged(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Text(
                'V',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: StageCraftTextField(
                  controller: verticalController,
                  onChanged: (_) => onChanged(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget for custom input mode.
class _EdgeInsetsCustomInput extends StatelessWidget {
  const _EdgeInsetsCustomInput({
    required this.topController,
    required this.leftController,
    required this.rightController,
    required this.bottomController,
    required this.onChanged,
  });

  final TextEditingController topController;
  final TextEditingController leftController;
  final TextEditingController rightController;
  final TextEditingController bottomController;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top
        Row(
          children: [
            Text(
              'T',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: StageCraftTextField(
                controller: topController,
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        // Left and Right
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    'L',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: StageCraftTextField(
                      controller: leftController,
                      onChanged: (_) => onChanged(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'R',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: StageCraftTextField(
                      controller: rightController,
                      onChanged: (_) => onChanged(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        // Bottom
        Row(
          children: [
            Text(
              'B',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: StageCraftTextField(
                controller: bottomController,
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// A control to modify a nullable EdgeInsets parameter of the widget on stage.
class EdgeInsetsControlNullable extends ValueControl<EdgeInsets?> {
  /// Creates a nullable EdgeInsets control.
  EdgeInsetsControlNullable({
    super.initialValue,
    required super.label,
  }) : _mode = initialValue != null ? _detectMode(initialValue) : EdgeInsetsMode.all;

  EdgeInsetsMode _mode;
  
  static EdgeInsetsMode _detectMode(EdgeInsets insets) {
    if (insets.left == insets.top && 
        insets.top == insets.right && 
        insets.right == insets.bottom) {
      return EdgeInsetsMode.all;
    } else if (insets.left == insets.right && insets.top == insets.bottom) {
      return EdgeInsetsMode.symmetric;
    } else {
      return EdgeInsetsMode.custom;
    }
  }

  late final TextEditingController _allController = 
      TextEditingController(text: value != null && _mode == EdgeInsetsMode.all ? value!.left.toString() : '');
  
  late final TextEditingController _horizontalController = 
      TextEditingController(text: value != null && _mode == EdgeInsetsMode.symmetric ? value!.left.toString() : '');
  late final TextEditingController _verticalController = 
      TextEditingController(text: value != null && _mode == EdgeInsetsMode.symmetric ? value!.top.toString() : '');
  
  late final TextEditingController _leftController = 
      TextEditingController(text: value?.left.toString() ?? '');
  late final TextEditingController _topController = 
      TextEditingController(text: value?.top.toString() ?? '');
  late final TextEditingController _rightController = 
      TextEditingController(text: value?.right.toString() ?? '');
  late final TextEditingController _bottomController = 
      TextEditingController(text: value?.bottom.toString() ?? '');

  void _updateFromMode() {
    switch (_mode) {
      case EdgeInsetsMode.all:
        final val = double.tryParse(_allController.text);
        value = val != null ? EdgeInsets.all(val) : null;
      case EdgeInsetsMode.symmetric:
        final horizontal = double.tryParse(_horizontalController.text);
        final vertical = double.tryParse(_verticalController.text);
        if (horizontal != null || vertical != null) {
          value = EdgeInsets.symmetric(
            horizontal: horizontal ?? 0, 
            vertical: vertical ?? 0,
          );
        } else {
          value = null;
        }
      case EdgeInsetsMode.custom:
        final left = double.tryParse(_leftController.text);
        final top = double.tryParse(_topController.text);
        final right = double.tryParse(_rightController.text);
        final bottom = double.tryParse(_bottomController.text);
        if (left != null || top != null || right != null || bottom != null) {
          value = EdgeInsets.only(
            left: left ?? 0, 
            top: top ?? 0, 
            right: right ?? 0, 
            bottom: bottom ?? 0,
          );
        } else {
          value = null;
        }
    }
  }

  void _updateControllersFromValue() {
    _leftController.text = value?.left.toString() ?? '';
    _topController.text = value?.top.toString() ?? '';
    _rightController.text = value?.right.toString() ?? '';
    _bottomController.text = value?.bottom.toString() ?? '';
    
    if (_mode == EdgeInsetsMode.all) {
      _allController.text = value?.left.toString() ?? '';
    } else if (_mode == EdgeInsetsMode.symmetric) {
      _horizontalController.text = value?.left.toString() ?? '';
      _verticalController.text = value?.top.toString() ?? '';
    }
  }

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mode selector
          StageCraftHoverControl(
            child: DropdownButton<EdgeInsetsMode>(
              style: Theme.of(context).textTheme.labelSmall,
              borderRadius: BorderRadius.circular(4),
              value: _mode,
              onChanged: (EdgeInsetsMode? newMode) {
                if (newMode != null) {
                  _mode = newMode;
                  _updateFromMode();
                  _updateControllersFromValue();
                }
              },
              isDense: true,
              itemHeight: null,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              underline: const SizedBox(),
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: EdgeInsetsMode.all,
                  child: Text('All'),
                ),
                DropdownMenuItem(
                  value: EdgeInsetsMode.symmetric,
                  child: Text('Symmetric'),
                ),
                DropdownMenuItem(
                  value: EdgeInsetsMode.custom,
                  child: Text('Custom'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Input fields based on mode
          if (_mode == EdgeInsetsMode.all)
            _EdgeInsetsAllInputNullable(
              controller: _allController,
              onChanged: _updateFromMode,
            )
          else if (_mode == EdgeInsetsMode.symmetric)
            _EdgeInsetsSymmetricInputNullable(
              horizontalController: _horizontalController,
              verticalController: _verticalController,
              onChanged: _updateFromMode,
            )
          else
            _EdgeInsetsCustomInputNullable(
              topController: _topController,
              leftController: _leftController,
              rightController: _rightController,
              bottomController: _bottomController,
              onChanged: _updateFromMode,
            ),
        ],
      ),
    );
  }
}

/// Widget for nullable all-sides input mode.
class _EdgeInsetsAllInputNullable extends StatelessWidget {
  const _EdgeInsetsAllInputNullable({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return StageCraftTextField(
      controller: controller,
      onChanged: (_) => onChanged(),
    );
  }
}

/// Widget for nullable symmetric input mode.
class _EdgeInsetsSymmetricInputNullable extends StatelessWidget {
  const _EdgeInsetsSymmetricInputNullable({
    required this.horizontalController,
    required this.verticalController,
    required this.onChanged,
  });

  final TextEditingController horizontalController;
  final TextEditingController verticalController;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'H',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                'V',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Expanded(
              child: StageCraftTextField(
                controller: horizontalController,
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: StageCraftTextField(
                controller: verticalController,
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget for nullable custom input mode.
class _EdgeInsetsCustomInputNullable extends StatelessWidget {
  const _EdgeInsetsCustomInputNullable({
    required this.topController,
    required this.leftController,
    required this.rightController,
    required this.bottomController,
    required this.onChanged,
  });

  final TextEditingController topController;
  final TextEditingController leftController;
  final TextEditingController rightController;
  final TextEditingController bottomController;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top
        StageCraftTextField(
          controller: topController,
          onChanged: (_) => onChanged(),
        ),
        const SizedBox(height: 2),
        // Left and Right
        Row(
          children: [
            Expanded(
              child: StageCraftTextField(
                controller: leftController,
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: StageCraftTextField(
                controller: rightController,
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        // Bottom
        StageCraftTextField(
          controller: bottomController,
          onChanged: (_) => onChanged(),
        ),
      ],
    );
  }
}
