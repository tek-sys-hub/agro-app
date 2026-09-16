import 'package:flutter_test/flutter_test.dart';
import 'package:agro_app/main.dart';

void main() {
  testWidgets('AgroSmartApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AgroSmartApp());
    expect(find.byType(AgroSmartApp), findsOneWidget);
    // Advance beyond splash screen auto-transition
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();
  });
}
