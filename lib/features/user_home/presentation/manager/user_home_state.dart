part of 'user_home_cubit.dart';

@immutable
sealed class UserHomeState {}

final class UserHomeInitial extends UserHomeState {}

final class UserHomeLoaded extends UserHomeState {
  late final List<CategoryDataModel> data;
  UserHomeLoaded(this.data) {
    BotToastServices.showSuccessMessage(
      'Data Is Loaded Succefully',
    );
  }
}

final class UserHomeFailed extends UserHomeState {
  late final String _message;
  UserHomeFailed(this._message) {
    BotToastServices.showErrorMessage(
      this._message,
    );
  }
}
