import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

/// A control to modify a boolean parameter of the widget on stage.
class DurationControl extends ValueControl<Duration> {
  /// Creates a new boolean control.
  DurationControl({
    required super.initialValue,
    required super.label,
    super.min,
    super.max,
  });

  late final _millisecondsController = TextEditingController(text: value.inMilliseconds.toString());
  late final _secondsController = TextEditingController(text: value.inSeconds.toString());
  late final _minutesController = TextEditingController(text: value.inMinutes.toString());

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(
                width: 48,
                child: StageCraftTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  controller: _millisecondsController,
                  onChanged: (String value) {
                    _setValue();
                  },
                ),
              ),
              const SizedBox(width: 2),
              const Text('ms'),
            ],
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              SizedBox(
                width: 32,
                child: StageCraftTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  controller: _secondsController,
                  onChanged: (String value) {
                    _setValue();
                  },
                ),
              ),
              const SizedBox(width: 2),
              const Text('s'),
            ],
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              SizedBox(
                width: 32,
                child: StageCraftTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  controller: _minutesController,
                  onChanged: (String value) {
                    _setValue();
                  },
                ),
              ),
              const SizedBox(width: 2),
              const Text('m'),
            ],
          ),
        ],
      ),
    );
  }

  void _setValue() {
    value = Duration(
      seconds: int.tryParse(_secondsController.text) ?? 0,
      milliseconds: int.tryParse(_millisecondsController.text) ?? 0,
      minutes: int.tryParse(_minutesController.text) ?? 0,
    );
  }
}

/// A control to modify a boolean parameter of the widget on stage.
class DurationControlNullable extends ValueControl<Duration?> {
  /// Creates a new boolean control.
  DurationControlNullable({
    super.initialValue,
    required super.label,
    super.min,
    super.max,
  });

  final _millisecondsController = TextEditingController();
  final _secondsController = TextEditingController();
  final _minutesController = TextEditingController();

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(
                width: 48,
                child: StageCraftTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  controller: _millisecondsController,
                  onChanged: (String value) {
                    _setValue();
                  },
                ),
              ),
              const SizedBox(width: 2),
              const Text('ms'),
            ],
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              SizedBox(
                width: 32,
                child: StageCraftTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  controller: _secondsController,
                  onChanged: (String value) {
                    _setValue();
                  },
                ),
              ),
              const SizedBox(width: 2),
              const Text('s'),
            ],
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              SizedBox(
                width: 32,
                child: StageCraftTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  controller: _minutesController,
                  onChanged: (String value) {
                    _setValue();
                  },
                ),
              ),
              const SizedBox(width: 2),
              const Text('m'),
            ],
          ),
        ],
      ),
    );
  }

  void _setValue() {
    value = Duration(
      seconds: int.tryParse(_secondsController.text) ?? 0,
      milliseconds: int.tryParse(_millisecondsController.text) ?? 0,
      minutes: int.tryParse(_minutesController.text) ?? 0,
    );
  }
}
