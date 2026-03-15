import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:jhd/features/user_home/presentation/pages/custom_order/data/models/order_data_model.dart';

class OrdersCollections {
  final _firestore = FirebaseFirestore.instance.collection(
    'orders',
  );
  CollectionReference<OrderDataModel> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) => OrderDataModel.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (value, options) => value.toJson(),
      );

  Future<Either<String, List<OrderDataModel>>> getAllOrders() async {
    try {
      var response = await _collectionReference().get().then(
            (value) => value.docs
                .map(
                  (e) => e.data(),
                )
                .toList(),
          );
      debugPrint('On The Get All Orders the orders is $response');
      return Right(
        response,
      );
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }

  Future<Either<String, bool>> addOrder(
    OrderDataModel order,
  ) async {
    try {
      var docId = await _collectionReference().add(order).then(
            (value) => value.id,
          );
      order.oId = docId;
      await _collectionReference().doc(order.oId).update(
            order.toJson(),
          );
      return const Right(true);
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }
}
