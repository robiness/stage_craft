import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stage_craft/src/_old/field_configurators/field_configurators.dart';

/// Represents a nullable double parameter for a widget on a [WidgetStage].
class DoubleFieldConfiguratorNullable extends FieldConfigurator<double?> {
  DoubleFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return DoubleFieldConfigurationWidget(
      configurator: this,
    );
  }
}

/// Represents a double parameter for a widget on a [WidgetStage].
class DoubleFieldConfigurator extends FieldConfigurator<double> {
  DoubleFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return DoubleFieldConfigurationWidget(
      configurator: this,
    );
  }
}

class DoubleFieldConfigurationWidget extends StatefulConfigurationWidget<double?> {
  const DoubleFieldConfigurationWidget({
    super.key,
    required super.configurator,
  });

  @override
  State<DoubleFieldConfigurationWidget> createState() => _DoubleFieldConfigurationWidgetState();
}

class _DoubleFieldConfigurationWidgetState extends State<DoubleFieldConfigurationWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
      text: widget.configurator.value.toString(),
    );
    widget.configurator.addListener(() {
      if (widget.configurator.value == null) {
        _controller.text = '';
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FieldConfiguratorInputField(
      controller: _controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('-?[0-9.,]')),
      ],
      onChanged: (value) {
        final replacedComma = value.replaceAll(',', '.');
        widget.configurator.updateValue(double.tryParse(replacedComma));
      },
    );
  }
}
