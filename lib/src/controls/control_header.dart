import 'package:flutter/widgets.dart';
import 'package:stage_craft/src/controls/control.dart';

class ControlHeader extends ValueControl {
  ControlHeader({required this.child}) : super(initialValue: null, label: 'Header');

  final Widget child;

  @override
  Widget builder(BuildContext context) {
    return child;
  }
}
