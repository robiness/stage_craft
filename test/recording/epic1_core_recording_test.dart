// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/controls/controls.dart';
import 'package:stage_craft/src/recording/playback_controller.dart';
import 'package:stage_craft/src/recording/scenario_repository.dart';
import 'package:stage_craft/src/recording/stage_controller.dart';
import 'package:stage_craft/src/recording/test_scenario.dart';
import 'package:stage_craft/src/stage/stage.dart';

void main() {
  group('Epic 1: Core Recording & Playback Engine', () {
    group('TestScenario and ScenarioFrame', () {
      test('should create ScenarioFrame with all required data', () {
        final frame = ScenarioFrame(
          timestamp: const Duration(milliseconds: 500),
          controlValues: {'size': 100.0, 'color': Colors.red.toARGB32()},
          canvasSettings: {'zoomFactor': 1.5, 'showRuler': true},
          drawingCalls: [
            const DrawingCall(
              method: 'drawRect',
              args: {'x': 10.0, 'y': 10.0, 'width': 100.0, 'height': 100.0},
              widgetName: 'Container',
            ),
          ],
        );

        expect(frame.timestamp, const Duration(milliseconds: 500));
        expect(frame.controlValues['size'], 100.0);
        expect(frame.canvasSettings['zoomFactor'], 1.5);
        expect(frame.drawingCalls.length, 1);
        expect(frame.drawingCalls.first.method, 'drawRect');
      });

      test('should serialize and deserialize ScenarioFrame correctly', () {
        const originalFrame = ScenarioFrame(
          timestamp: Duration(milliseconds: 1000),
          controlValues: {'test': 'value'},
          canvasSettings: {'zoom': 2.0},
          drawingCalls: [
            DrawingCall(
              method: 'drawCircle',
              args: {'radius': 50.0},
              widgetName: 'CircleAvatar',
              widgetKey: 'avatar_key',
            ),
          ],
        );

        final json = originalFrame.toJson();
        final reconstructedFrame = ScenarioFrame.fromJson(json);

        expect(reconstructedFrame.timestamp, originalFrame.timestamp);
        expect(reconstructedFrame.controlValues, originalFrame.controlValues);
        expect(reconstructedFrame.canvasSettings, originalFrame.canvasSettings);
        expect(reconstructedFrame.drawingCalls.length, 1);
        expect(reconstructedFrame.drawingCalls.first.method, 'drawCircle');
        expect(reconstructedFrame.drawingCalls.first.widgetKey, 'avatar_key');
      });

      test('should create TestScenario with frames and metadata', () {
        final frames = [
          const ScenarioFrame(
            timestamp: Duration.zero,
            controlValues: {'initial': true},
            canvasSettings: {},
            drawingCalls: [],
          ),
          const ScenarioFrame(
            timestamp: Duration(milliseconds: 500),
            controlValues: {'changed': true},
            canvasSettings: {},
            drawingCalls: [],
          ),
        ];

        final scenario = ConcreteTestScenario(
          name: 'Test Scenario',
          metadata: {'author': 'test', 'version': '1.0'},
          frames: frames,
        );

        expect(scenario.name, 'Test Scenario');
        expect(scenario.frames.length, 2);
        expect(scenario.totalDuration, const Duration(milliseconds: 500));
        expect(scenario.metadata['author'], 'test');
      });
    });

    group('StageController Recording', () {
      late StageController controller;
      late List<ValueControl> controls;
      late StageCanvasController canvasController;

      setUp(() {
        controller = StageController();
        controls = <ValueControl>[
          StringControl(label: 'text', initialValue: 'Hello'),
          IntControl(label: 'count', initialValue: 5),
        ];
        canvasController = StageCanvasController();
      });

      tearDown(() {
        canvasController.dispose();
      });

      test('should start recording with correct initial state', () {
        expect(controller.isRecording, false);
        expect(controller.recordingDuration, Duration.zero);

        controller.startRecording(controls, canvasController);

        expect(controller.isRecording, true);
        expect(controller.recordingDuration.inMilliseconds, greaterThanOrEqualTo(0));
      });

      test('should stop recording and maintain state', () {
        controller.startRecording(controls, canvasController);
        expect(controller.isRecording, true);

        controller.stopRecording();
        expect(controller.isRecording, false);
        expect(controller.recordingDuration, Duration.zero);
      });

      test('should cancel recording and clear data', () {
        controller.startRecording(controls, canvasController);

        controller.captureFrame([]);
        controller.captureFrame([]);

        final scenarioBeforeCancel = controller.createScenario(name: 'test');
        expect(scenarioBeforeCancel.frames.length, 2);

        controller.cancelRecording();
        expect(controller.isRecording, false);

        final scenarioAfterCancel = controller.createScenario(name: 'test');
        expect(scenarioAfterCancel.frames.length, 0);
      });

      test('should capture frames with correct timestamps', () async {
        controller.startRecording(controls, canvasController);

        controller.captureFrame([]);
        await Future.delayed(const Duration(milliseconds: 100));
        controller.captureFrame([]);

        final scenario = controller.createScenario(name: 'Timestamp Test');
        expect(scenario.frames.length, 2);
        expect(scenario.frames[0].timestamp.inMilliseconds, lessThanOrEqualTo(10));
        expect(scenario.frames[1].timestamp.inMilliseconds, greaterThan(50));
      });

      test('should capture control values in frames', () {
        controller.startRecording(controls, canvasController);

        controls[0].value = 'Updated';
        controls[1].value = 10;
        controller.captureFrame([]);

        final scenario = controller.createScenario(name: 'Control Values Test');
        expect(scenario.frames.length, 1);
        expect(scenario.frames[0].controlValues['text'], 'Updated');
        expect(scenario.frames[0].controlValues['count'], 10);
      });

      test('should capture canvas settings in frames', () {
        controller.startRecording(controls, canvasController);

        canvasController.zoomFactor = 2.0;
        canvasController.showRuler = true;
        canvasController.showCrossHair = true;
        controller.captureFrame([]);

        final scenario = controller.createScenario(name: 'Canvas Settings Test');
        expect(scenario.frames.length, 1);
        final frame = scenario.frames[0];
        expect(frame.canvasSettings['zoomFactor'], 2.0);
        expect(frame.canvasSettings['showRuler'], true);
        expect(frame.canvasSettings['showCrossHair'], true);
      });
    });

    group('FileScenarioRepository', () {
      late FileScenarioRepository repository;
      late Directory tempDir;

      setUp(() async {
        tempDir = await Directory.systemTemp.createTemp('scenario_test_');
        repository = FileScenarioRepository(defaultDirectory: tempDir.path);
      });

      tearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });

      test('should save scenario to file', () async {
        final scenario = ConcreteTestScenario(
          name: 'Test Save',
          metadata: {'test': true},
          frames: [
            ScenarioFrame(
              timestamp: Duration.zero,
              controlValues: {'value': 42},
              canvasSettings: {},
              drawingCalls: [],
            ),
          ],
        );

        await repository.saveScenario(scenario);

        final files = tempDir.listSync();
        expect(files.length, 1);
        expect(files.first.path, contains('Test_Save_'));
      });

      test('should load scenario from file', () async {
        final originalScenario = ConcreteTestScenario(
          name: 'Load Test',
          metadata: {'version': '1.0'},
          frames: [
            ScenarioFrame(
              timestamp: const Duration(milliseconds: 100),
              controlValues: {'loaded': true},
              canvasSettings: {'zoom': 1.5},
              drawingCalls: [
                const DrawingCall(
                  method: 'drawText',
                  args: {'text': 'Hello'},
                  widgetName: 'Text',
                ),
              ],
            ),
          ],
        );

        final filePath = '${tempDir.path}/test_scenario.json';
        final file = File(filePath);
        await file.writeAsString(
          const JsonEncoder.withIndent('  ').convert(originalScenario.toJson()),
        );

        final loadedScenario = await repository.loadScenarioFromFile(filePath);

        expect(loadedScenario.name, 'Load Test');
        expect(loadedScenario.metadata['version'], '1.0');
        expect(loadedScenario.frames.length, 1);
        expect(loadedScenario.frames[0].controlValues['loaded'], true);
        expect(loadedScenario.frames[0].drawingCalls.length, 1);
        expect(loadedScenario.frames[0].drawingCalls.first.method, 'drawText');
      });
    });

    group('PlaybackController', () {
      late PlaybackController playbackController;
      late List<ValueControl> controls;
      late StageCanvasController canvasController;

      setUp(() {
        playbackController = PlaybackController();
        controls = <ValueControl>[
          StringControl(label: 'text', initialValue: 'initial'),
          IntControl(label: 'number', initialValue: 0),
        ];
        canvasController = StageCanvasController();
      });

      tearDown(() {
        playbackController.dispose();
        canvasController.dispose();
      });

      test('should set playback speed correctly', () {
        expect(playbackController.playbackSpeed, 1.0);

        playbackController.playbackSpeed = 2.0;
        expect(playbackController.playbackSpeed, 2.0);

        expect(() => playbackController.playbackSpeed = 0, throwsArgumentError);
        expect(() => playbackController.playbackSpeed = -1, throwsArgumentError);
      });

      test('should start playback of scenario', () {
        final scenario = ConcreteTestScenario(
          name: 'Playback Test',
          metadata: {},
          frames: [
            ScenarioFrame(
              timestamp: Duration.zero,
              controlValues: {'text': 'frame1', 'number': 1},
              canvasSettings: {'zoomFactor': 1.0},
              drawingCalls: [],
            ),
          ],
        );

        expect(playbackController.isPlaying, false);

        playbackController.playScenario(scenario, controls: controls, canvasController: canvasController);

        expect(playbackController.isPlaying, true);
        expect(playbackController.currentFrameIndex, 1);
      });

      test('should apply frame data to controls and canvas', () {
        final scenario = ConcreteTestScenario(
          name: 'Apply Test',
          metadata: {},
          frames: [
            ScenarioFrame(
              timestamp: Duration.zero,
              controlValues: {'text': 'applied', 'number': 42},
              canvasSettings: {'zoomFactor': 2.5, 'showRuler': true},
              drawingCalls: [],
            ),
          ],
        );

        playbackController.playScenario(scenario, controls: controls, canvasController: canvasController);

        expect(controls[0].value, 'applied');
        expect(controls[1].value, 42);
        expect(canvasController.zoomFactor, 2.5);
        expect(canvasController.showRuler, true);
      });

      test('should pause and resume playback', () {
        final scenario = ConcreteTestScenario(
          name: 'Pause Test',
          metadata: {},
          frames: [
            ScenarioFrame(
              timestamp: Duration.zero,
              controlValues: {},
              canvasSettings: {},
              drawingCalls: [],
            ),
            ScenarioFrame(
              timestamp: const Duration(milliseconds: 1000),
              controlValues: {},
              canvasSettings: {},
              drawingCalls: [],
            ),
          ],
        );

        playbackController.playScenario(scenario, controls: controls, canvasController: canvasController);
        expect(playbackController.isPlaying, true);
        expect(playbackController.isPaused, false);

        playbackController.pause();
        expect(playbackController.isPlaying, true);
        expect(playbackController.isPaused, true);

        playbackController.resume(controls, canvasController);
        expect(playbackController.isPlaying, true);
        expect(playbackController.isPaused, false);
      });

      test('should stop playback correctly', () {
        final scenario = ConcreteTestScenario(
          name: 'Stop Test',
          metadata: {},
          frames: [
            ScenarioFrame(
              timestamp: Duration.zero,
              controlValues: {},
              canvasSettings: {},
              drawingCalls: [],
            ),
          ],
        );

        playbackController.playScenario(scenario, controls: controls, canvasController: canvasController);
        expect(playbackController.isPlaying, true);

        playbackController.stop();
        expect(playbackController.isPlaying, false);
        expect(playbackController.isPaused, false);
        expect(playbackController.currentFrameIndex, 0);
      });
    });

    group('Integration Tests', () {
      late StageController stageController;
      late FileScenarioRepository repository;
      late Directory tempDir;

      setUp(() async {
        tempDir = await Directory.systemTemp.createTemp('integration_test_');
        repository = FileScenarioRepository(defaultDirectory: tempDir.path);
        stageController = StageController(scenarioRepository: repository);
      });

      tearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });

      test('should record, save, load, and playback scenario end-to-end', () async {
        final controls = <ValueControl>[
          StringControl(label: 'title', initialValue: 'Start'),
          IntControl(label: 'count', initialValue: 1),
        ];
        final canvasController = StageCanvasController();

        stageController.startRecording(controls, canvasController);

        controls[0].value = 'Middle';
        controls[1].value = 2;
        stageController.captureFrame([]);

        await Future.delayed(const Duration(milliseconds: 50));

        controls[0].value = 'End';
        controls[1].value = 3;
        canvasController.zoomFactor = 1.5;
        stageController.captureFrame([]);

        stageController.stopRecording();

        final recordedScenario = stageController.createScenario(
          name: 'Integration Test',
          metadata: {'test': 'end-to-end'},
        );

        expect(recordedScenario.frames.length, 2);

        await stageController.saveScenario(recordedScenario);

        final files = tempDir.listSync();
        expect(files.length, 1);

        final loadedScenario = await repository.loadScenarioFromFile(files.first.path);
        expect(loadedScenario.name, 'Integration Test');
        expect(loadedScenario.frames.length, 2);

        controls[0].value = 'Reset';
        controls[1].value = 0;
        canvasController.zoomFactor = 1.0;

        final playbackController = PlaybackController();
        playbackController.playScenario(loadedScenario, controls: controls, canvasController: canvasController);

        expect(controls[0].value, 'Middle');
        expect(controls[1].value, 2);

        playbackController.dispose();
        canvasController.dispose();
      });
    });
  });
}
