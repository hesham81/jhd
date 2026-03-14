part of 'sign_in_cubit.dart';

sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInSuccess extends SignInState {
  final User user;

  SignInSuccess(this.user) {
    BotToastServices.showSuccessMessage("Login Successfully");
    Navigator.pushNamedAndRemoveUntil(
      navigationKey.currentContext!,
      RouteNames.userHome,
      (route) => true,
    );
  }
}

final class SignInFailed extends SignInState {
  final String errorMessage;

  SignInFailed(this.errorMessage){
    BotToastServices.showErrorMessage("Login Failed");
  }
}
