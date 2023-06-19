import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:stage_craft/src/stage_controller.dart';

class StageSettingsWidget extends StatelessWidget {
  const StageSettingsWidget({
    super.key,
    required this.stageController,
  });

  final StageController stageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SettingsWidget(
            iconPath: 'assets/ruler.png',
            option: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Zoom'),
                Text(stageController.zoom.toStringAsFixed(2)),
              ],
            ),
          ),
          SizedBox(
            width: 60,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: stageController.backgroundColor,
                            onColorChanged: stageController.setBackgroundColor,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Reset'),
                            onPressed: () {
                              stageController.resetBackgroundColor();
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Accept'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                    color: stageController.backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 1,
                        offset: Offset(-0.5, -0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({
    super.key,
    required this.iconPath,
    required this.option,
  });

  final String iconPath;
  final Widget option;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isOpen) {
          _overlayEntry?.remove();
          _overlayEntry = null;
          _isOpen = false;
        } else {
          _openOptions();
          _isOpen = true;
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: SizedBox(
          width: 60,
          child: Image.asset(
            widget.iconPath,
            width: 30,
            height: 30,
            package: 'stage_craft',
          ),
        ),
      ),
    );
  }

  void _openOptions() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return CompositedTransformFollower(
          link: _layerLink,
          followerAnchor: Alignment.bottomRight,
          targetAnchor: Alignment.topRight,
          offset: const Offset(0, -20),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.option,
              ),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }
}
