import 'package:flutter/widgets.dart';
import 'package:stage_craft/src/_old/stage/stage_area.dart';
import 'package:stage_craft/src/_old/stage/stage_controller.dart';
import 'package:stage_craft/src/_old/stage/stage_data.dart';
import 'package:stage_craft/src/_old/widgets/configuration_bar.dart';

/// The [StageCraft] widget is the main widget of the StageCraft package.
///
/// Use this to create a stage for your widgets.
///
class StageCraft extends StatefulWidget {
  const StageCraft({
    super.key,
    this.stageController,
    this.configurationBarFooter,
    StageCraftSettings? settings,
    this.stageData,
  }) : settings = settings ?? const StageCraftSettings();

  /// The [StageController] that controls the stage.
  ///
  /// Create one above the [StageCraft] widget and pass it here to react to stage events or set stage properties.
  final StageController? stageController;

  /// The size of the handle balls.
  final StageCraftSettings settings;

  /// An optional footer of the configuration bar.
  final Widget? configurationBarFooter;

  /// The initially selected stage data.
  final StageData? stageData;

  @override
  State<StageCraft> createState() => _StageCraftState();
}

class _StageCraftState extends State<StageCraft> {
  late final _stageController = widget.stageController ?? StageController();

  @override
  void initState() {
    super.initState();
    if (widget.stageData != null) {
      _stageController.selectWidget(widget.stageData!);
      if (widget.stageData!.initialStageSize != null) {
        _stageController.resizeStage(widget.stageData!.initialStageSize!);
        return;
      }
      _stageController.resizeStage(widget.settings.defaultStageSize);
    }
  }

  @override
  void dispose() {
    if (widget.stageController == null) {
      // If the user didn't provide a controller, we dispose it ourselves.
      _stageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StageArea(
          stageController: _stageController,
          settings: widget.settings,
        ),
        // In tests we don't want to show the configuration bar because find() would find widgets in it.
        Align(
          alignment: Alignment.topCenter,
          child: ConfigurationBar(
            controller: _stageController,
            configurationBarFooter: widget.configurationBarFooter,
          ),
        ),
      ],
    );
  }
}

class StageCraftSettings {
  const StageCraftSettings({
    double? handleBallSize,
    Color? handleBallColor,
    Color? initialBackgroundColor,
    Size? defaultStageSize,
  })  : handleBallSize = handleBallSize ?? 20,
        initialBackgroundColor = initialBackgroundColor ?? const Color(0xFFE3E3E3),
        handleBallColor = handleBallColor ?? const Color(0xCC185DE3),
        defaultStageSize = defaultStageSize ?? const Size(400, 400);

  final Color initialBackgroundColor;
  final Color handleBallColor;
  final double handleBallSize;
  final Size defaultStageSize;
}
