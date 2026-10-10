import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/appColors.dart';
import '../../../core/services/weatherService.dart';
import '../providers/weatherProvider.dart';

class WeatherDetailSheet extends ConsumerStatefulWidget {
  const WeatherDetailSheet({super.key});

  @override
  ConsumerState<WeatherDetailSheet> createState() => _WeatherDetailSheetState();
}

class _WeatherDetailSheetState extends ConsumerState<WeatherDetailSheet> {
  final List<Map<String, dynamic>> _locations = [
    {'name': 'Kathmandu, Nepal', 'lat': 27.7172, 'lon': 85.3240},
    {'name': 'Pokhara, Nepal', 'lat': 28.2096, 'lon': 83.9856},
    {'name': 'Chitwan, Nepal', 'lat': 27.5291, 'lon': 84.3542},
    {'name': 'Biratnagar, Nepal', 'lat': 26.4525, 'lon': 87.2718},
    {'name': 'Lalitpur, Nepal', 'lat': 27.6644, 'lon': 85.3188},
    {'name': 'Jhapa, Nepal', 'lat': 26.6333, 'lon': 87.8833},
  ];

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
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);
    final weather = weatherState.weather;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.cloud_outlined, color: AppColors.primary, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'OpenWeather Insights',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Location Selector Chips
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _locations.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final loc = _locations[index];
                  final isSelected = weather?.locationName == loc['name'];

                  return ChoiceChip(
                    label: Text(
                      loc['name'].toString().split(',')[0],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.borderSubtle,
                    onSelected: (selected) {
                      if (selected) {
                        ref.read(weatherProvider.notifier).loadWeather(
                              latitude: loc['lat'] as double,
                              longitude: loc['lon'] as double,
                              locationName: loc['name'] as String,
                            );
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            if (weatherState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else if (weather != null) ...[
              // Main Temperature Banner Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weather.locationName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              weather.conditionText,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          _getWeatherIcon(weather.weatherCode),
                          color: _getWeatherIconColor(weather.weatherCode),
                          size: 48,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${weather.temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'High: ${weather.tempMax.toStringAsFixed(1)}° / Low: ${weather.tempMin.toStringAsFixed(1)}°',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Detailed Weather Grid
              Row(
                children: [
                  Expanded(
                    child: _buildMetricTile(
                      icon: Icons.water_drop_outlined,
                      label: 'Humidity',
                      value: '${weather.humidity}%',
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMetricTile(
                      icon: Icons.air_rounded,
                      label: 'Wind Speed',
                      value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMetricTile(
                      icon: Icons.umbrella_rounded,
                      label: 'Rain Chance',
                      value: '${weather.rainProbability}%',
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 6-Hour Forecast Timeline
              const Text(
                'Hourly Forecast',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: weather.hourlyForecasts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final h = weather.hourlyForecasts[index];
                    return Container(
                      width: 65,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            h.time,
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            _getWeatherIcon(h.weatherCode),
                            color: _getWeatherIconColor(h.weatherCode),
                            size: 20,
                          ),
                          Text(
                            '${h.temp.toStringAsFixed(0)}°C',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Agricultural Guidance Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.eco_rounded, color: AppColors.primary, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Farmer Action Plan',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            weather.farmingAdvice,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryDark,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ] else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text('Unable to load weather details'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
