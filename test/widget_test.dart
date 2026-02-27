// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:nono_games/main.dart';

void main() {
  testWidgets('App launches and shows home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NanoGamesApp());

    // Verify that the app displays the home page with the expected title
    expect(find.text('NANO GAMES'), findsOneWidget);
    expect(find.text('Discover the Future of Card Gaming'), findsOneWidget);
  });
}
