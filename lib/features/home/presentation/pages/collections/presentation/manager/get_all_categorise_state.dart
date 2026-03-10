part of 'get_all_categorise_cubit.dart';

@immutable
sealed class GetAllCategoriseState {}

final class GetAllCategoriseInitial extends GetAllCategoriseState {}

final class GetAllCategoriseSuccefully extends GetAllCategoriseState {
  final List<CategoryDataModel> listOfCategories;

  GetAllCategoriseSuccefully(
    this.listOfCategories,
  ) {
    BotToastServices.showSuccessMessage(
      'Categorise Loaded Succefully',
    );
  }
}

final class GetAllCategoriseFailed extends GetAllCategoriseState {
  final String _message;
  GetAllCategoriseFailed(this._message) {
    BotToastServices.showErrorMessage(
      'Error While Loading Categorise Data',
    );
  }
}
