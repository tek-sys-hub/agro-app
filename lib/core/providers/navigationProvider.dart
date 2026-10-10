import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setTab(int index) {
    if (state != index) {
      state = index;
    }
  }

  void goToHome() => setTab(0);
  void goToMarket() => setTab(1);
  void goToAiScan() => setTab(2);
  void goToB2b() => setTab(3);
  void goToProfile() => setTab(4);
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
});
