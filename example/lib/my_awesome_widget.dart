import 'package:flutter/material.dart';

class MyAwesomeWidget extends StatelessWidget {
  const MyAwesomeWidget({
    super.key,
    this.label,
    this.color,
    this.controller,
    required this.offset,
    this.borderRadius,
  });

  final String? label;
  final Color? color;
  final TextEditingController? controller;
  final Offset offset;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    // return OutlinedButton(onPressed: () {}, child: Text('jojojjojo'));
    return SizedBox(
      height: 100,
      width: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Transform.translate(
          offset: offset,
          child: Column(
            children: [
              if (label != null) Text(label!),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter a value',
                ),
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
