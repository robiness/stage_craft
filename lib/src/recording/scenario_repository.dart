import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

/// SharedPreferences-based implementation of scenario repository.
class SharedPreferencesScenarioRepository implements ScenarioRepository {
  static const String _keyPrefix = 'scenario_';
  static const String _scenarioListKey = 'scenario_list';

  @override
  Future<void> saveScenario(TestScenario scenario) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix${DateTime.now().millisecondsSinceEpoch}';
    
    final jsonString = const JsonEncoder.withIndent('  ').convert(scenario.toJson());
    await prefs.setString(key, jsonString);
    
    // Add to scenario list
    final scenarioList = prefs.getStringList(_scenarioListKey) ?? [];
    scenarioList.add(key);
    await prefs.setStringList(_scenarioListKey, scenarioList);
  }

  @override
  Future<TestScenario> loadScenario() async {
    final prefs = await SharedPreferences.getInstance();
    final scenarioList = prefs.getStringList(_scenarioListKey) ?? [];
    
    if (scenarioList.isEmpty) {
      throw StateError('No scenarios found in storage');
    }
    
    // Load the most recent scenario
    final latestKey = scenarioList.last;
    final jsonString = prefs.getString(latestKey);
    
    if (jsonString == null) {
      throw StateError('Scenario data not found for key: $latestKey');
    }
    
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    return TestScenario.fromJson(jsonData);
  }

  /// Gets all saved scenario keys.
  Future<List<String>> getScenarioKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_scenarioListKey) ?? [];
  }

  /// Loads a specific scenario by key.
  Future<TestScenario> loadScenarioByKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    
    if (jsonString == null) {
      throw StateError('Scenario not found for key: $key');
    }
    
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    return TestScenario.fromJson(jsonData);
  }

  /// Deletes a scenario by key.
  Future<void> deleteScenario(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    
    // Remove from scenario list
    final scenarioList = prefs.getStringList(_scenarioListKey) ?? [];
    scenarioList.remove(key);
    await prefs.setStringList(_scenarioListKey, scenarioList);
  }

  /// Clears all scenarios.
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    final scenarioList = prefs.getStringList(_scenarioListKey) ?? [];
    
    // Remove all scenario data
    for (final key in scenarioList) {
      await prefs.remove(key);
    }
    
    // Clear the scenario list
    await prefs.remove(_scenarioListKey);
  }
}
