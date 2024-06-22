import 'package:flutter/material.dart';

abstract class ValueControl<T> extends ValueNotifier<T> {
  ValueControl({
    required T initialValue,
    this.listenable,
  })  : _lastValue = initialValue,
        super(initialValue);

  Widget builder(BuildContext context);

  T _lastValue;

  final Listenable? listenable;

  bool get isNullable => null is T;

  @override
  set value(T newValue) {
    _lastValue = value;
    if (newValue != value) {
      super.value = newValue;
    }
  }

  void toggleNull(bool? nullValue) {
    if (nullValue == true) {
      value = null as T;
    } else {
      value = _lastValue;
    }
  }
}
