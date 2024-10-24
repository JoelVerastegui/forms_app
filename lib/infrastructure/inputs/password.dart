import 'package:formz/formz.dart';

enum PasswordError { empty, length }

class Password extends FormzInput<String, PasswordError> {

  const Password.pure() : super.pure('');

  const Password.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if(isValid || isPure) return null;

    if(displayError == PasswordError.empty) return 'El campo está vacío';
    if(displayError == PasswordError.length) return 'Debe ingresar mínimo 6 caracteres';

    return null;
  }

  @override
  PasswordError? validator(String value) {
    if(value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if(value.length < 6) return PasswordError.length;

    return null;
  }
}