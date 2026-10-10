import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherModel {
  final String locationName;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final int weatherCode;
  final String conditionText;
  final int rainProbability;
  final double tempMax;
  final double tempMin;
  final String farmingAdvice;
  final List<HourlyForecast> hourlyForecasts;

  const WeatherModel({
    required this.locationName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.conditionText,
    required this.rainProbability,
    required this.tempMax,
    required this.tempMin,
    required this.farmingAdvice,
    required this.hourlyForecasts,
  });

  factory WeatherModel.fromOpenWeatherJson(
    Map<String, dynamic> json, {
    Map<String, dynamic>? forecastJson,
    String location = 'Kanchanpur, Nepal',
  }) {
    final main = json['main'] ?? {};
    final wind = json['wind'] ?? {};
    final weatherList = (json['weather'] as List?) ?? [];
    final weatherItem = weatherList.isNotEmpty ? weatherList[0] as Map<String, dynamic> : {};

    final temp = (main['temp'] as num?)?.toDouble() ?? 24.5;
    final hum = (main['humidity'] as num?)?.toInt() ?? 65;
    final windSpeedMps = (wind['speed'] as num?)?.toDouble() ?? 2.5;
    final tMax = (main['temp_max'] as num?)?.toDouble() ?? (temp + 2.5);
    final tMin = (main['temp_min'] as num?)?.toDouble() ?? (temp - 3.5);

    final mainCondition = weatherItem['main'] as String? ?? 'Clear';
    final description = weatherItem['description'] as String? ?? mainCondition;
    final code = (weatherItem['id'] as num?)?.toInt() ?? 800;
    final city = json['name'] as String? ?? location;

    int rainProb = 15;
    if (mainCondition.toLowerCase().contains('rain') || mainCondition.toLowerCase().contains('drizzle')) {
      rainProb = 85;
    } else if (mainCondition.toLowerCase().contains('thunderstorm')) {
      rainProb = 95;
    } else if (mainCondition.toLowerCase().contains('cloud')) {
      rainProb = 35;
    }

    final List<HourlyForecast> hList = [];

    if (forecastJson != null && forecastJson['list'] is List) {
      final list = forecastJson['list'] as List;
      for (int i = 0; i < list.length && hList.length < 6; i++) {
        final item = list[i] as Map<String, dynamic>;
        final dtTxt = item['dt_txt'] as String? ?? '';
        final itemMain = item['main'] ?? {};
        final itemWeatherList = (item['weather'] as List?) ?? [];
        final itemWeather = itemWeatherList.isNotEmpty ? itemWeatherList[0] as Map<String, dynamic> : {};

        final hTemp = (itemMain['temp'] as num?)?.toDouble() ?? temp;
        final hCode = (itemWeather['id'] as num?)?.toInt() ?? code;

        String timeDisplay = '12:00';
        if (dtTxt.contains(' ')) {
          final timePart = dtTxt.split(' ')[1];
          final parts = timePart.split(':');
          if (parts.length >= 2) {
            timeDisplay = '${parts[0]}:${parts[1]}';
          }
        }

        hList.add(HourlyForecast(
          time: timeDisplay,
          temp: hTemp,
          weatherCode: hCode,
        ));
      }
    }

    if (hList.isEmpty) {
      final currentHour = DateTime.now().hour;
      final offsets = [0, 2, 4, 6, 8, 10];
      final tempVariations = [0.0, 1.2, 0.8, -0.5, -1.8, -2.5];

      for (int i = 0; i < 6; i++) {
        final hour = (currentHour + offsets[i]) % 24;
        final formattedTime = '${hour.toString().padLeft(2, '0')}:00';
        hList.add(HourlyForecast(
          time: formattedTime,
          temp: temp + tempVariations[i],
          weatherCode: code,
        ));
      }
    }

    final advice = _generateFarmingAdvice(code, temp, hum, rainProb);
    final conditionCapitalized = description.isNotEmpty
        ? description[0].toUpperCase() + description.substring(1)
        : mainCondition;

    return WeatherModel(
      locationName: city.contains('Nepal') ? city : '$city, Nepal',
      temperature: temp,
      humidity: hum,
      windSpeed: windSpeedMps * 3.6, // Convert m/s to km/h
      weatherCode: code,
      conditionText: conditionCapitalized,
      rainProbability: rainProb,
      tempMax: tMax,
      tempMin: tMin,
      farmingAdvice: advice,
      hourlyForecasts: hList,
    );
  }

  factory WeatherModel.fromOpenMeteoJson(Map<String, dynamic> json, {String location = 'Kanchanpur, Nepal'}) {
    final current = json['current'] ?? {};
    final daily = json['daily'] ?? {};
    final hourly = json['hourly'] ?? {};

    final temp = (current['temperature_2m'] as num?)?.toDouble() ?? 24.5;
    final hum = (current['relative_humidity_2m'] as num?)?.toInt() ?? 65;
    final wind = (current['wind_speed_10m'] as num?)?.toDouble() ?? 8.2;
    final code = (current['weather_code'] as num?)?.toInt() ?? 0;

    final maxTemps = (daily['temperature_2m_max'] as List?) ?? [28.0];
    final minTemps = (daily['temperature_2m_min'] as List?) ?? [18.0];
    final rainProbs = (daily['precipitation_probability_max'] as List?) ?? [20];

    final tMax = (maxTemps.isNotEmpty ? maxTemps[0] as num : 28.0).toDouble();
    final tMin = (minTemps.isNotEmpty ? minTemps[0] as num : 18.0).toDouble();
    final rainProb = (rainProbs.isNotEmpty ? rainProbs[0] as num : 20).toInt();

    final condition = _getConditionText(code);
    final advice = _generateFarmingAdvice(code, temp, hum, rainProb);

    final hourlyTimes = (hourly['time'] as List?) ?? [];
    final hourlyTemps = (hourly['temperature_2m'] as List?) ?? [];
    final hourlyCodes = (hourly['weather_code'] as List?) ?? [];

    final List<HourlyForecast> hList = [];
    final nowHour = DateTime.now().hour;

    for (int i = 0; i < hourlyTimes.length && hList.length < 6; i++) {
      final timeStr = hourlyTimes[i] as String;
      final dt = DateTime.tryParse(timeStr);
      if (dt != null && dt.hour >= nowHour) {
        final hTemp = (i < hourlyTemps.length ? hourlyTemps[i] as num : temp).toDouble();
        final hCode = (i < hourlyCodes.length ? hourlyCodes[i] as num : code).toInt();
        final timeDisplay = '${dt.hour.toString().padLeft(2, '0')}:00';

        hList.add(HourlyForecast(
          time: timeDisplay,
          temp: hTemp,
          weatherCode: hCode,
        ));
      }
    }

    return WeatherModel(
      locationName: location,
      temperature: temp,
      humidity: hum,
      windSpeed: wind,
      weatherCode: code,
      conditionText: condition,
      rainProbability: rainProb,
      tempMax: tMax,
      tempMin: tMin,
      farmingAdvice: advice,
      hourlyForecasts: hList,
    );
  }

  static String _getConditionText(int code) {
    if (code == 0) return 'Clear Sky';
    if (code >= 1 && code <= 3) return 'Partly Cloudy';
    if (code >= 45 && code <= 48) return 'Foggy';
    if (code >= 51 && code <= 67) return 'Light Rain';
    if (code >= 80 && code <= 82) return 'Showers';
    if (code >= 95) return 'Thunderstorm';
    return 'Cloudy';
  }

  static String _generateFarmingAdvice(int code, double temp, int humidity, int rainProb) {
    if (rainProb > 60 || code >= 80) {
      return '🌧 High rain probability ($rainProb%). Avoid irrigation and outdoor pesticide spraying in Kanchanpur fields today.';
    } else if (temp > 30) {
      return '☀️ High temperature ($temp°C). Consider evening drip irrigation for paddy & vegetable crops.';
    } else if (humidity > 80) {
      return '💧 High humidity ($humidity%). Monitor paddy & wheat crops for fungal disease symptoms.';
    } else {
      return '🌱 Ideal weather conditions in Kanchanpur. Excellent time for field work, weeding, and organic fertilizer application.';
    }
  }
}

