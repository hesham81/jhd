import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/user_details/data/repositories/user_details_repositories.dart';

class DeleteSelectedUserByIdUseCase {
  late final UserDetailsRepositories _repositories;
  DeleteSelectedUserByIdUseCase(
    this._repositories,
  );
  Future<Either<String, bool>> call(String uid) async =>
      await _repositories.deleteUser(
        uid,
      );
}
