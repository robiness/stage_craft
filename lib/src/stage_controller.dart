import 'package:flutter/widgets.dart';
import 'package:stage_craft/src/widget_stage_data.dart';

class StageController extends ChangeNotifier {
  StageController({
    Offset? stagePosition,
    Size? stageSize,
    Color? backgroundColor,
  })  : initialBackgroundColor = backgroundColor ?? const Color(0xFFE0E0E0),
        _stagePosition = stagePosition ?? const Offset(50, 50),
        _stageSize = stageSize ?? const Size(300, 400);

  Offset _stagePosition;

  Offset get stagePosition => _stagePosition;

  set stagePosition(Offset value) {
    if (_stagePosition != value) {
      _stagePosition = value;
      notifyListeners();
    }
  }

  Size _stageSize;

  Size get stageSize => _stageSize;

  set stageSize(Size value) {
    if (_stageSize != value) {
      _stageSize = value;
      notifyListeners();
    }
  }

  double _zoom = 1;

  double get zoom => _zoom;

  void setZoom({
    required double value,
  }) {
    if (_zoom != value) {
      _zoom = value;
      transformationController.value.setEntry(0, 0, zoom);
      transformationController.value.setEntry(1, 1, zoom);
      transformationController.value.setEntry(2, 2, zoom);
      notifyListeners();
    }
  }

  bool _showBalls = false;

  bool get showBalls => _showBalls;

  set showBalls(bool value) {
    if (_showBalls != value) {
      _showBalls = value;
      notifyListeners();
    }
  }

  bool isDragging = false;

  double scale(double value) => value * (1 / zoom);

  void selectWidget(WidgetStageData selectedWidget) {
    if (_selectedWidget == selectedWidget) {
      for (final configurator in _selectedWidget!.allConfigurators) {
        configurator.removeListener(notifyListeners);
      }
    }
    _selectedWidget = selectedWidget;
    if (_selectedWidget == selectedWidget) {
      for (final configurator in _selectedWidget!.allConfigurators) {
        configurator.addListener(notifyListeners);
      }
    }
    notifyListeners();
  }

  WidgetStageData? _selectedWidget;

  WidgetStageData? get selectedWidget => _selectedWidget;

  final Color initialBackgroundColor;

  late Color _backgroundColor = initialBackgroundColor;

  Color get backgroundColor => _backgroundColor;

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  void resetBackgroundColor() {
    _backgroundColor = initialBackgroundColor;
    notifyListeners();
  }

  final TransformationController transformationController = TransformationController();
}
