import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/user_details/data/data_sources/user_details_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/user_details/data/repositories/user_details_repositories.dart';

class UserDetailsRepositoriesImplementation implements UserDetailsRepositories {
  late final UserDetailsInterfaceDataSource _dataSource;
  UserDetailsRepositoriesImplementation(
    this._dataSource,
  );
  @override
  Future<Either<String, bool>> deleteUser(
    String uid,
  ) async {
    return _dataSource.deleteUser(
      uid,
    );
  }
}
