import 'package:example/new/stage/stage.dart';
import 'package:flutter/material.dart';

class MyContainerScene extends StatefulWidget {
  const MyContainerScene({super.key});

  @override
  State<MyContainerScene> createState() => _MyContainerSceneState();
}

class _MyContainerSceneState extends State<MyContainerScene> {
  @override
  Widget build(BuildContext context) {
    return const Stage(
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
    return LayoutBuilder(
      builder: (context, constraints) {
        print('constraints: $constraints');
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
      },
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
