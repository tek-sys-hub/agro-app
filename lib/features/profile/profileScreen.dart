import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';
import '../notifications/notificationScreen.dart';
import '../auth/loginScreen.dart';

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
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Profile Hero Card
            _buildProfileCard(),

            const SizedBox(height: 16),

            // 4 Stats in a row
            _buildStatsRow(),

            const SizedBox(height: 16),

            // Agro Pro Banner
            _buildAgroProBanner(),

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

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar with edit pencil
          Stack(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: AppColors.primaryLight,
                child: const Icon(Icons.face_rounded, size: 44, color: AppColors.primary),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit_rounded, size: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Saugat Shahi',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.check_circle_rounded, size: 16, color: AppColors.primary),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'Tomato Farmer',
                  style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 12, color: AppColors.textMuted),
                    SizedBox(width: 4),
                    Text('Kathmandu, Nepal', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 2),
                const Row(
                  children: [
                    Icon(Icons.mail_outline_rounded, size: 12, color: AppColors.textMuted),
                    SizedBox(width: 4),
                    Text('saugatshahi@example.com', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              children: [
                Icon(Icons.qr_code_2_rounded, size: 14, color: AppColors.textPrimary),
                SizedBox(width: 4),
                Text('My QR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      {'val': '12', 'label': 'Crops Added', 'icon': Icons.eco_outlined, 'color': Colors.green},
      {'val': '28', 'label': 'Markets Tracked', 'icon': Icons.storefront_outlined, 'color': Colors.teal},
      {'val': '156', 'label': 'Insights Viewed', 'icon': Icons.trending_up_rounded, 'color': Colors.blue},
      {'val': '342', 'label': 'Community Points', 'icon': Icons.groups_outlined, 'color': Colors.orange},
    ];

    return Row(
      children: stats.map((s) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Icon(s['icon'] as IconData, size: 18, color: s['color'] as Color),
                const SizedBox(height: 6),
                Text(
                  s['val'] as String,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  s['label'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 8.5, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAgroProBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F7F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC7EBD9)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Agro Pro', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary)),
                SizedBox(height: 2),
                Text(
                  'Unlock advanced insights, premium recommendations and more.',
                  style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Upgrade Now', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                Icon(Icons.chevron_right_rounded, size: 12),
              ],
            ),
          ),
        ],
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
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        },
      ),
    );
  }
}
