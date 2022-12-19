import 'package:login/model/remote/logIn/login_request.dart';
import 'package:login/model/remote/logIn/login_response.dart';
import 'package:login/model/remote/logIn/service/login_service_type.dart';

class LoginService extends LoginServiceType {
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    return const LoginResponse(token: "1234");
  }
}
