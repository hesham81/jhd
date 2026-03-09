import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhd/core/route/route_names.dart';
import 'package:jhd/features/sign_in/presentation/manager/sign_in_cubit.dart';
import 'package:jhd/features/sign_in/presentation/pages/sign_in.dart';

import '../../features/home/presentation/pages/home.dart';
import '../../features/splash_screen/presentation/pages/splash_screen.dart';

abstract class OnGenerateRoute {
  static Route route(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.signIn:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<SignInCubit>(
                  create: (context) => SignInCubit(),
                  child: SignIn(),
                ));
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => Home());

      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
