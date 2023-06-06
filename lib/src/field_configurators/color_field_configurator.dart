import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:stage_craft/src/field_configurators/field_configurator_widget.dart';
import 'package:stage_craft/stage_craft.dart';

class ColorFieldConfigurator extends FieldConfigurator<Color> {
  ColorFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return ColorConfigurationWidget(
      configurator: this,
      updateValue: (Color? color) {
        updateValue(color ?? Colors.transparent);
      },
    );
  }
}

/// Represents a Color parameter for a widget on a [WidgetStage].
class ColorFieldConfiguratorNullable extends FieldConfigurator<Color?> {
  ColorFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return ColorConfigurationWidget(
      configurator: this,
      updateValue: updateValue,
    );
  }
}

class ColorConfigurationWidget extends StatefulConfigurationWidget<Color?> {
  const ColorConfigurationWidget({
    super.key,
    required super.configurator,
    required super.updateValue,
  });

  @override
  State<ColorConfigurationWidget> createState() => _ColorConfigurationFieldState();
}

class _ColorConfigurationFieldState extends State<ColorConfigurationWidget> {
  late Color? color = widget.configurator.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: color ?? Colors.white,
                  onColorChanged: (newColor) {
                    color = newColor;
                  },
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Abort'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Accept'),
                  onPressed: () {
                    widget.updateValue(color);
                    Navigator.of(context).pop();
                  },
                ),
              ],
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
                color: widget.configurator.value,
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
