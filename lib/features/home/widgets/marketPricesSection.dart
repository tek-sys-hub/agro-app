import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/smoothPageRoute.dart';
import '../../market/screens/searchScreen.dart';

class MarketPricesSection extends StatelessWidget {
  const MarketPricesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Tomato', 'price': 'Rs. 48/Kg', 'change': '▼ 2.3%', 'isUp': false, 'icon': '🍅'},
      {'name': 'Potato', 'price': 'Rs. 32/Kg', 'change': '▲ 1.1%', 'isUp': true, 'icon': '🥔'},
      {'name': 'Rice', 'price': 'Rs. 64/Kg', 'change': '▼ 0.8%', 'isUp': false, 'icon': '🍚'},
      {'name': 'Maize', 'price': 'Rs. 30/Kg', 'change': '▼ 1.5%', 'isUp': false, 'icon': '🌽'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Today\'s Market Prices',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  SmoothPageRoute(page: const SearchScreen()),
                );
              },
              child: const Text(
                'View All',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 86,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final item = items[index];
              final isUp = item['isUp'] as bool;
              return Container(
                width: 130,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
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
                  children: [
                    Text(item['icon'] as String, style: const TextStyle(fontSize: 26)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['name'] as String,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['price'] as String,
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['change'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isUp ? AppColors.success : AppColors.danger,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
