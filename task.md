# StageCraft Recording System Restructuring

## Project Overview

**Goal**: Refactor the StageCraft recording/testing system to use a simplified 3-class architecture with clear separation of concerns, improving maintainability, testability, and fixing integration issues.

**Current State**: The recording system (Epic 1 & 2) has working functionality but suffers from controllers with multiple responsibilities, integration gaps, and some incomplete features.

**Expected Outcome**: Clean, maintainable architecture using Service + State Management pattern with Freezed models and precise timing, all existing functionality preserved and enhanced with timeline scrubbing capabilities and comprehensive drawing call testing.

## Core Use Cases

### Use Case 1: Complete Recording
**Goal**: Capture comprehensive widget state for playback and testing.

**Recording captures:**
- **StateFrames**: Control values + canvas state (zoom, pan, UI toggles)
- **DrawingFrames**: Paint operations executed on canvas (shapes, paths, text, images)

```dart
// User starts recording
manager.startRecording(controls, canvas);

// User interacts → dual frame capture
sizeControl.value = 200.0;  // StateFrame: control change + canvas state
                           // DrawingFrame: resulting paint operations

canvas.setZoom(1.5);       // StateFrame: canvas change + control state  
                           // DrawingFrame: updated paint operations

manager.stopRecording();   // Creates TestScenario with dual timelines
```

### Use Case 2: Playback for Live Preview
**Goal**: Replay recorded interactions to see how widget behaves over time.

**Playback applies:**
- **StateFrames**: Restores control values + canvas state at precise timestamps
- **DrawingFrames**: IGNORED (widget redraws naturally from restored state)

```dart
// Load and play recorded scenario
manager.playScenario(scenario, controls, canvas);

// Timeline playback uses StateFrames only:
// t=0s:    Apply StateFrame 1 → controls + canvas restored → widget redraws
// t=1.5s:  Apply StateFrame 2 → controls + canvas restored → widget redraws  
// t=3.2s:  Apply StateFrame 3 → controls + canvas restored → widget redraws
```

### Use Case 3: Automated Testing with Draw Call Verification
**Goal**: Use recorded scenarios as golden tests to detect visual regressions.

**Testing process:**
1. **Apply StateFrame**: Restore control values + canvas state
2. **Capture current DrawingFrame**: Let widget redraw, intercept paint operations
3. **Compare DrawingFrames**: Verify current matches recorded drawing calls
4. **Report differences**: Highlight visual changes as test failures

```dart
testWidgets('Color picker visual regression test', (tester) async {
  final scenario = await loadScenario('color_picker_interaction.json');
  
  for (final stateFrame in scenario.stateFrames) {
    // Apply recorded state
    await applyStateFrame(stateFrame, controls, canvas);
    await tester.pump();
    
    // Find corresponding drawing frame
    final expectedDrawing = scenario.findDrawingAtTime(stateFrame.timestamp);
    
    if (expectedDrawing != null) {
      // Capture current draw calls and compare
      final actualDrawing = await captureDrawCalls(tester);
      expect(actualDrawing, matchesDrawCalls(expectedDrawing.commands));
    }
  }
});
```

**Benefits:**
- **Catch visual regressions**: Any change in drawing output detected
- **Comprehensive coverage**: Tests actual visual output, not just state
- **Timeline testing**: Verifies widget behavior throughout interaction sequence
- **Platform consistency**: Same recording works across platforms

## Problem Statement

### Current Architecture Issues

```
                    ⚠️  CURRENT PROBLEMS  ⚠️
┌─────────────────────────────────────────────────────────────────┐
│                  StageController                                │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌───────────┐ │
│  │ Recording   │ │ Capturing   │ │ Storage     │ │ File I/O  │ │ ❌ Too many
│  │ State       │ │ Logic       │ │ Management  │ │ Operations│ │    responsibilities
│  └─────────────┘ └─────────────┘ └─────────────┘ └───────────┘ │
└─────────────────────────────────────────────────────────────────┘
           │                    │                    │
           ▼                    ▼                    ▼
    ❌ Hard to test      ❌ Canvas controller   ❌ Memory leaks
                           not integrated      from timers
```

