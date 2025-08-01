import 'package:flutter/foundation.dart';

/// Controller responsible solely for managing recording state.
/// 
/// This controller follows the single responsibility principle by only handling
/// the recording state (isRecording, start, stop, cancel) without concerns about
/// frame capture, storage, or other recording operations.
class RecordingStateController extends ChangeNotifier {
  bool _isRecording = false;
  DateTime? _recordingStartTime;

  /// Whether recording is currently active.
  bool get isRecording => _isRecording;

  /// The duration of the current recording session.
  /// Returns [Duration.zero] if not currently recording.
  Duration get recordingDuration {
    if (!_isRecording || _recordingStartTime == null) {
      return Duration.zero;
    }
    return DateTime.now().difference(_recordingStartTime!);
  }

  /// Starts recording session.
  /// 
  /// If already recording, this method does nothing.
  /// Emits a change notification when recording starts.
  void start() {
    if (_isRecording) return;

    _isRecording = true;
    _recordingStartTime = DateTime.now();
    notifyListeners();
  }

  /// Stops the current recording session.
  /// 
  /// If not currently recording, this method does nothing.
  /// Emits a change notification when recording stops.
  void stop() {
    if (!_isRecording) return;

    _isRecording = false;
    _recordingStartTime = null;
    notifyListeners();
  }

  /// Cancels the current recording session.
  /// 
  /// Similar to [stop] but semantically indicates the recording
  /// was cancelled rather than completed.
  /// Emits a change notification when recording is cancelled.
  void cancel() {
    if (!_isRecording) return;

    _isRecording = false;
    _recordingStartTime = null;
    notifyListeners();
  }

  /// Resets the controller to initial state.
  /// 
  /// This is useful for testing or when the controller needs
  /// to be reused in a clean state.
  void reset() {
    _isRecording = false;
    _recordingStartTime = null;
    notifyListeners();
  }
}