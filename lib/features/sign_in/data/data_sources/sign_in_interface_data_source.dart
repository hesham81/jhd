import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jhd/features/sign_in/domain/entities/sign_in_request.dart';

abstract class SignInInterfaceDataSource {
  Future<Either< String , User>> signIn({required SignInRequest data});
}
