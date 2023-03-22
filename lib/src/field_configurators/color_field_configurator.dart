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
    return ColorPickerField(
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
    return ColorPickerField(
      value: value,
      updateValue: (Color? color) {
        value = color;
        notifyListeners();
      },
    );
  }
}

class ColorPickerField extends ConfigurationWidget<Color?> {
  const ColorPickerField({
    super.key,
    required super.value,
    required super.updateValue,
  });

  @override
  Widget build(BuildContext context) {
    final border = () {
      if (value == Colors.transparent || value == null) {
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
                  pickerColor: value ?? Colors.transparent,
                  onColorChanged: updateValue,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Accept'),
                  onPressed: () {
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
          color: value,
          borderRadius: BorderRadius.circular(8),
          border: border,
        ),
      ),
    );
  }
}
