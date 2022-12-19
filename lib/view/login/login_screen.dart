import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/email_validator.dart';
import 'package:login/domain/login_fields_validator.dart';
import 'package:login/domain/password_validator.dart';
import 'package:login/model/remote/logIn/service/loginService.dart';
import 'package:login/model/sharedPref/shared_pref.dart';
import 'package:login/routes.dart';
import 'package:login/useCase/logIn/login_use_case.dart';
import 'package:login/view/login/bloc/login_bloc.dart';
import 'package:login/view/login/bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(
            loginUseCase: LoginUseCase(
              loginService: LoginService(),
              loginValidator: LoginFieldsValidator(
                emailValidator: EmailValidator(),
                passwordValidator: PasswordValidator(),
              ),
              sharedPref: SharedPref(),
            ),
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listenWhen: (oldState, newState) {
              debugPrint("newState: ${newState.error}");
              return newState.error.isNotEmpty || newState.loggedIn;
            },
            listener: (context, state) {
              FocusScope.of(context).unfocus();

              if (state.loggedIn) {
                Navigator.of(context).popAndPushNamed(Routes.dashboard);
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            },
            child: const LoginPage(),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 100,
      ),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Email",
            ),
            onChanged: (email) {
              BlocProvider.of<LoginBloc>(context).onEmailChange(email);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Password",
            ),
            onChanged: (email) {
              BlocProvider.of<LoginBloc>(context).onPasswordChange(email);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).onSubmit();
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
