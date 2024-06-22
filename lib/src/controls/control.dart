import 'package:flutter/material.dart';

abstract class ValueControl<T> extends ValueNotifier<T> {
  ValueControl({
    required this.label,
    required T initialValue,
    this.listenable,
  })  : _lastValue = initialValue,
        super(initialValue);

  final String label;

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
    if (!isNullable) {
      return;
    }
    if (nullValue == true) {
      value = null as T;
    } else {
      value = _lastValue;
    }
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
              Text(control.label),
              Checkbox(
                value: control.value == null,
                onChanged: control.toggleNull,
              ),
              Expanded(
                child: child,
              ),
            ],
          );
        }
        return Row(
          children: [
            Text(control.label),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}
