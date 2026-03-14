part of 'add_order_cubit.dart';

@immutable
sealed class AddOrderState {
  final List<CategoryDataModel> categories;
  final List<CategoryDataModel> allCategories;
  final double totalAmount;

  const AddOrderState({
    this.categories = const [],
    this.allCategories = const [],
    this.totalAmount = 0.0,
  });
}

final class AddOrderInitial extends AddOrderState {
  const AddOrderInitial({
    super.categories,
    super.allCategories,
    super.totalAmount,
  });
}

final class UpdateAllCategories extends AddOrderState {
  const UpdateAllCategories({
    required super.allCategories,
    super.categories,
    super.totalAmount,
  });
}

final class UpdateCategory extends AddOrderState {
  UpdateCategory({
    required List<CategoryDataModel> categories,
    required List<CategoryDataModel> allCategories,
  }) : super(
          categories: categories,
          allCategories: allCategories,
          totalAmount: CalculateTotalAmount(categories).calcTotalAmount(),
        );
}

final class AddOrderSuccess extends AddOrderState {
  AddOrderSuccess({
    super.categories,
    super.allCategories,
    super.totalAmount,
  }) {
    navigationKey.currentState!.pop();
  }
}

final class AddOrderFailed extends AddOrderState {
  final String error;

  const AddOrderFailed(
    this.error, {
    super.categories,
    super.allCategories,
    super.totalAmount,
  });
}

final class CalculateTotalAmount {
  final List<CategoryDataModel> categories;

  CalculateTotalAmount(this.categories);

  double calcTotalAmount() {
    double amount = 0.0;
    for (final e in categories) {
      amount += e.price;
    }
    debugPrint('Total Amount is $amount');
    return amount;
  }
}
