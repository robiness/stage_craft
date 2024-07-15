import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/stage_craft_color_picker.dart';

/// A control to modify a color parameter of the widget on stage.
class ColorControl extends ValueControl<Color> {
  /// Creates a color control.
  ColorControl({
    required super.label,
    required super.initialValue,
    this.colorSamples,
  });

  /// The color samples to be displayed in the color picker.
  final List<ColorSample>? colorSamples;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: StageCraftColorPicker(
        initialColor: value,
        onColorSelected: (color) {
          value = color;
        },
        colorSamples: colorSamples,
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
                foregroundPainter: _ChessBoardPainter(
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

/// A control to modify a nullable color parameter of the widget on stage.
class ColorControlNullable extends ValueControl<Color?> {
  /// Creates a nullable color control.
  ColorControlNullable({
    required super.label,
    required super.initialValue,
    required this.colorSamples,
  });

  /// The color samples to be displayed in the color picker.
  final List<ColorSample> colorSamples;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: StageCraftColorPicker(
        initialColor: value,
        onColorSelected: (color) {
          value = color;
        },
        colorSamples: colorSamples,
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
                foregroundPainter: _ChessBoardPainter(
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

class _ChessBoardPainter extends CustomPainter {
  const _ChessBoardPainter({
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
