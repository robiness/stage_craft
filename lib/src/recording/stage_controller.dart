import 'package:flutter/foundation.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/recording/playback_controller.dart';
import 'package:stage_craft/src/recording/scenario_repository.dart';
import 'package:stage_craft/src/recording/test_scenario.dart';
import 'package:stage_craft/src/stage/stage.dart';

/// Central controller for managing recording state and operations.
class StageController extends ChangeNotifier {
  /// Creates a stage controller with optional scenario repository.
  StageController({ScenarioRepository? scenarioRepository}) : _scenarioRepository = scenarioRepository;

  final ScenarioRepository? _scenarioRepository;

  bool _isRecording = false;
  DateTime? _recordingStartTime;
  final List<ScenarioFrame> _recordedFrames = [];
  List<ValueControl>? _currentControls;
  StageCanvasController? _currentCanvasController;

  /// Whether recording is currently active.
  bool get isRecording => _isRecording;

  /// The duration of the current recording session.
  Duration get recordingDuration {
    if (!_isRecording || _recordingStartTime == null) {
      return Duration.zero;
    }
    return DateTime.now().difference(_recordingStartTime!);
  }

  /// Starts recording with the given controls and optional canvas controller.
  void startRecording(List<ValueControl> controls, [StageCanvasController? canvasController]) {
    if (_isRecording) return;

    _isRecording = true;
    _recordingStartTime = DateTime.now();
    _recordedFrames.clear();
    _currentControls = controls;
    _currentCanvasController = canvasController;

    notifyListeners();
  }

  /// Stops the current recording session.
  void stopRecording() {
    if (!_isRecording) return;

    _isRecording = false;
    _recordingStartTime = null;
    _currentControls = null;
    _currentCanvasController = null;

    notifyListeners();
  }

  /// Cancels the current recording and clears all recorded data.
  void cancelRecording() {
    if (!_isRecording) return;

    _isRecording = false;
    _recordingStartTime = null;
    _recordedFrames.clear();
    _currentControls = null;
    _currentCanvasController = null;

    notifyListeners();
  }

  /// Captures the current state and drawing calls as a new frame.
  void captureFrame(List<DrawingCall> drawingCalls) {
    if (!_isRecording || _recordingStartTime == null || _currentControls == null) return;

    final timestamp = DateTime.now().difference(_recordingStartTime!);

    final controlValues = <String, dynamic>{};
    for (final control in _currentControls!) {
      controlValues[control.label] = control.value;
    }

    final canvasSettings = <String, dynamic>{
      if (_currentCanvasController != null) ...{
        'zoomFactor': _currentCanvasController!.zoomFactor,
        'showRuler': _currentCanvasController!.showRuler,
        'showCrossHair': _currentCanvasController!.showCrossHair,
        'textScale': _currentCanvasController!.textScale,
      }
    };

    final frame = ScenarioFrame(
      timestamp: timestamp,
      controlValues: controlValues,
      canvasSettings: canvasSettings,
      drawingCalls: drawingCalls,
    );

    _recordedFrames.add(frame);
  }

  /// Saves a scenario using the configured repository.
  Future<void> saveScenario(TestScenario scenario) async {
    if (_scenarioRepository == null) {
      throw StateError('No ScenarioRepository provided to StageController');
    }
    await _scenarioRepository!.saveScenario(scenario);
  }

  /// Loads a scenario using the configured repository.
  Future<TestScenario> loadScenario() async {
    if (_scenarioRepository == null) {
      throw StateError('No ScenarioRepository provided to StageController');
    }
    return await _scenarioRepository!.loadScenario();
  }

  /// Plays a scenario using a new playback controller.
  void playScenario(
    TestScenario scenario, {
    List<ValueControl>? controls,
    StageCanvasController? canvasController,
  }) {
    final playbackController = PlaybackController();
    playbackController.playScenario(scenario, controls: controls, canvasController: canvasController);
  }

  /// Creates a scenario from the currently recorded frames.
  TestScenario createScenario({required String name, Map<String, dynamic>? metadata}) {
    return ConcreteTestScenario(
      name: name,
      metadata: metadata ?? {},
      frames: List.from(_recordedFrames),
    );
  }
}
