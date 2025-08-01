// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_scenario.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestScenario _$TestScenarioFromJson(Map<String, dynamic> json) {
  return _TestScenario.fromJson(json);
}

/// @nodoc
mixin _$TestScenario {
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
  String get name => throw _privateConstructorUsedError;

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
  List<StateFrame> get stateFrames => throw _privateConstructorUsedError;

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
  List<DrawingFrame> get drawingFrames => throw _privateConstructorUsedError;

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
  DateTime get createdAt => throw _privateConstructorUsedError;

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
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this TestScenario to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestScenario
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestScenarioCopyWith<TestScenario> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestScenarioCopyWith<$Res> {
  factory $TestScenarioCopyWith(
          TestScenario value, $Res Function(TestScenario) then) =
      _$TestScenarioCopyWithImpl<$Res, TestScenario>;
  @useResult
  $Res call(
      {String name,
      List<StateFrame> stateFrames,
      List<DrawingFrame> drawingFrames,
      DateTime createdAt,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$TestScenarioCopyWithImpl<$Res, $Val extends TestScenario>
    implements $TestScenarioCopyWith<$Res> {
  _$TestScenarioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestScenario
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? stateFrames = null,
    Object? drawingFrames = null,
    Object? createdAt = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      stateFrames: null == stateFrames
          ? _value.stateFrames
          : stateFrames // ignore: cast_nullable_to_non_nullable
              as List<StateFrame>,
      drawingFrames: null == drawingFrames
          ? _value.drawingFrames
          : drawingFrames // ignore: cast_nullable_to_non_nullable
              as List<DrawingFrame>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestScenarioImplCopyWith<$Res>
    implements $TestScenarioCopyWith<$Res> {
  factory _$$TestScenarioImplCopyWith(
          _$TestScenarioImpl value, $Res Function(_$TestScenarioImpl) then) =
      __$$TestScenarioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      List<StateFrame> stateFrames,
      List<DrawingFrame> drawingFrames,
      DateTime createdAt,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$TestScenarioImplCopyWithImpl<$Res>
    extends _$TestScenarioCopyWithImpl<$Res, _$TestScenarioImpl>
    implements _$$TestScenarioImplCopyWith<$Res> {
  __$$TestScenarioImplCopyWithImpl(
      _$TestScenarioImpl _value, $Res Function(_$TestScenarioImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestScenario
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? stateFrames = null,
    Object? drawingFrames = null,
    Object? createdAt = null,
    Object? metadata = null,
  }) {
    return _then(_$TestScenarioImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      stateFrames: null == stateFrames
          ? _value._stateFrames
          : stateFrames // ignore: cast_nullable_to_non_nullable
              as List<StateFrame>,
      drawingFrames: null == drawingFrames
          ? _value._drawingFrames
          : drawingFrames // ignore: cast_nullable_to_non_nullable
              as List<DrawingFrame>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestScenarioImpl implements _TestScenario {
  const _$TestScenarioImpl(
      {required this.name,
      required final List<StateFrame> stateFrames,
      final List<DrawingFrame> drawingFrames = const [],
      required this.createdAt,
      final Map<String, dynamic> metadata = const {}})
      : _stateFrames = stateFrames,
        _drawingFrames = drawingFrames,
        _metadata = metadata;

  factory _$TestScenarioImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestScenarioImplFromJson(json);

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
  @override
  final String name;

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
  final List<StateFrame> _stateFrames;

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
  @override
  List<StateFrame> get stateFrames {
    if (_stateFrames is EqualUnmodifiableListView) return _stateFrames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stateFrames);
  }

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
  final List<DrawingFrame> _drawingFrames;

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
  @override
  @JsonKey()
  List<DrawingFrame> get drawingFrames {
    if (_drawingFrames is EqualUnmodifiableListView) return _drawingFrames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_drawingFrames);
  }

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
  @override
  final DateTime createdAt;

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
  final Map<String, dynamic> _metadata;

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
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'TestScenario(name: $name, stateFrames: $stateFrames, drawingFrames: $drawingFrames, createdAt: $createdAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestScenarioImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._stateFrames, _stateFrames) &&
            const DeepCollectionEquality()
                .equals(other._drawingFrames, _drawingFrames) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_stateFrames),
      const DeepCollectionEquality().hash(_drawingFrames),
      createdAt,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of TestScenario
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestScenarioImplCopyWith<_$TestScenarioImpl> get copyWith =>
      __$$TestScenarioImplCopyWithImpl<_$TestScenarioImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestScenarioImplToJson(
      this,
    );
  }
}

abstract class _TestScenario implements TestScenario {
  const factory _TestScenario(
      {required final String name,
      required final List<StateFrame> stateFrames,
      final List<DrawingFrame> drawingFrames,
      required final DateTime createdAt,
      final Map<String, dynamic> metadata}) = _$TestScenarioImpl;

  factory _TestScenario.fromJson(Map<String, dynamic> json) =
      _$TestScenarioImpl.fromJson;

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
  @override
  String get name;

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
  @override
  List<StateFrame> get stateFrames;

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
  @override
  List<DrawingFrame> get drawingFrames;

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
  @override
  DateTime get createdAt;

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
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of TestScenario
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestScenarioImplCopyWith<_$TestScenarioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
