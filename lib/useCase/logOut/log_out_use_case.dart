import 'package:login/model/remote/logOut/log_out_request.dart';
import 'package:login/model/remote/logOut/log_out_response.dart';
import 'package:login/model/remote/logOut/service/log_out_service_type.dart';
import 'package:login/model/sharedPref/shared_pref_type.dart';
import 'package:login/useCase/logOut/log_out_use_case_type.dart';

class LogOutUseCase extends LogOutUseCaseType {
  final LogOutServiceType service;
  final SharedPrefType sharedPref;

  LogOutUseCase({
    required this.service,
    required this.sharedPref,
  });

  @override
  Future<LogOutResponse> logOut(LogOutRequest request) async {
    final response = await service.logOut(request);
    if (response.isSuccess()) sharedPref.saveLoginToken("");
    return response;
  }

  @override
  Future<String> getUserID() async {
    return "1";
  }
}
