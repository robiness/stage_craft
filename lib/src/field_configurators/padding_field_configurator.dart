import 'package:flutter/material.dart';
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
      updateValue: (value) {
        updateValue(value ?? EdgeInsets.zero);
      },
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
  late final Map<String, TextEditingController> _controllerMap = {
    "left": TextEditingController(text: widget.value?.left.toString()),
    "top": TextEditingController(text: widget.value?.top.toString()),
    "right": TextEditingController(text: widget.value?.right.toString()),
    "bottom": TextEditingController(text: widget.value?.bottom.toString()),
  };

  EdgeInsets createEdgeInsets() {
    final controllers = _controllerMap.values.toList();
    final doubles = controllers.map((controller) => double.tryParse(controller.text) ?? 0.0).toList();
    return EdgeInsets.only(
      left: doubles.first,
      top: doubles[1],
      right: doubles[2],
      bottom: doubles.last,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textFields = _controllerMap.entries
        .map(
          (entry) => _buildTextField(
            label: entry.key,
            controller: entry.value,
          ),
        )
        .toList();

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: textFields.first,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: textFields[1],
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: textFields[2],
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: textFields.last,
            ),
          ],
        ),
      ],
    );
  }

  TextField _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      controller: controller,
      onChanged: (String newValue) {
        widget.updateValue(createEdgeInsets());
      },
    );
  }
}
