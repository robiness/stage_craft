/// Base interface for any type of recorder.
/// T represents the type of data that is recorded (e.g., a list of state changes, a list of drawing calls).
abstract class Recorder<T> {
  /// Starts recording data.
  void start();

  /// Stops recording and finalizes the data.
  void stop();

  /// Whether the recorder is currently recording.
  bool get isRecording;

  /// The recorded data.
  T get data;

  /// Clears all recorded data.
  void clear();
}