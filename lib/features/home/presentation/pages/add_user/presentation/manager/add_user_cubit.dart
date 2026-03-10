import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/data_sources/add_user_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/data_sources/remote_add_user_data_source.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/repositories/add_users_reposatory.dart';
import 'package:jhd/features/home/presentation/pages/add_user/domain/repositories/add_user_reposatory_implementation.dart';
import 'package:jhd/features/home/presentation/pages/add_user/domain/use_cases/add_user_use_case.dart';
import 'package:meta/meta.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit() : super(AddUserInitial());

  late final AddUsersReposatory _reposatory;
  late final AddUserUseCase _useCase;
  late final AddUserInterfaceDataSource _dataSource;

  void backToDefault() {
    emit(
      AddUserInitial(),
    );
  }

  Future<void> addUser(
    AddUserRequestDataModel user,
  ) async {
    EasyLoading.show();
    try {
      _dataSource = RemoteAddUserDataSource();
      _reposatory = AddUserReposatoryImplementation(_dataSource);
      _useCase = AddUserUseCase(_reposatory);
      var response = await _useCase.call(user);
      
      response.fold(
        (error) => emit(
          AddUserFailed(
            errorMessage: error.toString(),
          ),
        ),
        (r) => emit(
          AddUserSuccefully(),
        ),
      );
    } catch (error) {
      emit(
        AddUserFailed(
          errorMessage: error.toString(),
        ),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
