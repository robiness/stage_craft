import 'package:flutter/material.dart';

import 'package:stage_craft/src/recording/stage_controller.dart';

/// A drawer widget that provides scenario management functionality.
/// Contains buttons for saving and loading scenarios, with potential for future enhancements.
class ScenarioManagementDrawer extends StatefulWidget {
  /// Creates a scenario management drawer with the given stage controller.
  const ScenarioManagementDrawer({
    super.key,
    required this.stageController,
    this.onClose,
  });

  /// The stage controller that manages scenarios.
  final StageController stageController;
  
  /// Optional callback when the drawer should be closed.
  final VoidCallback? onClose;

  @override
  State<ScenarioManagementDrawer> createState() => _ScenarioManagementDrawerState();
}

class _ScenarioManagementDrawerState extends State<ScenarioManagementDrawer> {
  String _scenarioName = '';
  bool _isLoading = false;
  String? _statusMessage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.video_library,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Scenario Management',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                if (widget.onClose != null)
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: widget.onClose,
                  ),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  CurrentScenarioInfo(stageController: widget.stageController),
                  
                  const SizedBox(height: 24),
                  
                  ScenarioNameInput(
                    scenarioName: _scenarioName,
                    onChanged: (value) => setState(() => _scenarioName = value),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  SaveScenarioButton(
                    stageController: widget.stageController,
                    scenarioName: _scenarioName,
                    isLoading: _isLoading,
                    onSaveStart: () => setState(() {
                      _isLoading = true;
                      _statusMessage = null;
                    }),
                    onSaveComplete: (success, message) => setState(() {
                      _isLoading = false;
                      _statusMessage = message;
                    }),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  LoadScenarioButton(
                    stageController: widget.stageController,
                    isLoading: _isLoading,
                    onLoadStart: () => setState(() {
                      _isLoading = true;
                      _statusMessage = null;
                    }),
                    onLoadComplete: (success, message) => setState(() {
                      _isLoading = false;
                      _statusMessage = message;
                    }),
                  ),
                  
                  if (_statusMessage != null) ...[
                    const SizedBox(height: 16),
                    StatusMessage(message: _statusMessage!),
                  ],
                  
                  const SizedBox(height: 24),
                  
                  const FutureEnhancementsPlaceholder(),
                ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget that displays information about the current scenario.
class CurrentScenarioInfo extends StatelessWidget {
  /// Creates a current scenario info widget.
  const CurrentScenarioInfo({
    super.key,
    required this.stageController,
  });

  /// The stage controller to get scenario information from.
  final StageController stageController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: stageController,
      builder: (context, child) {
        final tempScenario = stageController.createScenario(name: 'temp');
        final hasFrames = tempScenario.frames.isNotEmpty;
        
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Session',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text('Recording: ${stageController.isRecording ? "Active" : "Stopped"}'),
                Text('Frames: ${tempScenario.frames.length}'),
                Text('Duration: ${tempScenario.totalDuration.inMilliseconds}ms'),
                if (!hasFrames)
                  const Text(
                    'No frames recorded yet',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Widget for inputting scenario names.
class ScenarioNameInput extends StatelessWidget {
  /// Creates a scenario name input widget.
  const ScenarioNameInput({
    super.key,
    required this.scenarioName,
    required this.onChanged,
  });

  /// The current scenario name.
  final String scenarioName;
  
  /// Callback when the scenario name changes.
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Scenario Name',
        hintText: 'Enter a name for your scenario',
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}

/// Widget for saving scenarios.
class SaveScenarioButton extends StatelessWidget {
  /// Creates a save scenario button.
  const SaveScenarioButton({
    super.key,
    required this.stageController,
    required this.scenarioName,
    required this.isLoading,
    required this.onSaveStart,
    required this.onSaveComplete,
  });

  /// The stage controller to save scenarios with.
  final StageController stageController;
  
  /// The name for the scenario.
  final String scenarioName;
  
  /// Whether a save operation is in progress.
  final bool isLoading;
  
  /// Callback when save starts.
  final VoidCallback onSaveStart;
  
  /// Callback when save completes.
  final void Function(bool success, String message) onSaveComplete;

  @override
  Widget build(BuildContext context) {
    final hasFrames = stageController.createScenario(name: 'temp').frames.isNotEmpty;
    final canSave = hasFrames && scenarioName.trim().isNotEmpty && !isLoading;
    
    return ElevatedButton.icon(
      onPressed: canSave ? _handleSave : null,
      icon: isLoading ? const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ) : const Icon(Icons.save),
      label: Text(isLoading ? 'Saving...' : 'Save Scenario'),
    );
  }

  Future<void> _handleSave() async {
    onSaveStart();
    
    try {
      final scenario = stageController.createScenario(
        name: scenarioName.trim(),
        metadata: {
          'createdAt': DateTime.now().toIso8601String(),
          'description': 'Saved from scenario management drawer',
        },
      );
      
      await stageController.saveScenario(scenario);
      onSaveComplete(true, 'Scenario saved successfully!');
    } catch (e) {
      onSaveComplete(false, 'Failed to save scenario: $e');
    }
  }
}

/// Widget for loading scenarios.
class LoadScenarioButton extends StatelessWidget {
  /// Creates a load scenario button.
  const LoadScenarioButton({
    super.key,
    required this.stageController,
    required this.isLoading,
    required this.onLoadStart,
    required this.onLoadComplete,
  });

  /// The stage controller to load scenarios with.
  final StageController stageController;
  
  /// Whether a load operation is in progress.
  final bool isLoading;
  
  /// Callback when load starts.
  final VoidCallback onLoadStart;
  
  /// Callback when load completes.
  final void Function(bool success, String message) onLoadComplete;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: !isLoading ? _handleLoad : null,
      icon: isLoading ? const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ) : const Icon(Icons.folder_open),
      label: Text(isLoading ? 'Loading...' : 'Load Scenario'),
    );
  }

  Future<void> _handleLoad() async {
    onLoadStart();
    
    try {
      await stageController.loadScenario();
      onLoadComplete(true, 'Scenario loaded successfully!');
    } catch (e) {
      onLoadComplete(false, 'Failed to load scenario: $e');
    }
  }
}

/// Widget for displaying status messages.
class StatusMessage extends StatelessWidget {
  /// Creates a status message widget.
  const StatusMessage({
    super.key,
    required this.message,
  });

  /// The message to display.
  final String message;

  @override
  Widget build(BuildContext context) {
    final isSuccess = message.contains('successfully');
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSuccess 
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.red.withValues(alpha: 0.1),
        border: Border.all(
          color: isSuccess ? Colors.green : Colors.red,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isSuccess ? Colors.green[800] : Colors.red[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Placeholder widget for future enhancements.
class FutureEnhancementsPlaceholder extends StatelessWidget {
  /// Creates a future enhancements placeholder.
  const FutureEnhancementsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Future Enhancements',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              '• Recent scenarios list\n'
              '• Scenario preview\n'
              '• JSON viewer/editor\n'
              '• Scenario metadata editing',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