class HourlyForecast {
  final String time;
  final double temp;
  final int weatherCode;

  const HourlyForecast({
    required this.time,
    required this.temp,
    required this.weatherCode,
  });
}

class WeatherService {
  WeatherService._();
  static final WeatherService instance = WeatherService._();

  Future<WeatherModel> fetchCurrentWeather({
    double latitude = 28.9328,
    double longitude = 80.1983,
    String locationName = 'Kanchanpur, Nepal',
  }) async {
    final apiKey = dotenv.env['OPENWEATHER_API_KEY']?.trim();

    if (apiKey != null && apiKey.isNotEmpty) {
      try {
        final weatherUrl = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?'
          'lat=$latitude&lon=$longitude'
          '&appid=$apiKey&units=metric',
        );

        final response = await http.get(weatherUrl);

        if (response.statusCode == 200) {
          final currentData = json.decode(response.body) as Map<String, dynamic>;
          Map<String, dynamic>? forecastData;

          try {
            final forecastUrl = Uri.parse(
              'https://api.openweathermap.org/data/2.5/forecast?'
              'lat=$latitude&lon=$longitude'
              '&appid=$apiKey&units=metric',
            );
            final forecastResp = await http.get(forecastUrl);
            if (forecastResp.statusCode == 200) {
              forecastData = json.decode(forecastResp.body) as Map<String, dynamic>;
            }
          } catch (e) {
            if (kDebugMode) print('OpenWeather forecast fetch error: $e');
          }

          return WeatherModel.fromOpenWeatherJson(
            currentData,
            forecastJson: forecastData,
            location: locationName,
          );
        } else {
          if (kDebugMode) {
            print('OpenWeatherMap API response ${response.statusCode}: ${response.body}');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('OpenWeatherMap API request exception: $e');
        }
      }
    }

    // Fallback to Open-Meteo Weather API for Kanchanpur
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?'
      'latitude=$latitude&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m'
      '&hourly=temperature_2m,weather_code'
      '&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max'
      '&timezone=auto',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return WeatherModel.fromOpenMeteoJson(data, location: locationName);
    } else {
      throw Exception('Failed to fetch live weather data (${response.statusCode})');
    }
  }
}
