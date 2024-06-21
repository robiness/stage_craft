import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/src/_old/field_configurators/field_configurators.dart';

class StringListConfigurator extends FieldConfigurator<List<String>> {
  StringListConfigurator({
    required super.value,
    required super.name,
    this.defaultValue,
  });

  final String? defaultValue;

  @override
  Widget build(BuildContext context) {
    return StringListConfiguratorWidget(
      configurator: this,
      defaultValue: defaultValue,
    );
  }
}

class StringListConfiguratorWidget extends StatefulConfigurationWidget<List<String>> {
  const StringListConfiguratorWidget({
    super.key,
    required super.configurator,
    this.defaultValue,
  });

  final String? defaultValue;

  @override
  State<StringListConfiguratorWidget> createState() => _StringListConfiguratorWidgetState();
}

class _StringListConfiguratorWidgetState extends State<StringListConfiguratorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.configurator.value.mapIndexed((index, e) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: FieldConfiguratorInputField(
                  controller: TextEditingController(text: e)..selection = TextSelection.collapsed(offset: e.length),
                  onChanged: (value) {
                    widget.configurator.value[index] = value;
                    widget.configurator.updateValue(widget.configurator.value);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  final newValue = widget.configurator.value;
                  newValue.removeAt(index);
                  widget.configurator.updateValue(newValue);
                },
              )
            ],
          );
        }),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            final newValue = widget.configurator.value;
            newValue.add(widget.defaultValue ?? 'new value');
            widget.configurator.updateValue(newValue);
          },
        ),
      ],
    );
  }
}
