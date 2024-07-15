import 'package:flutter/material.dart';

/// Draws a grid on top of the child widget.
class MeasureGrid extends StatelessWidget {
  /// Creates a new [MeasureGrid].
  const MeasureGrid({
    super.key,
    required this.size,
  });

  /// The size of the grid.
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MeasureGridPainter(
        size: size,
      ),
    );
  }
}

class _MeasureGridPainter extends CustomPainter {
  _MeasureGridPainter({
    required this.size,
  });

  final double size;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.05)
      ..strokeWidth = 2;

    for (double i = 0; i < canvasSize.width; i += size) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, canvasSize.height),
        paint,
      );
    }

    for (double i = 0; i < canvasSize.height; i += size) {
      canvas.drawLine(
        Offset(0, i),
        Offset(canvasSize.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
