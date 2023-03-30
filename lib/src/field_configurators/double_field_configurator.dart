import 'package:flutter/material.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a nullable double parameter for a widget on a [WidgetStage].
class DoubleFieldConfiguratorNullable extends FieldConfigurator<double?> {
  DoubleFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return DoubleFieldConfigurationWidget(
      value: value,
      updateValue: updateValue,
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
      value: value,
      updateValue: (value) {
        updateValue(value ?? 0.0);
      },
    );
  }
}

class DoubleFieldConfigurationWidget extends StatefulConfigurationWidget<double?> {
  const DoubleFieldConfigurationWidget({
    super.key,
    required super.value,
    required super.updateValue,
  });

  @override
  State<DoubleFieldConfigurationWidget> createState() => _DoubleFieldConfigurationWidgetState();
}

class _DoubleFieldConfigurationWidgetState extends State<DoubleFieldConfigurationWidget> {
  // for example
  late final TextEditingController _controller = TextEditingController(text: widget.value.toString());

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
      onChanged: (newValue) {
        widget.updateValue(
          double.tryParse(newValue),
        );
      },
    );
  }
}
