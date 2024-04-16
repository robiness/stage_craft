import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:stage_craft/src/stage/stage_controller.dart';

class StageSettingsWidget extends StatefulWidget {
  const StageSettingsWidget({
    super.key,
    required this.stageController,
    required this.constraints,
  });

  final StageController stageController;
  final BoxConstraints? constraints;

  @override
  State<StageSettingsWidget> createState() => _StageSettingsWidgetState();
}

class _StageSettingsWidgetState extends State<StageSettingsWidget> {
  late final Color _initialColor =
      widget.stageController.initialBackgroundColor;

  @override
  void initState() {
    super.initState();
  }

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
            option: ZoomSlider(
              constraints: widget.constraints,
              stageController: widget.stageController,
            ),
          ),
          SizedBox(
            width: 60,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  final color = await showColorPickerDialog(
                    context,
                    widget.stageController.backgroundColor,
                    customColorSwatchesAndNames: {
                      ColorTools.createPrimarySwatch(_initialColor):
                          'Default Color',
                    },
                    title: Text(
                      'Pick a color!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    pickerTypeLabels: <ColorPickerType, String>{
                      ColorPickerType.custom: 'Default',
                    },
                    heading: const SizedBox(height: 8.0),
                    subheading: const SizedBox(height: 8.0),
                    wheelSubheading: const SizedBox(height: 8.0),
                    spacing: 2,
                    showColorName: true,
                    showMaterialName: true,
                    runSpacing: 2,
                    wheelDiameter: 165,
                    enableOpacity: true,
                    showColorCode: true,
                    colorCodeHasColor: true,
                    pickersEnabled: <ColorPickerType, bool>{
                      ColorPickerType.wheel: true,
                      ColorPickerType.custom: true,
                    },
                    constraints: const BoxConstraints(
                      minHeight: 525,
                      minWidth: 320,
                      maxWidth: 320,
                    ),
                  );
                  widget.stageController.setBackgroundColor(color);
                },
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                    color: widget.stageController.backgroundColor,
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
            child: Material(
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
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }
}

class ZoomSlider extends StatefulWidget {
  const ZoomSlider({
    super.key,
    required this.stageController,
    required this.constraints,
  });

  final StageController stageController;
  final BoxConstraints? constraints;

  @override
  State<ZoomSlider> createState() => _ZoomSliderState();
}

class _ZoomSliderState extends State<ZoomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Zoom'),
        Text(
          widget.stageController.zoom.toStringAsFixed(2),
        ),
        SizedBox(
          width: 300,
          child: Slider(
            min: 0.1,
            max: 2,
            value: widget.stageController.zoom,
            onChanged: (double value) {
              setState(() {
                widget.stageController.setZoom(
                  value: value,
                  constraints: widget.constraints,
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
