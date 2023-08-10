import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.color,
    required this.text,
    this.isTrue,
    this.borderColor,
    EdgeInsets? padding,
    this.borderRadius = 8,
  }) : padding = padding ?? const EdgeInsets.all(8.0);

  final Color? color;
  final Color? borderColor;
  final double? borderRadius;
  final String text;
  final bool? isTrue;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor ?? const Color(0xFF000000)),
                  borderRadius: BorderRadius.circular(borderRadius ?? 0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$text is $isTrue"),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor ?? const Color(0xFF000000)),
                  borderRadius: BorderRadius.circular(borderRadius ?? 0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("right"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