### Specific Issues
1. **StageController**: Violates single responsibility principle
   - Recording state management
   - Frame capturing and storage
   - Control value serialization
   - Canvas settings capture
   - Scenario creation
   - Repository operations
   - Timer management
   - Playback coordination

2. **PlaybackController**: Mixed responsibilities
   - Playback state + timing
   - Frame scheduling + data application
   - Control/canvas value deserialization

3. **Integration Problems**:
   - Canvas controller not passed to playback (TODO in `recording_stage_builder.dart:291`)
   - Record button incomplete in `RecordingToolbar` (`recording_toolbar.dart:101-103`)
   - Auto-capture timer captures every 100ms regardless of changes
   - Fixed periodic timer ignores original frame timing
   - **Canvas changes not captured** - zoom, pan, rulers don't trigger recording
   - **No drawing call capture** - cannot test visual regressions or detect drawing changes
   - Duplicate recording UI components

4. **Test Issues**:
   - Several test files completely commented out (`workflow_test.dart`, `recording_test.dart`)
   - Hard to test controllers due to multiple responsibilities
   - **No visual regression testing** - cannot detect when widget drawing output changes

## Proposed Architecture: Service + State Management Pattern

### 4-Class Architecture with Dual Timeline Models

```
                📋 DUAL TIMELINE ARCHITECTURE (4 Classes + Models)
┌─────────────────────────────────────────────────────────────────────────┐
│                      RecordingManager                                   │
│                    (Coordination Layer)                                 │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐           │
│  │   Coordinates   │ │    Manages      │ │     Handles     │           │
│  │   Workflows     │ │ Control+Canvas+ │ │ Precise Timing  │           │
│  │                 │ │ Drawing Capture │ │                 │           │
│  └─────────────────┘ └─────────────────┘ └─────────────────┘           │
└─────────────────────────────────────────────────────────────────────────┘
           │                    │                    │
           ▼                    ▼                    ▼
┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
│ RecordingSession│   │StateCaptureServ │   │DrawingCaptureSrv│
│ (State Manager) │   │ (Pure Function) │   │ (Pure Function) │
│                 │   │                 │   │                 │
│• RecordingState │   │• captureState() │   │• captureDrawing│
│• StateFrames    │   │• control+canvas │   │• paint intercept│
│• DrawingFrames  │   │• serialize types│   │• drawing commands│
│• Timeline Pos   │   │                 │   │                 │
└─────────────────┘   └─────────────────┘   └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
    ✅ Dual timeline         ✅ StateFrame            ✅ DrawingFrame
    management               capture logic           capture logic
    with separation          (for playback)          (for testing)

           ┌─────────────────────────────────────────┐
           │            @freezed Models               │
           │  • StateFrame (control + canvas)        │
           │  • DrawingFrame (paint operations)      │
           │  • RecordingState (union types)         │
           │  • TestScenario (dual timelines)        │
           │  → Type safety + Free serialization     │
           └─────────────────────────────────────────┘

┌─────────────────┐   
│StatePlaybackServ│   ← Playback only uses StateFrames
│ (Pure Function) │   
│                 │   
│• applyState()   │   ← Simple logic (unchanged)
│• deserialize()  │   
│• restore state  │   
│• canvas sync    │   
└─────────────────┘   
         │
         ▼
    ✅ Pure function
    playback logic
    (StateFrames only)
```

### Recording Flow with Dual Timeline Capture

