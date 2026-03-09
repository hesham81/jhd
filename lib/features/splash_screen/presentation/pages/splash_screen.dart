import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/align.dart';
import 'package:jhd/core/route/route_names.dart';
import 'package:jhd/features/sign_in/presentation/pages/sign_in.dart';
import 'package:jhd/main.dart';
import 'package:route_transitions/route_transitions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.signIn,
        (route) => false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInUp(
              duration: Duration(seconds: 2),
              child: Image.asset(AppAssets.logo).center)
        ],
      ),
    );
  }
}
