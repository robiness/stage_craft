import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Stage(
                    child: _stageController.selectedWidget?.widgetBuilder(context) ?? const SizedBox(),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.withOpacity(0.2),
                  thickness: 1,
                ),
                SizedBox(
                  width: 300,
                  child: ConfigurationBar(
                    fields: _stageController.selectedWidget?.fieldConfigurators.map((e) {
                          return e.builder(context);
                        }).toList() ??
                        [],
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
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlexibleStage(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: fields.map(
          (e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: e,
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

  Widget builder(BuildContext context);
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
