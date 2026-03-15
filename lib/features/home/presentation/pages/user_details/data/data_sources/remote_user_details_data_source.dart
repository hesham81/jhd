import 'package:dartz/dartz.dart';
import 'package:jhd/core/utils/auth/add_user.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/home/presentation/pages/user_details/data/data_sources/user_details_interface_data_source.dart';

class RemoteUserDetailsDataSource implements UserDetailsInterfaceDataSource {
  @override
  Future<Either<String, bool>> deleteUser(
    String uid,
  ) async {
    return UsersCollections().deleteUserById(
      uid,
    );
  }
}
