import 'package:flutter/material.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a String parameter for a widget on a [WidgetStage].
class StringFieldConfiguratorNullable extends FieldConfigurator<String?> {
  StringFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  late final TextEditingController _controller = TextEditingController(text: value);

  @override
  Widget builder(BuildContext context) {
    return FieldConfiguratorWidget(
      onNullTapped: () => updateValue(null),
      name: name,
      isNullable: true,
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
    );
  }
}

/// Represents a String parameter for a widget on a [WidgetStage].
class StringFieldConfigurator extends FieldConfigurator<String> {
  StringFieldConfigurator({
    required super.value,
    required super.name,
  });

  late final TextEditingController _controller = TextEditingController(text: value);

  @override
  Widget builder(BuildContext context) {
    return FieldConfiguratorWidget(
      name: name,
      isNullable: false,
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
    );
  }
}
