/// Base interface for a recorded test scenario, which can contain multiple data types.
abstract class TestScenario {
  /// The initial state needed to set up the test.
  Map<String, dynamic> get initialState;

  /// A collection of recorded data, keyed by the recorder type.
  Map<Type, dynamic> get recordings;

  /// Metadata about the scenario (name, description, timestamp, etc.).
  Map<String, dynamic> get metadata;

  /// Serializes the entire scenario to a JSON object.
  Map<String, dynamic> toJson();

  /// Creates a scenario from a JSON object.
  static TestScenario fromJson(Map<String, dynamic> json) {
    return ConcreteTestScenario.fromJson(json);
  }
}

/// Concrete implementation of [TestScenario].
class ConcreteTestScenario implements TestScenario {
  const ConcreteTestScenario({
    required this.initialState,
    required this.recordings,
    required this.metadata,
  });

  @override
  final Map<String, dynamic> initialState;

  @override
  final Map<Type, dynamic> recordings;

  @override
  final Map<String, dynamic> metadata;

  @override
  Map<String, dynamic> toJson() {
    return {
      'version': '1.0',
      'metadata': metadata,
      'initialState': initialState,
      'recordings': recordings.map((type, data) => MapEntry(
        type.toString(),
        data,
      )),
    };
  }

  static ConcreteTestScenario fromJson(Map<String, dynamic> json) {
    // Type reconstruction would need to be implemented based on recorder types
    throw UnimplementedError('Deserialization needs recorder type registry');
  }

  /// Creates a scenario with the given initial state and no recordings.
  static ConcreteTestScenario empty({
    Map<String, dynamic>? initialState,
    Map<String, dynamic>? metadata,
  }) {
    return ConcreteTestScenario(
      initialState: initialState ?? {},
      recordings: {},
      metadata: metadata ?? {
        'timestamp': DateTime.now().toIso8601String(),
        'version': '1.0',
      },
    );
  }

  /// Creates a new scenario with additional recordings added.
  ConcreteTestScenario withRecording<T>(Type recorderType, T data) {
    return ConcreteTestScenario(
      initialState: initialState,
      recordings: {...recordings, recorderType: data},
      metadata: metadata,
    );
  }
}