import 'package:flutter/material.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/src/flexible_stage.dart';
import 'package:widget_stage/widget_stage.dart';

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
  late final StageController _stageController = widget.controller ?? StageController();

  @override
  void initState() {
    super.initState();
    _stageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final configurators = _stageController.selectedWidget?.fieldConfigurators ?? [];

    final List<Widget> stageConfiguratorWidgets = () {
      final stageConfigurators = configurators.where((element) => element.type == ArgumentType.stage).toList();
      if (stageConfigurators.isEmpty) {
        return <Widget>[];
      }
      return stageConfigurators.map((configurator) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (configurator == stageConfigurators.first) ...[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Center(
                    child: Text(
                      'Widget Configurators',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FieldConfiguratorWidget(
                fieldConfigurator: configurator,
                child: configurator.build(context),
              ),
            ),
          ],
        );
      }).toList();
    }();

    final List<Widget> widgetConfiguratorWidgets = () {
      final widgetConfigurators = configurators.where((element) => element.type == ArgumentType.widget).toList();
      if (widgetConfigurators.isEmpty) {
        return <Widget>[];
      }
      return widgetConfigurators.map((configurator) {
        return Column(
          children: [
            if (configurator == widgetConfigurators.first) ...[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Center(
                    child: Text(
                      'Widget Configurators',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
            FieldConfiguratorWidget(
              fieldConfigurator: configurator,
              child: configurator.build(context),
            ),
          ],
        );
      }).toList();
    }();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
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
                    fields: [...stageConfiguratorWidgets, ...widgetConfiguratorWidgets],
                  ),
                ),
              ],
            ),
          ),
        ],
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
    return Center(
      child: FlexibleStage(
        stageController: stageController,
        child: Center(
          child: child,
        ),
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
    ArgumentType? type,
  }) : type = type ?? ArgumentType.widget;

  T value;

  String name;

  final ArgumentType type;

  bool get isNullable => null is T;

  void updateValue(T value) {
    this.value = value;
    notifyListeners();
  }

  Widget build(BuildContext context);
}

class StageController extends ChangeNotifier {
  WidgetStageData? _selectedWidget;

  WidgetStageData? get selectedWidget => _selectedWidget;

  void selectWidget(WidgetStageData selectedWidget) {
    for (final fieldConfigurator in _selectedWidget?.fieldConfigurators ?? <FieldConfigurator>[]) {
      fieldConfigurator.removeListener(notifyListeners);
    }
    _selectedWidget = selectedWidget;
    for (final fieldConfigurator in _selectedWidget?.fieldConfigurators ?? <FieldConfigurator>[]) {
      fieldConfigurator.addListener(notifyListeners);
    }
    notifyListeners();
  }
}

/// Allows for separation of the configurators in the [ConfigurationBar] depending on whether they affect the widget on the stage or the stage itself (e.g. amount of the same widget to display in a list).
enum ArgumentType {
  widget,
  stage,
}
