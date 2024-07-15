import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';

/// A control for a list of strings.
class StringListControl extends ValueControl<List<String>> {
  /// Creates a new [StringListControl].
  StringListControl({
    required super.label,
    required super.initialValue,
    this.defaultValue = '',
  });

  /// The default value to add when the user presses the add button.
  final String defaultValue;

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Column(
        children: [
          ...value.mapIndexed((index, e) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: e)..selection = TextSelection.collapsed(offset: e.length),
                    onChanged: (value) {
                      final newList = this.value;
                      newList[index] = value;
                      this.value = newList;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    value = value..removeAt(index);
                  },
                ),
              ],
            );
          }),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              value = value..add(defaultValue);
            },
          ),
        ],
      ),
    );
  }
}
