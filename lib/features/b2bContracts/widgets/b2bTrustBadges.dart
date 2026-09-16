import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';

class B2bTrustBadges extends StatelessWidget {
  const B2bTrustBadges({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      {'title': 'Verified Buyers', 'icon': Icons.verified_user_outlined, 'color': AppColors.primary},
      {'title': 'Escrow Pay', 'icon': Icons.account_balance_wallet_outlined, 'color': Colors.blue},
      {'title': 'Quality Test', 'icon': Icons.verified_outlined, 'color': Colors.purple},
      {'title': 'Fast Logistics', 'icon': Icons.local_shipping_outlined, 'color': Colors.orange},
    ];

    return Row(
      children: badges.map((b) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
                Icon(b['icon'] as IconData, color: b['color'] as Color, size: 20),
                const SizedBox(height: 6),
                Text(
                  b['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
