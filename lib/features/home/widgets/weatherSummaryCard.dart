import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/widgets/metricBadge.dart';
import '../../../core/widgets/smoothPageRoute.dart';
import '../../sensors/providers/sensorProvider.dart';
import '../../sensors/screens/sensorDashboardScreen.dart';
import '../providers/weatherProvider.dart';
import 'weatherDetailSheet.dart';

class WeatherSummaryCard extends ConsumerWidget {
  const WeatherSummaryCard({super.key});

  IconData _getWeatherIcon(int code) {
    if (code == 800 || code == 0) return Icons.wb_sunny_rounded;
    if ((code >= 801 && code <= 804) || (code >= 1 && code <= 3)) return Icons.wb_cloudy_rounded;
    if ((code >= 500 && code < 600) || (code >= 300 && code < 400) || (code >= 51 && code <= 67)) {
      return Icons.grain_rounded;
    }
    if ((code >= 200 && code < 300) || code >= 80) return Icons.thunderstorm_rounded;
    if (code >= 600 && code < 700) return Icons.ac_unit_rounded;
    return Icons.cloud_rounded;
  }

  Color _getWeatherIconColor(int code) {
    if (code == 800 || code == 0) return Colors.amber;
    if ((code >= 801 && code <= 804) || (code >= 1 && code <= 3)) return Colors.lightBlue;
    if (code >= 500 || code >= 51) return Colors.blueAccent;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);
    final sensorState = ref.watch(sensorProvider);

    final weather = weatherState.weather;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Weather Card
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const WeatherDetailSheet(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
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
                            'Live Weather',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                          if (weatherState.isLoading)
                            const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(strokeWidth: 1.5, color: AppColors.primary),
                            )
                          else
                            GestureDetector(
                              onTap: () => ref.read(weatherProvider.notifier).loadWeather(),
                              child: const Icon(Icons.refresh_rounded, size: 14, color: AppColors.primary),
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded, size: 12, color: AppColors.primary),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              weather?.locationName ?? 'Kanchanpur, Nepal',
                              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (weather != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              _getWeatherIcon(weather.weatherCode),
                              color: _getWeatherIconColor(weather.weatherCode),
                              size: 32,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${weather.temperature.toStringAsFixed(1)}°C',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                                ),
                                Text(
                                  weather.conditionText,
                                  style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('Loading weather...', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        ),
                      const SizedBox(height: 10),
                      const Divider(height: 1, color: AppColors.borderSubtle),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.water_drop_outlined, size: 11, color: Colors.blue),
                              const SizedBox(width: 2),
                              Text(
                                '${weather?.humidity ?? 65}%',
                                style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.air_rounded, size: 11, color: Colors.blueGrey),
                              const SizedBox(width: 2),
                              Text(
                                '${weather?.windSpeed.toStringAsFixed(0) ?? "8"} km/h',
                                style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                          Text(
                            'Rain:${weather?.rainProbability ?? 20}%',
                            style: const TextStyle(fontSize: 9, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

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
                  padding: const EdgeInsets.all(12),
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
                        children: const [
                          Text(
                            'Field Telemetry',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                          Text(
                            'View All',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Icon(Icons.water_drop_rounded, size: 16, color: Colors.blue),
                                const SizedBox(height: 2),
                                Text(
                                  '${sensorState.soilMoisture.toInt()}%',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                ),
                                const Text('Moisture', style: TextStyle(fontSize: 8, color: AppColors.textMuted)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Icon(Icons.thermostat_rounded, size: 16, color: Colors.orange),
                                const SizedBox(height: 2),
                                Text(
                                  '${sensorState.temperature}°C',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                ),
                                const MetricBadge(text: 'Optimal', type: MetricBadgeType.success),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 1, color: AppColors.borderSubtle),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sensors_rounded, size: 12, color: AppColors.primary),
                          SizedBox(width: 4),
                          Text(
                            'Sensors Connected',
                            style: TextStyle(fontSize: 9, color: AppColors.primary, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Weather Agricultural Farming Banner
        if (weather != null && weather.farmingAdvice.isNotEmpty) ...[
          const SizedBox(height: 12),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const WeatherDetailSheet(),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.psychology_alt_rounded, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      weather.farmingAdvice,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryDark),
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.primary, size: 18),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
