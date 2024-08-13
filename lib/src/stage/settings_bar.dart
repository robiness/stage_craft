// ignore: unnecessary_import - remove when min SDK is 3.19 or higher
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:stage_craft/src/stage/stage.dart';

/// A settings bar that allows the user to toggle and adjust various stage settings.
class SettingsBarCenter extends StatelessWidget {
  /// Creates a new settings bar.
  const SettingsBarCenter({
    super.key,
    required this.canvasController,
    required this.onStyleToggled,
    required this.onSurfaceColorChanged,
  });

  /// The canvas controller to manipulate the stage.
  final StageCanvasController canvasController;

  /// Called when the style is toggled.
  final VoidCallback onStyleToggled;

  /// Called when the surface color is changed.
  final void Function(Color color) onSurfaceColorChanged;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: canvasController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              width: 2,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(64),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.space_bar_sharp,
                  color: canvasController.showRuler ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  canvasController.showRuler = !canvasController.showRuler;
                },
              ),
              IconButton(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: context.stageStyle.canvasColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: MaterialPicker(
                            pickerColor: context.stageStyle.canvasColor,
                            onColorChanged: onSurfaceColorChanged,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              // toggle light and dark mode
              IconButton(
                icon: Icon(
                  Theme.of(context).brightness == Brightness.light ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.grey,
                ),
                onPressed: onStyleToggled,
              ),
              IconButton(
                icon: Icon(Icons.aspect_ratio, color: canvasController.forceSize ? Colors.blue : Colors.grey),
                onPressed: () {
                  canvasController.forceSize = !canvasController.forceSize;
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.center_focus_strong_outlined,
                  color: canvasController.showCrossHair ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  canvasController.showCrossHair = !canvasController.showCrossHair;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A settings bar that allows the user to toggle and adjust various stage settings.
class SettingsBarRight extends StatelessWidget {
  /// Creates a new settings bar.
  const SettingsBarRight({
    super.key,
    required this.canvasController,
  });

  /// The canvas controller to manipulate the stage.
  final StageCanvasController canvasController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: canvasController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              width: 2,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(64),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: SizedBox(
                  height: 24,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.text_fields,
                            color: canvasController.textScale != 1.0 ? Colors.blue : Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${canvasController.textScale.toStringWithOptionalDecimal(2)}x',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: canvasController.textScale != 1.0 ? Colors.blue : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text('Text Scale'),
                        children: [
                          ListenableBuilder(
                            listenable: canvasController,
                            builder: (context, _) {
                              return Container(
                                constraints: const BoxConstraints(minWidth: 400, maxWidth: 400),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    const Text(
                                      'One-third of users modify text sizes for better readability. '
                                      'Developers should avoid using fixed heights for text to prevent content from being cut off when font sizes are increased.'
                                      '\n'
                                      'Supporting dynamic text scaling ensures applications are inclusive, user-friendly, and compliant with accessibility standards.',
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'textScaleFactor: ${canvasController.textScale.toStringAsFixed(2)}x',
                                          style: const TextStyle(
                                            fontFeatures: [FontFeature.tabularFigures()],
                                            // mono space font
                                            fontFamily: 'Roboto Mono',
                                            fontSize: 14,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            canvasController.textScale = 1.0;
                                          },
                                          child: const Text('Reset'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Slider(
                                      value: canvasController.textScale,
                                      onChanged: (value) {
                                        canvasController.textScale = value;
                                      },
                                      min: 0.5,
                                      max: 3.0,
                                      divisions: 15,
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const HorizontalDivider(),
              IconButton(
                onPressed: () {
                  if (canvasController.zoomFactor == 1.0) {
                    canvasController.zoomFactor = 2.0;
                  } else if (canvasController.zoomFactor == 2.0) {
                    canvasController.zoomFactor = 4.0;
                  } else {
                    canvasController.zoomFactor = 1.0;
                  }
                },
                icon: Container(
                  height: 24,
                  padding: const EdgeInsets.only(right: 10),
                  width: 62,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Builder(
                        builder: (context) {
                          final String text = switch (canvasController.zoomFactor) {
                            1.0 => '1x',
                            < 10 => '${canvasController.zoomFactor.toStringWithOptionalDecimal(2)}x',
                            _ => '${canvasController.zoomFactor.round()}x',
                          };

                          return Text(
                            text,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: canvasController.zoomFactor != 1.0 ? Colors.blue : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.zoom_in,
                        color: canvasController.zoomFactor != 1.0 ? Colors.blue : Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A horizontal divider
class HorizontalDivider extends StatelessWidget {
  /// Like [Divider] but horizontal.
  const HorizontalDivider({
    super.key,
    this.height,
  });

  /// The height of the divider
  /// Still is a 1px line, the reset is padding
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 20,
      child: const RotatedBox(
        quarterTurns: 1,
        child: Divider(
          height: 1,
        ),
      ),
    );
  }
}

extension on double {
  /// Removes trailing zeros when an actual integer, otherwise always shows [decimalPlaces] decimal places.
  /// 1.0 -> 1
  /// 1.10 -> 1.10
  /// 1.020 -> 1.02
  String toStringWithOptionalDecimal(int decimalPlaces) {
    final withFraction = toStringAsFixed(decimalPlaces);
    final zeroEnd = '.'.padRight(decimalPlaces + 1, '0');
    if (withFraction.endsWith(zeroEnd)) {
      return toStringAsFixed(0);
    }
    return withFraction;
  }
}
