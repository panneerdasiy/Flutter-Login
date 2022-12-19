import 'package:flutter/material.dart';
import 'package:login/routes.dart';
import 'package:login/view/dashboard/dashboard_screen.dart';
import 'package:login/view/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Routes.root: (_) => const LoginScreen(),
        Routes.dashboard: (_) => const DashboardScreen(),
      },
    );
  }
}
