import 'package:flutter/material.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a nullable int parameter for a widget on a [WidgetStage].
class IntFieldConfiguratorNullable extends FieldConfigurator<int?> {
  IntFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return IntFieldConfigurationWidget(
      value: value,
      updateValue: updateValue,
    );
  }
}

/// Represents a int parameter for a widget on a [WidgetStage].
class IntFieldConfigurator extends FieldConfigurator<int> {
  IntFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return IntFieldConfigurationWidget(
      value: value,
      updateValue: (value) {
        updateValue(value ?? 0);
      },
    );
  }
}

class IntFieldConfigurationWidget extends StatefulConfigurationWidget<int?> {
  const IntFieldConfigurationWidget({
    super.key,
    required super.value,
    required super.updateValue,
  });

  @override
  State<IntFieldConfigurationWidget> createState() => _IntFieldConfigurationWidgetState();
}

class _IntFieldConfigurationWidgetState extends State<IntFieldConfigurationWidget> {
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
          int.tryParse(newValue),
        );
      },
    );
  }
}
