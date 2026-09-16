import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/metricBadge.dart';
import '../../../core/widgets/smoothPageRoute.dart';
import '../../sensors/screens/sensorDashboardScreen.dart';

class WeatherSummaryCard extends StatelessWidget {
  const WeatherSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
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
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.of(context).push(
                SmoothPageRoute(page: const SensorDashboardScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
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
                        children: const [
                          Icon(Icons.water_drop_rounded, size: 18, color: Colors.blue),
                          SizedBox(height: 2),
                          Text('62%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          Text('Humidity', style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
                        ],
                      ),
                      Column(
                        children: const [
                          Icon(Icons.thermostat_rounded, size: 18, color: Colors.orange),
                          SizedBox(height: 2),
                          Text('28°C', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          MetricBadge(text: 'Normal', type: MetricBadgeType.success),
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
}
