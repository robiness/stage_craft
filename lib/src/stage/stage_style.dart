import 'package:flutter/material.dart';

/// Style settings for the stage.
class StageStyle {
  /// The size of the ball.
  final double ballSize = 10.0;

  /// The minimum distance between the ball and the edge of the stage.
  final double dragPadding = 20.0;

  final BoxDecoration stageBorderDecoration = BoxDecoration(
    border: Border.all(
      strokeAlign: BorderSide.strokeAlignCenter,
      color: const Color(0xFF989898).withOpacity(1),
    ),
  );
}

// InheritedWiget to access the StageStyle
class InheritedStageStyle extends InheritedWidget {
  final StageStyle style;

  const InheritedStageStyle({
    required this.style,
    required super.child,
    super.key,
  });

  static StageStyle of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedStageStyle>()!.style;
  }

  @override
  bool updateShouldNotify(InheritedStageStyle oldWidget) {
    return style != oldWidget.style;
  }
}
