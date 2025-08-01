import 'package:freezed_annotation/freezed_annotation.dart';
import 'drawing_frame.dart';
import 'state_frame.dart';

part 'test_scenario.freezed.dart';
part 'test_scenario.g.dart';

@freezed
class TestScenario with _$TestScenario {
  /// Represents a complete recorded test scenario with dual timelines.
  /// 
  /// A [TestScenario] contains the complete recording of a user interaction
  /// session, including both StateFrames (for playback) and DrawingFrames
  /// (for visual testing). This is the top-level data structure that gets
  /// saved to/loaded from storage and shared between team members.
  /// 
  /// **Dual Timeline Architecture:**
  /// - **StateFrames**: Control + canvas state changes (used for playback)
  /// - **DrawingFrames**: Paint operations (used for visual regression testing)
  /// 
  /// Both timelines share synchronized timestamps, enabling correlation
  /// between state changes and their visual results.
  /// 
  /// **Use Cases:**
  /// - **Live playback**: Uses stateFrames to recreate user interactions
  /// - **Visual testing**: Compares drawingFrames to detect regressions
  /// - **Documentation**: Demonstrates widget behavior over time
  /// - **Debugging**: Analyzes state/visual relationships
  /// - **Collaboration**: Shares reproducible widget scenarios
  /// 
  /// **Creation Methods:**
  /// - Recorded live through user interactions
  /// - Created programmatically for automated testing
  /// - Imported from external sources or team members
  /// - Generated from existing scenarios with modifications
  /// 
  /// Example:
  /// ```dart
  /// final scenario = TestScenario(
  ///   name: 'Color Picker Animation',
  ///   stateFrames: [
  ///     StateFrame(timestamp: Duration.zero, controlValues: {'color': initialColor}),
  ///     StateFrame(timestamp: Duration(seconds: 1), controlValues: {'color': redColor}),
  ///     StateFrame(timestamp: Duration(seconds: 2), controlValues: {'color': blueColor}),
  ///   ],
  ///   drawingFrames: [
  ///     DrawingFrame(timestamp: Duration.zero, commands: initialDrawing),
  ///     DrawingFrame(timestamp: Duration(seconds: 1), commands: redDrawing),
  ///     DrawingFrame(timestamp: Duration(seconds: 2), commands: blueDrawing),
  ///   ],
  ///   createdAt: DateTime.now(),
  ///   metadata: {
  ///     'description': 'Tests color picker with smooth transitions',
  ///     'author': 'Jane Developer',
  ///     'tags': ['animation', 'color-picker', 'smoke-test'],
  ///   },
  /// );
  /// ```
  const factory TestScenario({
    /// Human-readable name for the scenario.
    /// 
    /// Should be descriptive and unique within the project context.
    /// Used in UI lists, file names, test reports, and documentation.
    /// 
    /// **Naming Conventions:**
    /// - Descriptive: "Color Picker Interaction", not "Test 1"
    /// - Context-specific: "Mobile Layout - Portrait Mode"
    /// - Action-focused: "Form Validation Edge Cases"
    /// - Scope-indicating: "Performance Test - 1000 Items"
    /// 
    /// **Examples:**
    /// - "Color Picker Interaction"
    /// - "Responsive Layout - Mobile to Desktop"  
    /// - "Form Validation with Error States"
    /// - "Animation Timeline - Fade In/Out"
    /// - "Data Loading States - Success Path"
    required String name,

    /// Ordered list of state frames representing the interactive timeline.
    /// 
    /// StateFrames capture control and canvas state changes that occurred
    /// during recording. These frames are used during playback to recreate
    /// the user interaction sequence with precise timing.
    /// 
    /// **Frame Requirements:**
    /// - Must be ordered by timestamp (earliest first)
    /// - Timestamps should be relative to recording start (Duration.zero)
    /// - Empty list is valid (represents no-interaction scenario)
    /// - First frame typically has timestamp Duration.zero
    /// 
    /// **Timing Considerations:**
    /// - Gaps between timestamps become delays during playback
    /// - Microsecond precision available for fine-grained timing
    /// - Large gaps (>10s) may indicate user pauses or system delays
    /// 
    /// **Example Timeline:**
    /// ```dart
    /// stateFrames: [
    ///   StateFrame(timestamp: Duration.zero, ...),                    // Initial state
    ///   StateFrame(timestamp: Duration(milliseconds: 500), ...),     // 0.5s delay
    ///   StateFrame(timestamp: Duration(seconds: 2, milliseconds: 750), ...), // 2.25s delay
    /// ]
    /// ```
    /// 
    /// **Memory Considerations:**
    /// - Long scenarios can contain hundreds of frames
    /// - Each frame stores complete state snapshot
    /// - Consider frame trimming for very long recordings
    required List<StateFrame> stateFrames,

    /// Ordered list of drawing frames for visual regression testing.
    /// 
    /// DrawingFrames capture the paint operations that were executed
    /// during recording. These frames are used in testing to verify
    /// that widget visual output matches expected behavior.
    /// 
    /// **Frame Correlation:**
    /// - Timestamps synchronized with stateFrames
    /// - Not every stateFrame needs corresponding drawingFrame
    /// - DrawingFrames may exist without corresponding stateFrames
    /// 
    /// **Testing Workflow:**
    /// 1. Apply stateFrame to set up widget state
    /// 2. Find drawingFrame with matching/closest timestamp  
    /// 3. Capture current widget drawing operations
    /// 4. Compare actual vs expected drawing operations
    /// 
    /// **Optional Nature:**
    /// - Empty list is valid (no visual testing data)
    /// - Can be disabled during recording for performance
    /// - May be stripped from scenarios to reduce size
    /// - Not used during playback (only for testing)
    /// 
    /// **Performance Impact:**
    /// - DrawingFrames can be large (complex drawing data)
    /// - May significantly increase scenario file size
    /// - Loading time increases with drawing complexity
    /// - Consider compression for storage efficiency
    @Default([]) List<DrawingFrame> drawingFrames,

    /// Timestamp when scenario was created.
    /// 
    /// Used for:
    /// - Sorting scenarios in UI (newest first)
    /// - Tracking scenario age for cleanup policies
    /// - Debugging recording issues and correlating with logs
    /// - Version control integration and change tracking
    /// - Audit trails for collaborative development
    /// 
    /// **Timezone Considerations:**
    /// - Stored as UTC DateTime for consistency
    /// - UI layer should handle local timezone conversion
    /// - Important for distributed team collaboration
    required DateTime createdAt,

    /// Flexible metadata for extending scenario information.
    /// 
    /// Provides extensible storage for additional scenario context
    /// without breaking compatibility. Both standard and custom
    /// keys are supported.
    /// 
    /// **Standard Keys (all optional):**
    /// - `'description'`: String - Detailed scenario description
    /// - `'author'`: String - Who created this scenario  
    /// - `'tags'`: List<String> - Searchable tags for categorization
    /// - `'version'`: String - Scenario format version
    /// - `'deviceInfo'`: Map - Device/platform where recorded
    /// - `'widgetUnderTest'`: String - Primary widget being tested
    /// - `'testSuite'`: String - Test suite this scenario belongs to
    /// - `'priority'`: String - Testing priority (high/medium/low)
    /// - `'automatedTest'`: bool - Whether used in automated testing
    /// 
    /// **Custom Project Keys:**
    /// - `'jiraTicket'`: String - Associated ticket/issue
    /// - `'designSystem'`: String - Design system component name
    /// - `'accessibility'`: Map - Accessibility testing data
    /// - `'performance'`: Map - Performance metrics and thresholds
    /// - `'browserSupport'`: List<String> - Supported browsers/platforms
    /// 
    /// **Examples:**
    /// ```dart
    /// metadata: {
    ///   'description': 'Tests color picker animation with focus states',
    ///   'author': 'jane.developer@company.com',
    ///   'tags': ['animation', 'color-picker', 'accessibility'],
    ///   'version': '2.1',
    ///   'widgetUnderTest': 'ColorPickerWidget',
    ///   'testSuite': 'smoke-tests',
    ///   'priority': 'high',
    ///   'jiraTicket': 'PROJ-1234',
    ///   'automatedTest': true,
    ///   'deviceInfo': {
    ///     'platform': 'android',
    ///     'screenSize': {'width': 1080, 'height': 1920},
    ///     'pixelRatio': 3.0,
    ///   },
    /// }
    /// ```
    @Default({}) Map<String, dynamic> metadata,
  }) = _TestScenario;

