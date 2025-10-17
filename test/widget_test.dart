// OffMarket widget test
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offmarket_flutter/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());

    // Verify that the app title is present
    expect(find.text('OffMarket'), findsOneWidget);
  });
}
