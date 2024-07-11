import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/controls/controls.dart';
import 'package:stage_craft/src/stage/stage.dart';
import 'package:stage_craft/src/stage/stage_style.dart';

extension ControlsExtensions on WidgetTester {
  Future<void> pumpWidgetOnStage({
    required Widget widget,
    StageStyleData? inheritedStyle,
    StageStyleData? parameterStyle,
    Brightness? brightness,
    List<ValueControl>? controls,
  }) async {
    await pumpWidget(
      StageStyle(
        data: inheritedStyle,
        child: MaterialApp(
          theme: ThemeData(
            brightness: brightness,
          ),
          home: Scaffold(
            body: StageBuilder(
              controls: controls,
              style: parameterStyle,
              builder: (context) {
                return widget;
              },
            ),
          ),
        ),
      ),
    );
    await pump();
    await pump();
  }

  Future<void> pumpWidgetBuilderOnStage({
    required WidgetBuilder builder,
    StageStyleData? inheritedStyle,
    StageStyleData? parameterStyle,
    Brightness? brightness,
    List<ValueControl>? controls,
  }) async {
    await pumpWidget(
      StageStyle(
        data: inheritedStyle,
        child: MaterialApp(
          theme: ThemeData(
            brightness: brightness,
          ),
          home: Scaffold(
            body: StageBuilder(
              controls: controls,
              style: parameterStyle,
              builder: builder,
            ),
          ),
        ),
      ),
    );
    await pump();
    await pump();
  }
}

class TestWidget<T> extends StatefulWidget {
  const TestWidget({
    super.key,
    this.value,
    this.build,
    this.didChangeDependencies,
    this.dispose,
    this.initState,
    this.updateWidget,
  });

  final T? value;
  final void Function(BuildContext context)? build;
  final void Function(BuildContext context)? didChangeDependencies;
  final void Function()? dispose;
  final void Function()? initState;
  final void Function()? updateWidget;

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call(context);
  }

  @override
  Widget build(BuildContext context) {
    widget.build?.call(context);
    return const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose?.call();
  }

  @override
  void initState() {
    super.initState();
    widget.initState?.call();
  }

  @override
  void didUpdateWidget(TestWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.updateWidget?.call();
  }
}
