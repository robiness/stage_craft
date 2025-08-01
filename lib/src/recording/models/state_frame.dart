import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_frame.freezed.dart';
part 'state_frame.g.dart';

@freezed
class StateFrame with _$StateFrame {
  /// Creates a state frame representing control and canvas state at a specific timestamp.
  /// 
  /// A [StateFrame] captures the complete interactive state needed for playback:
  /// - All control values (sliders, colors, text inputs, toggles, etc.)
  /// - Canvas state (zoom, pan position, UI toggles, configuration)
  /// - Precise timing information for playback fidelity
  /// 
  /// StateFrames are used during playback to restore widget state. They do NOT
  /// contain drawing commands - those are captured separately in DrawingFrames
  /// for testing purposes.
  /// 
  /// This is the primary data structure for recording/playback functionality.
  /// Each StateFrame represents one moment in the user interaction timeline.
  /// 
  /// Example:
  /// ```dart
  /// final frame = StateFrame(
  ///   timestamp: Duration(milliseconds: 1500),
  ///   controlValues: {
  ///     'size': 150.0,
  ///     'color': {'type': 'Color', 'value': 0xFFFF0000},
  ///     'enabled': true,
  ///     'name': 'My Widget',
  ///   },
  ///   canvasState: {
  ///     'zoom': 1.5,
  ///     'panX': 100.0,
  ///     'panY': 50.0,
  ///     'showRulers': true,
  ///     'showGrid': false,
  ///   },
  /// );
  /// ```
  const factory StateFrame({
    /// Timestamp relative to recording start.
    /// 
    /// This represents when in the recording timeline this state was captured.
    /// Used for precise playback timing - the difference between frame timestamps
    /// determines the delay before applying the next frame.
    /// 
    /// Timeline examples:
    /// - Duration.zero: Initial state (captured when recording starts)
    /// - Duration(seconds: 2): State captured 2 seconds into recording
    /// - Duration(milliseconds: 750): State captured 0.75 seconds into recording
    /// 
    /// During playback, frames are applied in timestamp order with calculated
    /// delays between them to maintain original interaction timing.
    required Duration timestamp,

    /// Map of control labels to their serialized values.
    /// 
    /// Keys are the control.label values from ValueControl instances.
    /// Values are the serialized control values, with complex Flutter types
    /// stored as Maps with type information for safe deserialization.
    /// 
    /// Serialization examples:
    /// - Primitive types: 'size': 150.0, 'enabled': true, 'name': 'text'
    /// - Color: 'color': {'type': 'Color', 'value': 0xFFFF0000}  
    /// - DateTime: 'date': {'type': 'DateTime', 'value': '2024-01-01T10:00:00.000Z'}
    /// - Duration: 'delay': {'type': 'Duration', 'value': 5000000} // microseconds
    /// - Offset: 'position': {'type': 'Offset', 'dx': 10.0, 'dy': 20.0}
    /// - Size: 'bounds': {'type': 'Size', 'width': 100.0, 'height': 200.0}
    /// 
    /// This design enables:
    /// 1. Type-safe deserialization during playback
    /// 2. Extension to new control types without breaking existing data
    /// 3. JSON serialization for persistence and sharing
    /// 4. Human-readable debugging of recorded scenarios
    /// 
    /// Empty map is valid and represents a scenario with no controls.
    required Map<String, dynamic> controlValues,

    /// Canvas state including zoom, pan, and UI configuration.
    /// 
    /// Captures the complete visual state of the stage canvas for accurate
    /// playback reproduction. When applied during playback, the canvas view
    /// will be restored to exactly match the recorded state.
    /// 
    /// Standard canvas state structure:
    /// ```dart
    /// canvasState: {
    ///   // Visual state
    ///   'zoom': 1.5,              // Zoom level (1.0 = 100%, 2.0 = 200%)
    ///   'panX': 100.0,            // Pan offset X in logical pixels
    ///   'panY': -50.0,            // Pan offset Y in logical pixels
    ///   
    ///   // UI toggles
    ///   'showRulers': true,       // Whether rulers are visible
    ///   'showCrosshair': false,   // Whether crosshair overlay is visible
    ///   'showGrid': true,         // Whether background grid is visible
    ///   
    ///   // Configuration
    ///   'gridSpacing': 20.0,      // Grid spacing in logical pixels
    ///   'textScaling': 1.2,       // Text scaling factor for accessibility
    ///   'rulerOriginX': 0.0,      // Ruler origin point X (if configurable)
    ///   'rulerOriginY': 0.0,      // Ruler origin point Y (if configurable)
    /// }
    /// ```
    /// 
    /// Null when no canvas controller was present during capture.
    /// This occurs in:
    /// - Preview mode without canvas features
    /// - Simplified widget testing scenarios
    /// - Controls-only recordings
    /// 
    /// During playback, null canvasState is safely ignored, allowing
    /// the same StateFrame to work in both canvas and non-canvas environments.
    Map<String, dynamic>? canvasState,
  }) = _StateFrame;

