part of 'add_category_cubit.dart';

@immutable
sealed class AddCategoryState {}

final class AddCategoryInitial extends AddCategoryState {}

final class AddCategorySuccess extends AddCategoryState {
  AddCategorySuccess() {
    BotToastServices.showSuccessMessage(
      'Category Is Added Succefully',
    );
  }
}

final class AddCategoryFailed extends AddCategoryState {
  final String errorMessage;
  AddCategoryFailed({
    required this.errorMessage,
  }) {
    BotToastServices.showErrorMessage(
      errorMessage,
    );
  }
}
