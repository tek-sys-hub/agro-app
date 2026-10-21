import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/supabaseService.dart';
import '../../../core/theme/appColors.dart';

class NotificationModel {
  final String id;
  final String title;
  final String desc;
  final String time;
  final String category;
  final String period;
  final bool isNew;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.time,
    required this.category,
    required this.period,
    required this.isNew,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    final title = map['title'] as String? ?? 'Alert';
    final desc = map['description'] as String? ?? '';
    final category = map['category'] as String? ?? 'System';
    final isRead = map['is_read'] as bool? ?? false;
    final createdAtStr = map['created_at'] as String?;

    String period = 'Today';
    String timeDisplay = 'Just now';
    if (createdAtStr != null) {
      final dt = DateTime.tryParse(createdAtStr);
      if (dt != null) {
        final now = DateTime.now();
        final diff = now.difference(dt);
        if (diff.inDays >= 1) {
          period = 'Yesterday';
          timeDisplay = '${diff.inDays}d ago';
        } else if (diff.inHours >= 1) {
          timeDisplay = '${diff.inHours}h ago';
        } else if (diff.inMinutes >= 1) {
          timeDisplay = '${diff.inMinutes}m ago';
        }
      }
    }

    IconData icon = Icons.notifications_active_outlined;
    Color iconColor = AppColors.primary;
    Color iconBg = AppColors.primaryLight;

    if (category == 'Price Alerts' || title.contains('Price')) {
      icon = Icons.trending_down_rounded;
      iconColor = AppColors.success;
      iconBg = AppColors.successLight;
    } else if (category == 'Orders' || title.contains('Order')) {
      icon = Icons.check_circle_outline_rounded;
      iconColor = AppColors.primary;
      iconBg = AppColors.primaryLight;
    } else if (category == 'Market' || title.contains('Advisory')) {
      icon = Icons.warning_amber_rounded;
      iconColor = Colors.orange;
      iconBg = const Color(0xFFFEF3C7);
    } else if (category == 'System' || title.contains('Weather')) {
      icon = Icons.cloudy_snowing;
      iconColor = Colors.blue;
      iconBg = const Color(0xFFDBEAFE);
    }

    return NotificationModel(
      id: map['id'] as String? ?? '',
      title: title,
      desc: desc,
      time: timeDisplay,
      category: category,
      period: period,
      isNew: !isRead,
      icon: icon,
      iconColor: iconColor,
      iconBg: iconBg,
    );
  }
}

class NotificationState {
  final bool isLoading;
  final int selectedFilterIndex;
  final List<NotificationModel> notifications;

  const NotificationState({
    required this.isLoading,
    required this.selectedFilterIndex,
    required this.notifications,
  });

  NotificationState copyWith({
    bool? isLoading,
    int? selectedFilterIndex,
    List<NotificationModel>? notifications,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      notifications: notifications ?? this.notifications,
    );
  }
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  final SupabaseService _supabaseService = SupabaseService.instance;

  NotificationNotifier()
      : super(
          const NotificationState(
            isLoading: false,
            selectedFilterIndex: 0,
            notifications: [],
          ),
        ) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final user = _supabaseService.currentUser;
    if (user == null) {
      state = state.copyWith(notifications: []);
      return;
    }

    state = state.copyWith(isLoading: true);
    final data = await _supabaseService.fetchNotifications(user.id);

    final list = data.map((map) => NotificationModel.fromMap(map)).toList();
    state = state.copyWith(notifications: list, isLoading: false);
  }

  Future<void> markAllAsRead() async {
    final user = _supabaseService.currentUser;
    if (user != null) {
      await _supabaseService.markNotificationsAsRead(user.id);
    }

    final updated = state.notifications.map((n) {
      return NotificationModel(
        id: n.id,
        title: n.title,
        desc: n.desc,
        time: n.time,
        category: n.category,
        period: n.period,
        isNew: false,
        icon: n.icon,
        iconColor: n.iconColor,
        iconBg: n.iconBg,
      );
    }).toList();

    state = state.copyWith(notifications: updated);
  }

  void setFilterIndex(int index) {
    state = state.copyWith(selectedFilterIndex: index);
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier();
});
