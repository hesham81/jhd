import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';

abstract class OrderRepositories {
  Future<Either<String, bool>> addOrder(
    OrderDataModel order,
  );
  Future<Either<String, List<CategoryDataModel>>> getAllCategories();
}
