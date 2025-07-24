import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:stage_craft/src/recording/test_scenario.dart';

/// Repository interface for saving and loading test scenarios.
abstract class ScenarioRepository {
  /// Saves a test scenario.
  Future<void> saveScenario(TestScenario scenario);
  /// Loads a test scenario.
  Future<TestScenario> loadScenario();
}

/// File-based implementation of scenario repository.
class FileScenarioRepository implements ScenarioRepository {
  /// Creates a file scenario repository with optional default directory.
  FileScenarioRepository({this.defaultDirectory});

  /// Default directory for saving scenarios.
  final String? defaultDirectory;

  @override
  Future<void> saveScenario(TestScenario scenario) async {
    if (kIsWeb) {
      throw UnsupportedError('File operations not supported on web platform');
    }

    final directory = defaultDirectory ?? Directory.current.path;
    final fileName = '${scenario.name.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.json';
    final file = File('$directory/$fileName');

    final jsonString = const JsonEncoder.withIndent('  ').convert(scenario.toJson());
    await file.writeAsString(jsonString);
  }

  @override
  Future<TestScenario> loadScenario() {
    if (kIsWeb) {
      throw UnsupportedError('File operations not supported on web platform');
    }

    throw UnimplementedError('File picker for loading scenarios not yet implemented. '
        'For now, manually provide the file path to loadScenarioFromFile()');
  }

  /// Loads a scenario from a specific file path.
  Future<TestScenario> loadScenarioFromFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw FileSystemException('Scenario file not found', filePath);
    }

    final jsonString = await file.readAsString();
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    return TestScenario.fromJson(jsonData);
  }
}
