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
  final boolControlNullable = BoolControlNullable(
    label: 'bool Nullable',
    initialValue: null,
  );
  final stringControl = StringControl(
    label: 'Text',
    initialValue: 'Hello',
  );

  final offsetControl = OffsetControlNullable(
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

  final widthControl = DoubleControl(label: 'width', initialValue: 400);
  final heightControl = DoubleControl(label: 'height', initialValue: 100);

  final colorControl = ColorControl(
    label: 'Color',
    initialValue: Colors.blue,
    colorSamples: [
      const ColorSample(color: Colors.purpleAccent, name: 'Purple'),
      const ColorSample(color: Colors.orange, name: 'Blue'),
    ],
  );

  @override
  void dispose() {
    super.dispose();
    boolControl.dispose();
    boolControlNullable.dispose();
    stringControl.dispose();
    colorControl.dispose();
    offsetControl.dispose();
    genericControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StageBuilder(
      controls: [
        widthControl,
        heightControl,
        colorControl,
        stringControl,
        // offsetControl,
        // boolControl,
        // boolControlNullable,
        CustomHeader(
          childBuilder: (context) => Text(
            'Custom Header',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        // stringControl,
        // colorControl,
        // textEditingControl,
        // enumControl,
        // nullableEnum,
        // genericControl,
        // nullableString,
        // colorControl,
      ],
      builder: (context) {
        return MyAwesomeWidget(
          label: stringControl.value,
          color: colorControl.value,
          offset: offsetControl.value ?? Offset.zero,
          width: widthControl.value,
          height: heightControl.value,
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
