import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/api/api_services.dart';
import 'package:todo_app/core/routes/app_router.dart';
import 'package:todo_app/core/routes/routes.dart';
import 'package:todo_app/features/Authentication/data/repo/login_repo.dart';
import 'package:todo_app/features/Authentication/data/repo/signUp_repo.dart';
import 'package:todo_app/features/Authentication/logic/cubit/cubit/sign_up_cubit.dart';
import 'package:todo_app/features/Authentication/logic/cubit/login_cubit.dart';
import 'package:todo_app/features/dashboard/data/repo/home_repo.dart';
import 'package:todo_app/features/dashboard/logic/cubit/dashboard_cubit_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiServices = ApiServices();
  await apiServices.loadToken();

  runApp(MyApp(apiServices: apiServices));
}

class MyApp extends StatelessWidget {
  final ApiServices apiServices;

  const MyApp({super.key, required this.apiServices});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(LoginRepo(apiServices))),
        BlocProvider(create: (context) => SignUpCubit(SignupRepo(apiServices))),
        BlocProvider(
          create: (context) => DashboardCubitCubit(HomeRepo(apiServices)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: Routes.loginScreen,
      ),
    );
  }
}
