import 'package:flutter/material.dart';

import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/recording/playback_controller.dart';
import 'package:stage_craft/src/recording/scenario_repository.dart';
import 'package:stage_craft/src/recording/stage_controller.dart';
import 'package:stage_craft/src/recording/widgets/recording_toolbar.dart';
import 'package:stage_craft/src/recording/widgets/scenario_management_drawer.dart';
import 'package:stage_craft/src/stage/stage.dart';
import 'package:stage_craft/src/stage/stage_style.dart';

/// An enhanced StageBuilder that includes recording and playback functionality.
/// Wraps the standard StageBuilder with recording controls and scenario management.
class RecordingStageBuilder extends StatefulWidget {
  /// Creates a recording-enabled stage builder.
  const RecordingStageBuilder({
    super.key,
    required this.builder,
    required this.stageController,
    required this.playbackController,
    List<ValueControl>? controls,
    this.style,
    this.forceSize = true,
    this.showRecordingControls = true,
  }) : controls = controls ?? const [];

  /// The builder for the widget on stage.
  final WidgetBuilder builder;

  /// The stage controller for recording operations.
  final StageController stageController;

  /// The playback controller for scenario playback.
  final PlaybackController playbackController;

  /// The controls to manipulate the widget on stage.
  final List<ValueControl> controls;

  /// The style of the stage.
  final StageStyleData? style;

  /// If true, the size of the stage will be forced to the size of the child.
  final bool forceSize;

  /// Whether to show the recording controls.
  final bool showRecordingControls;

  @override
  State<RecordingStageBuilder> createState() => _RecordingStageBuilderState();
}

class _RecordingStageBuilderState extends State<RecordingStageBuilder> {
  bool _showScenarioDrawer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                StageBuilder(
                  builder: widget.builder,
                  controls: widget.controls,
                  style: widget.style,
                  forceSize: widget.forceSize,
                ),
                
                if (widget.showRecordingControls)
                  RecordingControlsOverlay(
                    stageController: widget.stageController,
                    playbackController: widget.playbackController,
                    controls: widget.controls,
                    onScenarioManagement: () => setState(() => _showScenarioDrawer = true),
                  ),
              ],
            ),
          ),
          
          if (_showScenarioDrawer)
            SizedBox(
              width: 320,
              child: ScenarioManagementDrawer(
                stageController: widget.stageController,
                onClose: () => setState(() => _showScenarioDrawer = false),
              ),
            ),
        ],
      ),
    );
  }
}

/// Overlay widget that positions recording controls on the stage.
class RecordingControlsOverlay extends StatefulWidget {
  /// Creates a recording controls overlay.
  const RecordingControlsOverlay({
    super.key,
    required this.stageController,
    required this.playbackController,
    required this.controls,
    this.onScenarioManagement,
  });

  /// The stage controller for recording operations.
  final StageController stageController;
  
  /// The playback controller for scenario playback.
  final PlaybackController playbackController;
  
  /// The list of controls for the stage.
  final List<ValueControl> controls;
  
  /// Callback for opening scenario management.
  final VoidCallback? onScenarioManagement;

  @override
  State<RecordingControlsOverlay> createState() => _RecordingControlsOverlayState();
}

class _RecordingControlsOverlayState extends State<RecordingControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          EnhancedRecordingToolbar(
            stageController: widget.stageController,
            playbackController: widget.playbackController,
            controls: widget.controls,
            onScenarioManagement: widget.onScenarioManagement,
          ),
          
          const SizedBox(height: 8),
          
          RecordingStatusIndicator(stageController: widget.stageController),
        ],
      ),
    );
  }
}

/// Enhanced recording toolbar that includes full functionality.
class EnhancedRecordingToolbar extends StatelessWidget {
  /// Creates an enhanced recording toolbar with full control integration.
  const EnhancedRecordingToolbar({
    super.key,
    required this.stageController,
    required this.playbackController,
    required this.controls,
    this.onScenarioManagement,
  });

  /// The stage controller for recording operations.
  final StageController stageController;
  
  /// The playback controller for scenario playback.
  final PlaybackController playbackController;
  
  /// The list of controls for the stage.
  final List<ValueControl> controls;
  
