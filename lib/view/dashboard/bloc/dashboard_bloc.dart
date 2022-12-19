import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/model/remote/logOut/log_out_request.dart';
import 'package:login/useCase/logOut/log_out_use_case_type.dart';
import 'package:login/view/dashboard/bloc/dashboard_state.dart';

class DashboardBloc extends Cubit<DashboardState> {
  final LogOutUseCaseType useCase;

  DashboardBloc({
    DashboardState initialState = const DashboardState(),
    required this.useCase,
  }) : super(initialState);

  Future<void> onLogOutPressed() async {
    String userId = await useCase.getUserID();
    final response = await useCase.logOut(
      LogOutRequest(
        userId: userId,
      ),
    );
    debugPrint("response: ${response.isSuccess()}");
    if (response.isSuccess()) {
      emit(state.copyWith(isLoggedOut: true, error: ""));
    } else {
      emit(
        state.copyWith(
          error: response.error!.trim().isEmpty
              ? "Something went wrong!"
              : response.error,
          isLoggedOut: false,
        ),
      );
    }
  }
}
