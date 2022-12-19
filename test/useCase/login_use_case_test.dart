import 'package:flutter_test/flutter_test.dart';
import 'package:login/domain/login_fields_validator_type.dart';
import 'package:login/model/remote/logIn/login_request.dart';
import 'package:login/model/remote/logIn/login_response.dart';
import 'package:login/model/remote/logIn/service/login_service_type.dart';
import 'package:login/model/sharedPref/shared_pref_type.dart';
import 'package:login/useCase/login/login_use_case.dart';

void main() {
  const loginRequest = LoginRequest(email: "email", password: "pass");

  late LoginUseCase sut;
  late MockLoginService loginService;
  late MockLoginFieldsValidator loginValidator;
  late MockSharedPref sharedPref;

  setUp(() {
    loginService = MockLoginService();
    loginValidator = MockLoginFieldsValidator();
    sharedPref = MockSharedPref();

    sut = LoginUseCase(
      loginService: loginService,
      loginValidator: loginValidator,
      sharedPref: sharedPref,
    );
  });

  group("login call tests", () {
    test("login call, calls validator's validate method", () async {
      await sut.login(loginRequest);

      expect(loginValidator.callCount, 1);
    });

    test("login call passes email & password to validator's validate method",
        () async {
      await sut.login(loginRequest);

      expect(loginValidator.emailParam, loginRequest.email);
      expect(loginValidator.passwordParam, loginRequest.password);
    });

    test("login call, saves token", () async {
      await sut.login(loginRequest);

      expect(sharedPref.saveTokenCallCount, 1);
    });

    test("login call, passes the token to sharedPref", () async {
      loginService.isSuccess = true;

      await sut.login(loginRequest);

      expect(sharedPref.tokenParam, MockLoginService.success.token);
    });

    test("login failure, returns error", () async {
      loginService.isSuccess = true;

      LoginResponse response = await sut.login(loginRequest);

      expect(response.error, isNull);
      expect(response.token, isNotNull);
      expect(response.token, isNotEmpty);
    });

    test("login success, returns token", () async {
      loginService.isSuccess = false;

      LoginResponse response = await sut.login(loginRequest);

      expect(response.token, isNull);
      expect(response.error, isNotNull);
      expect(response.error, isNotEmpty);
    });
  });

  group("isLoggedIn tests", () {
    test("user loggedIn, returns true", () async {
      sharedPref.tokenExist = true;

      bool isLoggedIn = await sut.isLoggedIn();

      expect(isLoggedIn, true);
    });

    test("user not loggedIn, returns false", () async {
      sharedPref.tokenExist = false;

      bool isLoggedIn = await sut.isLoggedIn();

      expect(isLoggedIn, false);
    });
  });
}

class MockSharedPref extends SharedPrefType {
  bool tokenExist = false;
  static String data = "1234";
  static String noData = "";
  int saveTokenCallCount = 0;
  String? tokenParam;

  @override
  Future<String> getLoginToken() async {
    return tokenExist ? data : noData;
  }

  @override
  Future<void> saveLoginToken(String token) async {
    tokenParam = token;
    saveTokenCallCount++;
  }
}

class MockLoginFieldsValidator extends LoginFieldsValidatorType {
  bool isValid = true;
  static String invalid = "error";
  static String valid = "";
  int callCount = 0;
  String emailParam = "";
  String passwordParam = "";

  @override
  String validate(String email, String password) {
    emailParam = email;
    passwordParam = password;
    callCount++;
    return isValid ? valid : invalid;
  }
}

class MockLoginService extends LoginServiceType {
  bool isSuccess = true;
  static LoginResponse success = const LoginResponse(token: "1234");
  static LoginResponse failure = const LoginResponse(error: "error");
  LoginRequest? requestParam;

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    requestParam = request;
    return isSuccess ? success : failure;
  }
}
