import 'package:flutter/material.dart';
import 'package:todo_app/core/routes/routes.dart';
import 'package:todo_app/features/Authentication/data/models/userModel.dart';
import 'package:todo_app/features/Authentication/presentation/screens/login_screen.dart';
import 'package:todo_app/features/Authentication/presentation/screens/sign_up_screen.dart';
import 'package:todo_app/features/dashboard/presentation/screens/home_screen.dart';
import 'package:todo_app/features/tasks/presentation/screens/tasks_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case Routes.tasksScreen:
        return MaterialPageRoute(builder: (context) => const TasksScreen());

      case Routes.homeScreen:
        final user = setting.arguments as Usermodel;
        return MaterialPageRoute(
          builder: (context) => DashboardScreen(user: user),
        );

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Page Not Found'))),
        );
    }
  }
}
