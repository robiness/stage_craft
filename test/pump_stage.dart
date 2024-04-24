import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/stage_craft.dart';

import 'test_stage_data.dart';

extension PumpStageExtension on WidgetTester {
  Future<void> pumpStage({StageData? stageData, ValueNotifier<Offset?>? debugMarker}) async {
    final stage = StageCraft(
      stageData: stageData ?? TestStageData(),
    );
    final child = () {
      if (debugMarker != null) {
        return DebugMarker(
          offset: debugMarker,
          child: stage,
        );
      } else {
        return stage;
      }
    }();
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
    await pumpAndSettle();
  }

  Size get testStageSize => getSize(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageTopLeft => getTopLeft(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageCenter => getCenter(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageBottomRight => getBottomRight(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageBottomLeft => getBottomLeft(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );

  Offset get testStageTopRight => getTopRight(
        find.byKey(
          const ValueKey('test_stage_data'),
        ),
      );
}

class DebugMarker extends StatefulWidget {
  const DebugMarker({
    super.key,
    required this.offset,
    required this.child,
  });

  final ValueNotifier<Offset?> offset;
  final Widget child;

  @override
  State<DebugMarker> createState() => _DebugMarkeerState();
}

class _DebugMarkeerState extends State<DebugMarker> {
  @override
  void initState() {
    super.initState();
    widget.offset.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offset.value == null) return widget.child;
    return Stack(
      children: [
        widget.child,
        Positioned(
          left: widget.offset.value!.dx,
          top: widget.offset.value!.dy,
          child: Container(
            width: 1,
            height: 1,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
