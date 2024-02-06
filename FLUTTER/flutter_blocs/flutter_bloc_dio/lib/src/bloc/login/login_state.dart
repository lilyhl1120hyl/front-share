part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.loginType = 'passwordType', // passwordType ,codeType , phoneType
    this.isAgree = false, // 是否同意协议
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final bool isValid;
  final String loginType;
  final bool isAgree;

  LoginState copyWith(
      {FormzSubmissionStatus? status,
      Username? username,
      Password? password,
      bool? isValid,
      String? loginType,
      bool? isAgree}) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      loginType: loginType ?? this.loginType,
      isAgree: isAgree ?? this.isAgree,
    );
  }

  @override
  List<Object> get props => [status, username, password, loginType, isAgree];
}
