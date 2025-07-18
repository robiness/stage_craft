import 'package:flutter/material.dart';

/// Style settings for the stage.
class StageStyleData {
  /// Creates a new [StageStyleData].
  StageStyleData({
    this.ballSize = 10,
    this.dragPadding = 20,
    this.controlPanelWidth = 250,
    required this.primaryColor,
    required this.canvasColor,
    required this.brightness,
    required this.onSurface,
    required this.borderColor,
  });

  /// Creates a new [StageStyleData] from a [ThemeData].
  factory StageStyleData.fromMaterialTheme(ThemeData theme) {
    return StageStyleData(
      brightness: theme.brightness,
      canvasColor: theme.colorScheme.surface,
      primaryColor: theme.colorScheme.primary,
      onSurface: theme.colorScheme.onSurface.withValues(alpha: 0.2),
      borderColor: theme.colorScheme.onSurface.withValues(alpha: 0.4),
    );
  }

  /// The brightness of the theme.
  final Brightness brightness;

  /// The primary color of the theme.
  final Color primaryColor;

  /// The size of the ball.
  final double ballSize;

  /// The width of the control panel.
  final double controlPanelWidth;

  /// The minimum distance between the ball and the edge of the stage.
  final double dragPadding;

  /// The Color of the whole canvas.
  final Color canvasColor;

  /// The Color of elements on the surface, like the stage area border or the ruler lines.
  final Color onSurface;

  /// The Color of the stage border.
  final Color borderColor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StageStyleData &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          primaryColor == other.primaryColor &&
          ballSize == other.ballSize &&
          dragPadding == other.dragPadding &&
          canvasColor == other.canvasColor &&
          onSurface == other.onSurface &&
          borderColor == other.borderColor &&
          controlPanelWidth == other.controlPanelWidth;

  @override
  int get hashCode =>
      brightness.hashCode ^
      primaryColor.hashCode ^
      ballSize.hashCode ^
      dragPadding.hashCode ^
      canvasColor.hashCode ^
      onSurface.hashCode ^
      borderColor.hashCode ^
      controlPanelWidth.hashCode;

  /// Creates a copy of this [StageStyleData] but with the given fields replaced with the new values.
  StageStyleData copyWith({
    Brightness? brightness,
    Color? primaryColor,
    double? ballSize,
    double? dragPadding,
    BoxDecoration? stageBorderDecoration,
    Color? canvasColor,
    Color? stageColor,
    Color? onSurface,
    Color? borderColor,
    double? controlPanelWidth,
  }) {
    return StageStyleData(
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? this.primaryColor,
      ballSize: ballSize ?? this.ballSize,
      dragPadding: dragPadding ?? this.dragPadding,
      canvasColor: canvasColor ?? this.canvasColor,
      onSurface: onSurface ?? this.onSurface,
      borderColor: borderColor ?? this.borderColor,
      controlPanelWidth: controlPanelWidth ?? this.controlPanelWidth,
    );
  }
}

/// A widget that provides the [StageStyleData] to its descendants.
class StageStyle extends InheritedWidget {
  /// The style data to provide to its descendants.
  final StageStyleData? data;

  /// Creates a new [StageStyle].
  const StageStyle({
    required this.data,
    required super.child,
    super.key,
  });

  /// Retrieves the [StageStyleData] from the nearest ancestor [StageStyle] widget which might be null.
  static StageStyleData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StageStyle>()?.data;
  }

  /// Retrieves the [StageStyleData] from the nearest ancestor [StageStyle] widget.
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
