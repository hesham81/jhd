import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/main.dart';

class CategoriesCollections {
  final _firestore = FirebaseFirestore.instance.collection("categories");

  CollectionReference<CategoryDataModel> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) => CategoryDataModel.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (value, options) => value.toJson(),
      );

  Future<Either<String, List<CategoryDataModel>>> getAllCategorise() async {
    try {
      var response = await _collectionReference().get().then(
            (value) => value.docs
                .map(
                  (e) => e.data(),
                )
                .toList(),
          );
      return Right(
        response,
      );
    } catch (error) {
      return const Left(
        'Error While Get All Categorise',
      );
    }
  }

  Future<Either<String, bool>> addCategory(
    CategoryDataModel category,
  ) async {
    try {
      // String id = '';
      String id = await _collectionReference()
          .add(
            category,
          )
          .then(
            (value) => value.id,
          );
      category.cid = id;
      await _collectionReference().doc(id).update(
            category.toJson(),
          );
      navigationKey.currentState!.pop();
      return const Right(true);
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }
}
