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
  final width = DoubleControlNullable(
    label: 'width',
    initialValue: 300,
    min: 100,
    max: 400,
  );
  final height = DoubleControl(label: 'height', initialValue: 250);

  final label = StringControl(
    label: 'label',
    initialValue: 'Tag Selection',
  );

  final backgroundColor = ColorControl(
    label: 'background',
    initialValue: Colors.orange,
  );

  final tagShadow = OffsetControl(
    label: 'shadow',
    initialValue: const Offset(2, 2),
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

  final duration = DurationControlNullable(
    label: 'duration',
    initialValue: const Duration(seconds: 3),
  );

  final padding = PaddingControl.all(16, label: 'padding');
  final margin = EdgeInsetsControl(
    label: 'margin',
    initialValue: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
        duration,
        padding,
        margin,
        ControlGroup(
          label: 'Chip',
          controls: [
            chipIntrinsicWidth,
            chipBorderRadius,
            tagShadow,
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
          duration: duration.value,
          padding: padding.value,
          margin: margin.value,
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
    required this.duration,
    required this.padding,
    required this.margin,
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
  final Duration? duration;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
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
          Text('Duration: $duration'),
          Text('Padding: $padding'),
          Text('Margin: $margin'),
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
            BoxShadow(
              blurRadius: 0,
              offset: shadowOffset ?? Offset.zero,
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
