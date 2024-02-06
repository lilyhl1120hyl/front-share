import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_dio/src/components/toast/show_toast.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc_dio/src/bloc/login/login_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserPasswordLogin extends StatelessWidget {
  const UserPasswordLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Padding(
          padding:
              EdgeInsets.only(left: 26.w, right: 26.w, top: 10.h, bottom: 11.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _UsernameInput(),
              _PasswordInput(),
              const Padding(padding: EdgeInsets.all(12)),
              _LoginButton(),
              const Padding(padding: EdgeInsets.all(12)),
              const AgreementBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: '用户名',
            errorText:
                state.username.displayError != null ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: '密码',
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (state.isAgree) {
                    if (state.isValid) {
                      context.read<LoginBloc>().add(const LoginSubmitted());
                    }
                  } else {
                    showWarnToast("请先同意协议");
                  }
                },
                child: const Text('登录'),
              );
      },
    );
  }
}

enum SingingCharacter { isAgree }

// 协议同意区
class AgreementBox extends StatefulWidget {
  const AgreementBox({super.key});

  @override
  State<AgreementBox> createState() => _AgreementBoxState();
}

class _AgreementBoxState extends State<AgreementBox> {
  SingingCharacter? _character = SingingCharacter.isAgree;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('同意协议'),
      leading: Radio<SingingCharacter>(
        value: SingingCharacter.isAgree,
        groupValue: _character,
        toggleable: true,
        onChanged: (SingingCharacter? value) {
          setState(() {
            _character = value;
          });
          print('Radio按钮1： $value');
          final isAgreeBool = _character == null ? 'false' : 'true';
          context.read<LoginBloc>().add(AgreeChanged(isAgreeBool));
        },
      ),
    );
  }
}
