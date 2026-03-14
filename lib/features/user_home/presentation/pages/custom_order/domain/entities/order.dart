import 'package:equatable/equatable.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';

// ignore: must_be_immutable
class Order extends Equatable {
  String oId;
  final String clientName;
  final String clientPhoneNumber;
  final String id;
  final String description;
  double totalOrder;
  late List<CategoryDataModel> tasks;

  Order({
    this.tasks = const [],
    required this.clientName,
    required this.clientPhoneNumber,
    required this.id,
    required this.description,
    this.totalOrder = 0,
    this.oId = '',
  });

  @override
  List<Object?> get props => [
        clientName,
        clientPhoneNumber,
        oId,
        id,
        description,
        totalOrder,
        tasks,
      ];
}
