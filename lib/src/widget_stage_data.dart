import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

/// Defines everything you need to put a widget on the stage.
///
///
/// Step by step guide to create a stage for you widget:
/// 1.
/// Declare the [FieldConfigurator]s.
/// They represent the fields of your widget.
/// For every type you need a [FieldConfigurator] of that exact type.
/// If not present, it's very easy to create one for your specific type.
/// See [FieldConfigurator] for more information about creating your own.
///
/// For Example:
/// ```dart
///   final ColorFieldConfigurator _color;
///   final StringFieldConfigurator _text;
///   final DoubleFieldConfigurator _borderRadius;
/// ```

/// 2.
/// Create a constructor for your widget.
///
/// Above your declarations, copy each parameter of your widget you want to be configurable.
/// Then initialize the [FieldConfigurator]s from step 1 with the
///
/// For Example:
/// ```dart
///   MyWidgetStageData({
///     required Color color,
///     required String text,
///     required double borderRadius,
///   })  : _color = ColorFieldConfigurator(color),
///         _text = StringFieldConfigurator(text),
///         _borderRadius = DoubleFieldConfigurator(borderRadius);
/// ```
///
/// 3.Return your widget in the widgetBuilder function.
///
/// For Example:
/// ```dart
/// @override
///   Widget widgetBuilder(BuildContext context) {
///     return MyWidget(
///       color: _color.value,
///       text: _text.value,
///       borderRadius: _borderRadius.value,
///     );
///   }
/// ```
/// 4.Return all defined [FieldConfigurator]s in the fieldConfigurators getter.
///
/// For Example:
/// ```dart
///   @override
///   List<FieldConfigurator> get fieldConfigurators {
///     return [
///       _color,
///       _text,
///       _borderRadius,
///     ];
///   }
/// ```
abstract class WidgetStageData {
  const WidgetStageData();

  /// The name of the widget.
  String get name;

  /// Return the widget you want to put on stage and use
  Widget widgetBuilder(BuildContext context);

  /// [FieldConfigurator]s that affect arguments of the widget displayed on the stage,
  /// as opposed to [stageConfigurators] which affect its surroundings or the stage itself.
  List<FieldConfigurator> get widgetConfigurators;

  /// [FieldConfigurator]s that affect the stage itself and/or provide additional configurations
  /// surrounding the [Widget] on the stage (e.g. outer [Padding] or a counter, in case the [Widget] is
  /// an [Iterable].
  List<FieldConfigurator> get stageConfigurators;

  Size? get stageSize => const Size(600, 800);
}
