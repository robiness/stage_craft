import 'package:freezed_annotation/freezed_annotation.dart';

part 'recording_state.freezed.dart';
part 'recording_state.g.dart';

@freezed  
class RecordingState with _$RecordingState {
  /// Represents the current state of the recording system.
  /// 
  /// This is a sealed union type that ensures all possible states are handled
  /// explicitly throughout the application. Each state represents a distinct
  /// mode of operation with different available actions, UI behavior, and
  /// system capabilities.
  /// 
  /// The union type design provides compile-time safety by forcing exhaustive
  /// handling of all states using pattern matching with the `when` method.
  /// This prevents bugs from unhandled state transitions or missing UI updates.
  /// 
  /// State transition flow:
  /// ```
  /// idle → recording → idle (normal recording workflow)
  /// idle → playing → paused → playing → idle (playback workflow)  
  /// idle → playing → idle (direct stop during playback)
  /// playing → idle (stop playback without pausing)
  /// paused → idle (stop from paused state)
  /// 
  /// Invalid transitions (prevented by design):
  /// recording → playing (must stop recording first)
  /// recording → paused (not applicable)
  /// ```
  /// 
  /// Example usage with type-safe pattern matching:
  /// ```dart
  /// final state = RecordingState.recording();
  /// 
  /// // Exhaustive pattern matching - compiler ensures all states handled
  /// final canRecord = state.when(
  ///   idle: () => true,
  ///   recording: () => false,
  ///   playing: () => false,
  ///   paused: () => false,
  /// );
  /// 
  /// // Partial matching with fallback
  /// final buttonIcon = state.maybeWhen(
  ///   idle: () => Icons.fiber_manual_record,
  ///   recording: () => Icons.stop,
  ///   orElse: () => Icons.play_arrow, // covers playing and paused
  /// );
  /// ```

  /// System is idle - ready to start recording or playback.
  /// 
  /// This is the default state when the recording system is initialized
  /// and the state after stopping any recording or playback operation.
  /// 
  /// **Available actions:**
  /// - Start new recording session
  /// - Load and play existing scenario
  /// - Load scenario from storage
  /// - Browse recorded scenarios
  /// - Configure recording settings
  /// 
  /// **UI behavior:**
  /// - Record button shows record icon (red circle)
  /// - Play button shows play icon (triangle)
  /// - All controls are fully interactive
  /// - Canvas can be manipulated freely by user
  /// - Timeline scrubber is available for loaded scenarios
  /// 
  /// **System behavior:**
  /// - No frame capture occurring
  /// - No change listeners active
  /// - Minimal resource usage
  /// - Ready for immediate action
  /// 
  /// **Data access:**
  /// - StateFrames: Read-only access to loaded scenarios
  /// - DrawingFrames: Read-only access to loaded scenarios
  /// - Current timeline position: Available if scenario loaded
  const factory RecordingState.idle() = _Idle;

  /// System is actively recording user interactions.
  /// 
  /// In this state, the system captures both StateFrames (control + canvas
  /// changes) and DrawingFrames (paint operations) in real-time as the user
  /// interacts with the widget and canvas.
  /// 
  /// **Available actions:**
  /// - Stop recording (saves current session)
  /// - Cancel recording (discards current session)
  /// - Continue interacting with controls/canvas (captured automatically)
  /// - Monitor recording progress and statistics
  /// 
  /// **UI behavior:**
  /// - Record button shows stop icon (red square) with recording indicator
  /// - Play button is disabled
  /// - Controls remain fully interactive (changes are captured)
  /// - Canvas interactions are captured (zoom, pan, etc.)
  /// - Recording indicator shows elapsed time and frame count
  /// - Real-time recording statistics may be displayed
  /// 
  /// **System behavior:**
  /// - Change listeners active on all controls and canvas
  /// - StateFrame capture triggered by control/canvas changes
  /// - DrawingFrame capture triggered by widget redraws (if enabled)
  /// - Debounced frame capture to avoid excessive data
  /// - Memory usage increases with recording length
  /// 
  /// **Performance considerations:**
  /// - Drawing capture adds ~5ms overhead per paint operation
  /// - StateFrame capture is lightweight (~1ms per change)
  /// - Memory usage grows linearly with interaction frequency
  /// - Long recordings may require periodic optimization
  /// 
  /// **Data access:**
  /// - StateFrames: Growing list of captured state changes
  /// - DrawingFrames: Growing list of captured drawing operations
  /// - Recording statistics: Duration, frame counts, memory usage
  const factory RecordingState.recording() = _Recording;