  factory TestScenario.fromJson(Map<String, dynamic> json) => 
      _$TestScenarioFromJson(json);
}

/// Extension methods for scenario analysis and manipulation.
extension TestScenarioX on TestScenario {
  /// Total duration of the scenario based on state frame timestamps.
  /// 
  /// Returns the timestamp of the last stateFrame, or Duration.zero
  /// if no stateFrames exist. This represents the total recorded
  /// interaction time.
  Duration get duration => stateFrames.isEmpty 
      ? Duration.zero 
      : stateFrames.last.timestamp;
  
  /// Total duration based on drawing frame timestamps.
  /// 
  /// May differ from state duration if drawing capture continued
  /// after state changes ended.
  Duration get drawingDuration => drawingFrames.isEmpty
      ? Duration.zero
      : drawingFrames.last.timestamp;
  
  /// Maximum duration across both timelines.
  /// 
  /// Represents the complete scenario timeline including both
  /// state changes and drawing operations.
  Duration get totalDuration {
    final stateDur = duration;
    final drawingDur = drawingDuration;
    return stateDur > drawingDur ? stateDur : drawingDur;
  }
  
  /// Number of state frames in the scenario.
  int get stateFrameCount => stateFrames.length;
  
  /// Number of drawing frames in the scenario.
  int get drawingFrameCount => drawingFrames.length;
  
