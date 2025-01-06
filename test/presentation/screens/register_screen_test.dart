import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/screens/register_screen.dart';
import 'package:forms_app/presentation/widgets/inputs/custom_text_form_field.dart';

void main() {
  late Widget widget;

  setUp(() {
    widget = const MaterialApp(home: RegisterScreen());
  });

  group('Components Tests', () {
    testWidgets('Widget title exists', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.text('Nuevo usuario'), findsOneWidget);
    });

    testWidgets('BlocProvider<RegisterCubit> exists', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(BlocProvider<RegisterCubit>), findsOneWidget);
    });

    testWidgets('Form fields exists', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(CustomTextFormField), findsNWidgets(3));
    });

    testWidgets('Form fields are in order', (tester) async {
      await tester.pumpWidget(widget);

      final customFields = find.byType(CustomTextFormField);

      expect(
          tester.widget<CustomTextFormField>(customFields.at(0)),
          isA<CustomTextFormField>()
              .having((e) => e.label, 'label', 'Nombre de usuario'));

      expect(
          tester.widget<CustomTextFormField>(customFields.at(1)),
          isA<CustomTextFormField>()
              .having((e) => e.label, 'label', 'Correo electrónico'));

      expect(
          tester.widget<CustomTextFormField>(customFields.at(2)),
          isA<CustomTextFormField>()
              .having((e) => e.label, 'label', 'Contraseña'));
    });

    testWidgets('Save button exists', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byIcon(Icons.save), findsOneWidget);
    });
  });

  group('Username Tests', () {
    test('Username errors quantity', () {
      expect(UsernameError.values.length, 2);
    });

    testWidgets('Username input works correctly', (tester) async {
      await tester.pumpWidget(widget);

      const String usernameText = 'Fernando Herrera';
      final usernameField = find.byType(CustomTextFormField).at(0);

      await tester.enterText(usernameField, usernameText);
      await tester.pump();

      final registerCubit =
          BlocProvider.of<RegisterCubit>(tester.element(usernameField));
      expect(registerCubit.state.username.value, equals(usernameText));
    });

    testWidgets('Username input shows empty error message', (tester) async {
      await tester.pumpWidget(widget);

      const String usernameText = '';
      final usernameField = find.byType(CustomTextFormField).at(0);

      await tester.enterText(usernameField, usernameText);
      await tester.pump();

      final registerCubit = BlocProvider.of<RegisterCubit>(tester.element(usernameField));
      final errorMessage = registerCubit.state.username.errorMessage;

      expect(tester.widget<CustomTextFormField>(usernameField).errorMessage, equals(errorMessage));
    });

    testWidgets('Username input shows length error message', (tester) async {
      await tester.pumpWidget(widget);

      const String usernameText = 'five';
      final usernameField = find.byType(CustomTextFormField).at(0);

      await tester.enterText(usernameField, usernameText);
      await tester.pump();

      final registerCubit = BlocProvider.of<RegisterCubit>(tester.element(usernameField));
      final errorMessage = registerCubit.state.username.errorMessage;

      expect(tester.widget<CustomTextFormField>(usernameField).errorMessage, equals(errorMessage));
    });
  });

  group('Email Tests', () {
    test('Email errors quantity', () {
      expect(EmailError.values.length, 2);
    });

    testWidgets('Email input works correctly', (tester) async {
      await tester.pumpWidget(widget);

      const String emailText = 'fernando@google.com';
      final emailField = find.byType(CustomTextFormField).at(1);

      await tester.enterText(emailField, emailText);
      await tester.pump();

      final registerCubit =
          BlocProvider.of<RegisterCubit>(tester.element(emailField));
      expect(registerCubit.state.email.value, equals(emailText));
    });

    testWidgets('Email input shows empty error message', (tester) async {
      await tester.pumpWidget(widget);

      const String emailText = '';
      final emailField = find.byType(CustomTextFormField).at(1);

      await tester.enterText(emailField, emailText);
      await tester.pump();

      final registerCubit = BlocProvider.of<RegisterCubit>(tester.element(emailField));
      final errorMessage = registerCubit.state.email.errorMessage;

      expect(tester.widget<CustomTextFormField>(emailField).errorMessage, equals(errorMessage));
    });

    testWidgets('Email input shows format error message', (tester) async {
      await tester.pumpWidget(widget);

      const String emailText = 'wrong-email@';
      final emailField = find.byType(CustomTextFormField).at(1);

      await tester.enterText(emailField, emailText);
      await tester.pump();

      final registerCubit = BlocProvider.of<RegisterCubit>(tester.element(emailField));
      final errorMessage = registerCubit.state.email.errorMessage;

      expect(tester.widget<CustomTextFormField>(emailField).errorMessage, equals(errorMessage));
    });
  });

  group('Password Tests', () {
    test('Password errors quantity', () {
      expect(PasswordError.values.length, 2);
    });

    testWidgets('Password input works correctly', (tester) async {
      await tester.pumpWidget(widget);

      const String passwordText = '123456';
      final passwordField = find.byType(CustomTextFormField).at(2);

      await tester.enterText(passwordField, passwordText);
      await tester.pump();

      final registerCubit =
          BlocProvider.of<RegisterCubit>(tester.element(passwordField));
      expect(registerCubit.state.password.value, equals(passwordText));
    });

    testWidgets('Password input shows empty error message', (tester) async {
      await tester.pumpWidget(widget);

      const String passwordText = '';
      final passwordField = find.byType(CustomTextFormField).at(2);

      await tester.enterText(passwordField, passwordText);
      await tester.pump();

      final registerCubit = BlocProvider.of<RegisterCubit>(tester.element(passwordField));
      final errorMessage = registerCubit.state.password.errorMessage;

      expect(tester.widget<CustomTextFormField>(passwordField).errorMessage, equals(errorMessage));
    });

    testWidgets('Password input shows length error message', (tester) async {
      await tester.pumpWidget(widget);

      const String passwordText = 'five';
      final passwordField = find.byType(CustomTextFormField).at(2);

      await tester.enterText(passwordField, passwordText);
      await tester.pump();

      final registerCubit = BlocProvider.of<RegisterCubit>(tester.element(passwordField));
      final errorMessage = registerCubit.state.password.errorMessage;

      expect(tester.widget<CustomTextFormField>(passwordField).errorMessage, equals(errorMessage));
    });
  });

  group('Save Tests', () {
    testWidgets('Register default values are constructor values', (tester) async {
      await tester.pumpWidget(widget);

      final saveButton = find.byIcon(Icons.save);
      RegisterFormState registerState = BlocProvider.of<RegisterCubit>(tester.element(saveButton)).state;

      final defaultCubit = RegisterCubit().state;
      
      expect(registerState.username, equals(defaultCubit.username));
      expect(registerState.email, equals(defaultCubit.email));
      expect(registerState.password, equals(defaultCubit.password));
      expect(registerState.status, equals(defaultCubit.status));
      expect(registerState.isValid, equals(defaultCubit.isValid));
    });

    testWidgets('Show fields error messages on save', (tester) async {
      await tester.pumpWidget(widget);

      final saveButton = find.byIcon(Icons.save);
      final usernameField = find.byType(CustomTextFormField).at(0);
      final emailField = find.byType(CustomTextFormField).at(1);
      final passwordField = find.byType(CustomTextFormField).at(2);

      await tester.enterText(emailField, 'wrong-email@');
      await tester.enterText(passwordField, 'five');
      await tester.tap(saveButton);
      await tester.pump();

      String? usernameError = tester.widget<CustomTextFormField>(usernameField).errorMessage;
      String? emailError = tester.widget<CustomTextFormField>(emailField).errorMessage;
      String? passwordError = tester.widget<CustomTextFormField>(passwordField).errorMessage;

      RegisterFormState registerState = BlocProvider.of<RegisterCubit>(tester.element(saveButton)).state;

      expect(usernameError, equals(registerState.username.errorMessage));
      expect(emailError, equals(registerState.email.errorMessage));
      expect(passwordError, equals(registerState.password.errorMessage));
      expect(registerState.status, equals(RegisterStatus.validating));
      expect(registerState.isValid, equals(false));

      await tester.enterText(usernameField, 'five');
      await tester.enterText(emailField, '');
      await tester.enterText(passwordField, '');
      await tester.tap(saveButton);
      await tester.pump();

      usernameError = tester.widget<CustomTextFormField>(usernameField).errorMessage;
      emailError = tester.widget<CustomTextFormField>(emailField).errorMessage;
      passwordError = tester.widget<CustomTextFormField>(passwordField).errorMessage;

      registerState = BlocProvider.of<RegisterCubit>(tester.element(saveButton)).state;

      expect(usernameError, equals(registerState.username.errorMessage));
      expect(emailError, equals(registerState.email.errorMessage));
      expect(passwordError, equals(registerState.password.errorMessage));
      expect(registerState.status, equals(RegisterStatus.validating));
      expect(registerState.isValid, equals(false));
    });

    testWidgets('Show fields are correct on save', (tester) async {
      await tester.pumpWidget(widget);

      final saveButton = find.byIcon(Icons.save);
      final usernameField = find.byType(CustomTextFormField).at(0);
      final emailField = find.byType(CustomTextFormField).at(1);
      final passwordField = find.byType(CustomTextFormField).at(2);

      await tester.enterText(usernameField, 'Pablo Herrera');
      await tester.enterText(emailField, 'pablo_herrera94@google.com');
      await tester.enterText(passwordField, '123456');
      await tester.tap(saveButton);
      await tester.pump();

      RegisterFormState registerState = BlocProvider.of<RegisterCubit>(tester.element(saveButton)).state;

      expect(registerState.username.isValid, equals(true));
      expect(registerState.email.isValid, equals(true));
      expect(registerState.password.isValid, equals(true));
      expect(registerState.status, equals(RegisterStatus.validating));
      expect(registerState.isValid, equals(true));
    });
  });
}
