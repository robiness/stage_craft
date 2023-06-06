import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stage_craft/src/widget_stage.dart';

class FieldConfiguratorWidget<T> extends StatelessWidget {
  const FieldConfiguratorWidget({
    super.key,
    required this.fieldConfigurator,
    required this.child,
  });

  final Widget child;
  final FieldConfigurator fieldConfigurator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${fieldConfigurator.name}:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (fieldConfigurator.isNullable) ...[
                  NullableButton(
                    fieldConfigurator: fieldConfigurator,
                  ),
                  const SizedBox(width: 4.0),
                ],
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NullableButton extends StatefulWidget {
  const NullableButton({
    super.key,
    required this.fieldConfigurator,
  });

  final FieldConfigurator fieldConfigurator;

  @override
  State<NullableButton> createState() => _NullableButtonState();
}

class _NullableButtonState extends State<NullableButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isNull = widget.fieldConfigurator.value == null;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.fieldConfigurator.updateValue(null),
        child: Container(
          decoration: BoxDecoration(
            color: isNull || _isHovering ? Colors.blue.withOpacity(0.2) : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: isNull ? Colors.blue : Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Center(
              child: Text(
                'null',
                textScaleFactor: 0.6,
                style: TextStyle(color: isNull ? Colors.blue : Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

abstract class ConfigurationWidget<T> extends StatelessWidget {
  const ConfigurationWidget({
    super.key,
    required this.value,
    required this.updateValue,
  });

  final T value;
  final void Function(T newValue) updateValue;
}

abstract class StatefulConfigurationWidget<T> extends StatefulWidget {
  const StatefulConfigurationWidget({
    super.key,
    required this.value,
    required this.updateValue,
  });

  final T value;
  final void Function(T newValue) updateValue;
}

class FieldConfiguratorInputField extends StatefulWidget {
  const FieldConfiguratorInputField({
    super.key,
    required this.controller,
    this.inputFormatters,
    this.onChanged,
  });

  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final void Function(String value)? onChanged;

  @override
  State<FieldConfiguratorInputField> createState() => _FieldConfiguratorInputFieldState();
}

class _FieldConfiguratorInputFieldState extends State<FieldConfiguratorInputField> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: SizedBox(
        height: 30,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: _isHovering ? Colors.blue.withOpacity(0.5) : Colors.transparent,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
              inputFormatters: widget.inputFormatters,
              keyboardType: TextInputType.number,
              controller: widget.controller,
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
