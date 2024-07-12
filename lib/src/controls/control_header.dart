import 'package:flutter/widgets.dart';
import 'package:stage_craft/src/controls/control.dart';

/// A custom header to be used in the control panel. Can be used to provide headers or other non control widgets.
class CustomHeader implements ValueControl {
  /// The builder for the child widget.
  CustomHeader({required this.childBuilder});

  /// The builder for the child widget.
  final WidgetBuilder childBuilder;

  @override
  Widget builder(BuildContext context) {
    return childBuilder(context);
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {}

  @override
  bool get hasListeners => false;

  @override
  bool get isNullable => false;

  @override
  String get label => '';

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  void toggleNull() {}

  @override
  Object? value;
}
