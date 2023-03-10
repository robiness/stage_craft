import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a int parameter for a widget on a [WidgetStage].
class IntFieldConfigurator extends FieldConfigurator<int> {
  IntFieldConfigurator({
    required super.value,
    required super.name,
  });

  late final _textEditingController = TextEditingController(text: value.toString());

  @override
  Widget builder(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$name:'),
        const SizedBox(width: 8),
        Flexible(
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            controller: _textEditingController,
            onChanged: (String newValue) {
              value = int.tryParse(newValue) ?? 0;
              notifyListeners();
            },
          ),
        ),
      ],
    );
  }
}
