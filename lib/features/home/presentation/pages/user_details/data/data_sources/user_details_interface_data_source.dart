import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';

abstract class UserDetailsInterfaceDataSource {
  Future<Either<String, bool>> deleteUser(String uid);
}
