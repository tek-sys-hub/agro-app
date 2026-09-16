import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All (12)', 'Market (3)', 'Price Alerts (2)', 'Orders (4)', 'System (3)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text('Stay updated with what matters to you.', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: AppColors.textPrimary,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filter Pills
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                      ),
                      child: Text(
                        _filters[index],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // Today
            const Text('Today', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            _buildNotificationCard(
              title: 'Price Alert',
              desc: 'Tomato price has dropped below NPR 80/kg in Kathmandu Market.',
              time: '2m ago',
              isNew: true,
              icon: Icons.trending_down_rounded,
              iconColor: AppColors.success,
              iconBg: AppColors.successLight,
            ),
            const SizedBox(height: 8),
            _buildNotificationCard(
              title: 'Weather Update',
              desc: 'Heavy rainfall expected in Eastern Region tomorrow. Plan your activities accordingly.',
              time: '15m ago',
              isNew: true,
              icon: Icons.cloudy_snowing,
              iconColor: Colors.blue,
              iconBg: const Color(0xFFDBEAFE),
            ),
            const SizedBox(height: 8),
            _buildNotificationCard(
              title: 'Order Update',
              desc: 'Your order #ORD1256 has been confirmed by Green Valley Farms.',
              time: '45m ago',
              isNew: true,
              icon: Icons.shopping_cart_outlined,
              iconColor: Colors.orange,
              iconBg: const Color(0xFFFEF3C7),
            ),
            const SizedBox(height: 8),
            _buildNotificationCard(
              title: 'Market News',
              desc: 'Government announces support package for wheat farmers.',
              time: '1h ago',
              isNew: false,
              icon: Icons.campaign_outlined,
              iconColor: Colors.purple,
              iconBg: const Color(0xFFEDE9FE),
            ),

            const SizedBox(height: 18),

            // Yesterday
            const Text('Yesterday', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            _buildNotificationCard(
              title: 'Price Alert',
              desc: 'Potato price increased above NPR 60/kg in Pokhara Market.',
              time: 'Yesterday, 8:30 PM',
              isNew: false,
              icon: Icons.attach_money_rounded,
              iconColor: Colors.amber[800]!,
              iconBg: const Color(0xFFFEF3C7),
            ),
            const SizedBox(height: 8),
            _buildNotificationCard(
              title: 'Order Delivered',
              desc: 'Your order #ORD1248 has been delivered successfully.',
              time: 'Yesterday, 4:20 PM',
              isNew: false,
              icon: Icons.shopping_bag_outlined,
              iconColor: AppColors.primary,
              iconBg: AppColors.primaryLight,
            ),
            const SizedBox(height: 8),
            _buildNotificationCard(
              title: 'System Update',
              desc: 'We\'ve updated our app to improve your experience.',
              time: 'Yesterday, 10:15 AM',
              isNew: false,
              icon: Icons.verified_outlined,
              iconColor: Colors.blueGrey,
              iconBg: const Color(0xFFF1F5F9),
            ),

            const SizedBox(height: 18),

            // This Week
            const Text('This Week', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            _buildNotificationCard(
              title: 'B2B Contract Update',
              desc: 'Your contract with Himalayan Organics is about to expire in 5 days.',
              time: 'May 27, 9:00 AM',
              isNew: false,
              icon: Icons.handshake_outlined,
              iconColor: AppColors.primary,
              iconBg: AppColors.primaryLight,
            ),

            const SizedBox(height: 16),
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Text('Load More', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                label: const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String desc,
    required String time,
    required bool isNew,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                        if (isNew) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('New', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.primary)),
                          ),
                        ],
                      ],
                    ),
                    Text(time, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
