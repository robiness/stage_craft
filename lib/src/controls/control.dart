import 'package:flutter/material.dart';

/// A abstract representation of a value to control the widget on stage.
/// The task is to provide a way for the user to change the value to then be used by the widget on stage.
///
/// Concrete implementations are for example [IntControl], [DoubleControl], [StringControl], [BoolControl].
/// You can always create your own implementation by extending this class and use it on the stage.
abstract class ValueControl<T> extends ValueNotifier<T> {
  /// Creates a new [ValueControl] with the given initial value.
  ValueControl({
    required this.label,
    required T initialValue,
  })  : _previousValue = initialValue,
        super(initialValue);

  /// The label to display in the control bar.
  final String label;

  /// The widget to display in the control bar to modify the value.
  Widget builder(BuildContext context);

  T _previousValue;

  /// Whether the value can be set to `null`.
  bool get isNullable => null is T;

  @override
  set value(T newValue) {
    _previousValue = value;
    if (newValue != value) {
      super.value = newValue;
    }
    notifyListeners();
  }

  /// Toggles the value between `null` and the previous value.
  void toggleNull() {
    if (!isNullable) {
      return;
    }
    if (value == null) {
      value = _previousValue;
    } else {
      value = null as T;
    }
    notifyListeners();
  }
}
