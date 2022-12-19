import 'package:login/domain/login_fields_validator_type.dart';
import 'package:login/model/remote/logIn/login_request.dart';
import 'package:login/model/remote/logIn/login_response.dart';
import 'package:login/model/remote/logIn/service/login_service_type.dart';
import 'package:login/model/sharedPref/shared_pref_type.dart';
import 'package:login/useCase/logIn/login_use_case_type.dart';

class LoginUseCase extends LoginUseCaseType {
  final LoginServiceType loginService;
  final LoginFieldsValidatorType loginValidator;
  final SharedPrefType sharedPref;

  LoginUseCase({
    required this.loginService,
    required this.loginValidator,
    required this.sharedPref,
  });

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    String error = loginValidator.validate(
      request.email,
      request.password,
    );

    if (error.isNotEmpty) return LoginResponse(error: error);

    LoginResponse response = await loginService.login(request);
    await sharedPref.saveLoginToken(response.token ?? "");

    return response;
  }

  @override
  Future<bool> isLoggedIn() async {
    String token = await sharedPref.getLoginToken();
    return token.isNotEmpty;
  }
}
