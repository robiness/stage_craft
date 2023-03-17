import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Represents a nullable bool parameter for a widget on a [WidgetStage].
class NullableBoolFieldConfigurator extends FieldConfigurator<bool?> {
  NullableBoolFieldConfigurator({
    required super.value,
    required super.name,
  });

  @override
  Widget builder(BuildContext context) {
    return _ButtonRow(
      value: value,
      callbacks: [
        () {
          value = null;
          notifyListeners();
        },
        () {
          value = false;
          notifyListeners();
        },
        () {
          value = true;
          notifyListeners();
        },
      ],
    );
  }
}

class _ButtonRow extends StatefulWidget {
  const _ButtonRow({
    required this.callbacks,
    this.value,
  });

  final List<void Function()> callbacks;
  final bool? value;

  @override
  State<_ButtonRow> createState() => _ButtonRowState();
}

class _ButtonRowState extends State<_ButtonRow> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(index: 0, onTap: widget.callbacks.first),
        _buildButton(index: 1, value: false, onTap: widget.callbacks[1]),
        _buildButton(index: 2, value: true, onTap: widget.callbacks.last),
      ],
    );
  }

  Widget _buildButton({
    required int index,
    bool? value,
    required void Function() onTap,
  }) {
    final text = () {
      if (index == 0) {
        return 'null';
      } else if (index == 1) {
        return 'false';
      }
      return 'true';
    }();

    final color = () {
      final isHovered = _hoveredIndex == index;
      if (isHovered) {
        return Colors.grey[200]!;
      }
      return Colors.grey[600]!;
    }();

    final borderRadius = () {
      const radius = Radius.circular(8);
      if (index == 1) {
        return null;
      } else if (index == 0) {
        return const BorderRadius.only(topLeft: radius, bottomLeft: radius);
      }
      return const BorderRadius.only(topRight: radius, bottomRight: radius);
    }();

    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _hoveredIndex = index;
        });
      },
      onExit: (event) {
        setState(() {
          _hoveredIndex = null;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: widget.value == value ? Colors.green : Colors.transparent,
            border: Border.all(color: color),
            borderRadius: borderRadius,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
