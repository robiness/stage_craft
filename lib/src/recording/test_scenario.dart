/// Represents a single drawing operation with method, arguments, and widget context.
class DrawingCall {
  /// Creates a drawing call with method, arguments, and widget context.
  const DrawingCall({
    required this.method,
    required this.args,
    required this.widgetName,
    this.widgetKey,
  });

  /// The drawing method name (e.g., 'drawRect', 'drawCircle').
  final String method;
  /// The serialized arguments for the drawing call.
  final Map<String, dynamic> args;
  /// The name of the widget that made this drawing call.
  final String widgetName;
  /// Optional key of the widget that made this drawing call.
  final String? widgetKey;

  /// Converts this drawing call to JSON.
  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'args': args,
      'widgetName': widgetName,
      'widgetKey': widgetKey,
    };
  }

  /// Creates a drawing call from JSON data.
  // ignore: prefer_constructors_over_static_methods
  static DrawingCall fromJson(Map<String, dynamic> json) {
    return DrawingCall(
      method: json['method'] as String,
      args: json['args'] as Map<String, dynamic>,
      widgetName: json['widgetName'] as String,
      widgetKey: json['widgetKey'] as String?,
    );
  }
}

/// Represents a single moment in time with control values, canvas settings, and drawing calls.
class ScenarioFrame {
  /// Creates a scenario frame with timestamp, control values, canvas settings, and drawing calls.
  const ScenarioFrame({
    required this.timestamp,
    required this.controlValues,
    required this.canvasSettings,
    required this.drawingCalls,
  });

  /// The timestamp when this frame was captured relative to recording start.
  final Duration timestamp;
  /// The values of all controls at the time of this frame.
  final Map<String, dynamic> controlValues;
  /// The canvas settings (zoom, ruler, etc.) at the time of this frame.
  final Map<String, dynamic> canvasSettings;
  /// The drawing calls that occurred when rendering this frame.
  final List<DrawingCall> drawingCalls;

  /// Converts this scenario frame to JSON.
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.inMilliseconds,
      'controlValues': controlValues,
      'canvasSettings': canvasSettings,
      'drawingCalls': drawingCalls.map((call) => call.toJson()).toList(),
    };
  }

  /// Creates a scenario frame from JSON data.
  // ignore: prefer_constructors_over_static_methods
  static ScenarioFrame fromJson(Map<String, dynamic> json) {
    final drawingCallsList = json['drawingCalls'] as List;
    return ScenarioFrame(
      timestamp: Duration(milliseconds: json['timestamp'] as int),
      controlValues: json['controlValues'] as Map<String, dynamic>,
      canvasSettings: json['canvasSettings'] as Map<String, dynamic>,
      drawingCalls: drawingCallsList.map((callJson) => DrawingCall.fromJson(callJson as Map<String, dynamic>)).toList(),
    );
  }
}

/// Abstract interface for a test scenario containing multiple frames.
abstract class TestScenario {
  /// The list of frames in this scenario.
  List<ScenarioFrame> get frames;
  /// The name of this scenario.
  String get name;
  /// The total duration of this scenario.
  Duration get totalDuration;
  /// Additional metadata for this scenario.
  Map<String, dynamic> get metadata;

  /// Converts this scenario to JSON.
  Map<String, dynamic> toJson();
  /// Creates a test scenario from JSON data.
  static TestScenario fromJson(Map<String, dynamic> json) {
    return ConcreteTestScenario.fromJson(json);
  }
}

/// Concrete implementation of a test scenario.
class ConcreteTestScenario implements TestScenario {
  /// Creates a concrete test scenario with frames, name, and metadata.
  const ConcreteTestScenario({
    required this.frames,
    required this.name,
    required this.metadata,
  });

  @override
  final List<ScenarioFrame> frames;

  @override
  final String name;

  @override
  final Map<String, dynamic> metadata;

  @override
  Duration get totalDuration => frames.isEmpty ? Duration.zero : frames.last.timestamp;

  @override
  Map<String, dynamic> toJson() {
    return {
      'version': '1.0',
      'name': name,
      'metadata': metadata,
      'totalDuration': totalDuration.inMilliseconds,
      'frames': frames.map((frame) => frame.toJson()).toList(),
    };
  }

  /// Creates a concrete test scenario from JSON data.
  // ignore: prefer_constructors_over_static_methods
  static ConcreteTestScenario fromJson(Map<String, dynamic> json) {
    final framesList = json['frames'] as List;
    return ConcreteTestScenario(
      name: json['name'] as String,
      metadata: json['metadata'] as Map<String, dynamic>,
      frames: framesList.map((frameJson) => ScenarioFrame.fromJson(frameJson as Map<String, dynamic>)).toList(),
    );
  }
}
