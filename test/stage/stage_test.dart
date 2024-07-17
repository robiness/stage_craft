import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/controls/controls.dart';

import 'stage_test_extensions.dart';

void main() {
  testWidgets('The widget on stage gets built twice initially', (WidgetTester tester) async {
    int buildCount = 0;
    await tester.pumpWidgetOnStage(
      widget: TestWidget(
        build: (_) {
          buildCount++;
        },
      ),
    );
    // The widget is built once offstage to measure its intrinsic size.
    // Then the widget is built again on stage.
    expect(buildCount, 2);
  });
  testWidgets('The widget gets rebuild when a control does change', (WidgetTester tester) async {
    int buildCount = 0;
    final controller = IntControl(label: 'label', initialValue: 0);
    await tester.pumpWidgetBuilderOnStage(
      controls: [controller],
      builder: (context) {
        return TestWidget(
          value: controller.value,
          build: (_) {
            buildCount++;
          },
        );
      },
    );

    expect(buildCount, 2);
    controller.value = 5;
    await tester.pump();
    expect(buildCount, 3);
  });
}
