import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/domain/entities/add_category_entity.dart';

abstract class AddCategoriesInterfaceDataSource {
  Future<Either<String, bool>> addCategory(
    CategoryDataModel category,
  );
}
