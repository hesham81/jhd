import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/data/repositories/admin_repositories.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';

class GetAllOrdersAdminReportUseCase {
  late final AdminRepositories _repositories;
  GetAllOrdersAdminReportUseCase(
    this._repositories,
  );
  Future<Either<String, List<OrderDataModel>>> call() async =>
      _repositories.getAllOrders();
}
