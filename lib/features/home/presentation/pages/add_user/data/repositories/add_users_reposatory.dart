import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/data_sources/add_user_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';

abstract class AddUsersReposatory {
  
  Future<Either<String, bool>> addUser(
    AddUserRequestDataModel user,
  );
}
