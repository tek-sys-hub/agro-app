import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/metricBadge.dart';

class DiseaseDiagnosisCard extends StatelessWidget {
  final String diseaseName;
  final String cropName;
  final int confidencePercent;
  final String severity;

  const DiseaseDiagnosisCard({
    super.key,
    this.diseaseName = 'Early Blight (Alternaria solani)',
    this.cropName = 'Tomato Plant',
    this.confidencePercent = 94,
    this.severity = 'Moderate',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 76,
                  height: 76,
                  color: const Color(0xFFFEF3C7),
                  child: const Center(
                    child: Icon(Icons.grass_rounded, size: 42, color: Colors.amber),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          cropName,
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const Spacer(),
                        MetricBadge(
                          text: '$confidencePercent% Match',
                          type: MetricBadgeType.success,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      diseaseName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text(
                          'Severity: ',
                          style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                        ),
                        MetricBadge(
                          text: severity,
                          type: MetricBadgeType.warning,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.borderSubtle),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'AI Confidence Level',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
              Text(
                'High (94.2%)',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.942,
              backgroundColor: Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
