import 'package:login/model/remote/logIn/login_request.dart';
import 'package:login/model/remote/logIn/login_response.dart';

abstract class LoginUseCaseType {
  Future<LoginResponse> login(LoginRequest request);

  Future<bool> isLoggedIn();
}
