part of 'admin_cubit.dart';

@immutable
sealed class AdminState {
  final List<OrderDataModel> orders;
  final List<AddUserRequestDataModel> users;
  final Map<String, double> budgets;
  final List<Map<String, double>> orderDetails;
  const AdminState({
    this.orders = const [],
    this.orderDetails = const [],
    this.users = const [],
    this.budgets = const {},
  });
}

final class AdminInitial extends AdminState {}

final class AdminSuccess extends AdminState {
  const AdminSuccess({
    super.orders,
    super.users,
    super.budgets,
    super.orderDetails
  });
}

final class AdminFailed extends AdminState {
  final String errorMessage;
  AdminFailed(
    this.errorMessage,
  );
}
