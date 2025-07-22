/// StageCraft Recording System - Platform-agnostic testing with state and drawing call recording
library recording;

// Core interfaces
export 'recorder.dart';
export 'test_scenario.dart';
export 'serialization.dart';

// Recording modules
export 'state_recorder.dart';
export 'drawing_call_recorder.dart';

// UI components
export 'test_stage.dart';

// Testing utilities
export 'golden_matchers.dart';