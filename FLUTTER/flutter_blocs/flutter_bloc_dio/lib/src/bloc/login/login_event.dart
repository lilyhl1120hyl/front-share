part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginTypeChanged extends LoginEvent {
  const LoginTypeChanged(this.loginType);

  final String loginType;

  @override
  List<Object> get props => [loginType];
}

final class AgreeChanged extends LoginEvent {
  const AgreeChanged(this.isAgree);
  final String isAgree;

  @override
  List<Object> get props => [isAgree];
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
