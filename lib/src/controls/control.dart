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

/// A default implementation of a control bar row.
/// It displays the label, a `null` button if the value is nullable and the child widget to modify the value.
class DefaultControlBarRow extends StatelessWidget {
  /// Creates a new [DefaultControlBarRow] with the given control and child.
  const DefaultControlBarRow({
    super.key,
    required this.control,
    required this.child,
  });

  /// The control to display in the control bar.
  final ValueControl control;

  /// The widget to display in the control bar to modify the value.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: control,
      builder: (context, _) {
        if (control.isNullable) {
          return Row(
            children: [
              Text(
                control.label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 8),
              NullButton(control: control),
              const SizedBox(width: 8),
              Expanded(
                child: child,
              ),
            ],
          );
        }
        return Row(
          children: [
            Text(
              control.label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}

/// A button to toggle the value between `null` and the previous value.
class NullButton extends StatelessWidget {
  /// Creates a new [NullButton] with the given control.
  const NullButton({
    super.key,
    required this.control,
  });

  /// The control to toggle the value.
  final ValueControl control;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: control.toggleNull,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: control.value == null ? Colors.orange[100] : Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'null',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: control.value == null ? Colors.orange : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
