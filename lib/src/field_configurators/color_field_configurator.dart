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
    return ColorConfigurationWidget(
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
    return ColorConfigurationWidget(
      value: value,
      updateValue: updateValue,
      colorSamples: colorSamples,
    );
  }
}

class ColorConfigurationWidget extends ConfigurationWidget<Color?> {
  const ColorConfigurationWidget({
    super.key,
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
                    onColorChanged: (newColor) => setState(() => color = newColor),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Abort'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                      child: const Text('Accept'),
                      onPressed: () {
                        updateValue(color);
                        Navigator.of(context).pop();
                      },
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

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({
    this.colorSamples,
    this.color,
    required this.onColorChanged,
  });

  final List<ColorSample>? colorSamples;
  final Color? color;
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
                    onTap: () => onColorChanged(sample.color),
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

class ColorSample {
  const ColorSample({
    required this.color,
    this.name,
  });
  final String? name;
  final Color color;
}
