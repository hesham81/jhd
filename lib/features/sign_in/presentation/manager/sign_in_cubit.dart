import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jhd/core/route/route_names.dart';
import 'package:jhd/core/services/snack_bar_services.dart';
import 'package:jhd/features/sign_in/data/data_sources/sign_in_interface_data_source.dart';
import 'package:jhd/features/sign_in/data/data_sources/sign_in_remotly_data_source.dart';
import 'package:jhd/features/sign_in/data/repositories/sign_in_repo.dart';
import 'package:jhd/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:jhd/features/sign_in/domain/repositories/sign_in_repo_implementation.dart';
import 'package:jhd/features/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:jhd/main.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  late SignInRepo _repo;

  late SignInInterfaceDataSource _dataSource;
  late SignInUseCase _useCase;

  Future<void> signIn({required SignInRequest data}) async {
    EasyLoading.show();
    try {
      _dataSource = SignInRemotlyDataSource();
      _repo = SignInRepoImplementation(_dataSource);
      _useCase = SignInUseCase(_repo);
      var response = await _useCase.call(data: data);
      return response.fold(
        (l) => emit(SignInFailed(l)),
        (r) => emit(SignInSuccess(r)),
      );
    } catch (error) {
      emit(SignInFailed(error.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }
}
