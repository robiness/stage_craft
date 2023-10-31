import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stage_craft/stage_craft.dart';

/// Represents a offset parameter for a widget on a [WidgetStage].
class OffsetFieldConfigurator extends FieldConfigurator<Offset> {
  OffsetFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return OffsetFieldConfigurationWidget(
      configurator: this,
      updateValue: (value) {
        updateValue(value ?? Offset.zero);
      },
    );
  }
}

class OffsetFieldConfigurationWidget extends StatefulConfigurationWidget<Offset?> {
  const OffsetFieldConfigurationWidget({
    super.key,
    required super.configurator,
    required super.updateValue,
  });

  @override
  State<OffsetFieldConfigurationWidget> createState() => _OffsetFieldConfigurationWidgetState();
}

class _OffsetFieldConfigurationWidgetState extends State<OffsetFieldConfigurationWidget> {
  late final TextEditingController _xController;
  late final TextEditingController _yController;

  @override
  void initState() {
    _xController = TextEditingController(
      text: widget.configurator.value?.dx.toString(),
    );
    _yController = TextEditingController(
      text: widget.configurator.value?.dy.toString(),
    );
    widget.configurator.addListener(() {
      if (widget.configurator.value == null) {
        _xController.text = '';
        _yController.text = '';
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('x'),
            const SizedBox(width: 8),
            _OffsetTextField(
              controller: _xController,
              onChanged: (value) {
                widget.updateValue(
                  Offset(
                    double.tryParse(value) ?? 0.0,
                    widget.configurator.value!.dy,
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            const Text('y'),
            const SizedBox(width: 8),
            _OffsetTextField(
              controller: _yController,
              onChanged: (value) {
                widget.updateValue(
                  Offset(
                    widget.configurator.value!.dx,
                    double.tryParse(value) ?? 0.0,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _OffsetTextField extends StatelessWidget {
  const _OffsetTextField({
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: FieldConfiguratorInputField(
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('-?[0-9.,]')),
        ],
        onChanged: (value) {
          final replacedComma = value.replaceAll(',', '.');
          onChanged?.call(replacedComma);
        },
      ),
    );
  }
}
