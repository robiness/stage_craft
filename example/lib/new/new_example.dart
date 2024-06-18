import 'package:example/new/stage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Expanded(
          child: ColoredBox(
            color: Colors.grey,
            child: Padding(
              padding: EdgeInsets.all(84.0),
              child: Stage(
                child: MyContainerScene(),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class MyContainerScene extends StatefulWidget {
  const MyContainerScene({super.key});

  @override
  State<MyContainerScene> createState() => _MyContainerSceneState();
}

class _MyContainerSceneState extends State<MyContainerScene> {
  @override
  Widget build(BuildContext context) {
    return const Scene(
      child: FunkyContainer(
        color: Colors.purpleAccent,
        child: Text('Funky!'),
      ),
    );
  }
}

class FunkyContainer extends StatefulWidget {
  const FunkyContainer({
    super.key,
    this.color,
    this.height,
    this.width,
    this.child,
  });

  final Color? color;
  final double? height;
  final double? width;
  final Widget? child;

  @override
  State<FunkyContainer> createState() => _FunkyContainerState();
}

class _FunkyContainerState extends State<FunkyContainer> {
  double _width = 100;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _onFunkyTap,
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }

  void _onFunkyTap() {
    if (_width == 200) {
      _width = 90;
    }
    setState(() {
      _width += 10;
    });
  }
}
