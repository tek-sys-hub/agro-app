import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agro_app/core/theme/appTheme.dart';
import 'package:agro_app/features/auth/screens/loginScreen.dart';
import 'package:agro_app/features/auth/screens/signupScreen.dart';

void main() {
  group('Auth Flow Verification', () {
    testWidgets('LoginScreen renders header, inputs, and triggers validation', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const LoginScreen(),
        ),
      );

      // Verify AgroSmart header and subtitle
      expect(find.text('AgroSmart'), findsOneWidget);
      expect(find.text('Welcome Back! 👋'), findsOneWidget);

      // Find Login button and tap without entering fields
      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      expect(loginButton, findsOneWidget);

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify validation errors
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);

      // Enter invalid email
      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'invalid-email');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('SignupScreen renders and validates fields', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const SignupScreen(),
        ),
      );

      expect(find.text('AgroSmart'), findsOneWidget);
      expect(find.text('Create Your Account'), findsOneWidget);

      final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');
      expect(signUpButton, findsOneWidget);

      // Tap without inputs
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter your full name'), findsOneWidget);
      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets('SignupScreen validates mismatched passwords and terms checkbox', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const SignupScreen(),
        ),
      );

      final textFields = find.byType(TextFormField);
      // Name
      await tester.enterText(textFields.at(0), 'Saugat Sharma');
      // Email
      await tester.enterText(textFields.at(1), 'saugat@agrosmart.np');
      // Password
      await tester.enterText(textFields.at(2), 'password123');
      // Confirm Password (mismatch)
      await tester.enterText(textFields.at(3), 'differentPass');

      final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });
  });
}
