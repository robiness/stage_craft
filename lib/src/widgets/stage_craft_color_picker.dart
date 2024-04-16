import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

/// A color picking interface that provides an enhanced color selection experience
/// using the FlexColorPicker library and integration with StageCraft widgets.
///
/// This widget provides a dialog-based color picker that allows the user to select a color either
/// from a wheel or from predefined custom color swatches. It supports color selection with
/// optional opacity and displays color names and codes.
///
/// Example usage:
/// ```dart
/// StageCraftColorPicker(
///   colorSamples: [
///     ColorSample(color: Colors.blue, name: 'Ocean Blue'),
///   ],
///   initialColor: Colors.red,
///   onColorSelected: (color) {
///     print('Color selected: $color');
///   },
///   child: Text('Tap to pick a color'),
/// );
/// ```
class StageCraftColorPicker extends StatefulWidget {
  /// Creates a `StageCraftColorPicker` widget.
  ///
  /// The [colorSamples] parameter is a list of `ColorSample` objects, each representing a predefined color.
  /// This parameter is optional. If it's null or empty, no predefined color swatches will be displayed.
  ///
  /// The [child] parameter is required and typically holds a widget that triggers the color picker dialog.
  ///
  /// The [initialColor] parameter represents the initially selected color when the picker is opened.
  /// If not provided, it defaults to transparent.
  ///
  /// The [onColorSelected] parameter is a callback that will be called when a new color is selected.
  ///
  /// The [customColorTabLabel] parameter allows customization of the tab label in the color picker dialog.
  /// If not provided, it defaults to 'Default'.
  const StageCraftColorPicker({
    super.key,
    this.colorSamples,
    required this.child,
    this.initialColor = Colors.transparent,
    this.onColorSelected,
    this.customColorTabLabel,
  });

  /// List of predefined color samples. Can be null.
  final List<ColorSample>? colorSamples;

  /// The widget displayed that triggers the color picker when interacted with.
  final Widget child;

  /// Initially selected color. Defaults to transparent if not provided.
  final Color initialColor;

  /// Callback that is called when a new color is selected.
  final void Function(Color color)? onColorSelected;

  /// Custom label for the color picker tab. Defaults to 'Default' if not provided.
  final String? customColorTabLabel;

  @override
  State<StageCraftColorPicker> createState() => _StageCraftColorPickerState();
}

class _StageCraftColorPickerState extends State<StageCraftColorPicker> {
  late final Map<ColorSwatch<Object>, String> _colorSwatches = {
    ColorTools.createPrimarySwatch(widget.initialColor): 'Initial Color',
  };

  @override
  void initState() {
    super.initState();
    if (widget.colorSamples?.isNotEmpty == true) {
      for (final sample in widget.colorSamples!) {
        _colorSwatches[ColorTools.createPrimarySwatch(sample.color)] =
            sample.name ?? '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final color = await showColorPickerDialog(
          context,
          widget.initialColor,
          customColorSwatchesAndNames: _colorSwatches,
          title: Text(
            'Pick a color!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          pickerTypeLabels: <ColorPickerType, String>{
            ColorPickerType.custom: widget.customColorTabLabel ?? 'Default',
          },
          heading: const SizedBox(height: 8.0),
          subheading: const SizedBox(height: 8.0),
          wheelSubheading: const SizedBox(height: 8.0),
          spacing: 2,
          showColorName: true,
          showMaterialName: true,
          runSpacing: 2,
          wheelDiameter: 165,
          enableOpacity: true,
          showColorCode: true,
          colorCodeHasColor: true,
          pickersEnabled: <ColorPickerType, bool>{
            ColorPickerType.wheel: true,
            ColorPickerType.custom: true,
          },
          constraints: const BoxConstraints(
            minHeight: 525,
            minWidth: 320,
            maxWidth: 320,
          ),
        );
        widget.onColorSelected?.call(color);
      },
      child: widget.child,
    );
  }
}

/// A ColorSample class represents a color sample with an optional name.
///
/// It contains a `Color` and an optional `String` to represent its according name.
///
/// Used as optional parameters in [ColorFieldConfigurator] and [ColorFieldConfiguratorNullable].
/// ```
/// Creating a ColorSample
/// const ColorSample sample = ColorSample(color: Colors.blue, name: "MyColors.blue");
/// ```
class ColorSample {
  /// Creates a `ColorSample`.
  ///
  /// The [color] parameter is required, and it represents the actual color of the sample.
  ///
  /// The [name] parameter is optional. It can be used to assign a specific name to the sample.
  const ColorSample({
    required this.color,
    this.name,
  });

  /// The name of the color sample, can be null.
  final String? name;

  /// The color of the color sample. This property is required and cannot be null.
  final Color color;
}
