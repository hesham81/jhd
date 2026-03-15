part of 'sign_in_cubit.dart';

sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInSuccess extends SignInState {
  final User user;

  SignInSuccess(this.user);
}

final class SignInFailed extends SignInState {
  final String errorMessage;

  SignInFailed(this.errorMessage) {
  }
}
