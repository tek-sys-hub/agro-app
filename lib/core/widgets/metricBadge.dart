import 'package:flutter/material.dart';

enum MetricBadgeType { success, warning, danger, info, neutral, primary }

class MetricBadge extends StatelessWidget {
  final String text;
  final MetricBadgeType type;
  final IconData? icon;
  final VoidCallback? onTap;

  const MetricBadge({
    super.key,
    required this.text,
    this.type = MetricBadgeType.success,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (type) {
      case MetricBadgeType.success:
        bg = const Color(0xFFDCFCE7);
        fg = const Color(0xFF15803D);
        break;
      case MetricBadgeType.warning:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFB45309);
        break;
      case MetricBadgeType.danger:
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFB91C1C);
        break;
      case MetricBadgeType.info:
        bg = const Color(0xFFDBEAFE);
        fg = const Color(0xFF1D4ED8);
        break;
      case MetricBadgeType.primary:
        bg = const Color(0xFFE8F7F0);
        fg = const Color(0xFF0E8A5E);
        break;
      case MetricBadgeType.neutral:
        bg = const Color(0xFFF3F4F6);
        fg = const Color(0xFF4B5563);
        break;
    }

    Widget content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: fg,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }
    return content;
  }
}
