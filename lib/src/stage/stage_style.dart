import 'package:flutter/material.dart';

/// Style settings for the stage.
class StageStyleData {
  StageStyleData({
    this.ballSize = 10,
    this.dragPadding = 20,
    BoxDecoration? stageBorderDecoration,
    required this.primaryColor,
    required this.canvasColor,
    required this.brightness,
    required this.onSurface,
  }) : stageBorderDecoration = stageBorderDecoration ??
            BoxDecoration(
              border: Border.all(
                color: onSurface,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            );

  factory StageStyleData.fromMaterialTheme(ThemeData theme) {
    return StageStyleData(
      brightness: theme.brightness,
      stageBorderDecoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.onSurface.withOpacity(0.4),
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      canvasColor: theme.colorScheme.surface,
      primaryColor: theme.colorScheme.primary,
      onSurface: theme.colorScheme.onSurface.withOpacity(0.2),
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

  /// The Color of elements on the surface, like the stage area border or the ruler lines.
  final Color onSurface;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StageStyleData &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          primaryColor == other.primaryColor &&
          ballSize == other.ballSize &&
          dragPadding == other.dragPadding &&
          stageBorderDecoration == other.stageBorderDecoration &&
          canvasColor == other.canvasColor &&
          onSurface == other.onSurface;

  @override
  int get hashCode =>
      brightness.hashCode ^
      primaryColor.hashCode ^
      ballSize.hashCode ^
      dragPadding.hashCode ^
      stageBorderDecoration.hashCode ^
      canvasColor.hashCode ^
      onSurface.hashCode;

  StageStyleData copyWith({
    Brightness? brightness,
    Color? primaryColor,
    double? ballSize,
    double? dragPadding,
    BoxDecoration? stageBorderDecoration,
    Color? canvasColor,
    Color? stageColor,
    Color? onSurface,
  }) {
    return StageStyleData(
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? this.primaryColor,
      ballSize: ballSize ?? this.ballSize,
      dragPadding: dragPadding ?? this.dragPadding,
      stageBorderDecoration: stageBorderDecoration ?? this.stageBorderDecoration,
      canvasColor: canvasColor ?? this.canvasColor,
      onSurface: onSurface ?? this.onSurface,
    );
  }
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
