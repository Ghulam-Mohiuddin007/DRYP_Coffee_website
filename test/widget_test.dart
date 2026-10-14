import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_shop_animated_website/main.dart';

void main() {
  testWidgets('DRYP Coffee App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DrypCoffeeApp());
    expect(find.text('DRYP'), findsWidgets);
  });
}
