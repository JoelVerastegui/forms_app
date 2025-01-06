import 'package:forms_app/infrastructure/inputs/password.dart';
import 'package:test/test.dart';

void main() {
  late Password password;

  setUp(() {
    password = const Password.pure();
  });

  group('Password Values', () {
    test('Password must be pure', () {
      expect(password, const Password.pure());
    });

    test('Password must be Pedro', () {
      password = const Password.dirty('Pedro');

      expect(password.value, 'Pedro');
    });

    test('Password must be Pedro Casillas', () {
      password = const Password.dirty('Pedro');
      password = Password.dirty('${password.value} Casillas');

      expect(password.value, 'Pedro Casillas');
    });

    test('Password must be empty', () {
      password = const Password.dirty('');

      expect(password.value, '');
    });

    test('Password must be numbers', () {
      password = const Password.dirty('12345');

      expect(password.value, '12345');
    });

    test('Password with special characters', () {
      password = const Password.dirty('@Pedro!');

      expect(password.value, '@Pedro!');
    });

    test('Password with very long string', () {
      final longString = 'a' * 1000;
      password = Password.dirty(longString);

      expect(password.value, longString);
    });
  });

  group('Password Validator', () {
    test('Password errors quantity', () {
      // Validate new error types in the future
      expect(PasswordError.values.length, 2);
    });

    test('Throws PasswordError empty', () {
      password = const Password.dirty('     ');

      expect(password.validator(password.value), PasswordError.empty);
    });

    test('Throws PasswordError length', () {
      password = const Password.dirty('fi ve');

      expect(password.validator(password.value), PasswordError.length);
    });

    test('Returns null', () {
      password = const Password.dirty('Fernando Herrera');

      expect(password.validator(password.value), null);
    });
  });

  group('Password errorMessage', () {
    test('Password errors quantity', () {
      // Validate new error types in the future
      expect(PasswordError.values.length, 2);
    });

    test('Empty error message', () {
      password = const Password.dirty('');
      
      expect(password.displayError, PasswordError.empty);
    });

    test('Length error message', () {
      password = const Password.dirty('five5');
      
      expect(password.displayError, PasswordError.length);
    });

    test('Null error message', () {
      password = const Password.dirty('Raul Casas');
      
      expect(password.displayError, null);
    });
  });
}
