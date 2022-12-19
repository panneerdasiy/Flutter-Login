import 'package:flutter_test/flutter_test.dart';
import 'package:login/model/remote/logOut/log_out_request.dart';
import 'package:login/model/remote/logOut/log_out_response.dart';
import 'package:login/model/remote/logOut/service/log_out_service_type.dart';
import 'package:login/useCase/logOut/log_out_use_case.dart';

import 'login_use_case_test.dart';

void main() {
  final request = LogOutRequest(userId: "2");

  late LogOutUseCase sut;
  late MockLogOutService service;
  late MockSharedPref sharedPref;

  setUp(() {
    service = MockLogOutService();
    sharedPref = MockSharedPref();

    sut = LogOutUseCase(
      service: service,
      sharedPref: sharedPref,
    );
  });

  group("logout tests", () {
    test("delegates request to service's logout", () async {
      await sut.logOut(request);

      expect(service.requestParam, request);
    });

    test("logout success, saves empty token", () async {
      service.success = true;

      await sut.logOut(request);

      expect(sharedPref.tokenParam, isEmpty);
    });

    test("logout failure, does not call save token", () async {
      service.success = false;

      await sut.logOut(request);

      expect(sharedPref.saveTokenCallCount, 0);
    });
  });
}

class MockLogOutService extends LogOutServiceType {
  bool success = true;
  LogOutRequest? requestParam;
  static LogOutResponse successResponse = LogOutResponse();
  static LogOutResponse failureResponse = LogOutResponse(error: "error");

  @override
  Future<LogOutResponse> logOut(LogOutRequest request) async {
    requestParam = request;
    return success ? successResponse : failureResponse;
  }
}
