import 'package:forms_app/infrastructure/inputs/email.dart';
import 'package:test/test.dart';

void main() {
  late Email email;

  setUp(() {
    email = const Email.pure();
  });

  group('Email Values', () {
    test('Email must be pure', () {
      expect(email, const Email.pure());
    });

    test('Email must be pedro_15@google.com', () {
      email = const Email.dirty('pedro_15@google.com');

      expect(email.value, 'pedro_15@google.com');
    });

    test('Email must be pedro_15@google.com.pe', () {
      email = const Email.dirty('pedro_15@google.com');
      email = Email.dirty('${email.value}.pe');

      expect(email.value, 'pedro_15@google.com.pe');
    });

    test('Email must be empty', () {
      email = const Email.dirty('');

      expect(email.value, '');
    });
  });

  group('Email Validator', () {
    test('Email errors quantity', () {
      // Validate new error types in the future
      expect(EmailError.values.length, 2);
    });

    test('Throws EmailError empty', () {
      email = const Email.dirty('     ');

      expect(email.validator(email.value), EmailError.empty);
    });

    test('Throws EmailError format', () {
      email = const Email.dirty('fernando@');
      expect(email.validator(email.value), EmailError.format);
      
      email = const Email.dirty('fernando@com');
      expect(email.validator(email.value), EmailError.format);
      
      email = const Email.dirty('_@pe');
      expect(email.validator(email.value), EmailError.format);
    });

    test('Returns null', () {
      email = const Email.dirty('fernandoherrera@google.com');

      expect(email.validator(email.value), null);
    });
  });

  group('Email errorMessage', () {
    test('Email errors quantity', () {
      // Validate new error types in the future
      expect(EmailError.values.length, 2);
    });

    test('Empty error message', () {
      email = const Email.dirty('');
      
      expect(email.displayError, EmailError.empty);
    });

    test('Format error message', () {
      email = const Email.dirty('fernando@');
      expect(email.displayError, EmailError.format);
      
      email = const Email.dirty('_@pe');
      expect(email.displayError, EmailError.format);
      
      email = const Email.dirty('fernando@com');
      expect(email.displayError, EmailError.format);
    });

    test('Null error message', () {
      email = const Email.dirty('fernandoherrera@google.com');
      
      expect(email.displayError, null);
    });
  });
}
