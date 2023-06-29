import 'package:flutter/material.dart';
import 'package:stage_craft/src/field_configurators/field_configurator.dart';

class BoolFieldConfiguratorNullable extends FieldConfigurator<bool?> {
  BoolFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return BoolFieldConfigurationWidget(
      value: value,
      updateValue: updateValue,
    );
  }
}

/// Represents a bool parameter for a widget on a [WidgetStage].
class BoolFieldConfigurator extends FieldConfigurator<bool> {
  BoolFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget build(BuildContext context) {
    return BoolFieldConfigurationWidget(
      value: value,
      updateValue: (value) {
        updateValue(value ?? false);
      },
    );
  }
}

class BoolFieldConfigurationWidget extends ConfigurationWidget<bool?> {
  const BoolFieldConfigurationWidget({
    required super.value,
    required super.updateValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: BoolButton(
            isSelected: value == true,
            onTap: () => updateValue(true),
            label: 'true',
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: BoolButton(
            isSelected: value == false,
            onTap: () => updateValue(false),
            label: 'false',
          ),
        ),
      ],
    );
  }
}

class BoolButton extends StatefulWidget {
  const BoolButton({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.label,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String label;

  @override
  State<BoolButton> createState() => _BoolButtonState();
}

class _BoolButtonState extends State<BoolButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: widget.isSelected ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelected || _isHovering ? Colors.blue.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: widget.isSelected ? Colors.blue : Colors.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(color: widget.isSelected ? Colors.blue : Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
