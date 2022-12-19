import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/model/remote/logIn/login_request.dart';
import 'package:login/useCase/logIn/login_use_case_type.dart';
import 'package:login/view/login/bloc/login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  final LoginUseCaseType loginUseCase;

  LoginBloc({
    LoginState initialState = const LoginState(),
    required this.loginUseCase,
  }) : super(initialState) {
    initState();
  }

  Future<void> initState() async {
    emit(
      state.copyWith(
        loggedIn: await loginUseCase.isLoggedIn(),
      ),
    );
  }

  void onEmailChange(String email) {
    emit(
      state.copyWith(
        email: email,
        error: "",
      ),
    );
  }

  void onPasswordChange(String password) {
    emit(
      state.copyWith(
        password: password,
        error: "",
      ),
    );
  }

  Future<void> onSubmit() async {
    final response = await loginUseCase.login(
      LoginRequest(
        email: state.email,
        password: state.password,
      ),
    );

    if (response.isSuccess()) {
      emit(state.copyWith(loggedIn: true, error: ""));
    } else {
      emit(state.copyWith(loggedIn: false, error: response.error ?? "Something went wrong"));
    }
  }
}
