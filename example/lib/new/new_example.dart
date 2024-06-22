import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

class MyContainerStage extends StatefulWidget {
  const MyContainerStage({super.key});

  @override
  State<MyContainerStage> createState() => _MyContainerStageState();
}

class _MyContainerStageState extends State<MyContainerStage> {
  final boolControl = BoolControl(
    label: 'bool',
    initialValue: false,
  );
  final boolControlNullable = BoolControlNullable(
    label: 'bool Nullable',
    initialValue: null,
  );
  final stringControl = StringControl(
    label: 'Text',
    initialValue: 'Hello',
  );
  final colorControl = ColorControl(
    label: 'Color',
    initialValue: Colors.blue,
  );

  final offsetControl = OffsetControl(
    label: 'Offset',
    initialValue: Offset.zero,
  );

  @override
  void dispose() {
    super.dispose();
    boolControl.dispose();
    boolControlNullable.dispose();
    stringControl.dispose();
    colorControl.dispose();
    offsetControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StageBuilder(
      controls: [offsetControl],
      builder: (context) {
        return FunkyContainer(
          color: colorControl.value,
          child: Transform.translate(
            offset: offsetControl.value,
            child: Text(stringControl.value),
          ),
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
