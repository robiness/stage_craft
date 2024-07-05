import 'package:example/my_awesome_widget.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

class MyAwesomeWidgetStage extends StatefulWidget {
  const MyAwesomeWidgetStage({super.key});

  @override
  State<MyAwesomeWidgetStage> createState() => _MyAwesomeWidgetStageState();
}

class _MyAwesomeWidgetStageState extends State<MyAwesomeWidgetStage> {
  final boolControl = BoolControl(
    label: 'bool',
    initialValue: false,
  );
  final textEditingControl = TextEditingControl(
    label: 'Awesome',
    initialValue: 'Test',
  );
  final boolControlNullable = BoolNullableControl(
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

  final offsetControl = OffsetNullableControl(
    label: 'Offset',
    initialValue: Offset.zero,
  );

  final enumControl = EnumControl<MyEnum>(
    label: 'Enum',
    initialValue: MyEnum.one,
    values: MyEnum.values,
  );

  final nullableEnum = EnumControlNullable<MyEnum>(
    label: 'NEnum',
    initialValue: null,
    values: MyEnum.values,
  );

  late final GenericControlNullable genericControl = GenericControlNullable<MyEnum>(
    label: 'Generic',
    initialValue: MyEnum.one,
    values: MyEnum.values
        .map(
          (e) => DropdownMenuItem<MyEnum>(
            value: e,
            child: Text(e.name),
          ),
        )
        .toList(),
  );

  final nullableString = StringControlNullable(
    label: 'Nstring',
    initialValue: null,
  );

  @override
  void dispose() {
    super.dispose();
    boolControl.dispose();
    boolControlNullable.dispose();
    stringControl.dispose();
    colorControl.dispose();
    offsetControl.dispose();
    textEditingControl.dispose();
    genericControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StageBuilder(
      controls: [
        offsetControl,
        boolControl,
        boolControlNullable,
        ControlHeader(
          child: const Text(
            'Colors',
            style: TextStyle(fontSize: 18),
          ),
        ),
        stringControl,
        colorControl,
        textEditingControl,
        enumControl,
        nullableEnum,
        genericControl,
        nullableString,
      ],
      builder: (context) {
        return MyAwesomeWidget(
          label: stringControl.value,
          color: colorControl.value,
          controller: textEditingControl.controller,
          offset: offsetControl.value ?? Offset.zero,
        );
      },
    );
  }
}

enum MyEnum {
  one,
  two,
  three,
}
