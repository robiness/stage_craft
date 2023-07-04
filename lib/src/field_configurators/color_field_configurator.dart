import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:stage_craft/stage_craft.dart';

class ColorFieldConfigurator extends FieldConfigurator<Color> {
  ColorFieldConfigurator({
    required super.value,
    required super.name,
    this.colorSamples,
  });

  final List<ColorSample>? colorSamples;

  @override
  Widget build(BuildContext context) {
    return _ColorConfigurationWidget(
      value: value,
      updateValue: (Color? color) {
        updateValue(color ?? Colors.transparent);
      },
      colorSamples: colorSamples,
    );
  }
}

/// Represents a Color parameter for a widget on a [WidgetStage].
class ColorFieldConfiguratorNullable extends FieldConfigurator<Color?> {
  ColorFieldConfiguratorNullable({
    required super.value,
    required super.name,
    this.colorSamples,
  });

  final List<ColorSample>? colorSamples;

  @override
  Widget build(BuildContext context) {
    return _ColorConfigurationWidget(
      value: value,
      updateValue: updateValue,
      colorSamples: colorSamples,
    );
  }
}

class _ColorConfigurationWidget extends ConfigurationWidget<Color?> {
  const _ColorConfigurationWidget({
    required super.value,
    required super.updateValue,
    this.colorSamples,
  });

  final List<ColorSample>? colorSamples;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Color? color = value;
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text('Pick a color!'),
                  content: _ColorPicker(
                    color: color ?? Colors.white,
                    colorSamples: colorSamples,
                    onColorChanged: (newColor) {
                      setState(() {
                        color = newColor;
                      });
                    },
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Abort'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        updateValue(color);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Accept'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 38,
              width: 38,
              foregroundDecoration: BoxDecoration(
                // The actual color drawn over the chessboard pattern
                color: value,
              ),
              // The chessboard pattern
              child: const CustomPaint(
                foregroundPainter: ChessBoardPainter(
                  boxSize: 8,
                  // The color of the chessboard pattern
                  color: Colors.grey,
                ),
                child: ColoredBox(
                  // Background of the chessboard pattern
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChessBoardPainter extends CustomPainter {
  const ChessBoardPainter({
    required this.color,
    this.boxSize = 20,
  });

  final double boxSize;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final maxVerticalBoxes = size.height / boxSize + 1;
    final maxHorizontalBoxes = size.width / boxSize + 1;

    for (int verticalBoxIndex = 0; verticalBoxIndex < maxVerticalBoxes; verticalBoxIndex++) {
      for (int horizontalBoxIndex = 0;
          horizontalBoxIndex < maxHorizontalBoxes;
          horizontalBoxIndex = horizontalBoxIndex + 2) {
        // Add a boxSize offset for every second row
        final offset = (verticalBoxIndex % 2) * boxSize;
        canvas.drawRect(
          Rect.fromLTWH(
            horizontalBoxIndex * boxSize + offset,
            verticalBoxIndex * boxSize,
            boxSize,
            boxSize,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// A `_ColorPicker` widget presents a color picking interface with two modes of color selection.
///
/// The widget provides a complete color picker that allows free selection of any color. In addition,
/// it also presents a list of predefined color samples to quickly select from if [colorSamples] are provided.
///
/// ```
/// // Creating a _ColorPicker widget
/// _ColorPicker(
///   colorSamples: [ColorSample(color: Colors.blue, name: 'Blue')],
///   color: Colors.red,
///   onColorChanged: (color) {
///     print('Color changed to $color');
///   },
/// );
/// ```
class _ColorPicker extends StatelessWidget {
  /// Creates a `_ColorPicker`.
  ///
  /// The [colorSamples] parameter is a list of `ColorSample` objects, each representing a predefined color.
  /// This parameter is optional, if it's null or empty, no color samples will be displayed.
  ///
  /// The [color] parameter represents the currently selected color in the [ColorPicker]. If not provided,
  /// the color picker will default to white.
  ///
  /// The [onColorChanged] parameter is a callback that will be called when a new color is selected, either
  /// from the [ColorPicker] or from the color samples. This parameter is required.
  const _ColorPicker({
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
        ColorPicker(
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
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onColorChanged.call(sample.color),
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
/// // Creating a ColorSample
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
