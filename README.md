# stage_craft

Develop and live test your UI widgets on a stage.

StageCraft helps you developing and testing your widgets in a controlled environment. <br>
It provides a stage where you can change the properties and constraints of your widget and see the changes in real time.

## Benefits
- **Instant Feedback**: See changes to your widgets immediately without navigating through your app.
- **Separation of Concerns**: Naturally separates your UI widgets from your app's state.
- **Efficient Development**: No need to rebuild the app to see changes.

## Installation
Add StageCraft to your project:
```yaml
dependencies:
  stage_craft: ^1.0.0
```

or simply run:
```shell
flutter pub add stage_craft
```

## Try it out
To test just copy the code below, paste it in a new dart file and run it.

<details>
<summary>Click to expand the example code</summary>

````dart
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
````
</details>
