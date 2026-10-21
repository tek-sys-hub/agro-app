import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/smoothPageRoute.dart';
import '../../../core/providers/navigationProvider.dart';
import '../../news/screens/newsScreen.dart';

class QuickActionsBar extends ConsumerWidget {
  const QuickActionsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = [
      {
        'title': 'Crop Guide',
        'icon': Icons.grass_rounded,
        'action': () {
          Navigator.of(context).push(
            SmoothPageRoute(page: const NewsScreen()),
          );
        },
      },
      {
        'title': 'Disease Scanner',
        'icon': Icons.shield_outlined,
        'action': () {
          ref.read(navigationProvider.notifier).goToAiScan();
        },
      },
      {
        'title': 'Market Insights',
        'icon': Icons.storefront_rounded,
        'action': () {
          ref.read(navigationProvider.notifier).goToMarket();
        },
      },
      {
        'title': 'Agro Learn',
        'icon': Icons.menu_book_rounded,
        'action': () {
          Navigator.of(context).push(
            SmoothPageRoute(page: const NewsScreen()),
          );
        },
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
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
        children: actions.map((act) {
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: act['action'] as VoidCallback,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(act['icon'] as IconData, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      act['title'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
