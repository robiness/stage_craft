import 'package:flutter/material.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/src/widget_stage.dart';

/// Represents a String parameter for a widget on a [WidgetStage].
class PaddingFieldConfigurator extends FieldConfigurator<EdgeInsets> {
  PaddingFieldConfigurator({
    required super.value,
    required super.name,
  });

  late final Map<String, TextEditingController> _controllerMap = {
    "left": TextEditingController(text: value.left.toString()),
    "top": TextEditingController(text: value.top.toString()),
    "right": TextEditingController(text: value.right.toString()),
    "bottom": TextEditingController(text: value.bottom.toString()),
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
  Widget builder(BuildContext context) {
    final textFields = _controllerMap.entries
        .map((entry) => _buildTextField(
              label: entry.key,
              controller: entry.value,
            ))
        .toList();

    return FieldConfiguratorWidget(
      name: name,
      isNullable: false,
      child: Column(
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
      ),
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
        value = createEdgeInsets();
        notifyListeners();
      },
    );
  }
}
