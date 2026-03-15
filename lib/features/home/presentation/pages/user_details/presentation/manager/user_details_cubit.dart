import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/features/home/presentation/pages/user_details/data/data_sources/remote_user_details_data_source.dart';
import 'package:jhd/features/home/presentation/pages/user_details/data/data_sources/user_details_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/user_details/data/repositories/user_details_repositories.dart';
import 'package:jhd/features/home/presentation/pages/user_details/domain/repositories/user_details_repositories_implementation.dart';
import 'package:jhd/features/home/presentation/pages/user_details/domain/use_cases/delete_selected_user_by_id_use_case.dart';
import 'package:meta/meta.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsInitial());

  late final UserDetailsRepositories _repositories;
  late final UserDetailsInterfaceDataSource _dataSource;
  late final DeleteSelectedUserByIdUseCase _useCase;

  Future<void> deleteUser(String uid) async {
    try {
      EasyLoading.show();
      _dataSource = RemoteUserDetailsDataSource();
      _repositories = UserDetailsRepositoriesImplementation(
        _dataSource,
      );
      _useCase = DeleteSelectedUserByIdUseCase(
        _repositories,
      );
      var response = await _useCase.call(
        uid,
      );
      response.fold(
        (errorMessage) => emit(
          UserDetailsError(
            errorMessage: errorMessage,
          ),
        ),
        (_) => emit(
          UserDetailsSuccess(),
        ),
      );
    } catch (error) {
      emit(
        UserDetailsError(
          errorMessage: error.toString(),
        ),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
