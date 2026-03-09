import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jhd/features/sign_in/data/repositories/sign_in_repo.dart';
import 'package:jhd/features/sign_in/domain/entities/sign_in_request.dart';

class SignInUseCase {
  late final SignInRepo _reposatory;

  SignInUseCase(this._reposatory);

  Future<Either<String, User>> call({required SignInRequest data}) async {
    return _reposatory.signIn(data: data);
  }
}