  /// System is playing back a recorded scenario.
  /// 
  /// During playback, the system applies StateFrames from a recorded scenario
  /// in precise timing sequence, causing the widget to animate through the
  /// recorded interaction timeline. DrawingFrames are ignored during playback.
  /// 
  /// **Available actions:**
  /// - Pause playback (preserves current position)
  /// - Stop playback (returns to idle state)
  /// - Adjust playback speed (1x, 2x, 0.5x, etc.)
  /// - Scrub timeline to different position (future feature)
  /// 
  /// **UI behavior:**
  /// - Play button shows pause icon
  /// - Stop button is available
  /// - Controls are updated automatically (not user-interactive)
  /// - Canvas view animates according to recorded timeline
  /// - Playback progress indicator shows current position
  /// - Timeline scrubber follows playback position
  /// 
  /// **System behavior:**
  /// - StateFrames applied at precise timestamps
  /// - Controls updated programmatically (no user input)
  /// - Canvas state updated programmatically
  /// - Widget redraws naturally from applied state
  /// - Timer scheduling ensures accurate timing
  /// - No frame capture occurring
  /// 
  /// **Performance considerations:**
  /// - StateFrame application is very fast (~1ms per frame)
  /// - Playback smoothness depends on scenario complexity
  /// - Memory usage stable (no new data generation)
  /// - CPU usage increases with rapid state changes
  /// 
  /// **Data access:**
  /// - StateFrames: Read-only sequential access
  /// - DrawingFrames: Available but not used
  /// - Playback position: Current frame index and timestamp
  const factory RecordingState.playing() = _Playing;

  /// Playback is paused - can be resumed or stopped.
  /// 
  /// The system maintains the current playback position and widget state
  /// while waiting for user action. This allows examination of specific
  /// moments in the recorded timeline.
  /// 
  /// **Available actions:**
  /// - Resume playback from current position
  /// - Stop playback (returns to idle state)
  /// - Scrub to different timeline position (future feature)
  /// - Examine current state values
  /// - Step frame-by-frame through timeline (future feature)
  /// 
  /// **UI behavior:**
  /// - Play button shows play icon (triangle)
  /// - Stop button is available
  /// - Controls are frozen at current playback position
  /// - Canvas view is frozen at current frame
  /// - Timeline scrubber shows current position and is interactive
  /// - Playback controls show pause state
  /// 
  /// **System behavior:**
  /// - All timers cancelled (no automatic progression)
  /// - Widget state reflects current frame values
  /// - No state changes occurring
  /// - Ready for immediate resume or position change
  /// - No frame capture occurring
  /// 
  /// **Data access:**
  /// - StateFrames: Read-only access with current position
  /// - DrawingFrames: Available for current position analysis
  /// - Playback context: Detailed current state information
  /// 
  /// **Use cases:**
  /// - Debugging specific moments in recorded interactions
  /// - Manual inspection of widget state at key points
  /// - Preparing for timeline scrubbing operations
  /// - Educational demonstration with controlled pacing
  const factory RecordingState.paused() = _Paused;

  factory RecordingState.fromJson(Map<String, dynamic> json) => 
      _$RecordingStateFromJson(json);
}

/// Extension methods for ergonomic state checking and analysis.
extension RecordingStateX on RecordingState {
  /// Whether the system is currently idle and ready for new operations.
  /// 
  /// Equivalent to: `this is _Idle`
  /// 
  /// Used for enabling/disabling UI elements that require idle state.
  bool get isIdle => when(
    idle: () => true,
    recording: () => false,
    playing: () => false,
    paused: () => false,
  );

