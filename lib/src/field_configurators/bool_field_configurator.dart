
import 'package:flutter/widgets.dart';
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
          child: _ToggleButton(
            isSelected: value == true,
            onTap: () => updateValue(true),
            label: 'True',
          ),
        ),
        Expanded(
          child: _ToggleButton(
            isSelected: value == false,
            onTap: () => updateValue(false),
            label: 'False',
          ),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.isSelected,
    required this.onTap,
    required this.label,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    bool isHovered = false;

    final fillColor = () {
      if (isSelected) {
        return const Color(0xFF195E96);
      }
      return isHovered ? const Color(0xFF195E96).withOpacity(0.3) : const Color(0x00000000);
    }();

    return MouseRegion(
      onEnter: (event) {
        isHovered = true;
      },
      onExit: (event) {
        isHovered = false;
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: fillColor,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
