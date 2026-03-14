import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/data_sources/order_interface_data_source.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/repositories/order_repositories.dart';

class OrderRepositoriesImplementation implements OrderRepositories {
  late final OrderInterfaceDataSource _dataSource;
  OrderRepositoriesImplementation(
    this._dataSource,
  );
  @override
  Future<Either<String, bool>> addOrder(
    OrderDataModel order,
  ) async {
    return await _dataSource.addOrder(
      order,
    );
  }

  @override
  Future<Either<String, List<CategoryDataModel>>> getAllCategories() async {
    return await _dataSource.getCategories();
  }
}
