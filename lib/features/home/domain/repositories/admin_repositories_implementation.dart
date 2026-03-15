import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/data/data_sources/admin_interface_data_source.dart';
import 'package:jhd/features/home/data/repositories/admin_repositories.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';

class AdminRepositoriesImplementation implements AdminRepositories {
  late final AdminInterfaceDataSource _dataSource;
  AdminRepositoriesImplementation(
    this._dataSource,
  );
  @override
  Future<Either<String, List<OrderDataModel>>> getAllOrders() async {
    return await _dataSource.getAllOrders();
  }

  @override
  Future<Either<String, List<AddUserRequestDataModel>>> getAllUsers() async {
    return await _dataSource.getAllUsers();
  }
}
