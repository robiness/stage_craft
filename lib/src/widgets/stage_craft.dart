import 'package:flutter/widgets.dart';
import 'package:stage_craft/src/stage_controller.dart';
import 'package:stage_craft/src/widget_stage_data.dart';
import 'package:stage_craft/src/widgets/configuration_bar.dart';
import 'package:stage_craft/src/widgets/stage_area.dart';

/// The [StageCraft] widget is the main widget of the StageCraft package.
///
/// Use this to create a stage for your widgets.
///
class StageCraft extends StatelessWidget {
  const StageCraft({
    super.key,
    required this.stageController,
    this.widgets = const [],
    Size? stageSize,
    Offset? stagePosition,
    double? handleBallSize,
  })  : stageSize = stageSize ?? const Size(600, 800),
        stagePosition = stagePosition ?? const Offset(50, 50),
        handleBallSize = handleBallSize ?? 30;

  /// The [StageController] that controls the stage.
  ///
  /// Create one above the [StageCraft] widget and pass it here to react to stage events or set stage properties.
  final StageController stageController;

  /// The size of the stage.
  final Size stageSize;

  /// The position of the stage.
  final Offset stagePosition;

  /// The size of the handle balls.
  final double handleBallSize;

  final List<WidgetStageData> widgets;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StageArea(
          stageController: stageController,
          handleBallSize: handleBallSize,
          handleBallColor: const Color(0xFF185DE3).withOpacity(0.8),
        ),
        ConfigurationBar(
          controller: stageController,
        ),
      ],
    );
  }
}
