import 'package:dartz/dartz.dart';
import 'package:jhd/core/utils/auth/add_user.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/data_sources/add_user_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/home/presentation/pages/add_user/domain/entities/add_user_request.dart';

class RemoteAddUserDataSource implements AddUserInterfaceDataSource {
  @override
  Future<Either<String, bool>> addUser(AddUserRequestDataModel user) async {
    return await UsersCollections().addUser(user , );
  }
}
