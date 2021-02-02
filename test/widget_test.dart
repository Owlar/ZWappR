import 'package:flutter_test/flutter_test.dart';
import 'package:zwappr/main.dart';

void main() {
  testWidgets('ZWappR is printed', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text("ZWappR"), findsOneWidget);
  });
}
