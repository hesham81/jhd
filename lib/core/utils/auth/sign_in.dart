import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jhd/core/constant/shared_preference_key.dart';
import 'package:jhd/core/services/local_storage/shared_preference.dart';
import 'package:jhd/core/services/role_based_route.dart';
import 'package:jhd/core/services/snack_bar_services.dart';
import 'package:jhd/core/utils/auth/add_user.dart';
import 'package:jhd/features/sign_in/domain/entities/sign_in_request.dart';

abstract class SignInAuth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<Either<String, User>> signIn(SignInRequest data) async {
    try {
      UserCredential response = await _firebaseAuth.signInWithEmailAndPassword(
        email: data.username,
        password: data.password,
      );

      if (response.user == null) {
        return const Left('Error While Sign In');
      } else {
        await SharedPreferenceServices.setString(
          SharedPreferenceKey.token,
          response.user!.uid,
        );
        String? role = await UsersCollections().getRoleByUserId(
          response.user!.uid,
        );
        log('Role Is $role');
        await SharedPreferenceServices.setString(
          SharedPreferenceKey.role,
          role ?? '',
        );
        BotToastServices.showSuccessMessage('Login Successfully');
        RoleBasedRoute.call();

        return Right(response.user!);
      }
    } on FirebaseAuthException catch (error) {
      BotToastServices.showErrorMessage(error.toString());
      return Left(error.message ?? 'Sign in failed');
    }
  }
}
