import 'package:example/my_awesome_widget.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

class MyAwesomeWidgetStage extends StatefulWidget {
  const MyAwesomeWidgetStage({super.key});

  @override
  State<MyAwesomeWidgetStage> createState() => _MyAwesomeWidgetStageState();
}

class _MyAwesomeWidgetStageState extends State<MyAwesomeWidgetStage> {
  final width = DoubleControl(label: 'width', initialValue: 400);
  final height = DoubleControl(label: 'height', initialValue: 200);

  final label = StringControl(
    label: 'label',
    initialValue: 'Tag Selection',
  );

  final backgroundColor = ColorControl(
    label: 'background',
    initialValue: Colors.white.withOpacity(0.5),
  );

  final tagShadow = OffsetControlNullable(
    label: 'shadow',
    initialValue: Offset.zero,
  );

  final options = StringListControl(
    label: 'options',
    initialValue: ['one', 'two', 'three'],
    defaultValue: 'option',
  );

  final chipBorderRadius = DoubleControl(
    label: 'border radius',
    initialValue: 10,
  );
  final chipColor = ColorControl(
    label: 'color',
    initialValue: Colors.blue,
  );
  final chipWidth = DoubleControl(
    label: 'width',
    initialValue: 100,
  );
  final alignment = EnumControl<CrossAxisAlignment>(
    label: 'alignment',
    initialValue: CrossAxisAlignment.start,
    values: CrossAxisAlignment.values,
  );
  final chipShadowBlur = DoubleControl(
    label: 'shadow blur',
    initialValue: 2,
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StageBuilder(
      controls: [
        width,
        height,
        label,
        backgroundColor,
        options,
        alignment,
        CustomHeader(
          childBuilder: (context) => Text(
            'Chip ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        chipBorderRadius,
        chipColor,
        chipWidth,
        chipShadowBlur,
      ],
      builder: (context) {
        return MyAwesomeWidget(
          width: width.value,
          height: height.value,
          label: label.value,
          backgroundColor: backgroundColor.value,
          chipShadowOffset: tagShadow.value,
          options: options.value,
          chipBorderRadius: chipBorderRadius.value,
          chipColor: chipColor.value,
          chipWidth: chipWidth.value,
          alignment: alignment.value,
          chipShadowBlur: chipShadowBlur.value,
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
