import 'package:flutter/material.dart';

abstract class ValueControl<T> extends ValueNotifier<T> {
  ValueControl({
    required T initialValue,
    this.listenable,
  }) : super(initialValue) {
    listenable?.addListener(() {
      notifyListeners();
    });
  }

  Widget builder(BuildContext context);

  final Listenable? listenable;
}
