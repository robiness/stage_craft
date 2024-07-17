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
    this.chipWidth,
    Color? chipColor,
    required this.alignment,
    required this.chipShadowBlur,
    required this.chipIntrinsicWidth,
  })  : options = options ?? const [],
        chipColor = chipColor ?? Colors.blue;

  final double? width;
  final double? height;
  final String? label;
  final Color? backgroundColor;

  final List<String> options;

  final double? chipBorderRadius;
  final Offset? chipShadowOffset;
  final double? chipWidth;
  final Color chipColor;
  final CrossAxisAlignment alignment;
  final double chipShadowBlur;
  final bool chipIntrinsicWidth;

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
              runSpacing: 8,
              spacing: 8,
              children: options.map(
                (option) {
                  return Chip(
                    width: chipWidth,
                    color: chipColor,
                    borderRadius: chipBorderRadius,
                    shadowOffset: chipShadowOffset,
                    blur: chipShadowBlur,
                    intrinsicWidth: chipIntrinsicWidth,
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
    required this.intrinsicWidth,
  });

  final double? width;
  final Color color;
  final double? borderRadius;
  final Offset? shadowOffset;
  final Widget child;
  final double blur;
  final bool intrinsicWidth;

  @override
  Widget build(BuildContext context) {
    final tag = SizedBox(
      height: 50,
      width: width,
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
    if (intrinsicWidth) {
      return IntrinsicWidth(
        child: tag,
      );
    }
    return tag;
  }
}
