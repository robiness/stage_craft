import 'package:flutter/material.dart';
import 'package:stage_craft/src/field_configurators/field_configurator_widget.dart';
import 'package:stage_craft/src/flexible_stage.dart';
import 'package:stage_craft/src/stage_settings.dart';
import 'package:stage_craft/src/widget_stage_data.dart';

/// The stage where all widgets can be put on.
class WidgetStage extends StatefulWidget {
  const WidgetStage({
    super.key,
    this.controller,
  });

  final StageController? controller;

  @override
  State<WidgetStage> createState() => _WidgetStageState();
}

class _WidgetStageState extends State<WidgetStage> {
  late final StageController _stageController;

  @override
  void initState() {
    super.initState();
    _stageController = widget.controller ??
        StageController(
          theme: Theme.of(context),
          stageSize: const Size(600, 800),
          stagePosition: const Offset(50, 50),
        );
    _stageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final stageConfigurators = _stageController.selectedWidget?.stageConfigurators;
    final widgetConfigurators = _stageController.selectedWidget?.widgetConfigurators;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stage(
            stageController: _stageController,
            child: _stageController.selectedWidget?.widgetBuilder(context) ?? const SizedBox(),
          ),
        ),
        VerticalDivider(
          color: Colors.grey.withOpacity(0.2),
          thickness: 1,
        ),
        SizedBox(
          width: 400,
          child: ConfigurationBar(
            fields: [
              if (widgetConfigurators?.isNotEmpty == true)
                _ConfiguratorGroup(
                  title: 'Widget',
                  configurators: widgetConfigurators,
                ),
              if (stageConfigurators?.isNotEmpty == true)
                _ConfiguratorGroup(
                  title: 'Stage',
                  configurators: stageConfigurators,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConfiguratorGroup extends StatelessWidget {
  const _ConfiguratorGroup({
    required this.title,
    this.configurators,
  });

  final String title;
  final List<FieldConfigurator>? configurators;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(
          color: Colors.blue.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.blue.withOpacity(0.2),
              thickness: 1,
            ),
            ...?configurators?.map((configurator) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: FieldConfiguratorWidget(
                  fieldConfigurator: configurator,
                  child: configurator.build(context),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// The actual stage to display the widget.
class Stage extends StatelessWidget {
  const Stage({
    super.key,
    required this.child,
    required this.stageController,
  });

  final Widget child;
  final StageController stageController;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: stageController.backgroundColor,
      child: Stack(
        children: [
          Center(
            child: FlexibleStage(
              stageController: stageController,
              child: Center(
                child: child,
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: StageSettingsWidget(
              stageController: stageController,
            ),
          ),
        ],
      ),
    );
  }
}

/// The configuration bar containing all the fields to live update the widget.
class ConfigurationBar extends StatelessWidget {
  const ConfigurationBar({
    super.key,
    required this.fields,
  });

  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: fields.map(
          (field) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: field,
            );
          },
        ).toList(),
      ),
    );
  }
}

/// Representing a single parameter of a widget on stage.
/// The [builder] returns a field for example a TextField to live update the widget.´
/// @see [StringFieldConfigurator] or [ColorFieldConfigurator]
abstract class FieldConfigurator<T> extends ChangeNotifier {
  FieldConfigurator({
    required this.value,
    required this.name,
  });

  T value;

  String name;

  bool get isNullable => null is T;

  void updateValue(T value) {
    this.value = value;
    notifyListeners();
  }

  Widget build(BuildContext context);
}

class StageController extends ChangeNotifier {
  StageController({
    required this.theme,
    Size? stageSize,
    Offset? stagePosition,
  })  : _stageSize = stageSize ?? const Size(600, 800),
        stagePosition = stagePosition ?? const Offset(50, 50);

  final ThemeData theme;

  WidgetStageData? _selectedWidget;

  WidgetStageData? get selectedWidget => _selectedWidget;

  // The size of the stage.
  Size _stageSize;

  Size get stageSize => _stageSize;

  set stageSize(Size size) {
    _stageSize = size;
    notifyListeners();
  }

  // The position of the stage on the screen.
  Offset stagePosition;

  double _scale = 1;

  double get scale => _scale;

  set scale(double scale) {
    _scale = scale;
    notifyListeners();
  }

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

  late Color _backgroundColor = theme.canvasColor;

  Color get backgroundColor => _backgroundColor;

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  void resetBackgroundColor() {
    _backgroundColor = theme.canvasColor;
    notifyListeners();
  }
}
