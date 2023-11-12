import 'package:flutter/widgets.dart';
import 'package:stage_craft/stage_craft.dart';

class TestStageData extends StageData {
  TestStageData({
    super.initialStageSize,
    String? name,
  }) : super(name: name ?? 'Test Stage Data');

  @override
  String get name => 'Test Stage Data';

  @override
  List<FieldConfigurator> get stageConfigurators => [];

  @override
  Widget widgetBuilder(BuildContext context) {
    return Container(
      key: const ValueKey('test_stage_data'),
      color: const Color(0xFF00FF00),
    );
  }

  @override
  List<FieldConfigurator> get widgetConfigurators => [];
}
