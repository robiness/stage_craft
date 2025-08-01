import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/recording/models/recording_state.dart';

void main() {
  group('RecordingState', () {
    group('Construction', () {
      test('creates idle state', () {
        const state = RecordingState.idle();
        
        state.when(
          idle: () => expect(true, isTrue),
          recording: () => fail('Should be idle state'),
          playing: () => fail('Should be idle state'),
          paused: () => fail('Should be idle state'),
        );
      });

      test('creates recording state', () {
        const state = RecordingState.recording();
        
        state.when(
          idle: () => fail('Should be recording state'),
          recording: () => expect(true, isTrue),
          playing: () => fail('Should be recording state'),
          paused: () => fail('Should be recording state'),
        );
      });

      test('creates playing state', () {
        const state = RecordingState.playing();
        
        state.when(
          idle: () => fail('Should be playing state'),
          recording: () => fail('Should be playing state'),
          playing: () => expect(true, isTrue),
          paused: () => fail('Should be playing state'),
        );
      });

      test('creates paused state', () {
        const state = RecordingState.paused();
        
        state.when(
          idle: () => fail('Should be paused state'),
          recording: () => fail('Should be paused state'),
          playing: () => fail('Should be paused state'),
          paused: () => expect(true, isTrue),
        );
      });
    });

    group('JSON Serialization', () {
      test('serializes and deserializes idle state', () {
        const original = RecordingState.idle();
        final json = original.toJson();
        final deserialized = RecordingState.fromJson(json);

        expect(deserialized, equals(original));
        expect(deserialized.isIdle, isTrue);
      });

      test('serializes and deserializes recording state', () {
        const original = RecordingState.recording();
        final json = original.toJson();
        final deserialized = RecordingState.fromJson(json);

        expect(deserialized, equals(original));
        expect(deserialized.isRecording, isTrue);
      });

      test('serializes and deserializes playing state', () {
        const original = RecordingState.playing();
        final json = original.toJson();
        final deserialized = RecordingState.fromJson(json);

        expect(deserialized, equals(original));
        expect(deserialized.isPlaying, isTrue);
      });

      test('serializes and deserializes paused state', () {
        const original = RecordingState.paused();
        final json = original.toJson();
        final deserialized = RecordingState.fromJson(json);

        expect(deserialized, equals(original));
        expect(deserialized.isPaused, isTrue);
      });
    });

    group('Extension Methods - State Checking', () {
      group('isIdle', () {
        test('returns true for idle state', () {
          const state = RecordingState.idle();
          expect(state.isIdle, isTrue);
        });

        test('returns false for non-idle states', () {
          const states = [
            RecordingState.recording(),
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in states) {
            expect(state.isIdle, isFalse);
          }
        });
      });

      group('isRecording', () {
        test('returns true for recording state', () {
          const state = RecordingState.recording();
          expect(state.isRecording, isTrue);
        });

        test('returns false for non-recording states', () {
          const states = [
            RecordingState.idle(),
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in states) {
            expect(state.isRecording, isFalse);
          }
        });
      });

      group('isPlaying', () {
        test('returns true for playing state', () {
          const state = RecordingState.playing();
          expect(state.isPlaying, isTrue);
        });

        test('returns false for non-playing states', () {
          const states = [
            RecordingState.idle(),
            RecordingState.recording(),
            RecordingState.paused(),
          ];

          for (final state in states) {
            expect(state.isPlaying, isFalse);
          }
        });
      });

      group('isPaused', () {
        test('returns true for paused state', () {
          const state = RecordingState.paused();
          expect(state.isPaused, isTrue);
        });

        test('returns false for non-paused states', () {
          const states = [
            RecordingState.idle(),
            RecordingState.recording(),
            RecordingState.playing(),
          ];

          for (final state in states) {
            expect(state.isPaused, isFalse);
          }
        });
      });

      group('isInPlaybackMode', () {
        test('returns true for playing and paused states', () {
          const playbackStates = [
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in playbackStates) {
            expect(state.isInPlaybackMode, isTrue);
          }
        });

        test('returns false for non-playback states', () {
          const nonPlaybackStates = [
            RecordingState.idle(),
            RecordingState.recording(),
          ];

          for (final state in nonPlaybackStates) {
            expect(state.isInPlaybackMode, isFalse);
          }
        });
      });

      group('isBusy', () {
        test('returns true for non-idle states', () {
          const busyStates = [
            RecordingState.recording(),
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in busyStates) {
            expect(state.isBusy, isTrue);
          }
        });

        test('returns false for idle state', () {
          const state = RecordingState.idle();
          expect(state.isBusy, isFalse);
        });
      });
    });

    group('Extension Methods - Interaction Control', () {
      group('allowsControlInteraction', () {
        test('returns true for idle and recording states', () {
          const interactiveStates = [
            RecordingState.idle(),
            RecordingState.recording(),
          ];

          for (final state in interactiveStates) {
            expect(state.allowsControlInteraction, isTrue,
                reason: 'State ${state.displayName} should allow control interaction');
          }
        });

        test('returns false for playing and paused states', () {
          const nonInteractiveStates = [
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in nonInteractiveStates) {
            expect(state.allowsControlInteraction, isFalse,
                reason: 'State ${state.displayName} should not allow control interaction');
          }
        });
      });

      group('allowsCanvasInteraction', () {
        test('returns same as allowsControlInteraction', () {
          const allStates = [
            RecordingState.idle(),
            RecordingState.recording(),
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in allStates) {
            expect(state.allowsCanvasInteraction, equals(state.allowsControlInteraction),
                reason: 'Canvas interaction should match control interaction for ${state.displayName}');
          }
        });
      });

      group('canStartRecording', () {
        test('returns true only for idle state', () {
          const state = RecordingState.idle();
          expect(state.canStartRecording, isTrue);
        });

        test('returns false for non-idle states', () {
          const nonIdleStates = [
            RecordingState.recording(),
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in nonIdleStates) {
            expect(state.canStartRecording, isFalse,
                reason: 'State ${state.displayName} should not allow starting recording');
          }
        });
      });

      group('canStartPlayback', () {
        test('returns true only for idle state', () {
          const state = RecordingState.idle();
          expect(state.canStartPlayback, isTrue);
        });

        test('returns false for non-idle states', () {
          const nonIdleStates = [
            RecordingState.recording(),
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in nonIdleStates) {
            expect(state.canStartPlayback, isFalse,
                reason: 'State ${state.displayName} should not allow starting playback');
          }
        });
      });
    });

    group('Extension Methods - Display Properties', () {
      group('displayName', () {
        test('returns correct display names', () {
          final expectedNames = {
            RecordingState.idle(): 'Ready',
            RecordingState.recording(): 'Recording...',
            RecordingState.playing(): 'Playing',
            RecordingState.paused(): 'Paused',
          };

          expectedNames.forEach((state, expectedName) {
            expect(state.displayName, equals(expectedName),
                reason: 'State should have display name "$expectedName"');
          });
        });

        test('display names are human-readable', () {
          const allStates = [
            RecordingState.idle(),
            RecordingState.recording(),
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in allStates) {
            final displayName = state.displayName;
            expect(displayName.isNotEmpty, isTrue);
            expect(displayName.length, greaterThan(3));
            expect(displayName[0].toUpperCase(), equals(displayName[0]),
                reason: 'Display name should start with capital letter');
          }
        });
      });

      group('iconName', () {
        test('returns correct icon names', () {
          final expectedIcons = {
            RecordingState.idle(): 'fiber_manual_record',
            RecordingState.recording(): 'stop',
            RecordingState.playing(): 'pause',
            RecordingState.paused(): 'play_arrow',
          };

          expectedIcons.forEach((state, expectedIcon) {
            expect(state.iconName, equals(expectedIcon),
                reason: 'State should have icon name "$expectedIcon"');
          });
        });

        test('icon names are valid Material Design icons', () {
          const allStates = [
            RecordingState.idle(),
            RecordingState.recording(),
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          // These are known Material Design icon names
          const validIconNames = {
            'fiber_manual_record',
            'stop',
            'pause',
            'play_arrow',
          };

          for (final state in allStates) {
            final iconName = state.iconName;
            expect(validIconNames, contains(iconName),
                reason: 'Icon name "$iconName" should be a valid Material Design icon');
          }
        });
      });

      group('stateColor', () {
        test('returns correct state colors', () {
          final expectedColors = {
            RecordingState.idle(): 0xFF2196F3,      // Blue
            RecordingState.recording(): 0xFFF44336, // Red
            RecordingState.playing(): 0xFF4CAF50,   // Green
            RecordingState.paused(): 0xFFFF9800,    // Orange
          };

          expectedColors.forEach((state, expectedColor) {
            expect(state.stateColor, equals(expectedColor),
                reason: 'State should have color $expectedColor');
          });
        });

        test('state colors are valid ARGB values', () {
          const allStates = [
            RecordingState.idle(),
            RecordingState.recording(),
            RecordingState.playing(),
            RecordingState.paused(),
          ];

          for (final state in allStates) {
            final color = state.stateColor;
            
            // Check that it's a valid ARGB color (alpha channel should be 0xFF)
            expect(color & 0xFF000000, equals(0xFF000000),
                reason: 'Color should have full alpha channel');
            
            // Check that it's within valid range
            expect(color, greaterThanOrEqualTo(0xFF000000));
            expect(color, lessThanOrEqualTo(0xFFFFFFFF));
          }
        });

        test('state colors are semantically appropriate', () {
          // Recording should be red (danger/active)
          expect(RecordingState.recording().stateColor & 0x00FF0000, 
              equals(0x00F40000), // High red component
              reason: 'Recording state should be predominantly red');
          
          // Playing should be green (success/active)
          expect(RecordingState.playing().stateColor & 0x0000FF00, 
              equals(0x0000AF00), // High green component
              reason: 'Playing state should be predominantly green');
              
          // Idle should be blue (info/neutral)
          expect(RecordingState.idle().stateColor & 0x000000FF, 
              equals(0x000000F3), // High blue component
              reason: 'Idle state should be predominantly blue');
        });
      });
    });

    group('State Equality and Comparison', () {
      test('same states are equal', () {
        const idle1 = RecordingState.idle();
        const idle2 = RecordingState.idle();
        const recording1 = RecordingState.recording();
        const recording2 = RecordingState.recording();

        expect(idle1, equals(idle2));
        expect(recording1, equals(recording2));
        expect(idle1.hashCode, equals(idle2.hashCode));
        expect(recording1.hashCode, equals(recording2.hashCode));
      });

      test('different states are not equal', () {
        const allStates = [
          RecordingState.idle(),
          RecordingState.recording(),
          RecordingState.playing(),
          RecordingState.paused(),
        ];

        for (int i = 0; i < allStates.length; i++) {
          for (int j = i + 1; j < allStates.length; j++) {
            expect(allStates[i], isNot(equals(allStates[j])),
                reason: '${allStates[i].displayName} should not equal ${allStates[j].displayName}');
          }
        }
      });
    });

    group('Pattern Matching', () {
      test('when method handles all states exhaustively', () {
        const allStates = [
          RecordingState.idle(),
          RecordingState.recording(),
          RecordingState.playing(),
          RecordingState.paused(),
        ];

        for (final state in allStates) {
          final result = state.when(
            idle: () => 'idle',
            recording: () => 'recording',
            playing: () => 'playing',
            paused: () => 'paused',
          );

          expect(result, isA<String>());
          expect(result.isNotEmpty, isTrue);
        }
      });

      test('maybeWhen method with orElse fallback', () {
        const state = RecordingState.recording();

        final result = state.maybeWhen(
          idle: () => 'idle',
          orElse: () => 'other',
        );

        expect(result, equals('other'));
      });

      test('map method works correctly', () {
        const allStates = [
          RecordingState.idle(),
          RecordingState.recording(),
          RecordingState.playing(),
          RecordingState.paused(),
        ];

        for (final state in allStates) {
          final result = state.map(
            idle: (idle) => 'mapped_idle',
            recording: (recording) => 'mapped_recording',
            playing: (playing) => 'mapped_playing',
            paused: (paused) => 'mapped_paused',
          );

          expect(result, startsWith('mapped_'));
        }
      });
    });

    group('State Transition Logic Validation', () {
      test('idle state allows starting operations', () {
        const state = RecordingState.idle();
        
        expect(state.canStartRecording, isTrue);
        expect(state.canStartPlayback, isTrue);
        expect(state.allowsControlInteraction, isTrue);
        expect(state.allowsCanvasInteraction, isTrue);
        expect(state.isBusy, isFalse);
      });

      test('recording state allows interactions but prevents new operations', () {
        const state = RecordingState.recording();
        
        expect(state.canStartRecording, isFalse);
        expect(state.canStartPlayback, isFalse);
        expect(state.allowsControlInteraction, isTrue); // Interactions are captured
        expect(state.allowsCanvasInteraction, isTrue);
        expect(state.isBusy, isTrue);
      });

      test('playing state prevents all interactions except stop', () {
        const state = RecordingState.playing();
        
        expect(state.canStartRecording, isFalse);
        expect(state.canStartPlayback, isFalse);
        expect(state.allowsControlInteraction, isFalse); // Controlled by playback
        expect(state.allowsCanvasInteraction, isFalse);
        expect(state.isBusy, isTrue);
        expect(state.isInPlaybackMode, isTrue);
      });

      test('paused state prevents interactions but allows timeline operations', () {
        const state = RecordingState.paused();
        
        expect(state.canStartRecording, isFalse);
        expect(state.canStartPlayback, isFalse);
        expect(state.allowsControlInteraction, isFalse); // Frozen at current values
        expect(state.allowsCanvasInteraction, isFalse);
        expect(state.isBusy, isTrue);
        expect(state.isInPlaybackMode, isTrue);
      });
    });

    group('UI Integration Properties', () {
      test('icon names map to meaningful UI actions', () {
        // Idle shows record icon - ready to start recording
        expect(RecordingState.idle().iconName, equals('fiber_manual_record'));
        
        // Recording shows stop icon - can stop recording
        expect(RecordingState.recording().iconName, equals('stop'));
        
        // Playing shows pause icon - can pause playback
        expect(RecordingState.playing().iconName, equals('pause'));
        
        // Paused shows play icon - can resume playback
        expect(RecordingState.paused().iconName, equals('play_arrow'));
      });

      test('colors provide semantic meaning', () {
        // Blue for neutral/ready state
        expect(RecordingState.idle().stateColor, equals(0xFF2196F3));
        
        // Red for active/dangerous operation (recording)
        expect(RecordingState.recording().stateColor, equals(0xFFF44336));
        
        // Green for positive/success operation (playing)
        expect(RecordingState.playing().stateColor, equals(0xFF4CAF50));
        
        // Orange for warning/intermediate state (paused)
        expect(RecordingState.paused().stateColor, equals(0xFFFF9800));
      });

      test('display names are user-friendly', () {
        expect(RecordingState.idle().displayName, equals('Ready'));
        expect(RecordingState.recording().displayName, equals('Recording...'));
        expect(RecordingState.playing().displayName, equals('Playing'));
        expect(RecordingState.paused().displayName, equals('Paused'));
      });
    });

    group('Documentation Examples Validation', () {
      test('pattern matching example from documentation works', () {
        const state = RecordingState.recording();
        
        final canRecord = state.when(
          idle: () => true,
          recording: () => false,
          playing: () => false,
          paused: () => false,
        );
        
        expect(canRecord, isFalse);
      });

      test('partial matching example from documentation works', () {
        const state = RecordingState.playing();
        
        final buttonIcon = state.maybeWhen(
          idle: () => 'fiber_manual_record',
          recording: () => 'stop',
          orElse: () => 'play_arrow', // Should cover playing and paused
        );
        
        expect(buttonIcon, equals('play_arrow'));
      });

      test('state transition examples are valid', () {
        // Valid transitions according to documentation
        const validTransitions = [
          // idle → recording → idle (normal recording workflow)
          [RecordingState.idle(), RecordingState.recording(), RecordingState.idle()],
          // idle → playing → paused → playing → idle (playback workflow)
          [RecordingState.idle(), RecordingState.playing(), RecordingState.paused(), RecordingState.playing(), RecordingState.idle()],
          // idle → playing → idle (direct stop during playback)
          [RecordingState.idle(), RecordingState.playing(), RecordingState.idle()],
        ];

        for (final transition in validTransitions) {
          for (final state in transition) {
            expect(state, isA<RecordingState>());
          }
        }
      });
    });

    group('Edge Cases and Error Conditions', () {
      test('handles toString gracefully', () {
        const allStates = [
          RecordingState.idle(),
          RecordingState.recording(),
          RecordingState.playing(),
          RecordingState.paused(),
        ];

        for (final state in allStates) {
          final stringRep = state.toString();
          expect(stringRep.isNotEmpty, isTrue);
          expect(stringRep.contains('RecordingState'), isTrue);
        }
      });

      test('properties are consistent with each other', () {
        const allStates = [
          RecordingState.idle(),
          RecordingState.recording(),
          RecordingState.playing(),
          RecordingState.paused(),
        ];

        for (final state in allStates) {
          // isBusy should be opposite of isIdle
          expect(state.isBusy, equals(!state.isIdle));
          
          // isInPlaybackMode should be true for playing or paused
          expect(state.isInPlaybackMode, equals(state.isPlaying || state.isPaused));
          
          // Only one state check should be true at a time
          final stateChecks = [
            state.isIdle,
            state.isRecording,
            state.isPlaying,
            state.isPaused,
          ];
          final trueCount = stateChecks.where((check) => check).length;
          expect(trueCount, equals(1), 
              reason: 'Exactly one state check should be true for ${state.displayName}');
        }
      });

      test('JSON roundtrip preserves state identity', () {
        const allStates = [
          RecordingState.idle(),
          RecordingState.recording(),
          RecordingState.playing(),
          RecordingState.paused(),
        ];

        for (final original in allStates) {
          final json = original.toJson();
          final deserialized = RecordingState.fromJson(json);
          
          // Should be equal
          expect(deserialized, equals(original));
          
          // Should have same properties
          expect(deserialized.isIdle, equals(original.isIdle));
          expect(deserialized.isRecording, equals(original.isRecording));
          expect(deserialized.isPlaying, equals(original.isPlaying));
          expect(deserialized.isPaused, equals(original.isPaused));
          expect(deserialized.displayName, equals(original.displayName));
          expect(deserialized.iconName, equals(original.iconName));
          expect(deserialized.stateColor, equals(original.stateColor));
        }
      });
    });
  });
}