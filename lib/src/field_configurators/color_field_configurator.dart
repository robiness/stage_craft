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

class ColorPickerField extends StatefulWidget {
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
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  Color? _initialColor;

  @override
  void initState() {
    super.initState();
    _initialColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    final border = () {
      if (widget.color == Colors.transparent || widget.color == null) {
        return Border.all(color: Colors.grey[600]!);
      }
    }();
    return FieldConfiguratorWidget(
      onNullTapped: () {
        widget.onChanged(null);
      },
      name: widget.name,
      isNullable: widget.isNullable,
      child: GestureDetector(
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Pick a color!'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: widget.color ?? Colors.transparent,
                    onColorChanged: widget.onChanged,
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      widget.onChanged.call(_initialColor);
                      Navigator.of(context).pop();
                    },
                  ),
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
            color: widget.color,
            borderRadius: BorderRadius.circular(8),
            border: border,
          ),
        ),
      ),
    );
  }
}
