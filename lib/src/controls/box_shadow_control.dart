import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_collapsible_section.dart';
import 'package:stage_craft/src/widgets/stage_craft_color_picker.dart';
import 'package:stage_craft/src/widgets/stage_craft_hover_control.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

/// A control to modify a BoxShadow parameter of the widget on stage.
class BoxShadowControl extends ValueControl<BoxShadow> {
  /// Creates a BoxShadow control.
  BoxShadowControl({
    required super.initialValue,
    required super.label,
  })  : _shadowColor = initialValue.color,
        _blurStyle = initialValue.blurStyle;

  late final TextEditingController _offsetXController = TextEditingController(text: value.offset.dx.toString());
  late final TextEditingController _offsetYController = TextEditingController(text: value.offset.dy.toString());
  late final TextEditingController _blurRadiusController = TextEditingController(text: value.blurRadius.toString());
  late final TextEditingController _spreadRadiusController = TextEditingController(text: value.spreadRadius.toString());

  Color _shadowColor;
  BlurStyle _blurStyle;

  // Expansion state for sections
  bool _advancedExpanded = false;

  void _updateShadow() {
    final offsetX = double.tryParse(_offsetXController.text) ?? 0;
    final offsetY = double.tryParse(_offsetYController.text) ?? 0;
    final blurRadius = double.tryParse(_blurRadiusController.text) ?? 0;
    final spreadRadius = double.tryParse(_spreadRadiusController.text) ?? 0;

    value = BoxShadow(
      color: _shadowColor,
      offset: Offset(offsetX, offsetY),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      blurStyle: _blurStyle,
    );
  }

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Core properties - always visible
          _BoxShadowCoreSection(
            color: _shadowColor,
            offsetXController: _offsetXController,
            offsetYController: _offsetYController,
            onColorChanged: (color) {
              _shadowColor = color;
              _updateShadow();
            },
            onOffsetChanged: _updateShadow,
          ),

          const SizedBox(height: 8),

