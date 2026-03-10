import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/repositories/add_users_reposatory.dart';

class AddUserUseCase {
  late final AddUsersReposatory _reposatory;
  AddUserUseCase(
    this._reposatory,
  );
  Future<Either<String, bool>> call(
    AddUserRequestDataModel user,
  ) async {
    return await _reposatory.addUser(
      user,
    );
  }
}
