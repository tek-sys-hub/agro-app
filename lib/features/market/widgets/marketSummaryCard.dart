import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';

class MarketSummaryCard extends StatelessWidget {
  const MarketSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    'Market Summary',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.info_outline_rounded, size: 14, color: AppColors.textMuted),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.textSecondary),
                    SizedBox(width: 4),
                    Text('Today', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Updated today, 10:30 AM',
              style: TextStyle(fontSize: 10, color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildSummaryStat(
                value: '12',
                label: 'Crops Up',
                change: '↑ 2 vs yest.',
                icon: Icons.arrow_upward_rounded,
                iconColor: AppColors.success,
                bgColor: AppColors.successLight,
              ),
              const SizedBox(width: 8),
              _buildSummaryStat(
                value: '5',
                label: 'Crops Down',
                change: '↓ 1 vs yest.',
                icon: Icons.arrow_downward_rounded,
                iconColor: AppColors.danger,
                bgColor: AppColors.dangerLight,
              ),
              const SizedBox(width: 8),
              _buildSummaryStat(
                value: '2',
                label: 'No Change',
                change: '– 0 vs yest.',
                icon: Icons.remove_rounded,
                iconColor: Colors.orange,
                bgColor: const Color(0xFFFEF3C7),
              ),
              const SizedBox(width: 8),
              _buildSummaryStat(
                value: 'Rs. 28.4',
                label: 'Overall Avg',
                change: '↑ 1.8% vs yest.',
                icon: Icons.auto_graph_rounded,
                iconColor: AppColors.primary,
                bgColor: AppColors.primaryLight,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat({
    required String value,
    required String label,
    required String change,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, size: 14, color: iconColor),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
            ),
            const SizedBox(height: 2),
            Text(
              change,
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: iconColor),
            ),
          ],
        ),
      ),
    );
  }
}
