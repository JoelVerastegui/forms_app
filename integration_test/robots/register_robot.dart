import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_app/presentation/screens/home_screen.dart';
import 'package:forms_app/presentation/screens/register_screen.dart';
import 'package:forms_app/presentation/widgets/inputs/custom_text_form_field.dart';

class RegisterRobot {
  final WidgetTester tester;

  const RegisterRobot(this.tester);

  void verifyHome() {
    expect(find.byType(HomeScreen), findsOneWidget);
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
  }

  Future<void> navigateToRegister() async {
    final registerButton = find.byType(ListTile).at(2);
    expect(registerButton, findsOneWidget);
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
  }

  Future<void> putUsername(String username) async {
    final usernameField = find.byType(CustomTextFormField).at(0);
    expect(usernameField, findsOneWidget);
    await tester.enterText(usernameField, username);
    await tester.pump();
  }

  Future<void> errorUsername(String? errorMessage) async {
    final usernameField = find.byType(CustomTextFormField).at(0);
    expect(usernameField, findsOneWidget);
    expect(tester.widget<CustomTextFormField>(usernameField).errorMessage, equals(errorMessage));
  }

  Future<void> putEmail(String email) async {
    final emailField = find.byType(CustomTextFormField).at(1);
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, email);
    await tester.pump();
  }

  Future<void> errorEmail(String? errorMessage) async {
    final emailField = find.byType(CustomTextFormField).at(1);
    expect(emailField, findsOneWidget);
    expect(tester.widget<CustomTextFormField>(emailField).errorMessage, equals(errorMessage));
  }

  Future<void> putPassword(String password) async {
    final passwordField = find.byType(CustomTextFormField).at(2);
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, password);
    await tester.pump();
  }

  Future<void> errorPassword(String? errorMessage) async {
    final passwordField = find.byType(CustomTextFormField).at(2);
    expect(passwordField, findsOneWidget);
    expect(tester.widget<CustomTextFormField>(passwordField).errorMessage, equals(errorMessage));
  }

  Future<void> save() async {
    final saveButton = find.byIcon(Icons.save);
    expect(saveButton, findsOneWidget);
    await tester.tap(saveButton);
    await tester.pump();
  }
}