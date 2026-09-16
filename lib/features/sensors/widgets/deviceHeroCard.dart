import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/metricBadge.dart';

class DeviceHeroCard extends StatelessWidget {
  final String deviceName;
  final String location;
  final String status;
  final String battery;
  final String signal;
  final String lastUpdated;

  const DeviceHeroCard({
    super.key,
    this.deviceName = 'Field Node 01 (Chitwan Plot A)',
    this.location = 'Chitwan, Nepal',
    this.status = 'Online',
    this.battery = '88%',
    this.signal = 'Good (4G LTE)',
    this.lastUpdated = 'Updated 3 mins ago',
  });

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.sensors_rounded, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        deviceName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                    ),
                    const MetricBadge(text: 'Active', type: MetricBadgeType.success),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  lastUpdated,
                  style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.battery_5_bar_rounded, size: 14, color: AppColors.success),
                    const SizedBox(width: 2),
                    Text(battery, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 10),
                    const Icon(Icons.signal_cellular_alt_rounded, size: 14, color: Colors.blue),
                    const SizedBox(width: 2),
                    Text(signal, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
