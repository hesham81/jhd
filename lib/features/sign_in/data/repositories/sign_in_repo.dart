import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/sign_in_request.dart';

abstract class SignInRepo {
  Future<Either<String, User>> signIn({required SignInRequest data});
}
