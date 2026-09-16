import 'package:flutter/material.dart';
import 'core/theme/appTheme.dart';
import 'core/widgets/mainNavigationScaffold.dart';

void main() {
  runApp(const AgroSmartApp());
}

class AgroSmartApp extends StatelessWidget {
  const AgroSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroSmart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationScaffold(),
    );
  }
}
