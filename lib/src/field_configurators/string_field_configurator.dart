import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a String parameter for a widget on a [WidgetStage].
class StringFieldConfigurator extends FieldConfigurator<String> {
  StringFieldConfigurator({
    required super.value,
    required super.name,
  }) : _controller = TextEditingController(text: value);

  final TextEditingController _controller;

  @override
  Widget builder(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: Text('$name: ')),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            controller: _controller,
            onChanged: (String newValue) {
              value = newValue;
              notifyListeners();
            },
          ),
        ),
      ],
    );
  }
}
