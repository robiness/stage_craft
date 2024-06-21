import 'package:flutter/widgets.dart';

class StageCraftStyle {
  const StageCraftStyle({required this.controlBarColor});

  final Color controlBarColor;

  static const StageCraftStyle defaultStyle = StageCraftStyle(
    controlBarColor: Color(0xFF4865D3),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StageCraftStyle && runtimeType == other.runtimeType && controlBarColor == other.controlBarColor;

  @override
  int get hashCode => controlBarColor.hashCode;
}

class InheritedStageCraftStyle extends InheritedWidget {
  const InheritedStageCraftStyle({
    super.key,
    required this.style,
    required super.child,
  });

  final StageCraftStyle style;

  static InheritedStageCraftStyle? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedStageCraftStyle>();
  }

  static InheritedStageCraftStyle of(BuildContext context) {
    final InheritedStageCraftStyle? style = maybeOf(context);
    assert(style != null, 'No StageCraftStyle found in context');
    return style!;
  }

  @override
  bool updateShouldNotify(InheritedStageCraftStyle oldWidget) => style != oldWidget.style;
}

extension StageCraftStyleExtension on BuildContext {
  StageCraftStyle get stageCraftStyle => InheritedStageCraftStyle.of(this).style;
}
