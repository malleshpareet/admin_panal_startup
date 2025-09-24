import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import '../lib/screens/login/login_screen.dart';
import '../lib/screens/login/provider/login_provider.dart';

void main() {
  testWidgets('Login screen displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginProvider(),
          child: LoginScreen(),
        ),
      ),
    );

    // Verify that the login screen shows the title
    expect(find.text('Admin Login'), findsOneWidget);

    // Verify that email and password fields are present
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

    // Verify that the login button is present
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });

  testWidgets('Login with correct credentials', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginProvider(),
          child: LoginScreen(),
        ),
      ),
    );

    // Enter test credentials
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'), 'admin@gmail.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'password1234567890');

    // Tap the login button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    // Wait for the async operation to complete
    await tester.pumpAndSettle();

    // Verify that no error message is shown
    expect(find.text('Invalid credentials'), findsNothing);
  });

  testWidgets('Login with incorrect credentials shows error',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginProvider(),
          child: LoginScreen(),
        ),
      ),
    );

    // Enter incorrect credentials
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'), 'wrong@email.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'wrongpassword');

    // Tap the login button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    // Wait for the async operation to complete
    await tester.pumpAndSettle();

    // Verify that error message is shown
    expect(find.text('Invalid credentials'), findsOneWidget);
  });
}
