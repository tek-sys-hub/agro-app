import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';

class SparklinePainter extends CustomPainter {
  final List<double> points;
  final Color lineColor;
  final int? selectedIndex;

  SparklinePainter({
    required this.points,
    this.lineColor = AppColors.primary,
    this.selectedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final min = points.reduce((a, b) => a < b ? a : b);
    final max = points.reduce((a, b) => a > b ? a : b);
    final range = (max - min == 0) ? 1.0 : (max - min);

    // Line Paint
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Fill Paint (Gradient)
    final fillPath = Path();
    final linePath = Path();

    final dotPaint = Paint()..color = lineColor;
    final dotInnerPaint = Paint()..color = Colors.white;

    final selectedDotPaint = Paint()..color = AppColors.primaryDark;

    for (int i = 0; i < points.length; i++) {
      final x = points.length > 1 ? (size.width / (points.length - 1)) * i : size.width / 2;
      final normalizedY = (points[i] - min) / range;
      final y = size.height - (normalizedY * (size.height - 24) + 12);

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      if (i == points.length - 1) {
        fillPath.lineTo(x, size.height);
        fillPath.close();
      }

      // Draw node dots
      final isSelected = selectedIndex == i;
      final radius = isSelected ? 5.5 : 3.5;

      canvas.drawCircle(Offset(x, y), radius, isSelected ? selectedDotPaint : dotPaint);
      canvas.drawCircle(Offset(x, y), radius / 2, dotInnerPaint);
    }

    // Draw Fill Gradient
    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          lineColor.withValues(alpha: 0.25),
          lineColor.withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
