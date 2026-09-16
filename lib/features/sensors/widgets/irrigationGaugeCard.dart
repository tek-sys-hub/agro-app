import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';

class IrrigationGaugeCard extends StatelessWidget {
  const IrrigationGaugeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.water_drop_outlined, size: 14, color: Colors.blue),
              SizedBox(width: 4),
              Text('Irrigation Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    value: 0.60,
                    strokeWidth: 7,
                    backgroundColor: Color(0xFFE5E7EB),
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                Column(
                  children: const [
                    Text('60%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                    Text('Efficiency', style: TextStyle(fontSize: 8, color: AppColors.textMuted)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text('Next: Tomorrow 6:00 AM', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          const Text('Water Used: 120 L', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow_rounded, size: 14, color: Colors.white),
            label: const Text('Run Irrigation', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 32),
              padding: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