          // Advanced section - collapsible
          StageCraftCollapsibleSection(
            title: 'Advanced',
            isExpanded: _advancedExpanded,
            onToggle: () {
              _advancedExpanded = !_advancedExpanded;
              notifyListeners();
            },
            child: _advancedExpanded
                ? _BoxShadowAdvancedSection(
                    blurRadiusController: _blurRadiusController,
                    spreadRadiusController: _spreadRadiusController,
                    blurStyle: _blurStyle,
                    onRadiusChanged: _updateShadow,
                    onBlurStyleChanged: (style) {
                      _blurStyle = style;
                      _updateShadow();
                    },
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

/// Widget for color input.
class _BoxShadowColorInput extends StatelessWidget {
  const _BoxShadowColorInput({
    required this.color,
    required this.onColorChanged,
  });

  final Color color;
  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Color',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        const SizedBox(width: 8),
        StageCraftColorPicker(
          initialColor: color,
          onColorSelected: onColorChanged,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 24,
                width: 48,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget for offset input.
class _BoxShadowOffsetInput extends StatelessWidget {
  const _BoxShadowOffsetInput({
    required this.offsetXController,
    required this.offsetYController,
    required this.onChanged,
  });

  final TextEditingController offsetXController;
  final TextEditingController offsetYController;
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
                'X',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                'Y',
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
                controller: offsetXController,
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: StageCraftTextField(
                controller: offsetYController,
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget for blur and spread radius input.
class _BoxShadowRadiusInput extends StatelessWidget {
  const _BoxShadowRadiusInput({
    required this.blurRadiusController,
    required this.spreadRadiusController,
    required this.onChanged,
  });

  final TextEditingController blurRadiusController;
  final TextEditingController spreadRadiusController;
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
                'Blur',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                'Spread',
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
                controller: blurRadiusController,
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: StageCraftTextField(
                controller: spreadRadiusController,
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget for blur style input.
class _BoxShadowBlurStyleInput extends StatelessWidget {
  const _BoxShadowBlurStyleInput({
    required this.blurStyle,
    required this.onBlurStyleChanged,
  });

  final BlurStyle blurStyle;
  final ValueChanged<BlurStyle> onBlurStyleChanged;

  @override
  Widget build(BuildContext context) {
    return StageCraftHoverControl(
      child: DropdownButton<BlurStyle>(
        style: Theme.of(context).textTheme.labelSmall,
        borderRadius: BorderRadius.circular(4),
        value: blurStyle,
        onChanged: (BlurStyle? newStyle) {
          if (newStyle != null) {
            onBlurStyleChanged(newStyle);
          }
        },
        isDense: true,
        itemHeight: null,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        underline: const SizedBox(),
        isExpanded: true,
        items: const [
          DropdownMenuItem(
            value: BlurStyle.normal,
            child: Text('Normal'),
          ),
          DropdownMenuItem(
            value: BlurStyle.solid,
            child: Text('Solid'),
          ),
          DropdownMenuItem(
            value: BlurStyle.outer,
            child: Text('Outer'),
          ),
          DropdownMenuItem(
            value: BlurStyle.inner,
            child: Text('Inner'),
          ),
        ],
      ),
    );
  }
}

/// Widget for core BoxShadow properties (always visible).
class _BoxShadowCoreSection extends StatelessWidget {
  const _BoxShadowCoreSection({
    required this.color,
    required this.offsetXController,
    required this.offsetYController,
    required this.onColorChanged,
    required this.onOffsetChanged,
  });

  final Color color;
  final TextEditingController offsetXController;
  final TextEditingController offsetYController;
  final ValueChanged<Color> onColorChanged;
  final VoidCallback onOffsetChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Color
        Row(
          children: [
            Expanded(
              child: Text(
                'Color',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(width: 8),
            StageCraftColorPicker(
              initialColor: color,
              onColorSelected: onColorChanged,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 24,
                    width: 48,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),

        // Offset
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'X',
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: StageCraftTextField(
                          controller: offsetXController,
                          onChanged: (_) => onOffsetChanged(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Y',
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: StageCraftTextField(
                          controller: offsetYController,
                          onChanged: (_) => onOffsetChanged(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget for advanced BoxShadow properties.
class _BoxShadowAdvancedSection extends StatelessWidget {
  const _BoxShadowAdvancedSection({
    required this.blurRadiusController,
    required this.spreadRadiusController,
    required this.blurStyle,
    required this.onRadiusChanged,
    required this.onBlurStyleChanged,
  });

  final TextEditingController blurRadiusController;
  final TextEditingController spreadRadiusController;
  final BlurStyle blurStyle;
  final VoidCallback onRadiusChanged;
  final ValueChanged<BlurStyle> onBlurStyleChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Blur and spread radius
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Blur',
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Spread',
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
                    controller: blurRadiusController,
                    onChanged: (_) => onRadiusChanged(),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: StageCraftTextField(
                    controller: spreadRadiusController,
                    onChanged: (_) => onRadiusChanged(),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),

        // Blur style
        StageCraftHoverControl(
          child: DropdownButton<BlurStyle>(
            style: Theme.of(context).textTheme.labelSmall,
            borderRadius: BorderRadius.circular(4),
            value: blurStyle,
            onChanged: (BlurStyle? newStyle) {
              if (newStyle != null) {
                onBlurStyleChanged(newStyle);
              }
            },
            isDense: true,
            itemHeight: null,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            underline: const SizedBox(),
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                value: BlurStyle.normal,
                child: Text('Normal'),
              ),
              DropdownMenuItem(
                value: BlurStyle.solid,
                child: Text('Solid'),
              ),
              DropdownMenuItem(
                value: BlurStyle.outer,
                child: Text('Outer'),
              ),
              DropdownMenuItem(
                value: BlurStyle.inner,
                child: Text('Inner'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A control to modify a nullable BoxShadow parameter of the widget on stage.
class BoxShadowControlNullable extends ValueControl<BoxShadow?> {
  /// Creates a nullable BoxShadow control.
  BoxShadowControlNullable({
    super.initialValue,
    required super.label,
  })  : _shadowColor = initialValue?.color ?? const BoxShadow().color,
        _blurStyle = initialValue?.blurStyle ?? BlurStyle.normal;

  late final TextEditingController _offsetXController = TextEditingController(text: value?.offset.dx.toString() ?? '');
  late final TextEditingController _offsetYController = TextEditingController(text: value?.offset.dy.toString() ?? '');
  late final TextEditingController _blurRadiusController =
      TextEditingController(text: value?.blurRadius.toString() ?? '');
  late final TextEditingController _spreadRadiusController =
      TextEditingController(text: value?.spreadRadius.toString() ?? '');

  Color _shadowColor;
  BlurStyle _blurStyle;

  void _updateShadow() {
    final offsetX = double.tryParse(_offsetXController.text);
    final offsetY = double.tryParse(_offsetYController.text);
    final blurRadius = double.tryParse(_blurRadiusController.text);
    final spreadRadius = double.tryParse(_spreadRadiusController.text);

    if (offsetX != null || offsetY != null || blurRadius != null || spreadRadius != null) {
      value = BoxShadow(
        color: _shadowColor,
        offset: Offset(offsetX ?? 0, offsetY ?? 0),
        blurRadius: blurRadius ?? 0,
        spreadRadius: spreadRadius ?? 0,
        blurStyle: _blurStyle,
      );
    } else {
      value = null;
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
          // Color picker
          _BoxShadowColorInputNullable(
            color: _shadowColor,
            onColorChanged: (color) {
              _shadowColor = color;
              _updateShadow();
            },
          ),
          const SizedBox(height: 4),
          // Offset controls
          _BoxShadowOffsetInputNullable(
            offsetXController: _offsetXController,
            offsetYController: _offsetYController,
            onChanged: _updateShadow,
          ),
          const SizedBox(height: 4),
          // Blur and spread radius
          _BoxShadowRadiusInputNullable(
            blurRadiusController: _blurRadiusController,
            spreadRadiusController: _spreadRadiusController,
            onChanged: _updateShadow,
          ),
          const SizedBox(height: 4),
          // Blur style
          _BoxShadowBlurStyleInputNullable(
            blurStyle: _blurStyle,
            onBlurStyleChanged: (style) {
              _blurStyle = style;
              _updateShadow();
            },
          ),
        ],
      ),
    );
  }
}

/// Widget for nullable color input.
class _BoxShadowColorInputNullable extends StatelessWidget {
  const _BoxShadowColorInputNullable({
    required this.color,
    required this.onColorChanged,
  });

  final Color color;
  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Color',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        const SizedBox(width: 8),
        StageCraftColorPicker(
          initialColor: color,
          onColorSelected: onColorChanged,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 24,
                width: 48,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget for nullable offset input.
class _BoxShadowOffsetInputNullable extends StatelessWidget {
  const _BoxShadowOffsetInputNullable({
    required this.offsetXController,
    required this.offsetYController,
    required this.onChanged,
  });

  final TextEditingController offsetXController;
  final TextEditingController offsetYController;
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
                'X',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                'Y',
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
                controller: offsetXController,
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: StageCraftTextField(
                controller: offsetYController,
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget for nullable blur and spread radius input.
class _BoxShadowRadiusInputNullable extends StatelessWidget {
  const _BoxShadowRadiusInputNullable({
    required this.blurRadiusController,
    required this.spreadRadiusController,
    required this.onChanged,
  });

  final TextEditingController blurRadiusController;
  final TextEditingController spreadRadiusController;
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
                'Blur',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                'Spread',
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
                controller: blurRadiusController,
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: StageCraftTextField(
                controller: spreadRadiusController,
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget for nullable blur style input.
class _BoxShadowBlurStyleInputNullable extends StatelessWidget {
  const _BoxShadowBlurStyleInputNullable({
    required this.blurStyle,
    required this.onBlurStyleChanged,
  });

  final BlurStyle blurStyle;
  final ValueChanged<BlurStyle> onBlurStyleChanged;

  @override
  Widget build(BuildContext context) {
    return StageCraftHoverControl(
      child: DropdownButton<BlurStyle>(
        style: Theme.of(context).textTheme.labelSmall,
        borderRadius: BorderRadius.circular(4),
        value: blurStyle,
        onChanged: (BlurStyle? newStyle) {
          if (newStyle != null) {
            onBlurStyleChanged(newStyle);
          }
        },
        isDense: true,
        itemHeight: null,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        underline: const SizedBox(),
        isExpanded: true,
        items: const [
          DropdownMenuItem(
            value: BlurStyle.normal,
            child: Text('Normal'),
          ),
          DropdownMenuItem(
            value: BlurStyle.solid,
            child: Text('Solid'),
          ),
          DropdownMenuItem(
            value: BlurStyle.outer,
            child: Text('Outer'),
          ),
          DropdownMenuItem(
            value: BlurStyle.inner,
            child: Text('Inner'),
          ),
        ],
      ),
    );
  }
}
