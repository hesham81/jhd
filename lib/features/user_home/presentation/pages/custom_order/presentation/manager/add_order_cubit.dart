import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/data_sources/order_interface_data_source.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/data_sources/order_remote_interface_data_source.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/repositories/order_repositories.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/domain/repositories/order_repositories_implementation.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/domain/use_cases/add_order_use_case.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/domain/use_cases/get_all_categories_from_orders_use_case.dart';
import 'package:jhd/main.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit() : super(const AddOrderInitial());

  late final OrderInterfaceDataSource _dataSource;
  late final OrderRepositories _repositories;
  late final AddOrderUseCase _useCase;
  late final GetAllCategoriesFromOrdersUseCase _allCategoriesFromOrdersUseCase;

  void _setCategories(List<CategoryDataModel> categories) {
    emit(
      UpdateAllCategories(
        allCategories: categories,
        categories: state.categories,
        totalAmount: state.totalAmount,
      ),
    );
  }

  Future<void> getAllData() async {
    try {
      EasyLoading.show();

      _dataSource = OrderRemoteInterfaceDataSource();
      _repositories = OrderRepositoriesImplementation(_dataSource);
      _allCategoriesFromOrdersUseCase =
          GetAllCategoriesFromOrdersUseCase(_repositories);

      final response = await _allCategoriesFromOrdersUseCase.call();

      response.fold(
        (errorMessage) {
          emit(AddOrderFailed(errorMessage));
        },
        (categories) {
          _setCategories(categories);
        },
      );
    } catch (error) {
      emit(AddOrderFailed(error.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }

  void updateSelectedCategories(List<CategoryDataModel> categories) {
    emit(
      UpdateCategory(
        categories: categories,
        allCategories: state.allCategories,
      ),
    );
  }

  Future<void> addOrder(OrderDataModel order) async {
    try {
      EasyLoading.show();

      _useCase = AddOrderUseCase(_repositories);

      order.tasks = List<CategoryDataModel>.from(state.categories);
      order.totalOrder = state.totalAmount;

      final response = await _useCase.call(order);

      for (final e in state.categories) {
        debugPrint(e.name);
      }

      response.fold(
        (errorMessage) {
          emit(AddOrderFailed(errorMessage));
        },
        (_) {
          emit(
            AddOrderSuccess(
              allCategories: state.allCategories,
              categories: state.categories,
              totalAmount: state.totalAmount,
            ),
          );
        },
      );
    } catch (error) {
      emit(AddOrderFailed(error.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }
}
