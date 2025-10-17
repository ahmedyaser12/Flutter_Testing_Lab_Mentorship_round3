// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  group('User Registration Form Widget Tests', () {
    // 🧪 Test 1: Show error when the full name field is empty
    testWidgets('show error when name is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        '',
      );
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle(); // rebuild after tap

      expect(find.text('Please enter your full name'), findsOneWidget);
    });

    // 🧪 Test 2: Show error when the full name is shorter than 2 characters
    testWidgets('show error when name is short', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'A',
      );
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Name must be at least 2 characters'), findsOneWidget);
    });

    // 🧪 Test 3: Show error when the email format is invalid
    testWidgets('show error when the email is not valid', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        '@email.com',
      );
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    // 🧪 Test 4: No error should appear when the email is valid
    testWidgets('no error when the email is valid', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'ahmed@email.com',
      );
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsNothing);
    });

    // 🧪 Test 5: Show error when the password does not meet strength criteria
    testWidgets('show error when the password is not valid', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        '1234',
      );
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Password is too weak'), findsOneWidget);
    });
  });

  // 🧪 Test 6: Show error when the confirm password does not match the password
  testWidgets('show error when the Confirm Password is not valid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm Password'),
      '1234',
    );
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Passwords do not match'), findsOneWidget);
  });

  // 🧪 Test 7: No error when the password meets all validity requirements
  testWidgets('No error when the Password is valid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'Abcd@1234',
    );
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Password is too weak'), findsNothing);
  });

  // 🧪 Test 8: Registration should fail with invalid email and mismatched passwords
  testWidgets('Failed registration', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Full Name'),
      'Ahmed',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'ahmedemail.com', // invalid email
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'bcd1234',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm Password'),
      'Abcd@1234', // does not match
    );
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Registration successful!'), findsNothing);
  });

  // 🧪 Test 9: Registration should succeed when all inputs are valid
  testWidgets('Success registration', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Full Name'),
      'Ahmed',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'ahmed@email.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'Abcd@1234',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm Password'),
      'Abcd@1234',
    );
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Registration successful!'), findsOneWidget);
  });
}
