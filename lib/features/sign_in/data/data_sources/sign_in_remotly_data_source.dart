import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jhd/core/utils/auth/sign_in.dart';
import 'package:jhd/features/sign_in/data/data_sources/sign_in_interface_data_source.dart';
import 'package:jhd/features/sign_in/domain/entities/sign_in_request.dart';

class SignInRemotlyDataSource implements SignInInterfaceDataSource {
  @override
  Future<Either<String, User>> signIn({required SignInRequest data}) async {
    return SignInAuth.signIn(data);
  }
}
