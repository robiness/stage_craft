import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/recording/test_scenario.dart';
import 'package:stage_craft/src/stage/stage.dart';

/// Controls the playback of recorded test scenarios with timing and state management.
class PlaybackController extends ChangeNotifier {
  bool _isPlaying = false;
  bool _isPaused = false;
  double _playbackSpeed = 1.0;
  int _currentFrameIndex = 0;
  TestScenario? _currentScenario;
  Timer? _playbackTimer;

  /// Whether a scenario is currently playing.
  bool get isPlaying => _isPlaying;
  /// Whether playback is currently paused.
  bool get isPaused => _isPaused;
  /// The current playback speed multiplier (1.0 = normal speed).
  double get playbackSpeed => _playbackSpeed;
  /// The index of the current frame being played.
  int get currentFrameIndex => _currentFrameIndex;

  /// Sets the playback speed multiplier.
  set playbackSpeed(double speed) {
    if (speed <= 0) throw ArgumentError('Playback speed must be positive');
    _playbackSpeed = speed;
    notifyListeners();
  }

  /// Starts playing the given scenario, applying frames to the provided controls and canvas.
  void playScenario(
    TestScenario scenario, {
    List<ValueControl>? controls,
    StageCanvasController? canvasController,
  }) {
    if (_isPlaying) stop();

    _currentScenario = scenario;
    _currentFrameIndex = 0;
    _isPlaying = true;
    _isPaused = false;

    if (scenario.frames.isEmpty) {
      stop();
      return;
    }

    _scheduleNextFrame(controls, canvasController);
    notifyListeners();
  }

  /// Pauses the current playback.
  void pause() {
    if (!_isPlaying || _isPaused) return;
    
    _isPaused = true;
    _playbackTimer?.cancel();
    notifyListeners();
  }

  /// Resumes paused playback.
  void resume(List<ValueControl>? controls, StageCanvasController? canvasController) {
    if (!_isPlaying || !_isPaused) return;
    
    _isPaused = false;
    _scheduleNextFrame(controls, canvasController);
    notifyListeners();
  }

  /// Stops playback and resets to initial state.
  void stop() {
    _isPlaying = false;
    _isPaused = false;
    _currentFrameIndex = 0;
    _currentScenario = null;
    _playbackTimer?.cancel();
    _playbackTimer = null;
    notifyListeners();
  }

  void _scheduleNextFrame(List<ValueControl>? controls, StageCanvasController? canvasController) {
    if (!_isPlaying || _isPaused || _currentScenario == null) return;

    if (_currentFrameIndex >= _currentScenario!.frames.length) {
      stop();
      return;
    }

    final currentFrame = _currentScenario!.frames[_currentFrameIndex];
    
    _applyFrame(currentFrame, controls, canvasController);
    _currentFrameIndex++;

    if (_currentFrameIndex < _currentScenario!.frames.length) {
      final nextFrame = _currentScenario!.frames[_currentFrameIndex];
      final delay = nextFrame.timestamp - currentFrame.timestamp;
      final adjustedDelay = Duration(
        milliseconds: (delay.inMilliseconds / _playbackSpeed).round(),
      );

      _playbackTimer = Timer(adjustedDelay, () {
        _scheduleNextFrame(controls, canvasController);
      });
    } else {
      // Don't stop immediately, let the caller decide when to stop
      // For single-frame scenarios, we want to remain in playing state
      _playbackTimer = Timer(const Duration(milliseconds: 10), () {
        stop();
      });
    }
  }

  void _applyFrame(
    ScenarioFrame frame,
    List<ValueControl>? controls,
    StageCanvasController? canvasController,
  ) {
    if (controls != null) {
      for (final control in controls) {
        if (frame.controlValues.containsKey(control.label)) {
          control.value = frame.controlValues[control.label];
        }
      }
    }

    if (canvasController != null) {
      final canvasSettings = frame.canvasSettings;
      if (canvasSettings.containsKey('zoomFactor')) {
        canvasController.zoomFactor = canvasSettings['zoomFactor'] as double;
      }
      if (canvasSettings.containsKey('showRuler')) {
        canvasController.showRuler = canvasSettings['showRuler'] as bool;
      }
      if (canvasSettings.containsKey('showCrossHair')) {
        canvasController.showCrossHair = canvasSettings['showCrossHair'] as bool;
      }
      if (canvasSettings.containsKey('textScale')) {
        canvasController.textScale = canvasSettings['textScale'] as double;
      }
    }
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    super.dispose();
  }
}
