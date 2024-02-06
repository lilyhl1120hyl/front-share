import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_dio/src/api/config/crypto.dart';
import 'package:flutter_bloc_dio/src/config/common_config.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc_dio/src/api/repository/authentication_repository.dart';
import 'package:flutter_bloc_dio/src/model/common_models/login_models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginTypeChanged>(_onTypeChanged); // 修改登录方式
    on<AgreeChanged>(_onAgreeChanged);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    print('登录按钮： $state');

    if (!state.isAgree) {
      // 没有点击同意协议
    }

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: generateMD5(state.password.value),
          app_key: appKey,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  void _onTypeChanged(
    LoginTypeChanged event,
    Emitter<LoginState> emit,
  ) {
    final loginType = event.loginType;
    emit(
      state.copyWith(
        loginType: loginType,
      ),
    );
  }

  void _onAgreeChanged(
    AgreeChanged event,
    Emitter<LoginState> emit,
  ) {
    final isAgree = event.isAgree == 'false' ? false : true;

    print('Radio按钮： $isAgree');
    emit(
      state.copyWith(
        isAgree: isAgree,
      ),
    );
  }
}
