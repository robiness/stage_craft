import 'package:flutter/material.dart';
import 'package:widget_stage/widget_stage.dart';

class MyListTileWidgetStage extends WidgetStageData {
  MyListTileWidgetStage()
      : _tileCount = IntFieldConfigurator(
          value: 1,
          name: 'tileCount',
          type: FieldConfiguratorType.stage,
        ),
        _listPadding = PaddingFieldConfigurator(
          value: EdgeInsets.zero,
          name: 'listPadding',
          type: FieldConfiguratorType.stage,
        ),
        _title = StringFieldConfigurator(value: 'My List Tile', name: 'title'),
        _stageColor = ColorFieldConfigurator(
          value: Colors.transparent,
          name: 'stageColor',
          type: FieldConfiguratorType.stage,
        ),
        _circleColor = ColorFieldConfigurator(value: Colors.purple, name: 'circleColor'),
        _tileColor = ColorFieldConfiguratorNullable(value: Colors.cyan, name: 'tileColor'),
        _textColor = ColorFieldConfiguratorNullable(value: Colors.white, name: 'textColor'),
        _borderRadius = DoubleFieldConfiguratorNullable(value: 10, name: 'borderRadius'),
        _tileGap = DoubleFieldConfigurator(
          value: 0,
          name: 'tileSpace',
          type: FieldConfiguratorType.stage,
        );

  @override
  List<FieldConfigurator> get fieldConfigurators {
    return [
      _tileCount,
      _listPadding,
      _title,
      _tileGap,
      _stageColor,
      _circleColor,
      _tileColor,
      _borderRadius,
      _textColor,
    ];
  }

  @override
  String get name => 'MyListTileWidget';

  final IntFieldConfigurator _tileCount;
  final DoubleFieldConfigurator _tileGap;
  final DoubleFieldConfiguratorNullable _borderRadius;
  final PaddingFieldConfigurator _listPadding;
  final StringFieldConfigurator _title;
  final ColorFieldConfigurator _stageColor;
  final ColorFieldConfigurator _circleColor;
  final ColorFieldConfiguratorNullable _textColor;
  final ColorFieldConfiguratorNullable _tileColor;

  @override
  Widget widgetBuilder(BuildContext context) {
    return ColoredBox(
      color: _stageColor.value,
      child: ListView.separated(
        padding: _listPadding.value,
        itemCount: _tileCount.value,
        separatorBuilder: (_, __) => SizedBox(height: _tileGap.value),
        itemBuilder: (context, index) {
          return _MyTitleTileWidget(
              title: _title.value,
              index: index,
              circleColor: _circleColor.value,
              tileColor: _tileColor.value,
              borderRadius: _borderRadius.value,
              textColor: _textColor.value,
            ),
          );
        },
      ),
    );
  }
}

class _MyTitleTileWidget extends StatelessWidget {
  const _MyTitleTileWidget({
    required this.index,
    required this.title,
    required this.circleColor,
    this.tileColor,
    this.borderRadius,
    this.textColor,
  });

  final String title;
  final Color circleColor;
  final Color? tileColor;
  final int index;
  final double? borderRadius;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          color: tileColor,
        ),
        child: ListTile(
          title: Text(title),
          leading: CircleAvatar(
            radius: 15,
            backgroundColor: circleColor,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
