import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jhd/features/sign_in/data/data_sources/sign_in_interface_data_source.dart';
import 'package:jhd/features/sign_in/data/repositories/sign_in_repo.dart';
import 'package:jhd/features/sign_in/domain/entities/sign_in_request.dart';

class SignInRepoImplementation implements SignInRepo {
  late final SignInInterfaceDataSource _dataSource;

  SignInRepoImplementation(this._dataSource);

  @override
  Future<Either<String, User>> signIn({required SignInRequest data}) async {
    try {
      return await _dataSource.signIn(data: data);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
