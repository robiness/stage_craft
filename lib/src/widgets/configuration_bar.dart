import 'package:flutter/material.dart';
import 'package:stage_craft/src/field_configurators/field_configurator.dart';
import 'package:stage_craft/src/stage_controller.dart';

class ConfigurationBar extends StatefulWidget {
  const ConfigurationBar({
    super.key,
    required this.controller,
  });

  final StageController controller;

  @override
  State<ConfigurationBar> createState() => _ConfigurationBarState();
}

class _ConfigurationBarState extends State<ConfigurationBar> {
  late List<FieldConfigurator<dynamic>>? stageConfigurators;
  late List<FieldConfigurator<dynamic>>? widgetConfigurators;

  @override
  void initState() {
    super.initState();
    stageConfigurators = widget.controller.selectedWidget?.stageConfigurators;
    widgetConfigurators = widget.controller.selectedWidget?.widgetConfigurators;
    widget.controller.addListener(() {
      setState(() {
        stageConfigurators = widget.controller.selectedWidget?.stageConfigurators;
        widgetConfigurators = widget.controller.selectedWidget?.widgetConfigurators;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widgetConfigurators?.isNotEmpty == true)
                _ConfiguratorGroup(
                  title: 'Widget',
                  configurators: widgetConfigurators,
                ),
              const SizedBox(height: 16),
              if (stageConfigurators?.isNotEmpty == true)
                _ConfiguratorGroup(
                  title: 'Stage',
                  configurators: stageConfigurators,
                ),
            ],
          ),
        ),
      ),
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
