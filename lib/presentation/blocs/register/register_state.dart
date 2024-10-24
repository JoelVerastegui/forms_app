part of 'register_cubit.dart';

enum RegisterStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  final Username username;
  final Email email;
  final Password password;
  final RegisterStatus status;
  final bool isValid;

  const RegisterFormState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = RegisterStatus.invalid,
    this.isValid = false
  });

  RegisterFormState copyWith({
    Username? username,
    Email? email,
    Password? password,
    RegisterStatus? status,
    bool? isValid
  }) => RegisterFormState(
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    status: status ?? this.status,
    isValid: isValid ?? this.isValid
  );

  @override
  List<Object> get props => [ username, email, password, status, isValid ];
}
