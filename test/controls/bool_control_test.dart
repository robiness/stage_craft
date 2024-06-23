import 'package:flutter_test/flutter_test.dart';
import 'package:stage_craft/src/controls/bool_control.dart';

import '../controls_test.dart';

void main() {
  testWidgets('The widget gets rebuild when', (WidgetTester tester) async {
    final controlTester = await tester.pumpControl(
      BoolControl(initialValue: false, label: 'Test'),
    );
    expect(find.byType(BoolControl), findsOneWidget);
  });
}
