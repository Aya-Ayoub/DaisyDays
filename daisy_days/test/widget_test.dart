
import 'package:flutter_test/flutter_test.dart';
import 'package:daisy_days/main.dart';

void main() {
  testWidgets('Daisy Days displays its home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DaisyDaysApp());

    expect(find.text('DAISY DAYS'), findsOneWidget);
    expect(find.text('Hello, lovely!'), findsOneWidget);
    expect(find.text('Your little rituals'), findsOneWidget);

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Habits'), findsOneWidget);
    expect(find.text('My Mood'), findsOneWidget);
  });
  testWidgets('Bottom navigation opens the Habits screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DaisyDaysApp());

    await tester.tap(find.text('Habits'));
    await tester.pumpAndSettle();

    expect(find.text('Your Little Habits'), findsOneWidget);
  });

  testWidgets('Bottom navigation opens the Mood Journal screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DaisyDaysApp());

    await tester.tap(find.text('My Mood'));
    await tester.pumpAndSettle();

    expect(find.text('My Mood Journal'), findsOneWidget);
  });
}
