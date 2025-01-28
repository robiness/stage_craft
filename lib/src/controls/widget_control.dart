import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';

/// A control to modify a widget parameter of the widget on stage.
class WidgetControl extends ValueControl<Widget> {
  /// Creates a widget control.
  WidgetControl({
    required super.label,
    Widget? initialValue,
  })  : _initialValue = initialValue,
        super(initialValue: initialValue ?? _textWidget);

  // We need to store it here since it can be null. If set we want to show it in the dropdown.
  final Widget? _initialValue;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: value,
          ),
          const SizedBox(),
          DropdownButton<Widget>(
            items: [
              if (_initialValue != null) DropdownMenuItem(value: _initialValue, child: const Text('Initial')),
              const DropdownMenuItem(value: _textWidget, child: Text('Text')),
              const DropdownMenuItem(value: ColoredBox(color: Colors.red), child: Text('ColoredBox')),
              const DropdownMenuItem(value: Icon(Icons.ac_unit), child: Text('Icon')),
            ],
            selectedItemBuilder: (context) {
              return [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: value,
                ),
              ];
            },
            onChanged: (value) {
              this.value = value!;
            },
          ),
        ],
      ),
    );
  }
}

/// A control to modify a nullable widget parameter of the widget on stage.
class WidgetControlNullable extends ValueControl<Widget?> {
  /// Creates a widget control.
  WidgetControlNullable({
    required super.label,
    Widget? initialValue,
  }) : super(initialValue: initialValue ?? _textWidget);

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: value,
          ),
          const SizedBox(),
          DropdownButton<Widget>(
            items: [
              if (initialValue != null) DropdownMenuItem(value: initialValue, child: const Text('Initial')),
              const DropdownMenuItem(value: _textWidget, child: Text('Text')),
              const DropdownMenuItem(value: ColoredBox(color: Colors.red), child: Text('ColoredBox')),
              const DropdownMenuItem(value: Icon(Icons.ac_unit), child: Text('Icon')),
            ],
            onChanged: (value) {
              this.value = value;
            },
          ),
        ],
      ),
    );
  }
}

const Center _textWidget = Center(child: Text('Text'));
