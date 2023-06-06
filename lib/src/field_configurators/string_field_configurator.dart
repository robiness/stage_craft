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
      configurator: this,
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
      configurator: this,
      updateValue: (value) {
        updateValue(value ?? '');
      },
    );
  }
}

class StringFieldConfigurationWidget extends StatefulConfigurationWidget<String?> {
  const StringFieldConfigurationWidget({
    super.key,
    required super.configurator,
    required super.updateValue,
  });

  @override
  State<StringFieldConfigurationWidget> createState() => _StringFieldConfigurationWidgetState();
}

class _StringFieldConfigurationWidgetState extends State<StringFieldConfigurationWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
      text: widget.configurator.value.toString(),
    );
    widget.configurator.addListener(() {
      if(widget.configurator.value == null) {
        _controller.text = '';
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FieldConfiguratorInputField(
      controller: _controller,
      onChanged: widget.updateValue,
    );
  }
}
