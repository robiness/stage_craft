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
    required this.initialValue,
    T? min,
    T? max,
  })  : _previousValue = initialValue,
        _minValue = min,
        _maxValue = max,
        assert(
          min == null || (initialValue as Comparable).compareTo(min) >= 0,
          'Initial value of $label is $initialValue but must be greater than or equal to min of $min.',
        ),
        assert(
          max == null || (initialValue as Comparable).compareTo(max) <= 0,
          'Initial value of $label is $initialValue but must be less than or equal to max of $max.',
        ),
        super(initialValue);

  /// The label to display in the control bar.
  final String label;

  /// The widget to display in the control bar to modify the value.
  Widget builder(BuildContext context);

  T _previousValue;

  /// The initial value of the control.
  final T initialValue;

  final T? _minValue;

  /// The minimum value that the control can be set to.
  T? get minValue => _minValue;
  final T? _maxValue;

  /// The maximum value that the control can be set to.
  T? get maxValue => _maxValue;

  /// Whether the value can be set to `null`.
  bool get isNullable => null is T;

  @override
  set value(T newValue) {
    try {
      if (_minValue != null && (newValue as Comparable).compareTo(_minValue) < 0) {
        return;
      }
      if (_maxValue != null && (newValue as Comparable).compareTo(_maxValue) > 0) {
        return;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
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