  /// Whether the system is currently recording user interactions.
  /// 
  /// Equivalent to: `this is _Recording`
  /// 
  /// Used for:
  /// - Triggering frame capture on changes
  /// - Showing recording indicators
  /// - Preventing conflicting operations
  bool get isRecording => when(
    idle: () => false,
    recording: () => true,
    playing: () => false,
    paused: () => false,
  );

  /// Whether the system is currently playing back a scenario.
  /// 
  /// Equivalent to: `this is _Playing`
  /// 
  /// Used for:
  /// - Controlling playback UI elements
  /// - Preventing user interaction with controls
  /// - Managing playback timers
  bool get isPlaying => when(
    idle: () => false,
    recording: () => false,
    playing: () => true,
    paused: () => false,
  );

  /// Whether playback is currently paused.
  /// 
  /// Equivalent to: `this is _Paused`
  /// 
  /// Used for:
  /// - Controlling pause/resume UI
  /// - Enabling timeline scrubbing
  /// - Maintaining playback context
  bool get isPaused => when(
    idle: () => false,
    recording: () => false,
    playing: () => false,
    paused: () => true,
  );

  /// Whether the system is in any playback-related state (playing or paused).
  /// 
  /// Useful for:
  /// - Disabling controls during any form of playback
  /// - Showing playback-related UI elements
  /// - Managing playback resources
  bool get isInPlaybackMode => isPlaying || isPaused;

  /// Whether the system is currently busy (not idle).
  /// 
  /// Useful for:
  /// - Showing loading/busy indicators
  /// - Preventing simultaneous operations
  /// - Managing resource allocation
  bool get isBusy => !isIdle;

  /// Whether user interaction with controls is allowed in current state.
  /// 
  /// Controls are interactive during:
  /// - Idle state (normal interaction)
  /// - Recording state (interactions are captured)
  /// 
  /// Controls are NOT interactive during:
  /// - Playing state (controlled by playback)
  /// - Paused state (frozen at current values)
  bool get allowsControlInteraction => when(
    idle: () => true,
    recording: () => true,
    playing: () => false,
    paused: () => false,
  );

  /// Whether canvas interaction is allowed in current state.
  /// 
  /// Similar to control interaction but specifically for canvas operations
  /// like zoom, pan, and UI toggles.
  bool get allowsCanvasInteraction => allowsControlInteraction;

  /// Whether new recording can be started from current state.
  /// 
  /// Recording can only be started from idle state to prevent
  /// conflicts with existing operations.
  bool get canStartRecording => isIdle;

  /// Whether playback can be started from current state.
  /// 
  /// Playback can only be started from idle state to prevent
  /// conflicts with recording or existing playback.
  bool get canStartPlayback => isIdle;

  /// Human-readable description of the current state.
  /// 
  /// Useful for debugging, logging, and user-facing status messages.
  /// 
  /// Returns:
  /// - "Ready" for idle state
  /// - "Recording..." for recording state  
  /// - "Playing" for playing state
  /// - "Paused" for paused state
  String get displayName => when(
    idle: () => 'Ready',
    recording: () => 'Recording...',
    playing: () => 'Playing',
    paused: () => 'Paused',
  );

  /// Icon that represents the current state.
  /// 
  /// Useful for consistent UI representation across the application.
  /// Note: This returns icon names as strings to avoid importing Flutter
  /// in the model layer. Convert to actual Icons in the UI layer.
  String get iconName => when(
    idle: () => 'fiber_manual_record', // Record button
    recording: () => 'stop',           // Stop button
    playing: () => 'pause',            // Pause button
    paused: () => 'play_arrow',        // Play button
  );

  /// Color that represents the current state.
  /// 
  /// Returns color values as integers to avoid importing Flutter.
  /// Convert to Color objects in the UI layer.
  /// 
  /// - Idle: Blue (0xFF2196F3)
  /// - Recording: Red (0xFFF44336) 
  /// - Playing: Green (0xFF4CAF50)
  /// - Paused: Orange (0xFFFF9800)
  int get stateColor => when(
    idle: () => 0xFF2196F3,      // Blue
    recording: () => 0xFFF44336, // Red
    playing: () => 0xFF4CAF50,   // Green
    paused: () => 0xFFFF9800,    // Orange
  );
}