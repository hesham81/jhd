import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String name;
  final double price;
  String cid;

  CategoryEntity({
    required this.name,
    required this.price,
    this.cid = "",
  });

  @override
  List<Object?> get props => [
        name,
        price,
        cid,
      ];
}
