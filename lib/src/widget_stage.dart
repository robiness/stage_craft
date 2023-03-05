import 'package:flutter/material.dart';
import 'package:widget_stage/src/discrete_resizable_component.dart';
import 'package:widget_stage/widget_stage.dart';

class WidgetStage extends StatefulWidget {
  const WidgetStage({
    Key? key,
    required this.widgets,
  }) : super(key: key);

  final List<WidgetStageData> widgets;

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
    selectedWidget.addListener(() {
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: widget.widgets.map((e) {
                return OutlinedButton(
                  onPressed: () => _selectWidget(e),
                  child: Text(e.name),
                );
              }).toList(),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2), thickness: 1),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Stage(
                    child: selectedWidget.widget,
                  ),
                ),
                VerticalDivider(
                    color: Colors.grey.withOpacity(0.2), thickness: 1),
                SizedBox(
                  width: 300,
                  child: ConfigurationBar(
                    fields: selectedWidget.configurationFields,
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

class Stage extends StatelessWidget {
  const Stage({
    Key? key,
    required this.child,
  }) : super(key: key);

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

class ConfigurationBar extends StatelessWidget {
  const ConfigurationBar({
    Key? key,
    required this.fields,
  }) : super(key: key);

  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fields,
    );
  }
}

class FieldConfigurator<T> {
  const FieldConfigurator({
    required this.value,
    required this.builder,
  });

  final T value;
  final Widget Function() builder;
}
