import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

class MyContainerStage extends StatefulWidget {
  const MyContainerStage({super.key});

  @override
  State<MyContainerStage> createState() => _MyContainerStageState();
}

class _MyContainerStageState extends State<MyContainerStage> {
  @override
  Widget build(BuildContext context) {
    final textConfigurator = StringControl(
      initialValue: 'Hello, World!',
    );
    final boolControl = BoolControl(
      initialValue: false,
    );
    return StageBuilder(
      controls: [textConfigurator, boolControl],
      builder: (context) {
        return FunkyContainer(
          color: boolControl.value ? Colors.purpleAccent : Colors.greenAccent,
          child: Text(textConfigurator.value),
        );
      },
    );
  }
}

class FunkyContainer extends StatefulWidget {
  const FunkyContainer({
    super.key,
    this.color,
    this.child,
    this.controller,
  });

  final Color? color;
  final Widget? child;
  final TextEditingController? controller;

  @override
  State<FunkyContainer> createState() => _FunkyContainerState();
}

class _FunkyContainerState extends State<FunkyContainer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print('constraints: $constraints');
        return DecoratedBox(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(24),
          ),
          child: widget.child,
        );
      },
    );
  }
}
