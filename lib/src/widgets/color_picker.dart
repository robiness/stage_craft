import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as picker;

/// A color picking interface with two modes of color selection.
///
/// The widget provides a complete color picker that allows free selection of any color. In addition,
/// it also presents a list of predefined color samples to quickly select from if [colorSamples] are provided.
///
/// ```
/// Creating a ColorPicker widget
/// ColorPicker(
///   colorSamples: [ColorSample(color: Colors.blue, name: 'Blue')],
///   color: Colors.red,
///   onColorChanged: (color) {
///     print('Color changed to $color');
///   },
/// );
/// ```
class ColorPicker extends StatelessWidget {
  /// Creates a `ColorPicker`.
  ///
  /// The [colorSamples] parameter is a list of `ColorSample` objects, each representing a predefined color.
  /// This parameter is optional, if it's null or empty, no color samples will be displayed.
  ///
  /// The [color] parameter represents the currently selected color in the [ColorPicker]. If not provided,
  /// the color picker will default to white.
  ///
  /// The required [onColorChanged] parameter is a callback that will be called when a new color is selected.
  const ColorPicker({
    this.colorSamples,
    this.color,
    required this.onColorChanged,
  });

  /// List of color samples. Can be null.
  final List<ColorSample>? colorSamples;

  /// Currently selected color. Can be null, in which case the color picker defaults to white.
  final Color? color;

  /// Callback that is called when a new color is selected.
  final void Function(Color color) onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        picker.ColorPicker(
          pickerColor: color ?? Colors.white,
          onColorChanged: onColorChanged,
        ),
        if (colorSamples?.isNotEmpty == true) ...[
          const SizedBox(height: 32.0),
          const Text('Color Samples'),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 24,
            runSpacing: 10,
            children: colorSamples!.map(
              (sample) {
                return GestureDetector(
                  onTap: () => onColorChanged.call(sample.color),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: sample.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (sample.name != null) ...[
                          const SizedBox(height: 6.0),
                          Text(
                            sample.name!,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ]
      ],
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
