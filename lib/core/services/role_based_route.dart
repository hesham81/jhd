import 'package:jhd/core/constant/shared_preference_key.dart';
import 'package:jhd/core/route/route_names.dart';
import 'package:jhd/core/services/local_storage/shared_preference.dart';
import 'package:jhd/main.dart';

 class RoleBasedRoute {
  static Future<void> call() async {
    // await SharedPreferenceServices.clearAll();
    final String role = await SharedPreferenceServices.getString(
          SharedPreferenceKey.role,
        ) ??
        '';
    if (role.isNotEmpty && role == 'admin') {
      navigationKey.currentState!.pushNamedAndRemoveUntil(
        RouteNames.home,
        (route) => true,
      );
    } else if (role.isNotEmpty && role == 'user') {
      navigationKey.currentState!.pushNamedAndRemoveUntil(
        RouteNames.userHome,
        (route) => true,
      );
    } else {
      navigationKey.currentState!.pushNamedAndRemoveUntil(
        RouteNames.signIn,
        (route) => true,
      );
    }
  }

  Future<void> logout() async {
    navigationKey.currentState!.pushNamedAndRemoveUntil(
      RouteNames.signIn,
      (route) => true,
    );
    await SharedPreferenceServices.remove(
      SharedPreferenceKey.role,
    );
    await SharedPreferenceServices.remove(
      SharedPreferenceKey.token,
    );
  }
}