```
User    RecordingUI    Manager    Session    StateCaptureService    DrawingCaptureService
 │           │           │          │             │                      │
 │  Click    │           │          │             │                      │
 │ Record ──▶│           │          │             │                      │
 │           │ start() ─▶│          │             │                      │
 │           │           │ start()─▶│             │                      │
 │           │           │          │ ✅ Recording │                      │
 │           │           │          │             │                      │
 │ Change    │           │          │             │                      │
 │Control ──▶│ listener ─▶│          │             │                      │
 │    OR     │           │          │             │                      │
 │ Change    │           │          │             │                      │
 │Canvas ───▶│ listener ─▶│          │             │                      │
 │(zoom/pan) │           │          │             │                      │
 │           │           │captureState()─────────▶│                      │
 │           │           │          │◀─StateFrame │                      │
 │           │           │ addStateFrame()────▶│   │                      │
 │           │           │          │ ✅ Stored   │                      │
 │           │           │          │             │                      │
 │           │           │captureDrawing()──────────────────────────────▶│
 │           │           │          │             │      ◀─DrawingFrame   │
 │           │           │ addDrawingFrame()──▶│   │                      │
 │           │           │          │ ✅ Stored   │                      │
 │           │           │          │             │                      │
 │  Click    │           │          │             │                      │
 │  Stop ───▶│ stop() ──▶│          │             │                      │
 │           │           │  stop() ─▶│             │                      │
 │           │           │          │ ❌ Recording │                      │
```

### Enhanced Canvas State Capture

**Canvas events that trigger frame capture:**
- Zoom level changes
- Pan/scroll position changes  
- Ruler visibility toggle
- Crosshair toggle
- Grid toggle
- Any canvas setting changes

### Playback Flow with Calculated Timing

```
User clicks Play ──▶ Manager.playScenario()
                      │
                      ├─ Load frames into Session
                      ├─ Apply first frame immediately (controls + canvas)
                      └─ Schedule next frame with calculated delay
                          │
                          ▼
                    Timer(nextFrame.timestamp - currentFrame.timestamp)
                          │
                          ▼
                    Apply next frame (controls + canvas) + Schedule following
                          │
                          ▼
                    Repeat until all frames played
```

### Timeline Scrubbing (Future Enhancement)

```
User drags timeline scrubber ──▶ Session.seekToFrame(index)
                                  │
                                  ├─ Update currentFrameIndex
                                  ├─ Get frame at index
                                  └─ PlaybackService.applyFrame()
                                      │
                                      ▼
                                  UI + Canvas updates immediately
                                  (< 16ms for smooth scrubbing)
```

## Implementation Plan

### Phase 1: Create Freezed Models (2 hours)

#### Task 1.1: Define Data Models
**Time Estimate**: 2 hours
**Files**: `lib/src/recording/models/`

**Dependencies to add:**
```yaml
dependencies:
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  freezed: ^2.4.6
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
```

**Deliverables**:
- [ ] `scenario_frame.dart` - Immutable frame data with JSON serialization
- [ ] `recording_state.dart` - Union type for recording states
- [ ] `test_scenario.dart` - Immutable scenario with metadata
- [ ] Run `dart run build_runner build` to generate code
- [ ] Unit tests for serialization/deserialization

**Enhanced ScenarioFrame with Canvas State:**
```dart
@freezed
class ScenarioFrame with _$ScenarioFrame {
  const factory ScenarioFrame({
    required Duration timestamp,
    required Map<String, dynamic> controlValues,
    Map<String, dynamic>? canvasState, // Enhanced with pan, zoom, etc.
  }) = _ScenarioFrame;
  
  factory ScenarioFrame.fromJson(Map<String, dynamic> json) => 
    _$ScenarioFrameFromJson(json);
}

@freezed
class RecordingState with _$RecordingState {
  const factory RecordingState.idle() = _Idle;
  const factory RecordingState.recording() = _Recording;
  const factory RecordingState.playing() = _Playing;
  const factory RecordingState.paused() = _Paused;
}

@freezed
class TestScenario with _$TestScenario {
  const factory TestScenario({
    required String name,
    required List<ScenarioFrame> frames,
    required DateTime createdAt,
    @Default({}) Map<String, dynamic> metadata,
  }) = _TestScenario;
  
  factory TestScenario.fromJson(Map<String, dynamic> json) => 
    _$TestScenarioFromJson(json);
}
```

**Acceptance Criteria**:
- All models are immutable with Freezed
- JSON serialization works for all types
- Canvas state properly included in ScenarioFrame
- Proper equality and copyWith methods

### Phase 2: Create Core Classes (6 hours)

#### Task 2.1: RecordingSession (State Container)
**Time Estimate**: 2 hours
**Files**: `lib/src/recording/recording_session.dart`

