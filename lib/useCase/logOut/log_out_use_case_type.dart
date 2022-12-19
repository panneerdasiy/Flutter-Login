import 'package:login/model/remote/logOut/log_out_request.dart';
import 'package:login/model/remote/logOut/log_out_response.dart';

abstract class LogOutUseCaseType {
  Future<String> getUserID();

  Future<LogOutResponse> logOut(LogOutRequest request);
}
