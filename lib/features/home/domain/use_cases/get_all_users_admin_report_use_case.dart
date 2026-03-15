import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/data/repositories/admin_repositories.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';

class GetAllUsersAdminReportUseCase {
  late final AdminRepositories _repositories;
  GetAllUsersAdminReportUseCase(
    this._repositories,
  );
  Future<Either<String, List<AddUserRequestDataModel>>> call() async =>
      _repositories.getAllUsers();
}
