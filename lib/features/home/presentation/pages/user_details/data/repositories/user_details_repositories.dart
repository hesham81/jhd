import 'package:dartz/dartz.dart';

abstract class UserDetailsRepositories {
    Future<Either<String, bool>> deleteUser(String uid);

}