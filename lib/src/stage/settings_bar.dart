import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:stage_craft/src/stage/stage.dart';

class SettingsBar extends StatelessWidget {
  const SettingsBar({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
    required this.onStyleToggled,
    required this.onSurfaceColorChanged,
  });

  final StageSettings settings;
  final void Function(StageSettings settings) onSettingsChanged;
  final VoidCallback onStyleToggled;
  final void Function(Color color) onSurfaceColorChanged;

  @override
  Widget build(BuildContext context) {
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
              color: settings.showRuler ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              onSettingsChanged(
                settings.copyWith(
                  showRuler: !settings.showRuler,
                ),
              );
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
                context: context,
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
        ],
      ),
    );
  }
}
