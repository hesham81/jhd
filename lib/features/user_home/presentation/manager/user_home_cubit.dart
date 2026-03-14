import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/core/services/snack_bar_services.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/user_home/data/data_sources/get_data_user_home_interface_data_source.dart';
import 'package:jhd/features/user_home/data/data_sources/remote_get_data_user_home_data_source.dart';
import 'package:jhd/features/user_home/data/repositories/get_all_data_user_home_reposatory.dart';
import 'package:jhd/features/user_home/domain/repositories/get_all_data_user_home_reposatory_implementation.dart';
import 'package:jhd/features/user_home/domain/use_cases/get_all_user_home_data_use_case.dart';
import 'package:meta/meta.dart';

part 'user_home_state.dart';

class UserHomeCubit extends Cubit<UserHomeState> {
  UserHomeCubit()
      : super(
          UserHomeInitial(),
        );

  late final GetDataUserHomeInterfaceDataSource _dataSource;
  late final GetAllDataUserHomeReposatory _reposatory;
  late final GetAllUserHomeDataUseCase _useCase;
  Future<void> getData() async {
    EasyLoading.show();
    try {
      _dataSource = RemoteGetDataUserHomeDataSource();
      _reposatory = GetAllDataUserHomeReposatoryImplementation(
        _dataSource,
      );
      _useCase = GetAllUserHomeDataUseCase(
        _reposatory,
      );
      var response = await _useCase.call();
      response.fold(
        (error) => emit(
          UserHomeFailed(
            error,
          ),
        ),
        (data) => emit(
          UserHomeLoaded(
            data,
          ),
        ),
      );
    } catch (error) {
      emit(
        UserHomeFailed(
          error.toString(),
        ),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
