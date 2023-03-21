import 'package:flutter/material.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/widget_stage.dart';

class BoolFieldConfiguratorNullable extends FieldConfigurator<bool?> {
  BoolFieldConfiguratorNullable({
    required super.value,
    required super.name,
  });

  @override
  Widget builder(BuildContext context) {
    return FieldConfiguratorWidget(
      onNullTapped: () => updateValue(null),
      name: name,
      isNullable: true,
      child: _ToggleButtons(
        value: value,
        onChanged: updateValue,
      ),
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
  Widget builder(BuildContext context) {
    return FieldConfiguratorWidget(
      name: name,
      isNullable: false,
      child: _ToggleButtons(
        value: value,
        onChanged: (value) {
          // TODO CHECK IF FALLBACK IS CORRECT
          updateValue(value ?? false);
        },
      ),
    );
  }
}

class _ToggleButtons extends StatefulWidget {
  const _ToggleButtons({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool? value;
  final void Function(bool?) onChanged;

  @override
  State<_ToggleButtons> createState() => _ToggleButtonsState();
}

class _ToggleButtonsState extends State<_ToggleButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: _ToggleButton(
            isSelected: widget.value == true,
            onTap: () => widget.onChanged(true),
            label: 'True',
          ),
        ),
        Expanded(
          child: _ToggleButton(
            isSelected: widget.value == false,
            onTap: () => widget.onChanged(false),
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
        return Colors.blue;
      }
      return isHovered ? Colors.blue.withOpacity(0.3) : Colors.transparent;
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
