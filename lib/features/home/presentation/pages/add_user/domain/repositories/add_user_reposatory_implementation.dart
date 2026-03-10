import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/data_sources/add_user_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/repositories/add_users_reposatory.dart';

class AddUserReposatoryImplementation implements AddUsersReposatory {
  late final AddUserInterfaceDataSource _dataSource;
  AddUserReposatoryImplementation(
    this._dataSource,
  );
  @override
  Future<Either<String, bool>> addUser(
    AddUserRequestDataModel user,
  ) async {
    try {
      return await _dataSource.addUser(
        user,
      );
    } catch (error) {
      return Left(error.toString());
    }
  }
}
