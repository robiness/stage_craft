import 'package:flutter/material.dart';
import 'package:widget_stage/src/discrete_resizable_component.dart';
import 'package:widget_stage/widget_stage.dart';

/// The stage where all widgets can be put on.
class WidgetStage extends StatefulWidget {
  const WidgetStage({
    super.key,
    required this.widgets,
    required this.onThemeSwitchChanged,
  });

  final List<WidgetStageData> widgets;
  final void Function(ThemeMode themeMode) onThemeSwitchChanged;

  @override
  State<WidgetStage> createState() => _WidgetStageState();
}

class _WidgetStageState extends State<WidgetStage> {
  late WidgetStageData selectedWidget;

  @override
  void initState() {
    super.initState();
    _selectWidget(widget.widgets.first);
  }

  void _selectWidget(WidgetStageData widget) {
    selectedWidget = widget;
    for (final element in selectedWidget.fieldConfigurators) {
      element.addListener(() => setState(() {}));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 38,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Switch(
                      value: Theme.of(context).brightness == Brightness.light,
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.black54,
                      onChanged: (value) {
                        widget.onThemeSwitchChanged(
                          value ? ThemeMode.light : ThemeMode.dark,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2), thickness: 1),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ListView(
                    children: widget.widgets.map(
                      (e) {
                        return ListTile(
                          tileColor: selectedWidget == e ? Colors.orange : null,
                          title: Text(e.name),
                          onTap: () => _selectWidget(e),
                        );
                      },
                    ).toList(),
                  ),
                ),
                VerticalDivider(
                    color: Colors.grey.withOpacity(0.2), thickness: 1,),
                Expanded(
                  child: Stage(
                    child: selectedWidget.widgetBuilder(context),
                  ),
                ),
                VerticalDivider(
                    color: Colors.grey.withOpacity(0.2), thickness: 1,),
                SizedBox(
                  width: 300,
                  child: ConfigurationBar(
                    fields: selectedWidget.fieldConfigurators.map((e) {
                      return e.builder(context);
                    }).toList(),
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
      child: DiscreteResizableComponent(
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
