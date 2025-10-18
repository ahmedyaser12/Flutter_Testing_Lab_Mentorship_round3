import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

void main() {
  group('Weather display', () {
    testWidgets('1️⃣ Returns valid data for known city', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('London'));
      await tester.pumpAndSettle();
      expect(find.text('London').last, findsOneWidget);
    });
    testWidgets('2️⃣ Returns null for Invalid City', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City'));
      await tester.pumpAndSettle();
      expect(find.text('Invalid City').last, findsOneWidget);
    });
    testWidgets('check with refresh button with valid city', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('London'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Refresh'));
      await tester.pumpAndSettle();
      expect(find.text('Invalid City'), findsNothing);
    });
    testWidgets('check with refresh button with invalid city', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Refresh'));
      await tester.pumpAndSettle();
      expect(find.text('Invalid City'), findsOneWidget);
    });
    testWidgets('Shows error message when weather data is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Invalid City'));
      await tester.pump(const Duration(seconds: 3)); // Wait for async fetch

      expect(
        find.textContaining('Failed to fetch weather data'),
        findsOneWidget,
      );
    });
    testWidgets('check Temperature with Fahrenheit', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('London'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(find.text('Fahrenheit'), findsOneWidget);
      final fahrenheitText = find.textContaining('°F');
      expect(fahrenheitText, findsOneWidget);
      expect(find.text('Celsius'), findsNothing);
    });
    testWidgets('check Temperature with Celsius', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('London'));
      await tester.pumpAndSettle();
      expect(find.text('Fahrenheit'), findsNothing);
      expect(find.text('Celsius'), findsOneWidget);
      final celsiusText = find.textContaining('°C');
      expect(celsiusText, findsOneWidget);
    });
    testWidgets('Shows loading indicator while fetching weather data', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      // Tap refresh immediately
      await tester.tap(find.widgetWithText(ElevatedButton, 'Refresh'));
      await tester.pump(); // Start loading

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Finish async operation
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
