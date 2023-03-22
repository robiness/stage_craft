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
  Widget builder(BuildContext context) {
    return ColorPickerField(
      color: value,
      name: name,
      isNullable: false,
      onChanged: (Color? color) {
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
  Widget builder(BuildContext context) {
    return ColorPickerField(
      color: value,
      name: name,
      isNullable: true,
      onChanged: (Color? color) {
        value = color;
        notifyListeners();
      },
    );
  }
}

class ColorPickerField extends StatelessWidget {
  const ColorPickerField({
    super.key,
    required this.color,
    required this.onChanged,
    required this.name,
    required this.isNullable,
  });

  final Color? color;
  final ValueChanged<Color?> onChanged;
  final String name;
  final bool isNullable;

  @override
  Widget build(BuildContext context) {
    return FieldConfiguratorWidget(
      onNullTapped: () {
        onChanged(null);
      },
      name: name,
      isNullable: isNullable,
      child: GestureDetector(
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Pick a color!'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: color ?? Colors.transparent,
                    onColorChanged: onChanged,
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
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: color == Colors.transparent ? Border.all(color: Colors.grey[600]!) : null,
          ),
        ),
      ),
    );
  }
}
