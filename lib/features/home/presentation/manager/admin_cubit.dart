// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/features/home/data/data_sources/admin_interface_data_source.dart';
import 'package:jhd/features/home/data/data_sources/remote_admin_interface_data_source.dart';
import 'package:jhd/features/home/data/repositories/admin_repositories.dart';
import 'package:jhd/features/home/domain/repositories/admin_repositories_implementation.dart';
import 'package:jhd/features/home/domain/use_cases/get_all_orders_admin_report_use_case.dart';
import 'package:jhd/features/home/domain/use_cases/get_all_users_admin_report_use_case.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  late final AdminInterfaceDataSource _dataSource;
  late final AdminRepositories _repositories;
  late final GetAllOrdersAdminReportUseCase _allOrdersAdminReportUseCase;
  late final GetAllUsersAdminReportUseCase _getAllUsersAdminReportUseCase;

  Future<void> syncData() async {
    EasyLoading.show();

    try {
      _dataSource = RemoteAdminInterfaceDataSource();
      _repositories = AdminRepositoriesImplementation(_dataSource);
      _allOrdersAdminReportUseCase =
          GetAllOrdersAdminReportUseCase(_repositories);
      _getAllUsersAdminReportUseCase =
          GetAllUsersAdminReportUseCase(_repositories);

      List<OrderDataModel> orderList = [];
      List<AddUserRequestDataModel> usersList = [];

      final ordersResponse = await _allOrdersAdminReportUseCase.call();
      final usersResponse = await _getAllUsersAdminReportUseCase.call();

      bool hasError = false;

      ordersResponse.fold(
        (errorMessage) {
          hasError = true;
          emit(AdminFailed(errorMessage));
        },
        (orders) {
          orderList = orders;
        },
      );

      if (hasError) return;

      usersResponse.fold(
        (errorMessage) {
          hasError = true;
          emit(AdminFailed(errorMessage));
        },
        (users) {
          usersList = users;
        },
      );

      if (hasError) return;

      final Map<String, String> userNames = {
        for (final user in usersList) user.uid: user.name,
      };

      final Map<String, double> budgets = {};

      for (final order in orderList) {
        final name = userNames[order.id] ?? 'Unknown';

        budgets[name] = (budgets[name] ?? 0) + order.totalOrder;
      }

      final Map<String, double> temp = {};

      for (final order in orderList) {
        for (final task in order.tasks) {
          final key = task.name;

          temp[key] = (temp[key] ?? 0) + task.price;
        }
      }

      final List<Map<String, double>> ordersDescription =
          temp.entries.map((e) => {e.key: e.value}).toList();
      emit(
        AdminSuccess(
          orders: orderList,
          users: usersList,
          budgets: budgets,
          orderDetails: ordersDescription,
        ),
      );
    } catch (error) {
      emit(
        AdminFailed(error.toString()),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
