import 'package:flutter/widgets.dart';
import 'package:stage_craft/src/controls/control.dart';

class CustomHeader extends ValueControl {
  CustomHeader({required this.childBuilder}) : super(initialValue: null, label: 'Header');

  final WidgetBuilder childBuilder;

  @override
  Widget builder(BuildContext context) {
    return childBuilder(context);
  }
}