  /// Total number of frames across both timelines.
  int get totalFrameCount => stateFrameCount + drawingFrameCount;
  
  /// Whether this scenario has any recorded interactions.
  /// 
  /// Returns false only if both timelines are empty.
  bool get isEmpty => stateFrames.isEmpty && drawingFrames.isEmpty;
  
  /// Whether this scenario has state data (can be played back).
  bool get hasStateData => stateFrames.isNotEmpty;
  
  /// Whether this scenario has drawing data (can be visually tested).
  bool get hasDrawingData => drawingFrames.isNotEmpty;
  
  /// Whether this scenario supports visual regression testing.
  /// 
  /// Requires both state frames (to set up conditions) and
  /// drawing frames (to compare visual output).
  bool get supportsVisualTesting => hasStateData && hasDrawingData;
  
  /// Estimated file size in bytes (rough approximation).
  /// 
  /// Useful for storage planning and performance optimization.
  /// This is an estimate based on typical frame sizes.
  int get estimatedSizeBytes {
    // Rough estimates: StateFrame ~500 bytes, DrawingFrame ~2KB
    const stateFrameSize = 500;
    const drawingFrameSize = 2000;
    const baseSize = 1000; // Name, metadata, etc.
    
    return baseSize + 
           (stateFrameCount * stateFrameSize) + 
           (drawingFrameCount * drawingFrameSize);
  }
  
  /// Creates a new scenario with additional metadata merged in.
  /// 
  /// Existing metadata is preserved unless overridden by new values.
  /// 
  /// Example:
  /// ```dart
  /// final taggedScenario = scenario.withMetadata('tags', ['new-tag']);
  /// final updatedScenario = scenario.withMetadata('lastModified', DateTime.now());
  /// ```
  TestScenario withMetadata(String key, dynamic value) {
    return copyWith(metadata: {...metadata, key: value});
  }
  
  /// Creates a new scenario with multiple metadata entries added.
  /// 
  /// Example:
  /// ```dart
  /// final enhancedScenario = scenario.withAllMetadata({
  ///   'priority': 'high',
  ///   'automatedTest': true,
  ///   'lastModified': DateTime.now(),
  /// });
  /// ```
  TestScenario withAllMetadata(Map<String, dynamic> additionalMetadata) {
    return copyWith(metadata: {...metadata, ...additionalMetadata});
  }
  
  /// Creates a trimmed scenario containing only frames within the time range.
  /// 
  /// Useful for creating focused test scenarios from longer recordings
  /// or removing irrelevant portions of scenarios.
  /// 
  /// Timestamps are adjusted so the trimmed scenario starts at Duration.zero.
  /// 
  /// Example:
  /// ```dart
  /// // Extract middle 5 seconds of a 10-second scenario
  /// final trimmed = scenario.trimToTimeRange(
  ///   Duration(seconds: 2), 
  ///   Duration(seconds: 7)
  /// );
  /// ```
  TestScenario trimToTimeRange(Duration start, Duration end) {
    // Filter and adjust state frames
    final trimmedStateFrames = stateFrames
        .where((frame) => frame.timestamp >= start && frame.timestamp <= end)
        .map((frame) => frame.withTimestampOffset(-start))
        .toList();
    
    // Filter and adjust drawing frames
    final trimmedDrawingFrames = drawingFrames
        .where((frame) => frame.timestamp >= start && frame.timestamp <= end)
        .map((frame) => frame.withTimestampOffset(-start))
        .toList();
    
    return copyWith(
      name: '$name (${start.inSeconds}s-${end.inSeconds}s)',
      stateFrames: trimmedStateFrames,
      drawingFrames: trimmedDrawingFrames,
      metadata: {
        ...metadata,
        'trimmedFrom': name,
        'originalStart': start.inMilliseconds,
        'originalEnd': end.inMilliseconds,
        'trimmedAt': DateTime.now().toIso8601String(),
      },
    );
  }
  
