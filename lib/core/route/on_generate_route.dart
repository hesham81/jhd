import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhd/core/route/route_names.dart';
import 'package:jhd/features/home/presentation/pages/add_user/presentation/manager/add_user_cubit.dart';
import 'package:jhd/features/home/presentation/pages/add_user/presentation/pages/add_user.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/manager/get_all_categorise_cubit.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/presentation/manager/add_category_cubit.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/presentation/pages/add_collections.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/collections.dart';
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
            child: const SignIn(),
          ),
        );
      case RouteNames.addUser:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AddUserCubit>(
            create: (context) => AddUserCubit(),
            child: const AddUser(),
          ),
        );
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => const Home(),
        );
      case RouteNames.addCollections:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AddCategoryCubit>(
            create: (context) => AddCategoryCubit(),
            child: const AddCollections(),
          ),
        );
      case RouteNames.collections:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<GetAllCategoriseCubit>(
            create: (context) => GetAllCategoriseCubit()..getAllCategorise(),
            child: const Categories(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
    }
  }
}
