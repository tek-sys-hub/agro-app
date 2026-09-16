import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/metricBadge.dart';
import 'sparklinePainter.dart';

class CommodityPriceCard extends StatelessWidget {
  final String name;
  final String category;
  final String price;
  final String change;
  final bool isUp;
  final List<double> sparkline;
  final String icon;
  final VoidCallback? onTap;

  const CommodityPriceCard({
    super.key,
    required this.name,
    required this.category,
    required this.price,
    required this.change,
    required this.isUp,
    required this.sparkline,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category,
                    style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60,
              height: 30,
              child: CustomPaint(
                painter: SparklinePainter(
                  points: sparkline,
                  lineColor: isUp ? AppColors.success : AppColors.danger,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 2),
                MetricBadge(
                  text: change,
                  type: isUp ? MetricBadgeType.success : MetricBadgeType.danger,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