  /// Creates a scenario with only state frames (removes drawing data).
  /// 
  /// Useful for reducing file size when visual testing is not needed
  /// or for sharing scenarios without exposing visual implementation details.
  /// 
  /// Example:
  /// ```dart
  /// final playbackOnly = scenario.withoutDrawingFrames();
  /// ```
  TestScenario withoutDrawingFrames() {
    return copyWith(
      drawingFrames: [],
      metadata: {
        ...metadata,
        'drawingFramesRemoved': true,
        'originalDrawingFrameCount': drawingFrameCount,
        'strippedAt': DateTime.now().toIso8601String(),
      },
    );
  }
  
  /// Creates a scenario with only drawing frames (removes state data).
  /// 
  /// Useful for visual-only testing or analysis where playback
  /// is not needed.
  /// 
  /// Example:
  /// ```dart
  /// final visualOnly = scenario.withoutStateFrames();
  /// ```
  TestScenario withoutStateFrames() {
    return copyWith(
      stateFrames: [],
      metadata: {
        ...metadata,
        'stateFramesRemoved': true,
        'originalStateFrameCount': stateFrameCount,
        'strippedAt': DateTime.now().toIso8601String(),
      },
    );
  }
  
  /// Finds the drawing frame closest to the given timestamp.
  /// 
  /// Used during testing to correlate state frames with their
  /// corresponding visual output.
  /// 
  /// Returns null if no drawing frames exist or if no frame
  /// is found within a reasonable time window.
  /// 
  /// Example:
  /// ```dart
  /// for (final stateFrame in scenario.stateFrames) {
  ///   final drawingFrame = scenario.findDrawingAtTime(stateFrame.timestamp);
  ///   if (drawingFrame != null) {
  ///     // Compare expected vs actual drawing
  ///   }
  /// }
  /// ```
  DrawingFrame? findDrawingAtTime(Duration timestamp, {Duration tolerance = const Duration(milliseconds: 100)}) {
    if (drawingFrames.isEmpty) return null;
    
    // Find frames within tolerance
    final candidateFrames = drawingFrames
        .where((frame) => (frame.timestamp - timestamp).abs() <= tolerance)
        .toList();
    
    if (candidateFrames.isEmpty) return null;
    
    // Return closest match
    candidateFrames.sort((a, b) => 
        (a.timestamp - timestamp).abs().compareTo((b.timestamp - timestamp).abs()));
    
    return candidateFrames.first;
  }
  
  /// Finds the state frame closest to the given timestamp.
  /// 
  /// Similar to findDrawingAtTime but for state frames.
  StateFrame? findStateAtTime(Duration timestamp, {Duration tolerance = const Duration(milliseconds: 100)}) {
    if (stateFrames.isEmpty) return null;
    
    final candidateFrames = stateFrames
        .where((frame) => (frame.timestamp - timestamp).abs() <= tolerance)
        .toList();
    
    if (candidateFrames.isEmpty) return null;
    
    candidateFrames.sort((a, b) => 
        (a.timestamp - timestamp).abs().compareTo((b.timestamp - timestamp).abs()));
    
    return candidateFrames.first;
  }
  
  /// Gets timeline statistics for analysis and debugging.
  /// 
  /// Returns a map with detailed information about the scenario
  /// structure and content.
  Map<String, dynamic> get statistics {
    return {
      'duration': {
        'total': totalDuration.inMilliseconds,
        'state': duration.inMilliseconds,
        'drawing': drawingDuration.inMilliseconds,
      },
      'frames': {
        'state': stateFrameCount,
        'drawing': drawingFrameCount,
        'total': totalFrameCount,
      },
      'size': {
        'estimated_bytes': estimatedSizeBytes,
        'estimated_kb': (estimatedSizeBytes / 1024).round(),
      },
      'capabilities': {
        'playback': hasStateData,
        'visual_testing': supportsVisualTesting,
        'empty': isEmpty,
      },
      'metadata_keys': metadata.keys.toList(),
    };
  }
}