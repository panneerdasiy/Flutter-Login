import 'package:flutter_test/flutter_test.dart';
import 'package:login/model/remote/logIn/login_request.dart';
import 'package:login/model/remote/logIn/login_response.dart';
import 'package:login/useCase/logIn/login_use_case_type.dart';
import 'package:login/view/login/bloc/login_bloc.dart';
import 'package:login/view/login/bloc/login_state.dart';

void main() {
  const email = "email";
  const password = "pass";
  const error = "error";
  const loginState = LoginState(
    email: email,
    password: password,
    error: error,
  );

  late LoginBloc sut;
  late MockLoginUseCase useCase;

  setUp(() {
    useCase = MockLoginUseCase();

    sut = LoginBloc(loginUseCase: useCase);
  });

  group("initState tests", () {

    test("initState call with loggedIn true, return loggedIn value as true in initial state", () async {
      useCase.loggedIn = true;

      await sut.initState();

      LoginState state = sut.state;

      expect(state.loggedIn, true);
      expect(state.email, isEmpty);
      expect(state.error, isEmpty);
      expect(state.password, isEmpty);
    });

    test("initState called with loggedIn false, return loggedIn false in initial state", () async {
      useCase.loggedIn = false;

      await sut.initState();

      LoginState state = sut.state;

      expect(state.loggedIn, false);
      expect(state.email, isEmpty);
      expect(state.error, isEmpty);
      expect(state.password, isEmpty);
    });
  });

  test("onEmailChange, emit state with new email value", () async {
    sut.emit(loginState);

    sut.onEmailChange(email);

    LoginState state = sut.state;

    expect(state.email, email);
    expect(state.error, isEmpty);
    expect(state.password, loginState.password);
    expect(state.loggedIn, loginState.loggedIn);
  });

  test("onPasswordChange, emit state with new password value", () async {
    sut.emit(loginState);

    sut.onPasswordChange(password);

    LoginState state = sut.state;

    expect(state.password, password);
    expect(state.error, isEmpty);
    expect(state.email, loginState.email);
    expect(state.loggedIn, false);
  });

  group("onSubmit tests", () {
    test("onSubmit, delegate email & password to service", () async {
      sut.emit(loginState);

      await sut.onSubmit();

      LoginState state = sut.state;

      expect(useCase.requestParam?.email, state.email);
      expect(useCase.requestParam?.password, state.password);
    });

    test(
        "onSubmit success, emit old state with new error empty and new loggedIn true",
        () async {
      useCase.loggedIn = true;
      sut.emit(loginState);

      await sut.onSubmit();

      LoginState state = sut.state;

      expect(state.error, isEmpty);
      expect(state.loggedIn, true);
      expect(state.email, email);
      expect(state.password, password);
    });

    test(
        "onSubmit failure, emit old state with new non-empty error and new loggedIn false",
        () async {
      useCase.loggedIn = false;
      sut.emit(loginState);

      await sut.onSubmit();

      LoginState state = sut.state;

      expect(state.error, isNotEmpty);
      expect(state.loggedIn, false);
      expect(state.email, email);
      expect(state.password, password);
    });
  });
}

class MockLoginUseCase extends LoginUseCaseType {
  bool loggedIn = true;
  LoginRequest? requestParam;
  static const LoginResponse success = LoginResponse(token: "1234");
  static const LoginResponse failure = LoginResponse(error: "error");

  @override
  Future<bool> isLoggedIn() async {
    return loggedIn;
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    requestParam = request;
    return loggedIn ? success : failure;
  }
}
