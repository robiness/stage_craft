import 'package:flutter/material.dart';

import 'package:stage_craft/src/recording/playback_controller.dart';
import 'package:stage_craft/src/recording/stage_controller.dart';

/// A toolbar widget that provides recording controls for the stage.
/// Contains buttons for Record, Stop, Play, and Save operations with tooltips.
class RecordingToolbar extends StatelessWidget {
  /// Creates a recording toolbar with the given controllers.
  const RecordingToolbar({
    super.key,
    required this.stageController,
    this.playbackController,
    this.onScenarioManagement,
  });

  /// The stage controller that manages recording state.
  final StageController stageController;
  
  /// Optional playback controller for scenario replay.
  final PlaybackController? playbackController;
  
  /// Callback for opening scenario management interface.
  final VoidCallback? onScenarioManagement;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        stageController,
        if (playbackController != null) playbackController!,
      ]),
      builder: (context, child) {
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RecordButton(stageController: stageController),
                
                const SizedBox(width: 4),
                
                if (_canShowPlayButton)
                  PlaybackButton(playbackController: playbackController),
                
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
    return playbackController != null || 
           stageController.hasRecordedFrames;
  }

  bool get _canShowSaveButton {
    return !stageController.isRecording && 
           stageController.hasRecordedFrames;
  }
}

/// Button widget for recording control (start/stop recording).
class RecordButton extends StatelessWidget {
  /// Creates a record button that toggles recording state.
  const RecordButton({
    super.key,
    required this.stageController,
  });

  /// The stage controller that manages recording state.
  final StageController stageController;

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
      // Note: This requires controls and canvas controller from parent
      // We'll need to pass these in when integrating with StageBuilder
    }
  }
}

/// Button widget for playback control (play/pause/stop).
class PlaybackButton extends StatelessWidget {
  /// Creates a playback button that controls scenario replay.
  const PlaybackButton({
    super.key,
    this.playbackController,
  });

  /// Optional playback controller for scenario replay.
  final PlaybackController? playbackController;

  @override
  Widget build(BuildContext context) {
    return ToolbarIconButton(
      icon: _getPlayIcon(),
      tooltip: _getPlayTooltip(),
      onPressed: _handlePlayback,
      color: playbackController?.isPlaying == true ? Colors.green : null,
    );
  }

  void _handlePlayback() {
    if (playbackController != null) {
      if (playbackController!.isPlaying) {
        if (playbackController!.isPaused) {
          // Resume implementation would need controls and canvas controller
          // playbackController!.resume(controls, canvasController);
        } else {
          playbackController!.pause();
        }
      } else {
        playbackController!.stop();
      }
    }
  }

  IconData _getPlayIcon() {
    if (playbackController?.isPlaying == true) {
      return playbackController!.isPaused ? Icons.play_arrow : Icons.pause;
    }
    return Icons.play_arrow;
  }

  String _getPlayTooltip() {
    if (playbackController?.isPlaying == true) {
      return playbackController!.isPaused ? 'Resume Playback' : 'Pause Playback';
    }
    return 'Play Scenario';
  }
}

/// Button widget for saving scenarios.
class SaveButton extends StatelessWidget {
  /// Creates a save button that saves the current scenario.
  const SaveButton({
    super.key,
    required this.stageController,
  });

  /// The stage controller that manages recording state.
  final StageController stageController;

  @override
  Widget build(BuildContext context) {
    return ToolbarIconButton(
      icon: Icons.save,
      tooltip: 'Save Scenario',
      onPressed: _handleSave,
    );
  }

  void _handleSave() {
    final scenario = stageController.createScenario(
      name: 'Recorded Scenario ${DateTime.now().millisecondsSinceEpoch}',
      metadata: {
        'createdAt': DateTime.now().toIso8601String(),
        'duration': stageController.recordingDuration.inMilliseconds,
      },
    );
    
    stageController.saveScenario(scenario);
  }
}

/// Button widget for opening scenario management interface.
class ScenarioManagementButton extends StatelessWidget {
  /// Creates a scenario management button.
  const ScenarioManagementButton({
    super.key,
    required this.onPressed,
  });

  /// Callback for opening scenario management interface.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ToolbarIconButton(
      icon: Icons.folder_open,
      tooltip: 'Manage Scenarios',
      onPressed: onPressed,
    );
  }
}

/// Reusable icon button widget for the recording toolbar.
class ToolbarIconButton extends StatelessWidget {
  /// Creates a toolbar icon button with tooltip and optional color.
  const ToolbarIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color,
  });

  /// The icon to display in the button.
  final IconData icon;
  
  /// The tooltip text for the button.
  final String tooltip;
  
  /// Callback when the button is pressed.
  final VoidCallback? onPressed;
  
  /// Optional color for the icon.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
