import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stage_craft/stage_craft.dart';

export 'bool_field_configurator.dart';
export 'color_field_configurator.dart';
export 'double_field_configurator.dart';
export 'enum_field_configurator.dart';
export 'int_field_configurator.dart';
export 'offset_field_configurator.dart';
export 'padding_field_configurator.dart';
export 'string_field_configurator.dart';

/// Representing a single parameter of a widget on stage.
/// The [builder] returns a field for example a TextField to live update the widget.´
/// @see [StringFieldConfigurator] or [ColorFieldConfigurator]
abstract class FieldConfigurator<T> extends ChangeNotifier {
  FieldConfigurator({
    required this.value,
    required this.name,
  });

  T value;

  String name;

  bool get isNullable => null is T;

  void updateValue(T value) {
    this.value = value;
    notifyListeners();
  }

  Widget build(BuildContext context);
}

class FieldConfiguratorWidget<T> extends StatefulWidget {
  const FieldConfiguratorWidget({
    super.key,
    required this.fieldConfigurator,
    required this.child,
  });

  final Widget child;
  final FieldConfigurator fieldConfigurator;

  @override
  State<FieldConfiguratorWidget<T>> createState() =>
      _FieldConfiguratorWidgetState<T>();
}

class _FieldConfiguratorWidgetState<T>
    extends State<FieldConfiguratorWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${widget.fieldConfigurator.name}:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.fieldConfigurator.isNullable) ...[
                  NullableButton(
                    fieldConfigurator: widget.fieldConfigurator,
                  ),
                  const SizedBox(width: 4.0),
                ],
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
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
    required this.configurator,
    required this.updateValue,
  });

  final FieldConfigurator<T> configurator;
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
  State<FieldConfiguratorInputField> createState() =>
      _FieldConfiguratorInputFieldState();
}

class _FieldConfiguratorInputFieldState
    extends State<FieldConfiguratorInputField> {
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
              color: _isHovering
                  ? Colors.blue.withOpacity(0.5)
                  : Colors.transparent,
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
      cursor: isNull ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.fieldConfigurator.updateValue(null),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              color: isNull || _isHovering
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.transparent,
              border: Border.all(color: isNull ? Colors.blue : Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    'null',
                    style: TextStyle(
                      color: isNull ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
