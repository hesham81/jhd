import 'package:flutter/material.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/domain/entities/add_category_entity.dart';

@immutable
// ignore: must_be_immutable
class CategoryDataModel extends CategoryEntity {
  CategoryDataModel({
    required super.name,
    required super.price,
    super.cid,
  });
  factory CategoryDataModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      CategoryDataModel(
        name: json['name'] as String,
        price: json['price'] as double,
        cid: json['cid'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'price': this.price,
        'cid': this.cid,
      };
}
