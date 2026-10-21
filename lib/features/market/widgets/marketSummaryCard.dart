import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/appColors.dart';
import '../providers/marketProvider.dart';

class MarketSummaryCard extends ConsumerWidget {
  const MarketSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketState = ref.watch(marketProvider);
    final notifier = ref.read(marketProvider.notifier);

    final currentPeriod = marketState.summaryPeriod;
    final crops = marketState.crops;

    // Dynamically calculate summary stats based on currentPeriod
    int cropsUp = crops.where((c) => c.isUp).length;
    int cropsDown = crops.where((c) => !c.isUp).length;
    int noChange = 2;

    if (currentPeriod == 'Yesterday') {
      cropsUp = (cropsUp * 0.8).toInt();
      cropsDown = (cropsDown * 1.1).toInt();
    } else if (currentPeriod == '7 Days') {
      cropsUp = (cropsUp * 1.2).toInt();
      cropsDown = (cropsDown * 0.9).toInt();
    } else if (currentPeriod == '30 Days') {
      cropsUp = (cropsUp * 1.5).toInt();
      cropsDown = (cropsDown * 1.3).toInt();
    }

    double totalPricesSum = 0;
    for (final c in crops) {
      final cleanStr = c.price.replaceAll('Rs.', '').replaceAll('/Kg', '').trim();
      final val = double.tryParse(cleanStr) ?? 50.0;
      totalPricesSum += val;
    }
    final avgPrice = crops.isNotEmpty ? (totalPricesSum / crops.length) : 58.4;

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

              // Interactive Period Dropdown Menu
              PopupMenuButton<String>(
                onSelected: (val) => notifier.setSummaryPeriod(val),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                itemBuilder: (ctx) => [
                  const PopupMenuItem(value: 'Today', child: Text('Today')),
                  const PopupMenuItem(value: 'Yesterday', child: Text('Yesterday')),
                  const PopupMenuItem(value: '7 Days', child: Text('7 Days')),
                  const PopupMenuItem(value: '30 Days', child: Text('30 Days')),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        currentPeriod,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: AppColors.textMuted),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Showing Market Summary for $currentPeriod',
              style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildSummaryStat(
                value: '$cropsUp',
                label: 'Crops Up',
                change: '↑ vs prev.',
                icon: Icons.arrow_upward_rounded,
                iconColor: AppColors.success,
                bgColor: AppColors.successLight,
              ),
              const SizedBox(width: 8),
              _buildSummaryStat(
                value: '$cropsDown',
                label: 'Crops Down',
                change: '↓ vs prev.',
                icon: Icons.arrow_downward_rounded,
                iconColor: AppColors.danger,
                bgColor: AppColors.dangerLight,
              ),
              const SizedBox(width: 8),
              _buildSummaryStat(
                value: '$noChange',
                label: 'No Change',
                change: '– stable',
                icon: Icons.remove_rounded,
                iconColor: Colors.orange,
                bgColor: const Color(0xFFFEF3C7),
              ),
              const SizedBox(width: 8),
              _buildSummaryStat(
                value: 'Rs. ${avgPrice.toStringAsFixed(0)}',
                label: 'Overall Avg',
                change: 'Avg /Kg',
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              change,
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: iconColor),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
