import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../widgets/notificationCard.dart';

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
            splashRadius: 20,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filter Pills
            SizedBox(
              height: 34,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
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
            const NotificationCard(
              title: 'Price Alert',
              desc: 'Tomato price has dropped below NPR 80/kg in Kathmandu Market.',
              time: '2m ago',
              isNew: true,
              icon: Icons.trending_down_rounded,
              iconColor: AppColors.success,
              iconBg: AppColors.successLight,
            ),
            const NotificationCard(
              title: 'Weather Update',
              desc: 'Heavy rainfall expected in Eastern Region tomorrow. Plan your activities accordingly.',
              time: '15m ago',
              isNew: true,
              icon: Icons.cloudy_snowing,
              iconColor: Colors.blue,
              iconBg: Color(0xFFDBEAFE),
            ),
            const NotificationCard(
              title: 'Order Update',
              desc: 'Your order #ORD1256 has been confirmed by Green Valley Farms.',
              time: '45m ago',
              isNew: false,
              icon: Icons.check_circle_outline_rounded,
              iconColor: AppColors.primary,
              iconBg: AppColors.primaryLight,
            ),
            const NotificationCard(
              title: 'Sensor Alert',
              desc: 'Field Node 01 soil moisture reached optimal level (62%). Irrigation stopped.',
              time: '1h ago',
              isNew: false,
              icon: Icons.sensors_rounded,
              iconColor: Colors.teal,
              iconBg: Color(0xFFCCFBF1),
            ),

            const SizedBox(height: 18),

            // Yesterday
            const Text('Yesterday', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            const NotificationCard(
              title: 'Payment Received',
              desc: 'NPR 1,20,000 received for Basmati Rice Contract #CT-2024-001 into escrow.',
              time: 'Yesterday, 4:30 PM',
              isNew: false,
              icon: Icons.account_balance_wallet_outlined,
              iconColor: AppColors.success,
              iconBg: AppColors.successLight,
            ),
            const NotificationCard(
              title: 'Disease Advisory',
              desc: 'Early Blight risk elevated in your region due to current temperature and humidity patterns.',
              time: 'Yesterday, 11:00 AM',
              isNew: false,
              icon: Icons.warning_amber_rounded,
              iconColor: Colors.orange,
              iconBg: Color(0xFFFEF3C7),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