**Deliverables**:
- [ ] State management with ChangeNotifier
- [ ] Frame storage and timeline position
- [ ] Recording state transitions
- [ ] Timeline navigation methods for future scrubbing
- [ ] Unit tests with 100% coverage

**Implementation** (unchanged from previous version - no canvas logic here):
```dart
class RecordingSession extends ChangeNotifier {
  RecordingState _state = const RecordingState.idle();
  List<ScenarioFrame> _frames = [];
  int _currentFrameIndex = 0;
  DateTime? _recordingStartTime;
  
  // ... (same as previous version)
}
```

#### Task 2.2: FrameCaptureService (Pure Function)
**Time Estimate**: 2 hours
**Files**: `lib/src/recording/services/frame_capture_service.dart`

**Deliverables**:
- [ ] Pure function for state capture
- [ ] Serialization of all control types (Color, DateTime, etc.)
- [ ] **Enhanced canvas settings capture with pan position**
- [ ] Error handling for unsupported types
- [ ] Unit tests for all control and canvas types

**Enhanced Implementation with Canvas State:**
```dart
class FrameCaptureService {
  static ScenarioFrame captureCurrentState(
    List<ValueControl> controls,
    StageCanvasController? canvas,
    Duration timestamp,
  ) {
    final controlValues = <String, dynamic>{};
    
    // Capture all control values
    for (final control in controls) {
      try {
        controlValues[control.label] = _serializeValue(control.value);
      } catch (e) {
        print('Failed to serialize control ${control.label}: $e');
      }
    }
    
    // Enhanced canvas state capture
    final canvasState = canvas != null ? {
      'zoom': canvas.zoom,
      'panX': canvas.panOffset.dx,        // ← New: pan position
      'panY': canvas.panOffset.dy,        // ← New: pan position
      'showRulers': canvas.showRulers,
      'showCrosshair': canvas.showCrosshair,
      'showGrid': canvas.showGrid,
      'rulerOrigin': canvas.rulerOrigin?.toJson(), // ← New: if rulers have origin
      'gridSpacing': canvas.gridSpacing,  // ← New: grid configuration
      'textScaling': canvas.textScaling,  // ← New: text scaling factor
      // Add other canvas properties as discovered
    } : null;
    
    return ScenarioFrame(
      timestamp: timestamp,
      controlValues: controlValues,
      canvasState: canvasState,
    );
  }
  
  static dynamic _serializeValue(dynamic value) {
    if (value == null) return null;
    
    // Handle Flutter types that need special serialization
    if (value is Color) {
      return {'type': 'Color', 'value': value.value};
    }
    if (value is DateTime) {
      return {'type': 'DateTime', 'value': value.toIso8601String()};
    }
    if (value is Duration) {
      return {'type': 'Duration', 'value': value.inMicroseconds};
    }
    if (value is Offset) {
      return {'type': 'Offset', 'dx': value.dx, 'dy': value.dy};
    }
    if (value is Size) {
      return {'type': 'Size', 'width': value.width, 'height': value.height};
    }
    // Add more type handlers as needed
    
    return value;
  }
}
```

**Acceptance Criteria**:
- Pure function with no side effects
- Handles all existing control types
- **Captures complete canvas state including pan position**
- Graceful error handling

#### Task 2.3: FramePlaybackService (Pure Function)
**Time Estimate**: 2 hours
**Files**: `lib/src/recording/services/frame_playback_service.dart`

**Deliverables**:
- [ ] Pure function for state restoration
- [ ] Deserialization matching capture logic
- [ ] **Enhanced canvas settings application with pan restoration**
- [ ] Performance optimized for timeline scrubbing (<16ms)
- [ ] Unit tests for all control and canvas types

