import 'package:login/model/remote/logOut/log_out_request.dart';
import 'package:login/model/remote/logOut/log_out_response.dart';
import 'package:login/model/remote/logOut/service/log_out_service_type.dart';

class LogOutService extends LogOutServiceType {
  @override
  Future<LogOutResponse> logOut(LogOutRequest request) async {
    return LogOutResponse();
  }
}
