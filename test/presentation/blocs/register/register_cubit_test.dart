import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:test/test.dart';

void main() {
  late RegisterCubit registerCubit;

  setUp(() => registerCubit = RegisterCubit()
    ..usernameChanged('Francisco')
    ..emailChanged('francisco@google.com')
    ..passwordChanged('123456')
  );

  group('State Tests', () {
    test('Initial values are equal to RegisterFormState constructor', () {
      const registerState = RegisterFormState();
      expect(RegisterCubit().state, registerState);
    });

    test('Instance states with same values are equal', () {
      final instance1 = RegisterCubit().state;
      final instance2 = RegisterCubit().state;
      expect(instance1, instance2);
    });

    test('Instances with different values are not equal', () {
      final instance1 = RegisterCubit();
      final instance2 = RegisterCubit()..usernameChanged('Matias');
      expect(instance1, isNot(instance2));
    });
  });

  group('UsernameChanged Tests', () {
    test('Username must be not valid', () {
      const String newUsername = 'Pedro';
      registerCubit.usernameChanged(newUsername);
      expect(registerCubit.state.username.value, newUsername);
      expect(registerCubit.state.isValid, false);
    });
    test('Username must be valid', () {
      const String newUsername = 'Fernando';
      registerCubit.usernameChanged(newUsername);
      expect(registerCubit.state.username.value, newUsername);
      expect(registerCubit.state.isValid, true);
    });
  });

  group('EmailChanged Tests', () {
    test('Email must be not valid', () {
      const String newEmail = 'pedro@google';
      registerCubit.emailChanged(newEmail);
      expect(registerCubit.state.email.value, newEmail);
      expect(registerCubit.state.isValid, false);
    });
    test('Email must be valid', () {
      const String newEmail = 'pedro@google.com';
      registerCubit.emailChanged(newEmail);
      expect(registerCubit.state.email.value, newEmail);
      expect(registerCubit.state.isValid, true);
    });
  });

  group('PasswordChanged Tests', () {
    test('Password must be not valid', () {
      const String newPassword = '12345';
      registerCubit.passwordChanged(newPassword);
      expect(registerCubit.state.password.value, newPassword);
      expect(registerCubit.state.isValid, false);
    });
    test('Password must be valid', () {
      const String newPassword = 'Abcd1234';
      registerCubit.passwordChanged(newPassword);
      expect(registerCubit.state.password.value, newPassword);
      expect(registerCubit.state.isValid, true);
    });
  });

  group('OnSubmit Tests', () {
    test('Status must be Validating on submit', () {
      registerCubit.onSubmit();
      expect(registerCubit.state.status, RegisterStatus.validating);
    });

    test('isValid must be true with correct fields', () {
      registerCubit.onSubmit();
      expect(registerCubit.state.isValid, true);
    });
  });
}