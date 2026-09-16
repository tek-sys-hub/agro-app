import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/smoothPageRoute.dart';
import '../../aiScan/screens/aiScanScreen.dart';
import '../../news/screens/newsScreen.dart';

class QuickActionsBar extends StatelessWidget {
  const QuickActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
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
          Navigator.of(context).push(
            SmoothPageRoute(
              page: const AiScanScreen(initialTabIndex: 0),
            ),
          );
        },
      },
      {
        'title': 'Market Insights',
        'icon': Icons.storefront_rounded,
        'action': () {
          Navigator.of(context).push(
            SmoothPageRoute(page: const NewsScreen()),
          );
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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((act) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: act['action'] as VoidCallback,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(act['icon'] as IconData, color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    act['title'] as String,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
