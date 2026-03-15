import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        return Right(response.user!);
      }
    } on FirebaseAuthException catch (error) {
      return Left(error.message ?? 'Sign in failed');
    }
  }
}
