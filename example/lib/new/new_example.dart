import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

class MyContainerStage extends StatefulWidget {
  const MyContainerStage({super.key});

  @override
  State<MyContainerStage> createState() => _MyContainerStageState();
}

class _MyContainerStageState extends State<MyContainerStage> {
  final boolControl = BoolControl(
    initialValue: false,
  );
  final boolControlNullable = BoolControlNullable(
    initialValue: null,
  );
  final stringControl = StringControl(
    initialValue: 'Hello',
  );

  @override
  Widget build(BuildContext context) {
    return StageBuilder(
      controls: [boolControl, stringControl, boolControlNullable],
      builder: (context) {
        return FunkyContainer(
          color: boolControlNullable.value == null
              ? null
              : boolControlNullable.value!
                  ? Colors.green
                  : Colors.blue,
          child: Text(stringControl.value),
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
