import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/core/route/on_generate_route.dart';
import 'package:jhd/core/services/loading_service.dart';
import 'package:jhd/core/theme/app_theme.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configLoading();
  runApp(const MyApp());
}
var navigationKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: OnGenerateRoute.route,
      navigatorKey: navigationKey,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
