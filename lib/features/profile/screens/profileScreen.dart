import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/smoothPageRoute.dart';
import '../../notifications/screens/notificationScreen.dart';
import '../../auth/screens/loginScreen.dart';
import '../widgets/profileCard.dart';
import '../widgets/profileStatsRow.dart';
import '../widgets/agroProBanner.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.eco_rounded, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              'Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            color: AppColors.textPrimary,
            splashRadius: 20,
            onPressed: () {
              Navigator.of(context).push(
                SmoothPageRoute(page: const NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Profile Hero Card
            const ProfileCard(),

            const SizedBox(height: 16),

            // 4 Stats in a row
            const ProfileStatsRow(),

            const SizedBox(height: 16),

            // Agro Pro Banner
            const AgroProBanner(),

            const SizedBox(height: 16),

            // Menu Options List
            _buildMenuList(context),

            const SizedBox(height: 16),

            // Log Out Button
            _buildLogoutButton(context),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    final items = [
      {'title': 'Personal Information', 'icon': Icons.person_outline_rounded},
      {'title': 'Farm Information', 'icon': Icons.yard_outlined},
      {'title': 'Saved Reports', 'icon': Icons.bookmark_border_rounded},
      {'title': 'Favorite Crops', 'icon': Icons.favorite_border_rounded},
      {'title': 'Notification Settings', 'icon': Icons.notifications_none_rounded},
      {'title': 'Privacy & Security', 'icon': Icons.lock_outline_rounded},
      {'title': 'Help & Support', 'icon': Icons.help_outline_rounded},
      {'title': 'App Settings', 'icon': Icons.settings_outlined},
    ];

    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.borderSubtle),
        itemBuilder: (context, index) {
          final it = items[index];
          return ListTile(
            leading: Icon(it['icon'] as IconData, color: AppColors.textSecondary, size: 20),
            title: Text(
              it['title'] as String,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textMuted),
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: const Icon(Icons.logout_rounded, color: AppColors.danger, size: 20),
        title: const Text(
          'Log Out',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.danger),
        ),
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            SmoothPageRoute(page: const LoginScreen()),
            (route) => false,
          );
        },
      ),
    );
  }
}
