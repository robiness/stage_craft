import 'package:flutter/material.dart';

class MyAwesomeWidget extends StatelessWidget {
  const MyAwesomeWidget({
    super.key,
    this.label,
    this.color,
    this.controller,
    required this.offset,
    this.borderRadius,
    this.width,
    this.height,
  });

  final String? label;
  final Color? color;
  final TextEditingController? controller;
  final Offset offset;
  final double? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Transform.translate(
          offset: offset,
          child: Column(
            children: [
              if (label != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(label!),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter a value',
                  ),
                  controller: controller,
                ),
              ),
              // Text(label ?? 'No label'),
            ],
          ),
        ),
      ),
    );
  }
}
