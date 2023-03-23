import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/widget_stage.dart';

class ColorFieldConfigurator extends FieldConfigurator<Color> {
  ColorFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return ColorConfigurationWidget(
      value: value,
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
      value: value,
      updateValue: updateValue,
    );
  }
}

class ColorConfigurationWidget extends StatefulConfigurationWidget<Color?> {
  const ColorConfigurationWidget({
    super.key,
    required super.value,
    required super.updateValue,
  });

  @override
  State<ColorConfigurationWidget> createState() => _ColorConfigurationFieldState();
}

class _ColorConfigurationFieldState extends State<ColorConfigurationWidget> {
  late Color? color = widget.value;

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
                  pickerColor: widget.value ?? Colors.white,
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
      child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomPaint(
              painter: ChessBoardPainter(
                boxSize: 8,
                color: widget.value,
                offset: Offset(-4, -8),
              ),
            ),
          )),
    );
  }
}

class ChessBoardPainter extends CustomPainter {
  const ChessBoardPainter({
    this.boxSize = 20,
    this.offset = Offset.zero,
    this.color,
  });

  final double boxSize;
  final Offset offset;
  final Color? color;

  @override
  void paint(Canvas canvas, Size size) {
    print(color);
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int vertical = 0; vertical < (size.height / boxSize) + 1; vertical++) {
      for (int horizontal = 0; horizontal < (size.width / boxSize) + 1; horizontal = horizontal + 2) {
        canvas.drawRect(
          Rect.fromLTWH(
            (horizontal.toDouble() * boxSize + boxSize * (vertical % 2)) + offset.dx,
            (vertical.toDouble() * boxSize) + offset.dy,
            boxSize,
            boxSize,
          ),
          paint,
        );
      }
    }
    canvas.drawColor(color ?? Colors.grey, BlendMode.hue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    print('should repaint');
    return true;
  }
}
