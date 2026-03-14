import 'package:dartz/dartz.dart';
import 'package:jhd/core/utils/categories.dart';
import 'package:jhd/core/utils/orders_collections.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/data_sources/order_interface_data_source.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';

class OrderRemoteInterfaceDataSource implements OrderInterfaceDataSource {
  @override
  Future<Either<String, bool>> addOrder(
    OrderDataModel order,
  ) async {
    return await OrdersCollections().addOrder(
      order,
    );
  }

  @override
  Future<Either<String, List<CategoryDataModel>>> getCategories() async {
    return await CategoriesCollections().getAllCategorise();
  }
}
