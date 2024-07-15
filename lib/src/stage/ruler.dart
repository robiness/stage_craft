import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stage_craft/src/stage/stage.dart';

/// A widget that displays rulers around the stage as indicators of the size of the stage.
class Rulers extends StatelessWidget {
  /// Creates a widget that displays rulers around the stage as indicators of the size of the stage.
  const Rulers({
    super.key,
    required this.rect,
  });

  /// The rect of the stage.
  final Rect rect;

  @override
  Widget build(BuildContext context) {
    return StageRect(
      rect: rect.inflate(80),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Ruler(
              direction: Axis.vertical,
              length: rect.height,
              color: context.stageStyle.onSurface,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Ruler(
              direction: Axis.horizontal,
              length: rect.width,
              color: context.stageStyle.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget that displays a ruler as an indicator of the size of the stage.
class Ruler extends StatelessWidget {
  /// Creates a widget that displays a ruler as an indicator of the size of the stage.
  const Ruler({
    super.key,
    required this.length,
    required this.color,
    required this.direction,
  });

  /// The length of the ruler.
  final double length;

  /// The color of the ruler.
  final Color color;

  /// The direction of the ruler.
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final text = Text(
      length.toStringAsFixed(1),
      style: Theme.of(context).textTheme.labelMedium,
    );
    return SizedBox(
      width: direction == Axis.horizontal ? max(40, length) : 80,
      height: direction == Axis.vertical ? max(40, length) : 80,
      child: length < 50
          ? Flex(
              direction: direction,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text,
              ],
            )
          : Flex(
              direction: direction,
              children: [
                _buildEdgeLine(),
                _buildExpandedLine(),
                _buildSpacing(),
                text,
                _buildSpacing(),
                _buildExpandedLine(),
                _buildEdgeLine(),
              ],
            ),
    );
  }

  Widget _buildEdgeLine() {
    return Container(
      color: color,
      width: direction == Axis.vertical ? 8 : 2,
      height: direction == Axis.vertical ? 2 : 8,
    );
  }

  Widget _buildExpandedLine() {
    return Expanded(
      child: Container(
        color: color,
        width: direction == Axis.vertical ? 1 : null,
        height: direction == Axis.horizontal ? 1 : null,
      ),
    );
  }

  Widget _buildSpacing() {
    return SizedBox(
      width: direction == Axis.horizontal ? 8 : null,
      height: direction == Axis.vertical ? 8 : null,
    );
  }
}
