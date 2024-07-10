import 'package:flutter/material.dart';

abstract class ValueControl<T> extends ValueNotifier<T> {
  ValueControl({
    required this.label,
    required T initialValue,
  })  : _previousValue = initialValue,
        super(initialValue);

  final String label;

  Widget builder(BuildContext context);

  T _previousValue;

  bool get isNullable => null is T;

  @override
  set value(T newValue) {
    _previousValue = value;
    if (newValue != value) {
      super.value = newValue;
    }
    notifyListeners();
  }

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

class NullButton extends StatelessWidget {
  const NullButton({
    super.key,
    required this.control,
  });

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
