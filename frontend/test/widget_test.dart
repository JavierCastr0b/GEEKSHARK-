import 'package:flutter_test/flutter_test.dart';
import 'package:geekshark/main.dart';

void main() {
  testWidgets('GeekShark app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GeekSharkApp());
    expect(find.byType(GeekSharkApp), findsOneWidget);
  });
}
