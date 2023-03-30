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
    final List<Widget> stageConfiguratorWidgets = () {
      final stageConfigurators = _stageController.selectedWidget?.stageConfigurators ?? [];
      if (stageConfigurators.isEmpty) return <Widget>[];
      return stageConfigurators.map((configurator) {
        if (configurator == stageConfigurators.first) {
          return _LeadingFieldConfigurationWidget(
            configurator: configurator,
            title: 'Stage Arguments',
          );
        }
        return Padding(
          padding: configurator == stageConfigurators.last ? const EdgeInsets.only(bottom: 12.0) : EdgeInsets.zero,
          child: FieldConfiguratorWidget(
            fieldConfigurator: configurator,
            child: configurator.build(context),
          ),
        );
      }).toList();
    }();

    final List<Widget> widgetConfiguratorWidgets = () {
      final widgetConfigurators = _stageController.selectedWidget?.widgetConfigurators ?? [];
      if (widgetConfigurators.isEmpty) return <Widget>[];
      return widgetConfigurators.map((configurator) {
        if (configurator == widgetConfigurators.first) {
          return _LeadingFieldConfigurationWidget(
            configurator: configurator,
            title: 'Widget Arguments',
          );
        }
        return FieldConfiguratorWidget(
          fieldConfigurator: configurator,
          child: configurator.build(context),
        );
      }).toList();
    }();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
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
                      ...stageConfiguratorWidgets,
                      ...widgetConfiguratorWidgets,
                    ],
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

class _LeadingFieldConfigurationWidget extends StatelessWidget {
  const _LeadingFieldConfigurationWidget({
    required this.title,
    required this.configurator,
  });

  final FieldConfigurator configurator;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 4.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          width: double.infinity,
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        FieldConfiguratorWidget(
          fieldConfigurator: configurator,
          child: configurator.build(context),
        ),
      ],
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
  WidgetStageData? _selectedWidget;

  WidgetStageData? get selectedWidget => _selectedWidget;

  void selectWidget(WidgetStageData selectedWidget) {
    for (final widgetConfigurator in _selectedWidget?.widgetConfigurators ?? <FieldConfigurator>[]) {
      widgetConfigurator.removeListener(notifyListeners);
    }
    for (final stageConfigurator in _selectedWidget?.stageConfigurators ?? <FieldConfigurator>[]) {
      stageConfigurator.removeListener(notifyListeners);
    }
    _selectedWidget = selectedWidget;
    for (final widgetConfigurator in _selectedWidget?.widgetConfigurators ?? <FieldConfigurator>[]) {
      widgetConfigurator.addListener(notifyListeners);
    }
    for (final stageConfigurator in _selectedWidget?.stageConfigurators ?? <FieldConfigurator>[]) {
      stageConfigurator.addListener(notifyListeners);
    }
    notifyListeners();
  }
}
