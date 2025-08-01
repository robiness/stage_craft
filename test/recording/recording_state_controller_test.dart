import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/recording/recording_state_controller.dart';

void main() {
  group('RecordingStateController', () {
    late RecordingStateController controller;

    setUp(() {
      controller = RecordingStateController();
    });

    tearDown(() {
      controller.dispose();
    });

    group('Initial State', () {
      test('should start with recording disabled', () {
        expect(controller.isRecording, false);
      });

      test('should have zero recording duration initially', () {
        expect(controller.recordingDuration, Duration.zero);
      });
    });

    group('Start Recording', () {
      test('should enable recording when start is called', () {
        controller.start();
        expect(controller.isRecording, true);
      });

      test('should set recording start time when start is called', () {
        controller.start();
        expect(controller.recordingDuration.inMilliseconds, greaterThanOrEqualTo(0));
      });

      test('should notify listeners when recording starts', () {
        bool notified = false;
        controller.addListener(() => notified = true);
        
        controller.start();
        expect(notified, true);
      });

      test('should do nothing if already recording', () {
        controller.start();
        final firstDuration = controller.recordingDuration;
        
        // Try to start again
        controller.start();
        expect(controller.isRecording, true);
        
        // Duration should be similar (allowing for small time differences)
        final timeDiff = (controller.recordingDuration - firstDuration).inMilliseconds.abs();
        expect(timeDiff, lessThan(10));
      });
    });

    group('Stop Recording', () {
      test('should disable recording when stop is called', () {
        controller.start();
        controller.stop();
        
        expect(controller.isRecording, false);
      });

      test('should reset recording duration when stopped', () {
        controller.start();
        controller.stop();
        
        expect(controller.recordingDuration, Duration.zero);
      });

      test('should notify listeners when recording stops', () {
        controller.start();
        
        bool notified = false;
        controller.addListener(() => notified = true);
        
        controller.stop();
        expect(notified, true);
      });

      test('should do nothing if not recording', () {
        expect(controller.isRecording, false);
        
        bool notified = false;
        controller.addListener(() => notified = true);
        
        controller.stop();
        expect(notified, false);
        expect(controller.isRecording, false);
      });
    });

    group('Cancel Recording', () {
      test('should disable recording when cancel is called', () {
        controller.start();
        controller.cancel();
        
        expect(controller.isRecording, false);
      });

      test('should reset recording duration when cancelled', () {
        controller.start();
        controller.cancel();
        
        expect(controller.recordingDuration, Duration.zero);
      });

      test('should notify listeners when recording is cancelled', () {
        controller.start();
        
        bool notified = false;
        controller.addListener(() => notified = true);
        
        controller.cancel();
        expect(notified, true);
      });

      test('should do nothing if not recording', () {
        expect(controller.isRecording, false);
        
        bool notified = false;
        controller.addListener(() => notified = true);
        
        controller.cancel();
        expect(notified, false);
        expect(controller.isRecording, false);
      });
    });

    group('Reset', () {
      test('should reset recording state', () {
        controller.start();
        controller.reset();
        
        expect(controller.isRecording, false);
        expect(controller.recordingDuration, Duration.zero);
      });

      test('should notify listeners when reset', () {
        controller.start();
        
        bool notified = false;
        controller.addListener(() => notified = true);
        
        controller.reset();
        expect(notified, true);
      });

      test('should work when not recording', () {
        bool notified = false;
        controller.addListener(() => notified = true);
        
        controller.reset();
        expect(notified, true);
        expect(controller.isRecording, false);
      });
    });

    group('Recording Duration', () {
      test('should track recording time accurately', () async {
        controller.start();
        
        await Future.delayed(const Duration(milliseconds: 50));
        
        final duration = controller.recordingDuration;
        expect(duration.inMilliseconds, greaterThanOrEqualTo(40));
        expect(duration.inMilliseconds, lessThan(100));
      });

      test('should return zero when not recording', () {
        expect(controller.recordingDuration, Duration.zero);
        
        controller.start();
        controller.stop();
        
        expect(controller.recordingDuration, Duration.zero);
      });
    });

    group('State Transitions', () {
      test('should handle start -> stop -> start sequence', () {
        // First recording session
        controller.start();
        expect(controller.isRecording, true);
        
        controller.stop();
        expect(controller.isRecording, false);
        
        // Second recording session
        controller.start();
        expect(controller.isRecording, true);
      });

      test('should handle start -> cancel -> start sequence', () {
        // First recording session
        controller.start();
        expect(controller.isRecording, true);
        
        controller.cancel();
        expect(controller.isRecording, false);
        
        // Second recording session
        controller.start();
        expect(controller.isRecording, true);
      });
    });
  });
}