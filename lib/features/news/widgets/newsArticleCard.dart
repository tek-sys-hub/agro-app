import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/metricBadge.dart';

class NewsArticleCard extends StatelessWidget {
  final String tag;
  final MetricBadgeType tagType;
  final String title;
  final String time;
  final String reads;
  final VoidCallback? onTap;

  const NewsArticleCard({
    super.key,
    required this.tag,
    required this.tagType,
    required this.title,
    required this.time,
    required this.reads,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MetricBadge(text: tag, type: tagType),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.3),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(time, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                      const SizedBox(width: 6),
                      const Text('•', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                      const SizedBox(width: 6),
                      Text(reads, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 72,
                height: 72,
                color: AppColors.primaryLight,
                child: const Center(
                  child: Icon(Icons.article_outlined, size: 32, color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
