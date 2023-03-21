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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text('$name:'),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: child),
              if (isNullable) ...[
                const SizedBox(width: 4.0),
                TextButton(
                  onPressed: onNullTapped,
                  child: const Text('null'),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
