import 'package:flutter/material.dart';

class FieldConfiguratorWidget<T> extends StatelessWidget {
  const FieldConfiguratorWidget({
    super.key,
    required this.name,
    required this.child,
    required this.isNullable,
    this.onNullTapped,
  });

  final String name;
  final Widget child;
  final bool isNullable;
  final VoidCallback? onNullTapped;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$name:'),
              if (isNullable)
                TextButton(
                  onPressed: onNullTapped,
                  child: const Text('null'),
                ),
            ],
          ),
        ),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
