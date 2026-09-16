import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/smoothPageRoute.dart';
import '../../news/screens/newsScreen.dart';
import '../../aiScan/screens/diseaseResultScreen.dart';

class CommunitySection extends StatelessWidget {
  const CommunitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'From the Community',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  SmoothPageRoute(page: const NewsScreen()),
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
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.of(context).push(
              SmoothPageRoute(page: const DiseaseResultScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.primaryLight,
                            child: const Icon(Icons.person, size: 18, color: AppColors.primary),
                          ),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Saugat Shahi',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.check_circle_rounded, size: 12, color: AppColors.primary),
                                ],
                              ),
                              Text(
                                'Tomato Farmer • 2h ago',
                                style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tips to control early blight in tomatoes. Neem oil spray works best!',
                        style: TextStyle(fontSize: 12, color: AppColors.textPrimary, height: 1.3),
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Icon(Icons.favorite_border_rounded, size: 14, color: AppColors.textMuted),
                          SizedBox(width: 4),
                          Text('128', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          SizedBox(width: 14),
                          Icon(Icons.chat_bubble_outline_rounded, size: 14, color: AppColors.textMuted),
                          SizedBox(width: 4),
                          Text('24', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          SizedBox(width: 14),
                          Icon(Icons.share_outlined, size: 14, color: AppColors.textMuted),
                          SizedBox(width: 4),
                          Text('12', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 110,
                    height: 100,
                    color: const Color(0xFFC8E6C9),
                    child: const Center(
                      child: Icon(Icons.park_rounded, size: 48, color: AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
