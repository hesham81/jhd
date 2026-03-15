import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';

abstract class AdminRepositories {
  Future<Either<String, List<OrderDataModel>>> getAllOrders();
  Future<Either<String, List<AddUserRequestDataModel>>> getAllUsers();
}
