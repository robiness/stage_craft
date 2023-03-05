import 'package:example/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_stage/widget_stage.dart';

class MyWidgetStageData extends ChangeNotifier implements WidgetStageData {
  MyWidgetStageData({
    required Color color,
    required String text,
    required double borderRadius,
  })  : _color = color,
        _text = text,
        _borderRadius = borderRadius;

  @override
  String get name => 'MyWidget';

  Color get color => _color;
  Color _color;

  String get text => _text;
  String _text;

  double get borderRadius => _borderRadius;
  double _borderRadius;

  @override
  Widget get widget {
    return MyWidget(
      color: _color,
      text: _text,
      borderRadius: _borderRadius,
    );
  }

  @override
  List<Widget> get configurationFields {
    return [
      ColorPickerField(
        color: _color,
        onChanged: (Color value) {
          _color = value;
          notifyListeners();
        },
      ),
      TextField(
        decoration: const InputDecoration(
          labelText: 'text',
        ),
        controller: TextEditingController(text: _text),
        onChanged: (String value) {
          _text = value;
          notifyListeners();
        },
      ),
      TextField(
        decoration: const InputDecoration(
          labelText: 'borderRadius',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (String value) {
          _borderRadius = double.parse(value);
          notifyListeners();
        },
      ),
    ];
  }
}
