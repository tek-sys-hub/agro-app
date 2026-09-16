import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';
import '../../core/widgets/metricBadge.dart';
import '../notifications/notificationScreen.dart';

class SensorDashboardScreen extends StatefulWidget {
  const SensorDashboardScreen({super.key});

  @override
  State<SensorDashboardScreen> createState() => _SensorDashboardScreenState();
}

class _SensorDashboardScreenState extends State<SensorDashboardScreen> {
  int _activeTab = 0;
  final List<String> _tabs = ['Overview', 'Charts', 'Alerts (2)', 'Devices', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sensor Dashboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text('Real-time farm environment monitoring', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
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
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
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
            // Active Device Hero Card
            _buildDeviceHeroCard(),

            const SizedBox(height: 14),

            // Tab bar pills
            _buildTabs(),

            const SizedBox(height: 14),

            // 9 Sensor Metric Cards Grid
            _buildSensorsGrid(),

            const SizedBox(height: 16),

            // Irrigation & Device Status Row
            _buildIrrigationAndDeviceRow(),

            const SizedBox(height: 16),

            // Historical Trends Chart Card
            _buildHistoricalTrendsCard(),

            const SizedBox(height: 16),

            // AI Recommendation Banner
            _buildAiRecommendationCard(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceHeroCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.router_rounded, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'North Field Sensor 1',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    SizedBox(width: 6),
                    MetricBadge(text: 'Active', type: MetricBadgeType.success),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 12, color: AppColors.textMuted),
                    SizedBox(width: 3),
                    Text('Location: North Field, Plot A', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 2),
                const Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 12, color: AppColors.textMuted),
                    SizedBox(width: 3),
                    Text('Last updated: 2 min ago', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Row(
                children: [
                  Text('82%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  SizedBox(width: 2),
                  Icon(Icons.battery_charging_full_rounded, size: 14, color: AppColors.primary),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text('Strong', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  SizedBox(width: 2),
                  Icon(Icons.wifi_rounded, size: 12, color: AppColors.primary),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _activeTab == index;
          return GestureDetector(
            onTap: () => setState(() => _activeTab = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
              ),
              child: Text(
                _tabs[index],
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
    );
  }

  Widget _buildSensorsGrid() {
    final metrics = [
      {'title': 'Soil Moisture', 'val': '32%', 'badge': 'Optimal', 'btype': MetricBadgeType.primary, 'ideal': '30–60%', 'color': Colors.blue, 'icon': Icons.water_drop_outlined},
      {'title': 'Soil pH', 'val': '6.4', 'badge': 'Optimal', 'btype': MetricBadgeType.success, 'ideal': '6.0–7.0', 'color': Colors.green, 'icon': Icons.eco_outlined},
      {'title': 'Temperature', 'val': '26.8°C', 'badge': 'Optimal', 'btype': MetricBadgeType.warning, 'ideal': 'Air: 26.8°C | Soil: 24.1°C', 'color': Colors.orange, 'icon': Icons.thermostat_outlined},
      {'title': 'Humidity', 'val': '68%', 'badge': 'Optimal', 'btype': MetricBadgeType.info, 'ideal': '40–70%', 'color': Colors.purple, 'icon': Icons.opacity_rounded},
      {'title': 'Nitrogen (N)', 'val': '28 ppm', 'badge': 'Good', 'btype': MetricBadgeType.info, 'ideal': '20–40 ppm', 'color': Colors.blueAccent, 'icon': Icons.science_outlined},
      {'title': 'Phosphorus (P)', 'val': '18 ppm', 'badge': 'Low', 'btype': MetricBadgeType.danger, 'ideal': '20–40 ppm', 'color': Colors.deepPurple, 'icon': Icons.bubble_chart_outlined},
      {'title': 'Potassium (K)', 'val': '156 ppm', 'badge': 'Good', 'btype': MetricBadgeType.warning, 'ideal': '120–200 ppm', 'color': Colors.amber, 'icon': Icons.grain_outlined},
      {'title': 'EC (Conductivity)', 'val': '1.2 dS/m', 'badge': 'Optimal', 'btype': MetricBadgeType.success, 'ideal': '0.8–2.0 dS/m', 'color': Colors.teal, 'icon': Icons.bolt_outlined},
      {'title': 'Light Intensity', 'val': '820 lux', 'badge': 'Good', 'btype': MetricBadgeType.warning, 'ideal': '500–1000 lux', 'color': Colors.orangeAccent, 'icon': Icons.light_mode_outlined},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.86,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final m = metrics[index];
        final color = m['color'] as Color;
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(m['icon'] as IconData, size: 14, color: color),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      m['title'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    m['val'] as String,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  MetricBadge(
                    text: m['badge'] as String,
                    type: m['btype'] as MetricBadgeType,
                  ),
                ],
              ),
              Text(
                'Ideal: ${m['ideal']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 8, color: AppColors.textMuted),
              ),
              // Mini wave indicator
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  height: 4,
                  width: double.infinity,
                  color: color.withValues(alpha: 0.2),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.7,
                    child: Container(color: color),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIrrigationAndDeviceRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Irrigation Status Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.water_drop_outlined, size: 14, color: Colors.blue),
                    SizedBox(width: 4),
                    Text('Irrigation Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(
                          value: 0.60,
                          strokeWidth: 7,
                          backgroundColor: Color(0xFFE5E7EB),
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                      ),
                      Column(
                        children: const [
                          Text('60%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                          Text('Efficiency', style: TextStyle(fontSize: 8, color: AppColors.textMuted)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Next: Tomorrow 6:00 AM', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                const Text('Water Used: 120 L', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow_rounded, size: 14, color: Colors.white),
                  label: const Text('Run Irrigation', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 32),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Device Status Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
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
                  children: const [
                    Text('Device Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    Text('View All', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 8),
                _buildDeviceItem('North Field 1', 'Online'),
                _buildDeviceItem('North Field 2', 'Online'),
                _buildDeviceItem('Greenhouse Sensor', 'Online'),
                _buildDeviceItem('Weather Station', 'Online'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceItem(String name, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.sensors_rounded, size: 12, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            ],
          ),
          Row(
            children: [
              Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
              const SizedBox(width: 3),
              Text(status, style: const TextStyle(fontSize: 9, color: AppColors.primary, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoricalTrendsCard() {
    final days = ['May 20', 'May 21', 'May 22', 'May 23', 'May 24', 'May 25', 'May 26'];
    return Container(
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
              const Text('Historical Trends', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Text('Soil Moisture ▼', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Text('7 Days ▼', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('May 26, 9:00 AM', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                Text('● 32%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.blue)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((d) => Text(d, style: const TextStyle(fontSize: 9, color: AppColors.textMuted))).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAiRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBBF7D0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco_outlined, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Recommendation', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                SizedBox(height: 2),
                Text(
                  'Soil moisture is slightly low. Consider irrigation in the next 24 hours for optimal growth.',
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('View', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                Icon(Icons.chevron_right_rounded, size: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
