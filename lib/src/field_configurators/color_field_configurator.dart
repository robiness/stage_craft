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
      updateValue: (Color? color) {
        value = color;
        notifyListeners();
      },
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
    final border = () {
      if (color == Colors.transparent || color == null) {
        return Border.all(color: Colors.grey[600]!);
      }
    }();
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: widget.value ?? Colors.transparent,
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
          color: widget.value,
          borderRadius: BorderRadius.circular(8),
          border: border,
        ),
      ),
    );
  }
}
