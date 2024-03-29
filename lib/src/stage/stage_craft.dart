import 'package:flutter/widgets.dart';
import 'package:stage_craft/src/stage/stage_area.dart';
import 'package:stage_craft/src/stage/stage_controller.dart';
import 'package:stage_craft/src/stage/stage_data.dart';
import 'package:stage_craft/src/widgets/configuration_bar.dart';
import 'package:universal_io/io.dart';

/// The [StageCraft] widget is the main widget of the StageCraft package.
///
/// Use this to create a stage for your widgets.
///
class StageCraft extends StatefulWidget {
  StageCraft({
    super.key,
    this.stageController,
    this.configurationBarFooter,
    this.stageSize,
    StageCraftSettings? settings,
    this.stageData,
  }) : settings = settings ??
            StageCraftSettings(
              handleBallSize: 20,
              handleBallColor: const Color(0xFF185DE3).withOpacity(0.8),
            );

  /// The [StageController] that controls the stage.
  ///
  /// Create one above the [StageCraft] widget and pass it here to react to stage events or set stage properties.
  final StageController? stageController;

  /// The size of the stage.
  final Size? stageSize;

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
    if (widget.stageSize != null) {
      _stageController.stageSize = widget.stageSize!;
    }
    if (widget.stageData != null) {
      _stageController.selectWidget(widget.stageData!);
    }
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
        if (!Platform.environment.containsKey('FLUTTER_TEST'))
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
    required this.handleBallSize,
    required this.handleBallColor,
    this.initialBackgroundColor,
  });

  final Color? initialBackgroundColor;
  final Color handleBallColor;
  final double handleBallSize;
}
