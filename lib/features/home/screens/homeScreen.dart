import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../widgets/homeHeader.dart';
import '../widgets/homeSearchBar.dart';
import '../widgets/aiAssistantBanner.dart';
import '../widgets/weatherSummaryCard.dart';
import '../widgets/marketPricesSection.dart';
import '../widgets/communitySection.dart';
import '../widgets/quickActionsBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              // Header with Profile & Notifications
              HomeHeader(),
              SizedBox(height: 16),

              // Search Bar & Scan Shortcut
              HomeSearchBar(),
              SizedBox(height: 16),

              // Agro AI Assistant Card
              AiAssistantBanner(),
              SizedBox(height: 16),

              // Weather and Sensors Row
              WeatherSummaryCard(),
              SizedBox(height: 20),

              // Today's Market Prices
              MarketPricesSection(),
              SizedBox(height: 20),

              // From the Community
              CommunitySection(),
              SizedBox(height: 20),

              // Quick Actions Bar
              QuickActionsBar(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
