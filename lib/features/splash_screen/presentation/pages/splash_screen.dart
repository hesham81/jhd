import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jhd/core/constant/app_assets.dart';
import 'package:jhd/core/extensions/align.dart';
import 'package:jhd/core/services/role_based_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      RoleBasedRoute.call,
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
              duration: const Duration(seconds: 2),
              child: Image.asset(AppAssets.logo).center)
        ],
      ),
    );
  }
}
