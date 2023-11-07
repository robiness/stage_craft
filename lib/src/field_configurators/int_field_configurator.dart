import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stage_craft/stage_craft.dart';

/// Represents a nullable int parameter for a widget on a [WidgetStage].
class IntFieldConfiguratorNullable extends FieldConfigurator<int?> {
  IntFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return IntFieldConfigurationWidget<int?>(
      configurator: this,
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
    return IntFieldConfigurationWidget<int>(
      configurator: this,
    );
  }
}

class IntFieldConfigurationWidget<T> extends StatefulConfigurationWidget<T> {
  const IntFieldConfigurationWidget({
    super.key,
    required super.configurator,
  });

  @override
  State<IntFieldConfigurationWidget> createState() => _IntFieldConfigurationWidgetState();
}

class _IntFieldConfigurationWidgetState extends State<IntFieldConfigurationWidget> {
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
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        widget.configurator.updateValue(int.tryParse(value));
      },
    );
  }
}
