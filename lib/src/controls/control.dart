import 'package:flutter/material.dart';

abstract class ValueControl<T> extends ValueNotifier<T> {
  ValueControl({
    required this.label,
    required T initialValue,
  })  : _lastValue = initialValue,
        super(initialValue);

  final String label;

  Widget builder(BuildContext context);

  T _lastValue;

  bool get isNullable => null is T;

  @override
  set value(T newValue) {
    _lastValue = value;
    if (newValue != value) {
      super.value = newValue;
    }
    notifyListeners();
    onChange();
  }

  void onChange() {}

  void toggleNull() {
    if (!isNullable) {
      return;
    }
    if (value == null) {
      value = _lastValue;
    } else {
      value = null as T;
    }
    notifyListeners();
    onChange();
  }
}

class DefaultControlBarRow extends StatelessWidget {
  const DefaultControlBarRow({
    super.key,
    required this.control,
    required this.child,
  });

  final ValueControl control;
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
              Checkbox(
                value: control.value == null,
                onChanged: (_) => control.toggleNull(),
              ),
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
