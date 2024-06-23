import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spot/spot.dart';
import 'package:stage_craft/src/controls/control.dart';

import '../controls_test.dart';

void main() {
  testWidgets('The controls builder does get built', (WidgetTester tester) async {
    await tester.pumpControl(TestControl<bool>(initialValue: false, label: 'Test'));
    spot<TestControlWidget<bool>>().existsOnce();
  });
  testWidgets('The control is not nullable when the type is not', (WidgetTester tester) async {
    await tester.pumpControl(TestControl<bool>(initialValue: false, label: 'Test'));
    expect(spotControl<bool>().isNullable, false);
  });
  testWidgets('The control is nullable when the type is', (WidgetTester tester) async {
    await tester.pumpControl(TestControl<bool?>(initialValue: false, label: 'Test'));
    expect(spotControl<bool?>().isNullable, true);
  });
  testWidgets('The control has the correct initialValue', (WidgetTester tester) async {
    await tester.pumpControl(TestControl<bool>(initialValue: false, label: 'Test'));
    expect(spotControl<bool>().value, false);
  });
  testWidgets('The control has the correct complex initialValue', (WidgetTester tester) async {
    final complexValue = ComplexTestValue();
    await tester.pumpControl(TestControl<ComplexTestValue>(initialValue: complexValue, label: 'Test'));
    expect(spotControl<ComplexTestValue>().value, complexValue);
  });
  testWidgets('When toggled null the value is null', (WidgetTester tester) async {
    await tester.pumpControl(TestControl<bool?>(initialValue: false, label: 'Test'));
    final control = spotControl<bool?>();
    control.toggleNull();
    expect(control.value, null);
  });
  testWidgets('When toggled null twice, the value is the last value', (WidgetTester tester) async {
    await tester.pumpControl(TestControl<bool?>(initialValue: false, label: 'Test'));
    final control = spotControl<bool?>();
    control.toggleNull();
    expect(control.value, null);
    control.toggleNull();
    expect(control.value, false);
  });
}

class TestControl<T> extends ValueControl<T> {
  TestControl({
    required super.initialValue,
    required super.label,
  });

  @override
  Widget builder(BuildContext context) {
    return TestControlWidget<T>(control: this);
  }
}

class TestControlWidget<T> extends StatefulWidget {
  const TestControlWidget({
    super.key,
    required this.control,
  });

  final ValueControl<T> control;

  @override
  State<TestControlWidget<T>> createState() => _TestControlWidgetState<T>();
}

class _TestControlWidgetState<T> extends State<TestControlWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ComplexTestValue {}

ValueControl<T> spotControl<T>() => spot<TestControlWidget<T>>().existsOnce().widget.control;
