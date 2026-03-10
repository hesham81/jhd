import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/core/services/snack_bar_services.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/data_sources/add_collection_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/data_sources/add_collection_remote_data_source.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/repositories/category_reposatory.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/domain/repositories/add_category_reposatory_implementation.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/domain/use_cases/add_category_use_case.dart';
import 'package:meta/meta.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit()
      : super(
          AddCategoryInitial(),
        );

  late final AddCategoryUseCase _useCase;
  late final AddCategoryReposatory _reposatory;
  late final AddCategoriesInterfaceDataSource _dataSource;
  Future<void> addCategory(
    CategoryDataModel category,
  ) async {
    EasyLoading.show();
    try {
      _dataSource = AddCategoryRemoteDataSource();
      _reposatory = AddCategoryReposatoryImplementation(
        _dataSource,
      );
      _useCase = AddCategoryUseCase(
        _reposatory,
      );

      var response = await _useCase.call(category);
      var data = response.fold(
        (l) => emit(
          AddCategoryFailed(
            errorMessage: l,
          ),
        ),
        (r) => emit(
          AddCategorySuccess(),
        ),
      );
      
    } catch (error) {
      
      emit(
        AddCategoryFailed(
          errorMessage: error.toString(),
        ),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
