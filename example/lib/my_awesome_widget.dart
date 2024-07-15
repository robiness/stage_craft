import 'package:flutter/material.dart';

class MyAwesomeWidget extends StatelessWidget {
  const MyAwesomeWidget({
    super.key,
    this.label,
    this.backgroundColor,
    this.width,
    this.height,
    List<String>? options,
    this.chipShadowOffset,
    this.chipBorderRadius,
    double? chipWidth,
    Color? chipColor,
    required this.alignment,
    required this.chipShadowBlur,
  })  : options = options ?? const [],
        chipWidth = chipWidth ?? 100,
        chipColor = chipColor ?? Colors.blue;

  final double? width;
  final double? height;
  final String? label;
  final Color? backgroundColor;

  final List<String> options;

  final double? chipBorderRadius;
  final Offset? chipShadowOffset;
  final double chipWidth;
  final Color chipColor;
  final CrossAxisAlignment alignment;
  final double chipShadowBlur;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            if (label != null)
              Text(
                label!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            Wrap(
              children: options.map(
                (option) {
                  return Chip(
                    width: chipWidth,
                    color: chipColor,
                    borderRadius: chipBorderRadius,
                    shadowOffset: chipShadowOffset,
                    blur: chipShadowBlur,
                    child: Center(
                      child: Text(
                        option,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Chip extends StatelessWidget {
  const Chip({
    super.key,
    required this.width,
    required this.color,
    required this.borderRadius,
    required this.shadowOffset,
    required this.child,
    required this.blur,
  });

  final double width;
  final Color color;
  final double? borderRadius;
  final Offset? shadowOffset;
  final Widget child;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
          boxShadow: [
            if (shadowOffset != null)
              BoxShadow(
                blurRadius: blur,
                offset: shadowOffset!,
              ),
          ],
        ),
        child: child,
      ),
    );
  }
}
