import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({
    Key? key,
    required this.color,
    required this.text,
    this.borderRadius = 8,
  }) : super(key: key);

  final Color color;
  final double? borderRadius;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    );
  }
}
