import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:test/test.dart';

void main() {
  late RegisterFormState registerState;

  setUp(() {
    registerState = const RegisterFormState();
  });

  group('Checking State tests', () {
    test('Instances with same values should be equal', () {
      const instance1 = RegisterFormState(
          username: Username.dirty('Pablo'),
          email: Email.dirty('pablo@google.com'),
          password: Password.dirty('12345'),
          status: RegisterStatus.validating,
          isValid: true);

      const instance2 = RegisterFormState(
          username: Username.dirty('Pablo'),
          email: Email.dirty('pablo@google.com'),
          password: Password.dirty('12345'),
          status: RegisterStatus.validating,
          isValid: true);

      expect(instance1, instance2);
    });

    test('Instances with different values should not be equal', () {
      const instance1 = RegisterFormState(
          username: Username.dirty('Pablo'),
          email: Email.dirty('pablo@google.com'),
          password: Password.dirty('12345'),
          status: RegisterStatus.validating,
          isValid: true);

      const instance2 = RegisterFormState(
          username: Username.dirty('Matias'),
          email: Email.dirty('matias@google.com'),
          password: Password.dirty('12345'),
          status: RegisterStatus.validating,
          isValid: true);

      expect(instance1, isNot(instance2));
    });

    test('Default values', () {
      expect(registerState.username, const Username.pure());
      expect(registerState.email, const Email.pure());
      expect(registerState.password, const Password.pure());
      expect(registerState.status, RegisterStatus.invalid);
      expect(registerState.isValid, false);
    });
  });

  group('Username Tests', () {
    test('Username must update to Chris', () {
      const newUsername = Username.dirty('Chris');
      registerState = registerState.copyWith(username: newUsername);
      expect(registerState.username.value, 'Chris');
      expect(registerState.username.isValid, false);
    });

    test('Username must not update to Chris', () {
      const newUsername = Username.dirty('Cornell');
      registerState = registerState.copyWith(username: newUsername);
      expect(registerState.username.value, isNot('Chris'));
      expect(registerState.username.isValid, true);
    });

    test('Username must receive numbers and symbols', () {
      const newUsername = Username.dirty('@chris223_2#45');
      registerState = registerState.copyWith(username: newUsername);
      expect(registerState.username.value, '@chris223_2#45');
      expect(registerState.username.isValid, true);
    });

    test('Username must receive long text', () {
      final longName = 'Maria${"a" * 1000}';
      final newUsername = Username.dirty(longName);
      registerState = registerState.copyWith(username: newUsername);
      expect(registerState.username.value, longName);
      expect(registerState.username.isValid, true);
    });

    test('Username must receive empty text', () {
      const newUsername = Username.dirty('');
      registerState = registerState.copyWith(username: newUsername);
      expect(registerState.username.value, '');
      expect(registerState.username.isValid, false);
    });
  });

  group('Email Tests', () {
    test('Email must update to chris@google.com', () {
      const newEmail = Email.dirty('chris@google.com');
      registerState = registerState.copyWith(email: newEmail);
      expect(registerState.email.value, 'chris@google.com');
      expect(registerState.email.isValid, true);
    });

    test('Email must not update to chris@google.com', () {
      const newEmail = Email.dirty('cornell@google.com');
      registerState = registerState.copyWith(email: newEmail);
      expect(registerState.email.value, isNot('chris@google.com'));
      expect(registerState.email.isValid, true);
    });

    test('Email must receive numbers and symbols', () {
      const newEmail = Email.dirty('chris14_34s@google.com');
      registerState = registerState.copyWith(email: newEmail);
      expect(registerState.email.value, 'chris14_34s@google.com');
      expect(registerState.email.isValid, true);
    });

    test('Email must receive long text', () {
      final longEmail = 'chris${"s" * 1000}@google.com';
      final newEmail = Email.dirty(longEmail);
      registerState = registerState.copyWith(email: newEmail);
      expect(registerState.email.value, longEmail);
      expect(registerState.email.isValid, true);
    });

    test('Email must receive empty text', () {
      const newEmail = Email.dirty('');
      registerState = registerState.copyWith(email: newEmail);
      expect(registerState.email.value, '');
      expect(registerState.email.isValid, false);
    });

    test('Email must not receive invalid format', () {
      const newEmail = Email.dirty('invalid-email');
      registerState = registerState.copyWith(email: newEmail);
      expect(registerState.email.value, 'invalid-email');
      expect(registerState.email.isValid, false);
    });

    test('Email must not receive invalid characters', () {
      const newEmail = Email.dirty('chris#google.com');
      registerState = registerState.copyWith(email: newEmail);
      expect(registerState.email.value, 'chris#google.com');
      expect(registerState.email.isValid, false);
    });
  });

  group('Password Tests', () {
    test('Password must update to Chris', () {
      const newPassword = Password.dirty('Chris');
      registerState = registerState.copyWith(password: newPassword);
      expect(registerState.password.value, 'Chris');
      expect(registerState.password.isValid, false);
    });

    test('Password must not update to Chris', () {
      const newPassword = Password.dirty('Cornell');
      registerState = registerState.copyWith(password: newPassword);
      expect(registerState.password.value, isNot('Chris'));
      expect(registerState.password.isValid, true);
    });

    test('Password must receive numbers and symbols', () {
      const newPassword = Password.dirty('@chris223_2#45');
      registerState = registerState.copyWith(password: newPassword);
      expect(registerState.password.value, '@chris223_2#45');
      expect(registerState.password.isValid, true);
    });

    test('Password must receive long text', () {
      final longName = 'Maria${"a" * 1000}';
      final newPassword = Password.dirty(longName);
      registerState = registerState.copyWith(password: newPassword);
      expect(registerState.password.value, longName);
      expect(registerState.password.isValid, true);
    });

    test('Password must receive empty text', () {
      const newPassword = Password.dirty('');
      registerState = registerState.copyWith(password: newPassword);
      expect(registerState.password.value, '');
      expect(registerState.password.isValid, false);
    });
  });

  group('RegisterStatus Tests', () {
    test('RegisterStatus values quantity', () {
      expect(RegisterStatus.values.length, 4);
    });

    test('RegisterStatus receive invalid value', () {
      registerState = registerState.copyWith(status: RegisterStatus.invalid);
      expect(registerState.status, RegisterStatus.invalid);
    });

    test('RegisterStatus receive valid value', () {
      registerState = registerState.copyWith(status: RegisterStatus.valid);
      expect(registerState.status, RegisterStatus.valid);
    });

    test('RegisterStatus receive validating value', () {
      registerState = registerState.copyWith(status: RegisterStatus.validating);
      expect(registerState.status, RegisterStatus.validating);
    });

    test('RegisterStatus receive posting value', () {
      registerState = registerState.copyWith(status: RegisterStatus.posting);
      expect(registerState.status, RegisterStatus.posting);
    });
  });

  group('isValid Tests', () {
    test('isValid must be true', () {
      registerState = registerState.copyWith(isValid: true);
      expect(registerState.isValid, true);
    });
    test('isValid must be false', () {
      registerState = registerState.copyWith(isValid: false);
      expect(registerState.isValid, false);
    });
  });
}
