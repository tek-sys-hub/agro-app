import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';
import '../../core/widgets/metricBadge.dart';
import '../notifications/notificationScreen.dart';
import '../market/searchScreen.dart';
import '../sensors/sensorDashboardScreen.dart';
import '../news/newsScreen.dart';
import '../aiScan/aiScanScreen.dart';
import '../aiScan/diseaseResultScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              _buildHeader(context),
              const SizedBox(height: 16),

              // Search Bar
              _buildSearchBar(context),
              const SizedBox(height: 16),

              // Agro AI Assistant Card
              _buildAiAssistantBanner(context),
              const SizedBox(height: 16),

              // Weather and Sensors Row
              _buildWeatherAndSensorsRow(context),
              const SizedBox(height: 20),

              // Today's Market Prices
              _buildMarketPricesSection(context),
              const SizedBox(height: 20),

              // From the Community
              _buildCommunitySection(context),
              const SizedBox(height: 20),

              // Quick Actions Bar
              _buildQuickActions(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.eco_rounded, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Evening,',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Saugat Shahi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text('👋', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            // Notification bell with badge
            Stack(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none_rounded, size: 22),
                    color: AppColors.textPrimary,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const NotificationScreen()),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            // Profile Avatar
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primaryLight,
              child: const Icon(Icons.face_rounded, color: AppColors.primary, size: 26),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search_rounded, color: AppColors.textMuted, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Search crops, diseases, markets...',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            icon: const Icon(Icons.crop_free_rounded, color: AppColors.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AiScanScreen(initialTabIndex: 0),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAiAssistantBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F7F0),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFC7EBD9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agro AI Assistant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Get smart crop recommendations, disease detection, and expert advice.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AiScanScreen(initialTabIndex: 1),
                ),
              );
            },
            icon: const Icon(Icons.auto_awesome_rounded, size: 16, color: Colors.white),
            label: const Text('Ask AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherAndSensorsRow(BuildContext context) {
    return Row(
      children: [
        // Weather Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weather Today',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 3),
                const Row(
                  children: [
                    Icon(Icons.location_on_rounded, size: 12, color: AppColors.primary),
                    SizedBox(width: 2),
                    Text(
                      'Kathmandu, Nepal',
                      style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.wb_sunny_rounded, color: Colors.amber, size: 36),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '24°C',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                        ),
                        Text(
                          'Partly Cloudy',
                          style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 1, color: AppColors.borderSubtle),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.water_drop_outlined, size: 12, color: Colors.blue),
                        SizedBox(width: 2),
                        Text('10%', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.air_rounded, size: 12, color: Colors.blueGrey),
                        SizedBox(width: 2),
                        Text('8 km/h', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                      ],
                    ),
                    Text('NE', style: TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Field Sensors Card
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SensorDashboardScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Field Sensors',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.water_drop_rounded, size: 18, color: Colors.blue),
                          const SizedBox(height: 2),
                          const Text('62%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          const Text('Humidity', style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.thermostat_rounded, size: 18, color: Colors.orange),
                          const SizedBox(height: 2),
                          const Text('28°C', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          const MetricBadge(text: 'Normal', type: MetricBadgeType.success),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: AppColors.borderSubtle),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sensors_rounded, size: 13, color: AppColors.primary),
                      SizedBox(width: 4),
                      Text(
                        'All sensors active',
                        style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketPricesSection(BuildContext context) {
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
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
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

  Widget _buildCommunitySection(BuildContext context) {
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
                  MaterialPageRoute(builder: (_) => const NewsScreen()),
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
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DiseaseResultScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
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

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'title': 'Crop Guide', 'icon': Icons.grass_rounded, 'action': () {}},
      {
        'title': 'Disease Scanner',
        'icon': Icons.shield_outlined,
        'action': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AiScanScreen(initialTabIndex: 0),
            ),
          );
        }
      },
      {
        'title': 'Market Insights',
        'icon': Icons.storefront_rounded,
        'action': () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NewsScreen()),
          );
        }
      },
      {
        'title': 'Agro Learn',
        'icon': Icons.menu_book_rounded,
        'action': () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NewsScreen()),
          );
        }
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((act) {
          return GestureDetector(
            onTap: act['action'] as VoidCallback,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(act['icon'] as IconData, color: AppColors.primary, size: 20),
                ),
                const SizedBox(height: 6),
                Text(
                  act['title'] as String,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
