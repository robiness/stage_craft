import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';

/// A control to modify a widget parameter of the widget on stage.
class WidgetControl extends ValueControl<Widget> {
  /// Creates a widget control.
  WidgetControl({
    required super.initialValue,
    required super.label,
  });

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: DropdownButton<Widget>(
        items: const [
          DropdownMenuItem(value: Text('Nicer Text'), child: Text('Text')),
          DropdownMenuItem(value: ColoredBox(color: Colors.red), child: Text('ColoredBox')),
          DropdownMenuItem(value: Icon(Icons.ac_unit), child: Text('Icon')),
        ],
        onChanged: (value) {
          this.value = value!;
        },
      ),
    );
  }
}

/// A control to modify a nullable widget parameter of the widget on stage.
class WidgetControlNullable extends ValueControl<Widget?> {
  /// Creates a widget control.
  WidgetControlNullable({
    super.initialValue,
    required super.label,
  });

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: DropdownButton<Widget>(
        items: const [
          DropdownMenuItem(value: Text('Nicer Text'), child: Text('Text')),
          DropdownMenuItem(value: ColoredBox(color: Colors.red), child: Text('ColoredBox')),
          DropdownMenuItem(value: Icon(Icons.ac_unit), child: Text('Icon')),
        ],
        onChanged: (value) {
          this.value = value;
        },
      ),
    );
  }
}
