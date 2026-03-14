import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/domain/entities/order.dart';

class OrderDataModel extends Order {
  OrderDataModel({
    required super.clientName,
    required super.clientPhoneNumber,
    required super.id,
    required super.description,
    super.totalOrder,
    super.oId,
    super.tasks,
  });
  factory OrderDataModel.fromJson(Map<String, dynamic> json) {
    return OrderDataModel(
      clientName: json['clientName'] as String,
      clientPhoneNumber: json['clientPhoneNumber'] as String,
      id: json['id'] as String,
      description: json['description'] as String,
      totalOrder: (json['totalOrder'] as num).toDouble(),
      tasks: (json['tasks'] as List?)
              ?.map(
                  (e) => CategoryDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'clientName': this.clientName,
        'clientPhoneNumber': this.clientPhoneNumber,
        'id': this.id,
        'description': this.description,
        'totalOrder': this.totalOrder,
        'oId': this.oId,
        'tasks': this
            .tasks
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      };
}
