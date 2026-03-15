import 'package:jhd/features/home/domain/entities/admin_reports.dart';
import 'package:jhd/features/home/presentation/pages/add_user/data/models/add_user_request_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';

class AdminReportsDataModel extends AdminReports {
  const AdminReportsDataModel({
    required super.user,
    required super.uid,
    required super.orders,
  });

  factory AdminReportsDataModel.fromJson(Map<String, dynamic> json) =>
      AdminReportsDataModel(
        user: AddUserRequestDataModel.fromJson(
          json['user'] as Map<String, dynamic>,
        ),
        uid: json['uid'] as String,
        orders: (json['orders'] as List)
            .map(
              (e) => OrderDataModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'user': this.user.toMap(),
        'uid': this.uid,
        'orders': this
            .orders
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      };
}
