import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary brand greens
  static const Color primary = Color(0xFF0E8A5E);
  static const Color primaryDark = Color(0xFF075E3D);
  static const Color primaryLight = Color(0xFFE8F7F0);
  static const Color primarySurface = Color(0xFFF0FDF4);
  static const Color primaryHover = Color(0xFF09734D);

  // Backgrounds & Surface
  static const Color background = Color(0xFFF8FAF9);
  static const Color surface = Colors.white;
  static const Color card = Colors.white;
  static const Color surfaceMuted = Color(0xFFF3F4F6);

  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textLight = Color(0xFFD1D5DB);

  // Borders & Dividers
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderSubtle = Color(0xFFF1F5F9);

  // Accent & Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFDCFCE7);
  
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerLight = Color(0xFFFEE2E2);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleLight = Color(0xFFEDE9FE);

  // Gradients
  static const List<Color> greenGradient = [
    Color(0xFF0E8A5E),
    Color(0xFF22C55E),
  ];

  static const List<Color> bannerGradient = [
    Color(0xFFE6F7ED),
    Color(0xFFD3EEDF),
  ];
}
