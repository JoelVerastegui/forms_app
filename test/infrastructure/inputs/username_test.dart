import 'package:forms_app/infrastructure/inputs/username.dart';
import 'package:test/test.dart';

void main() {
  late Username username;

  setUp(() {
    username = const Username.pure();
  });

  group('Username Values', () {
    test('Username must be pure', () {
      expect(username, const Username.pure());
    });

    test('Username must be Pedro', () {
      username = const Username.dirty('Pedro');

      expect(username.value, 'Pedro');
    });

    test('Username must be Pedro Casillas', () {
      username = const Username.dirty('Pedro');
      username = Username.dirty('${username.value} Casillas');

      expect(username.value, 'Pedro Casillas');
    });

    test('Username must be empty', () {
      username = const Username.dirty('');

      expect(username.value, '');
    });

    test('Username must be numbers', () {
      username = const Username.dirty('12345');

      expect(username.value, '12345');
    });

    test('Username with special characters', () {
      username = const Username.dirty('@Pedro!');

      expect(username.value, '@Pedro!');
    });

    test('Username with very long string', () {
      final longString = 'a' * 1000;
      username = Username.dirty(longString);

      expect(username.value, longString);
    });
  });

  group('Username Validator', () {
    test('Username errors quantity', () {
      // Validate new error types in the future
      expect(UsernameError.values.length, 2);
    });

    test('Throws UsernameError empty', () {
      username = const Username.dirty('     ');

      expect(username.validator(username.value), UsernameError.empty);
    });

    test('Throws UsernameError length', () {
      username = const Username.dirty('fi ve');

      expect(username.validator(username.value), UsernameError.length);
    });

    test('Returns null', () {
      username = const Username.dirty('Fernando Herrera');

      expect(username.validator(username.value), null);
    });
  });

  group('Username errorMessage', () {
    test('Username errors quantity', () {
      // Validate new error types in the future
      expect(UsernameError.values.length, 2);
    });

    test('Empty error message', () {
      username = const Username.dirty('');
      
      expect(username.displayError, UsernameError.empty);
    });

    test('Length error message', () {
      username = const Username.dirty('five5');
      
      expect(username.displayError, UsernameError.length);
    });

    test('Null error message', () {
      username = const Username.dirty('Raul Casas');
      
      expect(username.displayError, null);
    });
  });
}