**Enhanced Implementation with Canvas Restoration:**
```dart
class FramePlaybackService {
  static void applyFrame(
    ScenarioFrame frame,
    List<ValueControl> controls,
    StageCanvasController? canvas,
  ) {
    // Apply control values
    for (final control in controls) {
      final serializedValue = frame.controlValues[control.label];
      if (serializedValue != null) {
        try {
          final typedValue = _deserializeValue(serializedValue);
          control.value = typedValue;
        } catch (e) {
          print('Failed to apply value to control ${control.label}: $e');
        }
      }
    }
    
    // Enhanced canvas settings application
    if (canvas != null && frame.canvasState != null) {
      try {
        final state = frame.canvasState!;
        
        // Restore zoom and pan position
        canvas.setZoom(state['zoom'] ?? 1.0);
        canvas.setPanOffset(Offset(
          state['panX'] ?? 0.0,
          state['panY'] ?? 0.0,
        )); // ← New: restore exact pan position
        
        // Restore UI toggles
        canvas.setShowRulers(state['showRulers'] ?? true);
        canvas.setShowCrosshair(state['showCrosshair'] ?? false);
        canvas.setShowGrid(state['showGrid'] ?? false);
        
        // Restore advanced settings
        if (state['rulerOrigin'] != null) {
          canvas.setRulerOrigin(Offset.fromJson(state['rulerOrigin']));
        }
        canvas.setGridSpacing(state['gridSpacing'] ?? 20.0);
        canvas.setTextScaling(state['textScaling'] ?? 1.0);
        
      } catch (e) {
        print('Failed to apply canvas state: $e');
      }
    }
  }
  
  static dynamic _deserializeValue(dynamic serializedValue) {
    if (serializedValue == null) return null;
    
    if (serializedValue is Map<String, dynamic>) {
      final type = serializedValue['type'];
      
      switch (type) {
        case 'Color':
          return Color(serializedValue['value'] as int);
        case 'DateTime':
          return DateTime.parse(serializedValue['value'] as String);
        case 'Duration':
          return Duration(microseconds: serializedValue['value'] as int);
        case 'Offset':
          return Offset(serializedValue['dx'], serializedValue['dy']);
        case 'Size':
          return Size(serializedValue['width'], serializedValue['height']);
        // Add more type handlers as needed
      }
    }
    
    return serializedValue;
  }
}
```

**Acceptance Criteria**:
- Fast execution (<16ms for timeline scrubbing)
- **Complete canvas state restoration including pan/zoom**
- Error handling for corrupted data

### Phase 3: Create RecordingManager (4 hours)

#### Task 3.1: RecordingManager (Coordination)
**Time Estimate**: 4 hours
**Files**: `lib/src/recording/recording_manager.dart`

**Deliverables**:
- [ ] Recording workflow coordination
- [ ] **Change-based frame capturing for both controls AND canvas**
- [ ] Precise playback timing with calculated delays
- [ ] Clean listener management
- [ ] Integration tests

