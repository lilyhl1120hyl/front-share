import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:flutter_bloc_dio/src/api/repository/authentication_repository.dart';
import 'package:flutter_bloc_dio/src/api/repository/user_repository.dart';
import 'package:flutter_bloc_dio/src/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_bloc_dio/src/routers/application.dart';
import 'package:flutter_bloc_dio/src/routers/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, _) {
              return const AppView();
            }),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            Application.router.navigateTo(context, Routes.home);
          case AuthenticationStatus.unauthenticated:
            Application.router.navigateTo(context, Routes.login);
          case AuthenticationStatus.unknown:
            break;
        }
      },
    );
  }
}
