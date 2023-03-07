import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a bool parameter for a widget on a [WidgetStage].
class BoolFieldConfigurator extends FieldConfigurator<bool> {
  BoolFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget builder(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: Text('$name: ')),
        Expanded(
          child: Switch(
            value: value,
            activeColor: Colors.green,
            onChanged: (bool newValue) {
              value = newValue;
              notifyListeners();
            },
          ),
        ),
      ],
    );
  }
}
