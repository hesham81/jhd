import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/core/services/snack_bar_services.dart';
import 'package:jhd/features/home/presentation/pages/collections/data/data_sources/get_all_categorise_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/collections/data/data_sources/remote_get_all_categorise_data_source.dart';
import 'package:jhd/features/home/presentation/pages/collections/data/repositories/get_all_categorise_reposatories.dart';
import 'package:jhd/features/home/presentation/pages/collections/domain/repositories/get_all_categorise_reposatories_implementation.dart';
import 'package:jhd/features/home/presentation/pages/collections/domain/use_cases/get_all_categorise_use_case.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:meta/meta.dart';

part 'get_all_categorise_state.dart';

class GetAllCategoriseCubit extends Cubit<GetAllCategoriseState> {
  GetAllCategoriseCubit()
      : super(
          GetAllCategoriseInitial(),
        );

  late final GetAllCategoriseUseCase _useCase;
  late final GetAllCategoriseReposatories _reposatories;
  late final GetAllCategoriseInterfaceDataSource _dataSource;

  Future<void> getAllCategorise() async {
    EasyLoading.show();
    try {
      _dataSource = RemoteGetAllCategoriseDataSource();
      _reposatories = GetAllCategoriseReposatoriesImplementation(_dataSource);
      _useCase = GetAllCategoriseUseCase(_reposatories);

      var response = await _useCase.call();

      response.fold(
        (errorMessage) => emit(
          GetAllCategoriseFailed(
            errorMessage,
          ),
        ),
        (data) => emit(
          GetAllCategoriseSuccefully(
            data,
          ),
        ),
      );
    } catch (error) {
      emit(
        GetAllCategoriseFailed(
          error.toString(),
        ),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
