import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/model/remote/logOut/service/log_out_service.dart';
import 'package:login/model/sharedPref/shared_pref.dart';
import 'package:login/routes.dart';
import 'package:login/useCase/logOut/log_out_use_case.dart';
import 'package:login/view/dashboard/bloc/dashboard_bloc.dart';
import 'package:login/view/dashboard/bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DashboardBloc>(
        create: (_) => DashboardBloc(
          useCase: LogOutUseCase(
            service: LogOutService(),
            sharedPref: SharedPref(),
          ),
        ),
        child: BlocListener<DashboardBloc, DashboardState>(
          listenWhen: (oldState, newState) => newState.isLoggedOut,
          listener: (context, state) {
            Navigator.of(context).popAndPushNamed(Routes.root);
          },
          child: const DashboardPage(),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () =>
            BlocProvider.of<DashboardBloc>(context).onLogOutPressed(),
        child: const Text("Log out"),
      ),
    );
  }
}
