import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a Color parameter for a widget on a [WidgetStage].
class ColorFieldConfigurator extends FieldConfigurator<Color> {
  ColorFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget builder(BuildContext context) {
    return ColorPickerField(
      color: value,
      onChanged: (Color color) {
        value = color;
        notifyListeners();
      },
    );
  }
}

class ColorPickerField extends StatelessWidget {
  const ColorPickerField({
    Key? key,
    required this.color,
    required this.onChanged,
  }) : super(key: key);

  final Color color;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text('color')),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: color,
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
