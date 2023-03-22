import 'package:flutter/material.dart';
import 'package:widget_stage/src/widget_stage.dart';

class FieldConfiguratorWidget<T> extends StatelessWidget {
  const FieldConfiguratorWidget({
    super.key,
    required this.fieldConfigurator,
    required this.child,
  });

  final Widget child;
  final FieldConfigurator fieldConfigurator;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text('${fieldConfigurator.name}:'),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (fieldConfigurator.nullable) ...[
                const SizedBox(width: 4.0),
                TextButton(
                  onPressed: () => fieldConfigurator.updateValue(null),
                  child: const Text('null'),
                ),
              ],
              Expanded(child: child),
            ],
          ),
        ),
      ],
    );
  }
}

abstract class ConfigurationWidget<T> extends StatelessWidget {
  const ConfigurationWidget({
    super.key,
    required this.value,
    required this.updateValue,
  });

  final T value;
  final void Function(T newValue) updateValue;
}

abstract class StatefulConfigurationWidget<T> extends StatefulWidget {
  const StatefulConfigurationWidget({
    super.key,
    required this.value,
    required this.updateValue,
  });

  final T value;
  final void Function(T newValue) updateValue;
}
