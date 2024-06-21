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
    return Stage(
      controls: [textConfigurator],
      builder: (context) {
        return FunkyContainer(
          color: Colors.purpleAccent,
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
        return Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(24),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
