import 'package:flutter/material.dart';
import 'package:stage_craft/src/field_configurators/field_configurator_widget.dart';
import 'package:stage_craft/stage_craft.dart';

/// Represents a nullable String parameter for a widget on a [WidgetStage].
class StringFieldConfiguratorNullable extends FieldConfigurator<String?> {
  StringFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return StringFieldConfigurationWidget(
      value: value,
      updateValue: updateValue,
    );
  }
}

/// Represents a String parameter for a widget on a [WidgetStage].
class StringFieldConfigurator extends FieldConfigurator<String> {
  StringFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return StringFieldConfigurationWidget(
      value: value,
      updateValue: (value) {
        updateValue(value ?? '');
      },
    );
  }
}

class StringFieldConfigurationWidget extends StatefulConfigurationWidget<String?> {
  const StringFieldConfigurationWidget({
    super.key,
    required super.value,
    required super.updateValue,
  });

  @override
  State<StringFieldConfigurationWidget> createState() => _StringFieldConfigurationWidgetState();
}

class _StringFieldConfigurationWidgetState extends State<StringFieldConfigurationWidget> {
  late final TextEditingController _controller = TextEditingController(text: widget.value);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      controller: _controller,
      onChanged: widget.updateValue,
    );
  }
}
