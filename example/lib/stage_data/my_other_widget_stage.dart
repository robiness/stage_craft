import 'package:example/my_other_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

class MyOtherWidgetStageData extends ChangeNotifier implements WidgetStageData {
  MyOtherWidgetStageData({
    required String text,
  }) : _text = text;

  String get text => _text;
  String _text;

  @override
  String get name => 'MyOtherWidget';

  @override
  Widget get widget {
    return MyOtherWidget(
      text: _text,
    );
  }

  @override
  List<Widget> get configurationFields {
    return [
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
    ];
  }
}
