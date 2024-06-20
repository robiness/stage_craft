import 'package:example/new/stage/stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });

  final StageSettings settings;
  final void Function(StageSettings settings) onSettingsChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 2,
        ),
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
            onPressed: () => onSettingsChanged(
              settings.copyWith(
                showRuler: !settings.showRuler,
              ),
            ),
          ),
          IconButton(
            icon: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: settings.stageColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
            ),
            onPressed: () {
              showDialog(
                builder: (context) => AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: MaterialPicker(
                      pickerColor: settings.stageColor,
                      onColorChanged: (newColor) => onSettingsChanged(
                        settings.copyWith(
                          stageColor: newColor,
                        ),
                      ),
                    ),
                  ),
                ),
                context: context,
              );
            },
          ),
        ],
      ),
    );
  }
}
