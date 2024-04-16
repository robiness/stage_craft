import 'package:flutter/material.dart';
import 'package:stage_craft/src/widgets/stage_craft_color_picker.dart';
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
    return StageCraftColorPicker(
      initialColor: value ?? Colors.transparent,
      onColorSelected: updateValue,
      colorSamples: colorSamples,
      customColorTabLabel: 'Custom',
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

    for (int verticalBoxIndex = 0;
        verticalBoxIndex < maxVerticalBoxes;
        verticalBoxIndex++) {
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
