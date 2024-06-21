import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stage_craft/src/_old/field_configurators/field_configurators.dart';

/// Represents a nullable EdgeInsets parameter for a widget on a [WidgetStage].
class PaddingFieldConfiguratorNullable extends FieldConfigurator<EdgeInsets?> {
  PaddingFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingFieldConfigurationWidget(
      configurator: this,
    );
  }
}

/// Represents an EdgeInsets parameter for a widget on a [WidgetStage].
class PaddingFieldConfigurator extends FieldConfigurator<EdgeInsets> {
  PaddingFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingFieldConfigurationWidget(
      configurator: this,
    );
  }
}

class PaddingFieldConfigurationWidget extends StatefulConfigurationWidget<EdgeInsets?> {
  const PaddingFieldConfigurationWidget({
    super.key,
    required super.configurator,
  });

  @override
  State<PaddingFieldConfigurationWidget> createState() => _PaddingFieldConfigurationWidgetState();
}

class _PaddingFieldConfigurationWidgetState extends State<PaddingFieldConfigurationWidget> {
  @override
  Widget build(BuildContext context) {
    final padding = widget.configurator.value ?? EdgeInsets.zero;
    return Column(
      children: [
        _PaddingField(
          value: padding.top,
          onChanged: (value) {
            setState(() {
              final newValue = padding.copyWith(top: value);
              widget.configurator.updateValue(newValue);
            });
          },
          label: 'top',
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PaddingField(
              value: padding.left,
              onChanged: (value) {
                setState(() {
                  final newValue = padding.copyWith(left: value);
                  widget.configurator.updateValue(newValue);
                });
              },
              label: 'left',
            ),
            const SizedBox(width: 8.0),
            _PaddingField(
              value: padding.right,
              onChanged: (value) {
                setState(() {
                  final newValue = padding.copyWith(right: value);
                  widget.configurator.updateValue(newValue);
                });
              },
              label: 'right',
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _PaddingField(
          value: padding.bottom,
          onChanged: (value) {
            setState(() {
              final newValue = padding.copyWith(bottom: value);
              widget.configurator.updateValue(newValue);
            });
          },
          label: 'bottom',
        ),
      ],
    );
  }
}

class _PaddingField extends StatefulWidget {
  const _PaddingField({
    required this.onChanged,
    required this.label,
    required this.value,
  });

  final String label;

  final double? value;
  final void Function(double) onChanged;

  @override
  State<_PaddingField> createState() => _PaddingFieldState();
}

class _PaddingFieldState extends State<_PaddingField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value?.toString());
  }

  @override
  void didUpdateWidget(covariant _PaddingField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && oldWidget.value != null) {
      setState(() {
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 60,
      child: FieldConfiguratorInputField(
        controller: _controller,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9,.]')),
        ],
        onChanged: (value) {
          final replacedComma = value.replaceAll(',', '.');
          widget.onChanged(double.tryParse(replacedComma) ?? 0);
        },
      ),
    );
  }
}
