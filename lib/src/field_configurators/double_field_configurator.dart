import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a double parameter for a widget on a [WidgetStage].
class DoubleFieldConfigurator extends FieldConfigurator<double> {
  DoubleFieldConfigurator({
    required super.value,
    required super.name,
  });

  late final _textEditingController = TextEditingController(text: value.toString());

  @override
  Widget builder(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text('$name:')),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            controller: _textEditingController,
            onChanged: (String newValue) {
              value = double.tryParse(newValue) ?? 0;
              notifyListeners();
            },
          ),
        ),
      ],
    );
  }
}
