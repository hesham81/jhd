part of 'add_user_cubit.dart';

abstract class AddUserState {}

@immutable
// ignore: camel_case_types
final class Handler extends AddUserState {}

final class AddUserInitial extends Handler {}

final class AddUserSuccefully extends Handler {}

final class AddUserFailed extends Handler {
  final String errorMessage;

  AddUserFailed({required this.errorMessage});
}
