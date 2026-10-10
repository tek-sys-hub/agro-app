import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/appColors.dart';
import '../../market/providers/marketProvider.dart';

class ProfileStatsRow extends ConsumerWidget {
  const ProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketState = ref.watch(marketProvider);
    final cropCount = marketState.crops.length;

    final stats = [
      {'val': '$cropCount', 'label': 'Tracked Crops', 'icon': Icons.eco_outlined, 'color': Colors.green},
      {'val': '4', 'label': 'Active Sensors', 'icon': Icons.sensors_rounded, 'color': Colors.blue},
      {'val': '12', 'label': 'AI Diagnostics', 'icon': Icons.chat_bubble_outline_rounded, 'color': Colors.purple},
      {'val': '5.0', 'label': 'Trust Score', 'icon': Icons.star_rounded, 'color': Colors.amber},
    ];

    return Row(
      children: stats.map((s) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(s['icon'] as IconData, size: 20, color: s['color'] as Color),
                const SizedBox(height: 4),
                Text(
                  s['val'] as String,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                Text(
                  s['label'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
