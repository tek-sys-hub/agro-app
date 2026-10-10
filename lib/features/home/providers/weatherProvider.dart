import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/weatherService.dart';

class WeatherState {
  final bool isLoading;
  final String? errorMessage;
  final WeatherModel? weather;

  const WeatherState({
    required this.isLoading,
    this.errorMessage,
    this.weather,
  });

  WeatherState copyWith({
    bool? isLoading,
    String? errorMessage,
    WeatherModel? weather,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      weather: weather ?? this.weather,
    );
  }
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  final WeatherService _weatherService = WeatherService.instance;

  WeatherNotifier() : super(const WeatherState(isLoading: true)) {
    loadWeather();
  }

  Future<void> loadWeather({
    double latitude = 28.9328,
    double longitude = 80.1983,
    String locationName = 'Kanchanpur, Nepal',
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final data = await _weatherService.fetchCurrentWeather(
        latitude: latitude,
        longitude: longitude,
        locationName: locationName,
      );
      state = state.copyWith(
        isLoading: false,
        weather: data,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
  return WeatherNotifier();
});
