import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

Future<void> main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyAwesomeWidgetStage(),
      ),
    ),
  );
}

class MyAwesomeWidgetStage extends StatefulWidget {
  const MyAwesomeWidgetStage({super.key});

  @override
  State<MyAwesomeWidgetStage> createState() => _MyAwesomeWidgetStageState();
}

class _MyAwesomeWidgetStageState extends State<MyAwesomeWidgetStage> {
  final width = DoubleControlNullable(label: 'width', initialValue: 400);
  final height = DoubleControl(label: 'height', initialValue: 250);

  final label = StringControl(
    label: 'label',
    initialValue: 'Tag Selection',
  );

  final backgroundColor = ColorControl(
    label: 'background',
    initialValue: Colors.orange,
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
  final chipWidth = DoubleControlNullable(
    label: 'width',
    initialValue: null,
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
  final chipIntrinsicWidth = BoolControl(
    label: 'intrinsic width',
    initialValue: true,
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
        alignment,
        options,
        ControlGroup(
          label: 'Chip',
          controls: [
            chipIntrinsicWidth,
            chipBorderRadius,
            chipColor,
            chipWidth,
            chipShadowBlur,
          ],
        ),
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
          chipIntrinsicWidth: chipIntrinsicWidth.value,
        );
      },
    );
  }
}

class MyAwesomeWidget extends StatelessWidget {
  const MyAwesomeWidget({
    super.key,
    this.label,
    this.backgroundColor,
    this.width,
    this.height,
    List<String>? options,
    this.chipShadowOffset,
    this.chipBorderRadius,
    this.chipWidth,
    Color? chipColor,
    required this.alignment,
    required this.chipShadowBlur,
    required this.chipIntrinsicWidth,
  })  : options = options ?? const [],
        chipColor = chipColor ?? Colors.blue;

  final double? width;
  final double? height;
  final String? label;
  final Color? backgroundColor;

  final List<String> options;

  final double? chipBorderRadius;
  final Offset? chipShadowOffset;
  final double? chipWidth;
  final Color chipColor;
  final CrossAxisAlignment alignment;
  final double chipShadowBlur;
  final bool chipIntrinsicWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            if (label != null)
              Text(
                label!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: options.map(
                (option) {
                  return Chip(
                    width: chipWidth,
                    color: chipColor,
                    borderRadius: chipBorderRadius,
                    shadowOffset: chipShadowOffset,
                    blur: chipShadowBlur,
                    intrinsicWidth: chipIntrinsicWidth,
                    child: Center(
                      child: Text(
                        option,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Chip extends StatelessWidget {
  const Chip({
    super.key,
    required this.width,
    required this.color,
    required this.borderRadius,
    required this.shadowOffset,
    required this.child,
    required this.blur,
    required this.intrinsicWidth,
  });

  final double? width;
  final Color color;
  final double? borderRadius;
  final Offset? shadowOffset;
  final Widget child;
  final double blur;
  final bool intrinsicWidth;

  @override
  Widget build(BuildContext context) {
    final tag = SizedBox(
      height: 50,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
          boxShadow: [
            if (shadowOffset != null)
              BoxShadow(
                blurRadius: blur,
                offset: shadowOffset!,
              ),
          ],
        ),
        child: child,
      ),
    );
    if (intrinsicWidth) {
      return IntrinsicWidth(
        child: tag,
      );
    }
    return tag;
  }
}
