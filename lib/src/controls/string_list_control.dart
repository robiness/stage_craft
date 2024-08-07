import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

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
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            ...value.mapIndexed((index, e) {
              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: StageCraftTextField(
                        controller: TextEditingController(text: e)
                          ..selection = TextSelection.collapsed(offset: e.length),
                        onChanged: (value) {
                          final newList = this.value;
                          newList[index] = value;
                          this.value = newList;
                        },
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        value = value..removeAt(index);
                      },
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(width: 32),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 2),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                value = value..add(defaultValue);
              },
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 32),
            ),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