  factory StateFrame.fromJson(Map<String, dynamic> json) => 
      _$StateFrameFromJson(json);
}

/// Extension methods for ergonomic state frame manipulation.
extension StateFrameX on StateFrame {
  /// Whether this frame has any control values captured.
  /// 
  /// Returns false for frames with empty controlValues map.
  /// Useful for filtering or validating frame data.
  bool get hasControlValues => controlValues.isNotEmpty;
  
  /// Whether this frame has canvas state captured.
  /// 
  /// Returns false when canvasState is null or empty.
  /// Useful for conditional canvas operations during playback.
  bool get hasCanvasState => canvasState != null && canvasState!.isNotEmpty;
  
  /// Number of controls captured in this frame.
  /// 
  /// Useful for debugging, validation, and progress tracking.
  int get controlCount => controlValues.length;
  
  /// Creates a new frame with the timestamp adjusted by the given offset.
  /// 
  /// Use cases:
  /// - Shifting entire frame timelines for synchronization
  /// - Creating loops by resetting timestamps to zero
  /// - Combining multiple recordings with time offsets
  /// 
  /// Example:
  /// ```dart
  /// // Shift frame timeline to start 2 seconds later
  /// final shiftedFrame = originalFrame.withTimestampOffset(Duration(seconds: 2));
  /// 
  /// // Create loop by resetting to zero
  /// final loopFrame = lastFrame.withTimestampOffset(-lastFrame.timestamp);
  /// ```
  StateFrame withTimestampOffset(Duration offset) {
    return copyWith(timestamp: timestamp + offset);
  }
  
  /// Creates a new frame with additional control values merged in.
  /// 
  /// Existing control values are preserved unless overridden by new values.
  /// This is useful for:
  /// - Programmatically modifying recorded scenarios
  /// - Adding missing control values to older recordings
  /// - Creating test variations from base recordings
  /// 
  /// Example:
  /// ```dart
  /// // Add or override specific control values
  /// final modifiedFrame = frame.withControlValues({
  ///   'newControl': 42.0,
  ///   'existingControl': 'new value', // Overrides existing
  /// });
  /// ```
  StateFrame withControlValues(Map<String, dynamic> additionalValues) {
    return copyWith(
      controlValues: {...controlValues, ...additionalValues},
    );
  }
  
  /// Creates a new frame with canvas state merged in.
  /// 
  /// Existing canvas state is preserved unless overridden by new values.
  /// If the original frame has null canvasState, the new state becomes
  /// the complete canvas state.
  /// 
  /// Use cases:
  /// - Modifying canvas settings in recorded scenarios
  /// - Adding canvas state to controls-only recordings
  /// - Creating test variations with different canvas configurations
  /// 
  /// Example:
  /// ```dart
  /// // Modify zoom while preserving other canvas settings
  /// final zoomedFrame = frame.withCanvasState({'zoom': 2.0});
  /// 
  /// // Add canvas state to frame that didn't have it
  /// final canvasFrame = controlsOnlyFrame.withCanvasState({
  ///   'zoom': 1.0,
  ///   'showRulers': true,
  /// });
  /// ```
  StateFrame withCanvasState(Map<String, dynamic> newCanvasState) {
    final mergedState = canvasState != null 
      ? {...canvasState!, ...newCanvasState}
      : newCanvasState;
    return copyWith(canvasState: mergedState);
  }
  
  /// Creates a new frame with only the specified control values.
  /// 
  /// Useful for creating focused test scenarios or reducing frame size
  /// by removing unnecessary control data.
  /// 
  /// Example:
  /// ```dart
  /// // Create frame with only size and color controls
  /// final focusedFrame = frame.withOnlyControls(['size', 'color']);
  /// ```
  StateFrame withOnlyControls(List<String> controlLabels) {
    final filteredValues = <String, dynamic>{};
    for (final label in controlLabels) {
      if (controlValues.containsKey(label)) {
        filteredValues[label] = controlValues[label];
      }
    }
    return copyWith(controlValues: filteredValues);
  }
  
  /// Creates a new frame without the specified control values.
  /// 
  /// Useful for removing problematic controls or creating simplified
  /// test variations.
  /// 
  /// Example:
  /// ```dart
  /// // Remove animation controls for static testing
  /// final staticFrame = frame.withoutControls(['animationSpeed', 'autoPlay']);
  /// ```
  StateFrame withoutControls(List<String> controlLabels) {
    final filteredValues = Map<String, dynamic>.from(controlValues);
    for (final label in controlLabels) {
      filteredValues.remove(label);
    }
    return copyWith(controlValues: filteredValues);
  }
}