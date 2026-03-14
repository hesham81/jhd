import 'package:dartz/dartz.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/repositories/order_repositories.dart';

class AddOrderUseCase {
  late final OrderRepositories _repositories;
  AddOrderUseCase(
    this._repositories,
  );
  Future<Either<String, bool>> call(
    OrderDataModel order,
  ) async =>
      await _repositories.addOrder(
        order,
      );
}