**Enhanced Implementation with Canvas Change Detection:**
```dart
class RecordingManager {
  final RecordingSession session;
  final ScenarioRepository? repository;
  
  List<ValueControl>? _currentControls;
  StageCanvasController? _currentCanvas;
  Timer? _nextFrameTimer;
  DateTime? _playbackStartTime;
  final List<VoidCallback> _changeListeners = [];
  Timer? _debounceTimer; // For debouncing rapid changes
  
  RecordingManager({
    required this.session,
    this.repository,
  });
  
  // Enhanced recording API with canvas change detection
  void startRecording(List<ValueControl> controls, StageCanvasController? canvas) {
    _currentControls = controls;
    _currentCanvas = canvas;
    session.start();
    
    // Set up change listeners on all controls
    for (final control in controls) {
      final listener = () => _onStateChanged();
      control.addListener(listener);
      _changeListeners.add(() => control.removeListener(listener));
    }
    
    // Set up canvas change listeners
    if (canvas != null) {
      final canvasListener = () => _onStateChanged();
      canvas.addListener(canvasListener); // Canvas must implement ChangeNotifier
      _changeListeners.add(() => canvas.removeListener(canvasListener));
    }
    
    // Capture initial frame with both control and canvas state
    _captureFrame();
  }
  
  void stopRecording() {
    // Clean up all listeners
    _debounceTimer?.cancel();
    for (final removeListener in _changeListeners) {
      removeListener();
    }
    _changeListeners.clear();
    
    session.stop();
    _currentControls = null;
    _currentCanvas = null;
  }
  
  void _onStateChanged() {
    // Debounce rapid changes (both control and canvas)
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: 50), () {
      if (session.isRecording) {
        _captureFrame();
      }
    });
  }
  
  void _captureFrame() {
    if (_currentControls != null) {
      final duration = session._recordingStartTime != null 
        ? DateTime.now().difference(session._recordingStartTime!)
        : Duration.zero;
        
      final frame = FrameCaptureService.captureCurrentState(
        _currentControls!,
        _currentCanvas, // Canvas state captured here
        duration,
      );
      
      session.addFrame(frame);
    }
  }
  
  // Playback API with precise timing (unchanged)
  void playScenario(TestScenario scenario, List<ValueControl> controls, StageCanvasController? canvas) {
    _currentControls = controls;
    _currentCanvas = canvas;
    
    session._frames = scenario.frames;
    session.play();
    _playbackStartTime = DateTime.now();
    
    // Apply first frame immediately (includes canvas state)
    if (scenario.frames.isNotEmpty) {
      FramePlaybackService.applyFrame(scenario.frames[0], controls, canvas);
      _scheduleNextFrame();
    }
  }
  
  void _scheduleNextFrame() {
    _nextFrameTimer?.cancel();
    
    if (session.currentFrameIndex >= session.totalFrames - 1) {
      session.stop();
      return;
    }
    
    final currentFrame = session.frames[session.currentFrameIndex];
    final nextFrame = session.frames[session.currentFrameIndex + 1];
    
    // Calculate precise delay between frames
    final delay = nextFrame.timestamp - currentFrame.timestamp;
    
    _nextFrameTimer = Timer(delay, () {
      session.seekToFrame(session.currentFrameIndex + 1);
      final frame = session.currentFrame;
      if (frame != null && _currentControls != null) {
        FramePlaybackService.applyFrame(frame, _currentControls!, _currentCanvas);
      }
      _scheduleNextFrame();
    });
  }
  
  // ... (rest of methods unchanged)
  
  void dispose() {
    stopRecording();
    stopPlayback();
    _debounceTimer?.cancel();
  }
}
```

**Acceptance Criteria**:
- **Change-based capturing for both controls AND canvas changes**
- Precise playback timing
- Clean listener management
- **Canvas pan/zoom changes trigger frame captures**

### Phase 4: UI Integration & Bug Fixes (3 hours)

#### Task 4.1: Update RecordingStageBuilder
**Time Estimate**: 1.5 hours
**Files**: `lib/src/recording/widgets/recording_stage_builder.dart`

**Deliverables**:
- [ ] Use RecordingManager instead of old controllers
- [ ] **Ensure canvas controller is ChangeNotifier for change detection**
- [ ] Fix canvas controller integration (resolve TODO)
- [ ] Proper dependency injection

#### Task 4.2: Fix RecordingToolbar
**Time Estimate**: 1 hour
**Files**: `lib/src/recording/widgets/recording_toolbar.dart`

**Deliverables**:
- [ ] Complete record button implementation
- [ ] **Canvas controller properly passed to recording**
- [ ] Remove duplicate implementations

#### Task 4.3: Update Exports
**Time Estimate**: 0.5 hours

**New exports:**
```dart
// Models
export 'models/scenario_frame.dart';
export 'models/recording_state.dart';
export 'models/test_scenario.dart';

// Core classes
export 'recording_session.dart';
export 'recording_manager.dart';
export 'services/frame_capture_service.dart';
export 'services/frame_playback_service.dart';

// Widgets
export 'widgets/recording_stage_builder.dart';
export 'widgets/recording_toolbar.dart';
export 'widgets/scenario_management_drawer.dart';
```

### Phase 5: Cleanup & Testing (2 hours)

#### Task 5.1: Remove Legacy Code
**Time Estimate**: 1 hour

**Deliverables**:
- [ ] Remove old StageController recording methods
- [ ] Remove old PlaybackController
- [ ] Delete broken test files
- [ ] Update documentation

#### Task 5.2: Comprehensive Testing
**Time Estimate**: 1 hour

**Test scenarios:**
- [ ] **Canvas zoom/pan changes trigger recording**
- [ ] **Canvas state correctly restored during playback**
- [ ] **Timeline scrubbing preserves canvas position**
- [ ] Control changes still work as before
- [ ] Performance validation
- [ ] Memory leak testing

