import 'package:flutter_riverpod/flutter_riverpod.dart';

class SensorState {
  final int activeTab;
  final bool isIrrigationActive;
  final double soilMoisture;
  final double temperature;
  final double soilPh;
  final int humidity;

  const SensorState({
    required this.activeTab,
    required this.isIrrigationActive,
    required this.soilMoisture,
    required this.temperature,
    required this.soilPh,
    required this.humidity,
  });

  SensorState copyWith({
    int? activeTab,
    bool? isIrrigationActive,
    double? soilMoisture,
    double? temperature,
    double? soilPh,
    int? humidity,
  }) {
    return SensorState(
      activeTab: activeTab ?? this.activeTab,
      isIrrigationActive: isIrrigationActive ?? this.isIrrigationActive,
      soilMoisture: soilMoisture ?? this.soilMoisture,
      temperature: temperature ?? this.temperature,
      soilPh: soilPh ?? this.soilPh,
      humidity: humidity ?? this.humidity,
    );
  }
}

class SensorNotifier extends StateNotifier<SensorState> {
  SensorNotifier()
      : super(
          const SensorState(
            activeTab: 0,
            isIrrigationActive: false,
            soilMoisture: 32.0,
            temperature: 26.8,
            soilPh: 6.4,
            humidity: 68,
          ),
        );

  void setTab(int tabIndex) {
    state = state.copyWith(activeTab: tabIndex);
  }

  void toggleIrrigation() {
    state = state.copyWith(isIrrigationActive: !state.isIrrigationActive);
  }

  void updateSoilMoisture(double val) {
    state = state.copyWith(soilMoisture: val);
  }
}

final sensorProvider = StateNotifierProvider<SensorNotifier, SensorState>((ref) {
  return SensorNotifier();
});
