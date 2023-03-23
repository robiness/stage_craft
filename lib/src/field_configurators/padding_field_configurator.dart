import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/src/widget_stage.dart';

/// Represents a nullable EdgeInsets parameter for a widget on a [WidgetStage].
class PaddingFieldConfiguratorNullable extends FieldConfigurator<EdgeInsets?> {
  PaddingFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingFieldConfigurationWidget(
      value: value,
      updateValue: updateValue,
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
      value: value,
      updateValue: (value) => updateValue(value ?? EdgeInsets.zero),
    );
  }
}

class PaddingFieldConfigurationWidget extends StatefulConfigurationWidget<EdgeInsets?> {
  const PaddingFieldConfigurationWidget({
    super.key,
    required super.value,
    required super.updateValue,
  });

  @override
  State<PaddingFieldConfigurationWidget> createState() => _PaddingFieldConfigurationWidgetState();
}

class _PaddingFieldConfigurationWidgetState extends State<PaddingFieldConfigurationWidget> {
  @override
  Widget build(BuildContext context) {
    final padding = widget.value ?? EdgeInsets.zero;
    return Column(
      children: [
        SizedBox(
          width: 80,
          child: _PaddingField(
            value: widget.value?.top,
            onChanged: (value) {
              setState(() {
                final newValue = padding.copyWith(top: value);
                widget.updateValue(newValue);
              });
            },
            label: 'top',
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60,
              child: _PaddingField(
                value: widget.value?.left,
                onChanged: (value) {
                  setState(() {
                    final newValue = padding.copyWith(left: value);
                    widget.updateValue(newValue);
                  });
                },
                label: 'left',
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 60,
              child: _PaddingField(
                value: widget.value?.right,
                onChanged: (value) {
                  setState(() {
                    final newValue = padding.copyWith(right: value);
                    widget.updateValue(newValue);
                  });
                },
                label: 'right',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: 80,
          child: _PaddingField(
            value: widget.value?.bottom,
            onChanged: (value) {
              setState(() {
                final newValue = padding.copyWith(bottom: value);
                widget.updateValue(newValue);
              });
            },
            label: 'bottom',
          ),
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
    return TextField(
      inputFormatters: <TextInputFormatter>[
        // Allow only digits, dot and 1 decimal
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?')),
      ],
      decoration: InputDecoration(
        labelText: widget.label,
        isDense: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      controller: _controller,
      onChanged: (value) {
        widget.onChanged.call(double.tryParse(value) ?? 0);
      },
    );
  }
}
