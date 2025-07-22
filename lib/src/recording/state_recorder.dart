import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/stage/stage.dart';
import 'package:stage_craft/src/recording/recorder.dart';
import 'package:stage_craft/src/recording/serialization.dart';

/// A recorded state change event.
class StateChangeEvent {
  const StateChangeEvent({
    required this.timestamp,
    required this.controlLabel,
    required this.oldValue,
    required this.newValue,
  });

  /// When the change occurred.
  final DateTime timestamp;

  /// The label of the control that changed.
  final String controlLabel;

  /// The previous value (serialized).
  final Map<String, dynamic>? oldValue;

  /// The new value (serialized).
  final Map<String, dynamic>? newValue;

  /// Converts this event to JSON.
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'controlLabel': controlLabel,
      'oldValue': oldValue,
      'newValue': newValue,
    };
  }

  /// Creates an event from JSON.
  static StateChangeEvent fromJson(Map<String, dynamic> json) {
    return StateChangeEvent(
      timestamp: DateTime.parse(json['timestamp'] as String),
      controlLabel: json['controlLabel'] as String,
      oldValue: json['oldValue'] as Map<String, dynamic>?,
      newValue: json['newValue'] as Map<String, dynamic>?,
    );
  }
}

/// A recorded canvas state change.
class CanvasStateEvent {
  const CanvasStateEvent({
    required this.timestamp,
    required this.property,
    required this.oldValue,
    required this.newValue,
  });

  /// When the change occurred.
  final DateTime timestamp;

  /// The canvas property that changed (e.g., 'zoom', 'showRuler').
  final String property;

  /// The previous value.
  final dynamic oldValue;

  /// The new value.
  final dynamic newValue;

  /// Converts this event to JSON.
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'property': property,
      'oldValue': oldValue,
      'newValue': newValue,
    };
  }

  /// Creates an event from JSON.
  static CanvasStateEvent fromJson(Map<String, dynamic> json) {
    return CanvasStateEvent(
      timestamp: DateTime.parse(json['timestamp'] as String),
      property: json['property'] as String,
      oldValue: json['oldValue'],
      newValue: json['newValue'],
    );
  }
}

/// Data structure for all recorded state changes.
class StateRecordingData {
  const StateRecordingData({
    required this.initialControlStates,
    required this.initialCanvasState,
    required this.stateChanges,
    required this.canvasChanges,
  });

  /// Initial state of all controls when recording started.
  final Map<String, Map<String, dynamic>?> initialControlStates;

  /// Initial canvas state when recording started.
  final Map<String, dynamic> initialCanvasState;

  /// All control state change events.
  final List<StateChangeEvent> stateChanges;

  /// All canvas state change events.
  final List<CanvasStateEvent> canvasChanges;

  /// Converts this data to JSON.
  Map<String, dynamic> toJson() {
    return {
      'initialControlStates': initialControlStates,
      'initialCanvasState': initialCanvasState,
      'stateChanges': stateChanges.map((e) => e.toJson()).toList(),
      'canvasChanges': canvasChanges.map((e) => e.toJson()).toList(),
    };
  }

  /// Creates data from JSON.
  static StateRecordingData fromJson(Map<String, dynamic> json) {
    return StateRecordingData(
      initialControlStates: (json['initialControlStates'] as Map<String, dynamic>)
          .cast<String, Map<String, dynamic>?>(),
      initialCanvasState: json['initialCanvasState'] as Map<String, dynamic>,
      stateChanges: (json['stateChanges'] as List)
          .map((e) => StateChangeEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      canvasChanges: (json['canvasChanges'] as List)
          .map((e) => CanvasStateEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Records state changes from ValueControl instances and canvas state.
class StateRecorder implements Recorder<StateRecordingData> {
  StateRecorder({
    required this.controls,
    this.canvasController,
  });

  /// The controls to monitor for changes.
  final List<ValueControl> controls;

  /// The canvas controller to monitor (optional).
  final StageCanvasController? canvasController;

  bool _isRecording = false;
  final List<StateChangeEvent> _stateChanges = [];
  final List<CanvasStateEvent> _canvasChanges = [];
  final Map<String, dynamic> _previousControlValues = {};
  Map<String, dynamic> _previousCanvasState = {};
  Map<String, Map<String, dynamic>?> _initialControlStates = {};
  Map<String, dynamic> _initialCanvasState = {};

  @override
  bool get isRecording => _isRecording;

  @override
  StateRecordingData get data {
    return StateRecordingData(
      initialControlStates: Map.from(_initialControlStates),
      initialCanvasState: Map.from(_initialCanvasState),
      stateChanges: List.from(_stateChanges),
      canvasChanges: List.from(_canvasChanges),
    );
  }

  @override
  void start() {
    if (_isRecording) return;

    _isRecording = true;
    clear();

    // Capture initial states
    _captureInitialStates();

    // Start listening to changes
    for (final control in controls) {
      control.addListener(() => _onControlChanged(control));
    }

    canvasController?.addListener(_onCanvasChanged);
  }

  @override
  void stop() {
    if (!_isRecording) return;

    _isRecording = false;

    // Stop listening to changes
    for (final control in controls) {
      control.removeListener(() => _onControlChanged(control));
    }

    canvasController?.removeListener(_onCanvasChanged);
  }

  @override
  void clear() {
    _stateChanges.clear();
    _canvasChanges.clear();
    _previousControlValues.clear();
    _previousCanvasState.clear();
    _initialControlStates.clear();
    _initialCanvasState.clear();
  }

  void _captureInitialStates() {
    // Capture initial control states
    for (final control in controls) {
      final serializedValue = SerializerRegistry.serializeValue(control.value);
      _initialControlStates[control.label] = serializedValue;
      _previousControlValues[control.label] = control.value;
    }

    // Capture initial canvas state
    if (canvasController != null) {
      _initialCanvasState = _serializeCanvasState(canvasController!);
      _previousCanvasState = Map.from(_initialCanvasState);
    }
  }

  void _onControlChanged(ValueControl control) {
    if (!_isRecording) return;

    final oldValue = _previousControlValues[control.label];
    final newValue = control.value;

    if (oldValue != newValue) {
      final event = StateChangeEvent(
        timestamp: DateTime.now(),
        controlLabel: control.label,
        oldValue: SerializerRegistry.serializeValue(oldValue),
        newValue: SerializerRegistry.serializeValue(newValue),
      );

      _stateChanges.add(event);
      _previousControlValues[control.label] = newValue;
    }
  }

  void _onCanvasChanged() {
    if (!_isRecording || canvasController == null) return;

    final currentState = _serializeCanvasState(canvasController!);
    
    // Check each property for changes
    for (final entry in currentState.entries) {
      final property = entry.key;
      final newValue = entry.value;
      final oldValue = _previousCanvasState[property];

      if (oldValue != newValue) {
        final event = CanvasStateEvent(
          timestamp: DateTime.now(),
          property: property,
          oldValue: oldValue,
          newValue: newValue,
        );

        _canvasChanges.add(event);
      }
    }

    _previousCanvasState = currentState;
  }

  Map<String, dynamic> _serializeCanvasState(StageCanvasController controller) {
    return {
      'zoomFactor': controller.zoomFactor,
      'showRuler': controller.showRuler,
      'forceSize': controller.forceSize,
      'showCrossHair': controller.showCrossHair,
      'textScale': controller.textScale,
    };
  }
}

/// Extension to add null-safe let functionality.
extension LetExtension<T> on T? {
  /// Applies [operation] if this value is not null.
  R? let<R>(R Function(T) operation) {
    final value = this;
    return value != null ? operation(value) : null;
  }
}