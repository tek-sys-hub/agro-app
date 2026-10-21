import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/appColors.dart';
import '../providers/notificationProvider.dart';
import '../widgets/notificationCard.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  static const List<String> _filters = ['All', 'Market', 'Price Alerts', 'Orders', 'System'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);

    final selectedFilterIndex = state.selectedFilterIndex;
    final allNotifications = state.notifications;

    final filteredList = allNotifications.where((n) {
      if (selectedFilterIndex == 0) return true;
      final filterName = _filters[selectedFilterIndex];
      if (filterName == 'Price Alerts') return n.category == 'Price Alerts';
      if (filterName == 'Market') return n.category == 'Market';
      if (filterName == 'Orders') return n.category == 'Orders';
      if (filterName == 'System') return n.category == 'System';
      return true;
    }).toList();

    final todayList = filteredList.where((n) => n.period == 'Today').toList();
    final yesterdayList = filteredList.where((n) => n.period == 'Yesterday').toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text('Stay updated with real-time farm activity', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              notifier.markAllAsRead();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.done_all_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('All notifications marked as read.'),
                    ],
                  ),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.done_all_rounded, size: 16, color: AppColors.primary),
            label: const Text(
              'Read All',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
            ),
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
                  final isSelected = selectedFilterIndex == index;
                  return GestureDetector(
                    onTap: () => notifier.setFilterIndex(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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

            if (state.isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                ),
              )
            else if (filteredList.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.notifications_off_outlined, size: 36, color: AppColors.textMuted),
                    SizedBox(height: 10),
                    Text(
                      'No notifications found for this user.',
                      style: TextStyle(fontSize: 13, color: AppColors.textMuted, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            else ...[
              if (todayList.isNotEmpty) ...[
                const Text('Today', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 10),
                ...todayList.map((n) => NotificationCard(
                      title: n.title,
                      desc: n.desc,
                      time: n.time,
                      isNew: n.isNew,
                      icon: n.icon,
                      iconColor: n.iconColor,
                      iconBg: n.iconBg,
                    )),
              ],
              if (yesterdayList.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text('Yesterday', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 10),
                ...yesterdayList.map((n) => NotificationCard(
                      title: n.title,
                      desc: n.desc,
                      time: n.time,
                      isNew: n.isNew,
                      icon: n.icon,
                      iconColor: n.iconColor,
                      iconBg: n.iconBg,
                    )),
              ],
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