  /// Callback for opening scenario management.
  final VoidCallback? onScenarioManagement;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([stageController, playbackController]),
      builder: (context, child) {
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                EnhancedRecordButton(
                  stageController: stageController,
                  controls: controls,
                ),
                
                const SizedBox(width: 4),
                
                if (_canShowPlayButton)
                  EnhancedPlaybackButton(
                    stageController: stageController,
                    playbackController: playbackController,
                    controls: controls,
                  ),
                
                if (_canShowPlayButton) const SizedBox(width: 4),
                
                if (_canShowSaveButton)
                  SaveButton(stageController: stageController),
                
                if (_canShowSaveButton) const SizedBox(width: 4),
                
                if (onScenarioManagement != null)
                  ScenarioManagementButton(onPressed: onScenarioManagement!),
              ],
            ),
          ),
        );
      },
    );
  }

  bool get _canShowPlayButton {
    return stageController.createScenario(name: 'temp').frames.isNotEmpty;
  }

  bool get _canShowSaveButton {
    return !stageController.isRecording && 
           stageController.createScenario(name: 'temp').frames.isNotEmpty;
  }
}

/// Enhanced record button that properly integrates with controls.
class EnhancedRecordButton extends StatelessWidget {
  /// Creates an enhanced record button with full integration.
  const EnhancedRecordButton({
    super.key,
    required this.stageController,
    required this.controls,
  });

  /// The stage controller for recording operations.
  final StageController stageController;
  
  /// The list of controls for the stage.
  final List<ValueControl> controls;

  @override
  Widget build(BuildContext context) {
    return ToolbarIconButton(
      icon: stageController.isRecording ? Icons.stop : Icons.fiber_manual_record,
      tooltip: stageController.isRecording ? 'Stop Recording' : 'Start Recording',
      onPressed: _handleRecordToggle,
      color: stageController.isRecording ? Colors.red : null,
    );
  }

  void _handleRecordToggle() {
    if (stageController.isRecording) {
      stageController.stopRecording();
    } else {
      // We need access to the canvas controller from the StageBuilder
      // For now, we'll start recording with the controls we have
      stageController.startRecording(controls);
    }
  }
}

/// Enhanced playback button that properly integrates with controls.
class EnhancedPlaybackButton extends StatelessWidget {
  /// Creates an enhanced playback button with full integration.
  const EnhancedPlaybackButton({
    super.key,
    required this.stageController,
    required this.playbackController,
    required this.controls,
  });

  /// The stage controller for recording operations.
  final StageController stageController;
  
  /// The playback controller for scenario playback.
  final PlaybackController playbackController;
  
  /// The list of controls for the stage.
  final List<ValueControl> controls;

  @override
  Widget build(BuildContext context) {
    return ToolbarIconButton(
      icon: _getPlayIcon(),
      tooltip: _getPlayTooltip(),
      onPressed: _handlePlayback,
      color: playbackController.isPlaying ? Colors.green : null,
    );
  }

  void _handlePlayback() {
    if (playbackController.isPlaying) {
      if (playbackController.isPaused) {
        playbackController.resume(controls, null); // TODO: Pass canvas controller
      } else {
        playbackController.pause();
      }
    } else {
      final scenario = stageController.createScenario(name: 'playback');
      if (scenario.frames.isNotEmpty) {
        playbackController.playScenario(scenario, controls: controls);
      }
    }
  }

  IconData _getPlayIcon() {
    if (playbackController.isPlaying) {
      return playbackController.isPaused ? Icons.play_arrow : Icons.pause;
    }
    return Icons.play_arrow;
  }

  String _getPlayTooltip() {
    if (playbackController.isPlaying) {
      return playbackController.isPaused ? 'Resume Playback' : 'Pause Playback';
    }
    return 'Play Scenario';
  }
}

/// Widget that shows recording status information.
class RecordingStatusIndicator extends StatelessWidget {
  /// Creates a recording status indicator.
  const RecordingStatusIndicator({
    super.key,
    required this.stageController,
  });

  /// The stage controller to get status from.
  final StageController stageController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: stageController,
      builder: (context, child) {
        if (!stageController.isRecording) {
          return const SizedBox.shrink();
        }
        
        return Card(
          elevation: 2,
          color: Colors.red[50],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.circle, color: Colors.red, size: 12),
                const SizedBox(width: 4),
                Text(
                  'Recording ${_formatDuration(stageController.recordingDuration)}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
