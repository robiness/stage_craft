Epic 1: Core Recording & Playback Engine
As a developer, I need a reliable way to record, save, load, and replay the state of my widget and its controls so that I can reproduce bugs and specific configurations.

User Story 1.1: Record State Changes
Task 1.1.1: Add isRecording flag and recordingDuration property to StageController.

Task 1.1.2: Implement startRecording, stopRecording, and cancelRecording methods on StageController.

Task 1.1.3: Create a ListenableGroup that aggregates all ValueControl instances provided to the StageBuilder. This group will notify a single listener of any change in any control.

Task 1.1.4: In startRecording, attach a single listener to the ListenableGroup and the StageCanvasController.

Task 1.1.5: On any listener event, capture the complete state of all controls and canvas settings into a new ScenarioFrame object. This frame must include a Duration timestamp indicating the time since the recording started.

Task 1.1.6: In stopRecording, detach all listeners from the ListenableGroup and StageCanvasController.

User Story 1.2: Persist and Manage Scenarios via a Service
Task 1.2.1: Define an abstract class ScenarioService with methods Future<void> saveScenario(TestScenario scenario) and Future<TestScenario> loadScenario().

Task 1.2.2: Create a concrete implementation FileScenarioService that uses a file picker for saving and loading. This keeps the persistence logic separate from the controller.

Task 1.2.3: The StageController will now hold a reference to a ScenarioService instance.

Task 1.2.4: The saveScenario and loadScenario methods on the StageController will now delegate their calls to the ScenarioService.

User Story 1.3: Replay a Scenario with Timed Playback
Task 1.3.1: Create a new PlaybackController to manage the state of playback (e.g., isPlaying, isPaused, current frame index, playback speed).

Task 1.3.2: Implement a playScenario(TestScenario scenario) method on the StageController that initializes and starts the PlaybackController.

Task 1.3.3: The PlaybackController will use the timestamp on each ScenarioFrame to drive a Timer or Ticker, applying each frame's state to the StageController and ValueControls at the correct time.

Epic 2: UI & In-Stage Development Workflow
As a developer, I need clear and intuitive UI elements to manage recordings and scenarios, and these features must integrate seamlessly with the existing "in-stage" workflow.

User Story 2.1: Control Recording from a Toolbar
Task 2.1.1: Implement a RecordingToolbar widget to replace the simple FAB.

Task 2.1.2: The toolbar should contain IconButtons for "Record," "Stop," "Play," and "Save," each with a descriptive tooltip.

Task 2.1.3: The state and onPressed callbacks of the toolbar buttons will be bound to the StageController and PlaybackController.

User Story 2.2: Manage Scenarios from an Integrated UI
Task 2.2.1: Implement a ScenarioManagementDrawer that can be opened from the side of the stage.

Task 2.2.2: The drawer will contain "Save Scenario" and "Load Scenario" buttons that call the StageController methods.

Task 2.2.3: (Future Enhancement) This drawer can later be expanded to show a list of recently loaded scenarios or include an integrated JSON viewer/editor.

Epic 3: Advanced Testing & Verification
As a developer, I want to capture the precise visual output of my widget and generate automated tests from my recordings to build a robust regression suite.

User Story 3.1: Record Visual Drawing Calls
Task 3.1.1: Create a RecordingCanvas class that implements the complete dart:ui.Canvas interface.

Task 3.1.2: Each method implementation will serialize its name and arguments into a DrawingCall object and add it to the current frame's list.

Task 3.1.3: Update the ScenarioFrame data model to include List<DrawingCall> drawingCalls.

User Story 3.2: Generate Versatile Test Files
Task 3.2.1: Create a TestGenerator service that takes a TestScenario and outputs a test file string.

Task 3.2.2: The generator must support creating assertions for both DrawingCall comparison and, optionally, matchesGoldenFile for specific frames.

Task 3.2.3: Implement a "Generate Test" button in the ScenarioManagementDrawer that uses this service.
