import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// A [FieldConfigurator] for the [WidgetStage] which can handle a nullable boolean parameter by
/// offering to set one of the following values:
/// - null
/// - false
/// - true
class NullableBoolFieldConfigurator extends FieldConfigurator<bool?> {
  NullableBoolFieldConfigurator({
    required super.value,
    required super.name,
  });

  int? _hoveredIndex;
  final List<bool?> _options = [null, false, true];

  @override
  Widget builder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text('$name:')),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _options.map((option) {
              return Expanded(
                child: _buildOption(option: option),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildOption({
    bool? option,
  }) {
    final index = _options.indexOf(option);
    final isSelected = value == option;
    final isHovered = _hoveredIndex == index;

    final fillColor = () {
      if (isSelected) {
        return Colors.blue;
      }
      return isHovered ? Colors.blue.withOpacity(0.3) : Colors.transparent;
    }();

    final borderRadius = () {
      const radius = Radius.circular(6);
      if (option == null) {
        return const BorderRadius.only(topLeft: radius, bottomLeft: radius);
      }
      return option ? const BorderRadius.only(topRight: radius, bottomRight: radius) : null;
    }();

    return MouseRegion(
      onEnter: (event) {
        _hoveredIndex = index;
        notifyListeners();
      },
      onExit: (event) {
        _hoveredIndex = null;
        notifyListeners();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          value = option;
          notifyListeners();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey[600]!),
            borderRadius: borderRadius,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(option.toString()),
            ),
          ),
        ),
      ),
    );
  }
}