## Success Criteria

### Functional Requirements
- [ ] **Zero Regression**: All existing functionality preserved
- [ ] **Complete State Integration**: Canvas changes trigger StateFrame recording, state restored during playback
- [ ] **Drawing Call Capture**: Paint operations intercepted and recorded as DrawingFrames
- [ ] **Dual Timeline Recording**: Both StateFrames and DrawingFrames captured simultaneously
- [ ] **Simple Playback**: Playback uses StateFrames only, ignores DrawingFrames (unchanged logic)
- [ ] **Visual Regression Testing**: DrawingFrames enable detection of visual changes
- [ ] **Timeline Ready**: Architecture supports future timeline scrubbing with both frame types

### Architecture Requirements
- [ ] **Clean Separation**: 4 focused classes with clear responsibilities (Manager, Session, StateCapture, DrawingCapture)
- [ ] **Dual Timeline Management**: Separate StateFrames and DrawingFrames with synchronized timestamps
- [ ] **Canvas as First-Class Citizen**: Canvas state treated equally to control state in StateFrames
- [ ] **Drawing Interception**: Paint operations captured without affecting widget rendering
- [ ] **Immutable Data**: All models use Freezed for type safety
- [ ] **Precise Timing**: Calculated delays instead of fixed intervals
- [ ] **Testability**: Each class independently testable

### Quality Requirements
- [ ] **Test Coverage**: 90%+ coverage including both StateFrame and DrawingFrame scenarios
- [ ] **Performance**: StateFrame capture/restore < 16ms for timeline scrubbing
- [ ] **Drawing Performance**: DrawingFrame capture adds <5ms overhead to paint operations
- [ ] **Memory Management**: No leaks during dual timeline recording sessions
- [ ] **Optional Drawing Capture**: Can disable DrawingFrame capture for performance-sensitive scenarios

## Key Implementation Notes

### Canvas Controller Requirements
The `StageCanvasController` must implement `ChangeNotifier` and emit change notifications for:
- Zoom level changes
- Pan offset changes  
- Ruler visibility toggles
- Crosshair toggles
- Grid toggles
- Any other canvas setting changes

### Dual Timeline Recording Behavior
When recording, changes trigger dual frame capture:
1. **Control value changes** → StateFrame + DrawingFrame capture
2. **Canvas changes** → StateFrame + DrawingFrame capture
3. **Widget redraws** → DrawingFrame capture (if drawing capture enabled)

### Simple Playback Behavior (Unchanged Logic)
During playback, only StateFrames are used:
1. **Apply StateFrame**: Restore control values + canvas state
2. **Widget redraws naturally**: No DrawingFrame application needed
3. **Timeline scrubbing**: Uses StateFrame timestamps only

### Testing with Drawing Verification
During testing:
1. **Apply StateFrame**: Set up widget state from recorded data
2. **Capture current DrawingFrame**: Intercept widget's paint operations  
3. **Compare DrawingFrames**: Verify current matches recorded drawing calls
4. **Report visual differences**: Detect regressions in drawing output

### Drawing Capture Requirements  
The drawing capture system must:
- Intercept `Canvas` paint calls without affecting rendering
- Serialize `Paint`, `Path`, and `TextStyle` objects
- Handle complex drawing operations (paths, images, gradients)
- Maintain performance (<5ms overhead per paint operation)

## Timeline

**Total Estimated Time**: 17 hours over 2-3 days

**Day 1** (8 hours): 
- Phase 1: Freezed models with enhanced canvas state (2h)
- Phase 2: Core classes with canvas integration (6h)

**Day 2** (6 hours):
- Phase 3: RecordingManager with canvas change detection (4h) 
- Phase 4: UI integration with canvas requirements (2h)

**Day 3** (3 hours):
- Phase 5: Cleanup and comprehensive testing including canvas scenarios (3h)

**Milestones**:
- End of Day 1: Canvas state capture/restore working
- End of Day 2: Canvas change detection triggering recordings
- End of Day 3: Complete canvas integration with timeline foundation