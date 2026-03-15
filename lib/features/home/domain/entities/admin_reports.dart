import 'package:equatable/equatable.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';

class AdminReports extends Equatable {
  final String uid;
  final AddUserRequestDataModel user;
  final List<OrderDataModel> orders;
  const AdminReports({
    required this.user,
    required this.uid,
    required this.orders,
  });

  @override
  List<Object?> get props => [
        this.uid,
        this.user,
        this.orders,
      ];
}
