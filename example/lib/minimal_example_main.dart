import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

Future<void> main() async {
  runApp(const StageControlExamples());
}

/// Your App or ui playground project
class StageControlExamples extends StatelessWidget {
  const StageControlExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ControlStage(),
      ),
    );
  }
}

class ControlStage extends StatelessWidget {
  ControlStage({super.key});

  final boolControl = BoolControl(label: 'bool', initialValue: true);
  final boolControlNullable = BoolControlNullable(label: 'boolNullable');
  final stringControl = StringControl(label: 'string', initialValue: 'Hello');
  final stringControlNullable = StringControlNullable(label: 'stringNullable');
  final intControl = IntControl(label: 'int', initialValue: 42);
  final intControlNullable = IntControlNullable(label: 'intNullable');
  final doubleControl = DoubleControl(label: 'double', initialValue: 42.0);
  final doubleControlNullable = DoubleControlNullable(label: 'doubleNullable');
  final colorControl = ColorControl(label: 'color', initialValue: Colors.red);
  final colorControlNullable = ColorControlNullable(label: 'colorNullable');
  final durationControl = DurationControl(label: 'duration', initialValue: const Duration(seconds: 1));
  final durationControlNullable = DurationControlNullable(label: 'durationNullable');
  final enumControl = EnumControl(label: 'enum', initialValue: TextAlign.center, values: TextAlign.values);
  final enumControlNullable = EnumControlNullable(label: 'enumNullable', values: TextAlign.values);
  final functionControl = VoidFunctionControl(label: 'function');
  final functionControlNullable = VoidFunctionControlNullable(label: 'functionNullable');
  final genericControl = GenericControl<int>(
    label: 'generic',
    initialValue: 1,
    options: [
      const DropdownMenuItem(value: 1, child: Text('1')),
      const DropdownMenuItem(value: 2, child: Text('2')),
    ],
  );
  final genericControlNullable = GenericControlNullable<int>(
    label: 'genericNullable',
    initialValue: 1,
    options: [
      const DropdownMenuItem(value: 1, child: Text('1')),
      const DropdownMenuItem(value: 2, child: Text('2')),
    ],
  );
  final offsetControl = OffsetControl(label: 'offset', initialValue: const Offset(1, 1));
  final offsetControlNullable = OffsetControlNullable(label: 'offsetNullable');

  final stringListControl = StringListControl(label: 'stringList', initialValue: ['Hello', 'World']);

  // TODO add initialValue to StringListControlNullable
  // final stringListControlNullable = StringListControlNullable(label: 'stringListNullable');
  final widgetControl = WidgetControl(label: 'widget', initialValue: const Text('Hello'));
  final widgetControlNullable = WidgetControlNullable(label: 'widgetNullable');

  @override
  Widget build(BuildContext context) {
    return StageBuilder(
      controls: [
        boolControl,
        boolControlNullable,
        stringControl,
        stringControlNullable,
        intControl,
        intControlNullable,
        doubleControl,
        doubleControlNullable,
        colorControl,
        colorControlNullable,
        durationControl,
        durationControlNullable,
        enumControl,
        enumControlNullable,
        functionControl,
        functionControlNullable,
        genericControl,
        genericControlNullable,
        offsetControl,
        offsetControlNullable,
        stringListControl,
        widgetControl,
        widgetControlNullable,
      ],
      builder: (context) {
        return Container(
          color: Colors.grey.withOpacity(0.8),
          child: ListView(
            children: [
              boolControl.builder(context),
              boolControlNullable.builder(context),
              stringControl.builder(context),
              stringControlNullable.builder(context),
              intControl.builder(context),
              intControlNullable.builder(context),
              doubleControl.builder(context),
              doubleControlNullable.builder(context),
              colorControl.builder(context),
              colorControlNullable.builder(context),
              durationControl.builder(context),
              durationControlNullable.builder(context),
              enumControl.builder(context),
              enumControlNullable.builder(context),
              _FunctionButton(
                onTap: functionControl.value,
                child: functionControl.builder(context),
              ),
              _FunctionButton(
                onTap: functionControlNullable.value,
                child: functionControlNullable.builder(context),
              ),
              genericControl.builder(context),
              genericControlNullable.builder(context),
              offsetControl.builder(context),
              offsetControlNullable.builder(context),
              stringListControl.builder(context),
              widgetControl.builder(context),
              widgetControlNullable.builder(context),
            ],
          ),
        );
      },
    );
  }
}

class _FunctionButton extends StatelessWidget {
  const _FunctionButton({required this.onTap, required this.child});

  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 20,
              width: 20,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(child: child),
      ],
    );
  }
}
