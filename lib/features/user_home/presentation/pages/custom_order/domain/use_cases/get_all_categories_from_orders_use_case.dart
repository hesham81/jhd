import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/repositories/order_repositories.dart';

class GetAllCategoriesFromOrdersUseCase {
  late final OrderRepositories _repositories;
  GetAllCategoriesFromOrdersUseCase(this._repositories);

  Future<Either<String, List<CategoryDataModel>>> call() async =>
      await _repositories.getAllCategories();
}
