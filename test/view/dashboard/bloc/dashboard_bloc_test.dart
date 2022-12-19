import 'package:flutter_test/flutter_test.dart';
import 'package:login/model/remote/logOut/log_out_request.dart';
import 'package:login/model/remote/logOut/log_out_response.dart';
import 'package:login/useCase/logOut/log_out_use_case_type.dart';
import 'package:login/view/dashboard/bloc/dashboard_bloc.dart';
import 'package:login/view/dashboard/bloc/dashboard_state.dart';

void main() {
  late MockLogOutUseCase useCase;
  late DashboardBloc sut;

  setUp(() {
    useCase = MockLogOutUseCase();
    sut = DashboardBloc(useCase: useCase);
  });

  group("Dashboard Bloc tests", () {
    test("onLogOutPressed, pass request to useCase", () async {
      await sut.onLogOutPressed();

      expect(useCase.requestParam?.userId, MockLogOutUseCase.userID);
    });

    test(
        "onLogOutPressed error, return state with logOut false & error non-empty",
        () async {
      useCase.loggedOut = false;

      await sut.onLogOutPressed();

      DashboardState state = sut.state;
      expect(state.error, isNotEmpty);
      expect(state.isLoggedOut, false);
    });

    test("onLogOutPressed success, return state with logOut true & error empty",
        () async {
      useCase.loggedOut = true;

      await sut.onLogOutPressed();

      DashboardState state = sut.state;
      expect(state.error, isEmpty);
      expect(state.isLoggedOut, true);
    });
  });
}

class MockLogOutUseCase extends LogOutUseCaseType {
  bool loggedOut = true;
  LogOutRequest? requestParam;
  static const userID = "3";
  static final success = LogOutResponse();
  static final failure = LogOutResponse(error: "error");

  @override
  Future<String> getUserID() async {
    return userID;
  }

  @override
  Future<LogOutResponse> logOut(LogOutRequest request) async {
    requestParam = request;
    return loggedOut ? success : failure;
  }
}
