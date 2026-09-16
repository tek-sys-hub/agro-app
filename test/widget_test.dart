import 'package:flutter_test/flutter_test.dart';
import 'package:agro_app/main.dart';

void main() {
  testWidgets('AgroSmartApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AgroSmartApp());
    expect(find.byType(AgroSmartApp), findsOneWidget);
  });
}
