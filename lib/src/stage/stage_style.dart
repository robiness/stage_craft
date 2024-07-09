import 'package:flutter/material.dart';

/// Style settings for the stage.
class StageStyleData {
  StageStyleData({
    this.ballSize = 10,
    this.dragPadding = 20,
    BoxDecoration? stageBorderDecoration,
    required this.primaryColor,
    required this.canvasColor,
    required this.stageColor,
    required this.rulerColor,
    required this.brightness,
    required this.lineColor,
  }) : stageBorderDecoration = stageBorderDecoration ??
            BoxDecoration(
              border: Border.all(
                color: lineColor,
              ),
            );

  factory StageStyleData.fromMaterialTheme(ThemeData theme) {
    return StageStyleData(
      brightness: theme.brightness,
      stageBorderDecoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.4),
        ),
      ),
      canvasColor: theme.colorScheme.surface,
      stageColor: theme.colorScheme.surface,
      rulerColor: theme.colorScheme.onSurface,
      primaryColor: theme.colorScheme.primary,
      lineColor: theme.colorScheme.onSurface,
    );
  }

  /// The brightness of the theme.
  final Brightness brightness;

  /// The primary color of the theme.
  final Color primaryColor;

  /// The size of the ball.
  final double ballSize;

  /// The minimum distance between the ball and the edge of the stage.
  final double dragPadding;

  /// The decoration of the stage border.
  final BoxDecoration stageBorderDecoration;

  /// The Color of the whole canvas.
  final Color canvasColor;

  /// The Color of the stage.
  final Color stageColor;

  /// The Color of the ruler.
  final Color rulerColor;

  /// The Color of lines, like the stage area border or the ruler lines.
  final Color lineColor;
}

// InheritedWidget to access the StageStyle
class StageStyle extends InheritedWidget {
  final StageStyleData data;

  const StageStyle({
    required this.data,
    required super.child,
    super.key,
  });

  static StageStyleData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StageStyle>()?.data;
  }

  static StageStyleData of(BuildContext context) {
    final StageStyleData? result = maybeOf(context);
    assert(result != null, 'No StageStyle found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(StageStyle oldWidget) {
    return data != oldWidget.data;
  }
}
