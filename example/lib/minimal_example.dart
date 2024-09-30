import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';

Future<void> main() async {
  runApp(const MinimalExample());
}

/// Your App or ui playground project
class MinimalExample extends StatelessWidget {
  const MinimalExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Minimal Example'),
        ),
        body: MinimalExampleStage(),
      ),
    );
  }
}

/// The Stage for your widget
class MinimalExampleStage extends StatelessWidget {
  MinimalExampleStage({super.key});

  final textControl = StringControl(label: 'text', initialValue: 'Hello!');

  final colorControl = ColorControl(label: 'color', initialValue: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return StageBuilder(
      controls: [textControl, colorControl],
      builder: (context) {
        return MyWidget(
          color: colorControl.value,
          text: textControl.value,
        );
      },
    );
  }
}

/// Your actual widget
class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
