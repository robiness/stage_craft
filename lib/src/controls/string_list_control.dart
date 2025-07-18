import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';
import 'package:stage_craft/src/widgets/stage_craft_collapsible_section.dart';

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

  // Expansion state for sections
  bool _moreItemsExpanded = false;
  bool _advancedExpanded = false;

  // Number of items to show in core section
  static const int _coreItemsCount = 2;

  @override
  Widget builder(BuildContext context) {
    final coreItems = value.take(_coreItemsCount).toList();
    final additionalItems = value.length > _coreItemsCount ? value.skip(_coreItemsCount).toList() : <String>[];
    
    final hasExpandedSections = (_moreItemsExpanded && additionalItems.isNotEmpty) || (_advancedExpanded && value.isNotEmpty);
    
    return DefaultControlBarRow(
      control: this,
      child: Container(
        decoration: BoxDecoration(
          color: hasExpandedSections 
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.08)
            : Theme.of(context).canvasColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: hasExpandedSections 
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            width: hasExpandedSections ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Core items - always visible
            _StringListCoreSection(
              items: coreItems,
              onItemChanged: (index, newValue) {
                final newList = List<String>.from(value);
                newList[index] = newValue;
                value = newList;
              },
              onItemRemoved: (index) {
                final newList = List<String>.from(value);
                newList.removeAt(index);
                value = newList;
              },
              onAddItem: () {
                value = List<String>.from(value)..add(defaultValue);
              },
            ),
          
            // More items section - collapsible (only show if there are additional items)
            if (additionalItems.isNotEmpty) ...<Widget>[
              const SizedBox(height: 4),
              StageCraftCollapsibleSection(
                title: 'More Items (${additionalItems.length})',
                isExpanded: _moreItemsExpanded,
                onToggle: () {
                  _moreItemsExpanded = !_moreItemsExpanded;
                  notifyListeners();
                },
                child: _moreItemsExpanded ? _StringListAdditionalSection(
                  items: additionalItems,
                  startIndex: _coreItemsCount,
                  onItemChanged: (index, newValue) {
                    final newList = List<String>.from(value);
                    newList[index] = newValue;
                    value = newList;
                  },
                  onItemRemoved: (index) {
                    final newList = List<String>.from(value);
                    newList.removeAt(index);
                    value = newList;
                  },
                  onAddItem: () {
                    value = List<String>.from(value)..add(defaultValue);
                  },
                ) : null,
              ),
            ],
          
            // Advanced section - collapsible (only show if there are items)
            if (value.isNotEmpty) ...<Widget>[
              const SizedBox(height: 4),
              StageCraftCollapsibleSection(
                title: 'Advanced',
                isExpanded: _advancedExpanded,
                onToggle: () {
                  _advancedExpanded = !_advancedExpanded;
                  notifyListeners();
                },
                child: _advancedExpanded ? _StringListAdvancedSection(
                  itemCount: value.length,
                  onClearAll: () {
                    value = [];
                  },
                  onAddMultiple: () {
                    final newItems = List.generate(3, (index) => '$defaultValue ${value.length + index + 1}');
                    value = List<String>.from(value)..addAll(newItems);
                  },
                ) : null,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Widget for core StringList items (always visible).
class _StringListCoreSection extends StatelessWidget {
  const _StringListCoreSection({
    required this.items,
    required this.onItemChanged,
    required this.onItemRemoved,
    required this.onAddItem,
  });

  final List<String> items;
  final Function(int index, String newValue) onItemChanged;
  final Function(int index) onItemRemoved;
  final VoidCallback onAddItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...items.mapIndexed((index, item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: StageCraftTextField(
                      controller: TextEditingController(text: item)
                        ..selection = TextSelection.collapsed(offset: item.length),
                      onChanged: (value) => onItemChanged(index, value),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => onItemRemoved(index),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(width: 32),
                  ),
                ],
              ),
            );
          }),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddItem,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 32),
          ),
        ],
      ),
    );
  }
}

/// Widget for additional StringList items (collapsible).
class _StringListAdditionalSection extends StatelessWidget {
  const _StringListAdditionalSection({
    required this.items,
    required this.startIndex,
    required this.onItemChanged,
    required this.onItemRemoved,
    required this.onAddItem,
  });

  final List<String> items;
  final int startIndex;
  final Function(int index, String newValue) onItemChanged;
  final Function(int index) onItemRemoved;
  final VoidCallback onAddItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...items.mapIndexed((localIndex, item) {
          final actualIndex = startIndex + localIndex;
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: StageCraftTextField(
                    controller: TextEditingController(text: item)
                      ..selection = TextSelection.collapsed(offset: item.length),
                    onChanged: (value) => onItemChanged(actualIndex, value),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => onItemRemoved(actualIndex),
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
          onPressed: onAddItem,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 32),
        ),
      ],
    );
  }
}

/// Widget for advanced StringList operations (collapsible).
class _StringListAdvancedSection extends StatelessWidget {
  const _StringListAdvancedSection({
    required this.itemCount,
    required this.onClearAll,
    required this.onAddMultiple,
  });

  final int itemCount;
  final VoidCallback onClearAll;
  final VoidCallback onAddMultiple;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Item count info
        Text(
          'Total items: $itemCount',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 4),
        
        // Bulk operations
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: onAddMultiple,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                visualDensity: VisualDensity.compact,
              ),
              child: const Text('Add 3'),
            ),
            ElevatedButton(
              onPressed: onClearAll,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                visualDensity: VisualDensity.compact,
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              child: const Text('Clear All'),
            ),
          ],
        ),
      ],
    );
  }
}
