import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/home/presentation/pages/add_user/domain/entities/add_user_request.dart';

abstract class AddUserInterfaceDataSource {
  // ignore: inference_failure_on_untyped_parameter
  Future<Either<String, bool>> addUser(
    AddUserRequestDataModel user,
  );
}
