import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc_dio/src/bloc/login/login_bloc.dart';
import 'package:formz/formz.dart';

class UserCode extends StatefulWidget {
  const UserCode({super.key});

  @override
  State<UserCode> createState() => _UserCodeState();
}

class _UserCodeState extends State<UserCode> {
  final _formKey = GlobalKey<FormState>();

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
              CodeForm(formKey: _formKey),
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

class CodeForm extends StatelessWidget {
  const CodeForm({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: '手机号/账户名',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '验证码',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入';
              }
              return null;
            },
          ),
        ],
      ),
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
                onPressed: state.isValid
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
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
          context.read<LoginBloc>().add(AgreeChanged(true as String));
        },
      ),
    );
  }
}
