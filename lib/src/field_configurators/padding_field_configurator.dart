import 'package:flutter/material.dart';
import 'package:widget_stage/src/field_configurators/field_configurator_widget.dart';
import 'package:widget_stage/src/widget_stage.dart';

/// Represents a String parameter for a widget on a [WidgetStage].
class PaddingFieldConfigurator extends FieldConfigurator<EdgeInsetsGeometry> {
  PaddingFieldConfigurator({
    required super.value,
    required super.name,
  });

  late final TextEditingController _leftController = TextEditingController(text: convertToExplicitEdgeInsets(value)[0]);
  late final TextEditingController _topController = TextEditingController(text: convertToExplicitEdgeInsets(value)[1]);
  late final TextEditingController _rightController =
      TextEditingController(text: convertToExplicitEdgeInsets(value)[2]);
  late final TextEditingController _bottomController =
      TextEditingController(text: convertToExplicitEdgeInsets(value)[3]);

  List<String> convertToExplicitEdgeInsets(EdgeInsetsGeometry? padding) {
    if (padding == null || padding == EdgeInsets.zero) {
      return ['0.0', '0.0', '0.0', '0.0'];
    }

    final RegExp edgeInsetsPattern = RegExp(r'EdgeInsets\((\d+(\.\d+)?),(\d+(\.\d+)?),(\d+(\.\d+)?),(\d+(\.\d+)?)\)');
    final RegExp edgeInsetsAllPattern = RegExp(r'EdgeInsets\.all\((\d+(\.\d+)?)\)');

    final String input = padding.toString();

    if (edgeInsetsPattern.hasMatch(input)) {
      final Match match = edgeInsetsPattern.firstMatch(input)!;
      return [match.group(1)!, match.group(3)!, match.group(5)!, match.group(7)!];
    } else if (edgeInsetsAllPattern.hasMatch(input)) {
      final RegExpMatch? match = edgeInsetsAllPattern.firstMatch(input);
      if (match != null) {
        final String? value = match.group(1);
        if (value != null) {
          return [value, value, value, value];
        }
      }
    }

    // Return a list with "0.0" values in case of an invalid input format
    // or if extraction of EdgeInsets.all value fails
    return ['0.0', '0.0', '0.0', '0.0'];
  }

  EdgeInsetsGeometry createEdgeInsets(List<String> stringList) {
    return EdgeInsets.only(
      left: double.parse(stringList[0]),
      top: double.parse(stringList[1]),
      right: double.parse(stringList[2]),
      bottom: double.parse(stringList[3]),
    );
  }

  @override
  Widget builder(BuildContext context) {
    return FieldConfiguratorWidget(
      name: name,
      isNullable: false,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              controller: _leftController,
              onChanged: (String newValue) {
                final List<String> stringList = [
                  newValue,
                  _topController.text,
                  _rightController.text,
                  _bottomController.text
                ];
                value = createEdgeInsets(stringList);
                notifyListeners();
              },
            ),
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              controller: _topController,
              onChanged: (String newValue) {
                final List<String> stringList = [
                  _leftController.text,
                  newValue,
                  _rightController.text,
                  _bottomController.text,
                ];
                value = createEdgeInsets(stringList);
                notifyListeners();
              },
            ),
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              controller: _rightController,
              onChanged: (String newValue) {
                final List<String> stringList = [
                  _leftController.text,
                  _topController.text,
                  newValue,
                  _bottomController.text,
                ];
                value = createEdgeInsets(stringList);
                notifyListeners();
              },
            ),
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              controller: _bottomController,
              onChanged: (String newValue) {
                final List<String> stringList = [
                  _leftController.text,
                  _topController.text,
                  _rightController.text,
                  newValue,
                ];
                value = createEdgeInsets(stringList);
                notifyListeners();
              },
            ),
          ),
        ],
      ),
    );
  }
}
