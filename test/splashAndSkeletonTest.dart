import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agro_app/core/theme/appTheme.dart';
import 'package:agro_app/core/widgets/skeletonLoader.dart';
import 'package:agro_app/features/splash/screens/splashScreen.dart';
import 'package:agro_app/features/auth/screens/loginScreen.dart';

void main() {
  group('Splash Screen & Skeleton Loader Verification', () {
    testWidgets('SplashScreen renders branding and transitions to LoginScreen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const SplashScreen(duration: Duration(milliseconds: 500)),
        ),
      );

      // Verify branding presence
      expect(find.text('AgroSmart'), findsOneWidget);
      expect(find.text('Smarter Farming • Better Tomorrow'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);

      // Advance time beyond splash duration
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      // Verify smooth transition into LoginScreen
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Welcome Back! 👋'), findsOneWidget);
    });

    testWidgets('Skeleton components render properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Column(
              children: const [
                SkeletonCard(),
                SkeletonListTile(),
                SkeletonBox(height: 20, width: 100),
                SkeletonCircle(size: 40),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonCard), findsOneWidget);
      expect(find.byType(SkeletonListTile), findsOneWidget);
      expect(find.byType(SkeletonBox), findsWidgets);
      expect(find.byType(SkeletonCircle), findsWidgets);
      expect(find.byType(SkeletonShimmer), findsWidgets);
    });
  });
}
